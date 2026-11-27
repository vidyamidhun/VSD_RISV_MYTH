"""Creates the two TL-Verilog CPUs from rvmyth_template.tlv and asm/gemm.hex."""
import os, re
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
read = lambda *p: open(os.path.join(root, *p)).read()
code = read('asm', 'gemm.hex').split()
PAD = 5                        # spare nops: fetches after the last 'ret' get cancelled
template = read('scripts', 'rvmyth_template.tlv')

# assembly text for the comments
asm = {}
for line in read('asm', 'gemm.objdump.txt').splitlines():
    m = re.match(r'\s*([0-9a-f]+):\t[0-9a-f]{8}\s+(.*)', line)
    if m:
        asm[int(m.group(1), 16)] = ' '.join(m.group(2).split())
program = '\n'.join("      assign instrs[%d] = 32'h%s;   // %03x: %s" % (i, w, 4 * i, asm[4 * i])
                    for i, w in enumerate(code))
program += ''.join("\n      assign instrs[%d] = 32'h00000013;   // nop (padding)" % (len(code) + i)
                   for i in range(PAD))

C = [30, 24, 18, 84, 69, 54, 138, 114, 90]
cell = lambda i: '|cpu/dmem[%d]' % (18 + i)
print_c = '\n'.join(
    '                  \\$display("   %%4d %%4d %%4d", %s);' %
    ', '.join('/dmem[%d]>>1$value' % (18 + r * 3 + c) for c in range(3)) for r in range(3))
passed = ' &&\n'.join("             %s>>5$value == 32'd%d" % (cell(i), v) for i, v in enumerate(C)) + ';'

D = '                  \\$display('
versions = {
 'rvmyth_pipelined.tlv': dict(
  TITLE='PIPELINED', FAILCYC='2500',
  PC="""         // Fetch every cycle. A redirect comes from the instruction 3 cycles ahead
         $pc[31:0] = >>1$reset          ? 32'd0 :
                     >>3$valid_taken_br ? >>3$br_tgt_pc :
                     >>3$valid_load     ? >>3$inc_pc :
                     >>3$valid_jal      ? >>3$br_tgt_pc :
                     >>3$valid_jalr     ? >>3$jalr_tgt_pc :
                                          >>1$inc_pc;
""",
  VALID="""         // Cancel the 2 instructions fetched after a taken branch, a load or a jump
         $valid = ! $reset &&
                  ! (>>1$valid_taken_br || >>2$valid_taken_br ||
                     >>1$valid_load     || >>2$valid_load     ||
                     >>1$valid_jump     || >>2$valid_jump);
""",
  PENALTY='\n'.join([
   D + '"Branch misses              : %0d", $cnt_taken);',
   D + '"Branch penalty cycles      : %0d  (2 per miss)", 2 * $cnt_taken);',
   D + '"Load penalty cycles        : %0d", 2 * $cnt_load);',
   D + '"Jump penalty cycles        : %0d", 2 * $cnt_jump);',
   D + '"Check: instructions + all penalties = %0d",',
   '                            $cnt_instr + 2 * ($cnt_taken + $cnt_load + $cnt_jump));'])),
 'rvmyth_nonpipelined.tlv': dict(
  TITLE='NON-PIPELINED', FAILCYC='4000',
  PC="""         // One instruction at a time: a new one starts every 3rd cycle
         $start = >>1$reset && ! $reset;
         $slot  = $reset ? 1'b0 :
                  $start ? 1'b1 :
                           >>3$slot;

         // The PC changes only after the previous instruction has finished
         $pc[31:0] = >>1$reset          ? 32'd0 :
                     >>3$valid_taken_br ? >>3$br_tgt_pc :
                     >>3$valid_jal      ? >>3$br_tgt_pc :
                     >>3$valid_jalr     ? >>3$jalr_tgt_pc :
                     >>3$valid          ? >>3$inc_pc :
                                          >>1$pc;
""",
  VALID="""         // Only one instruction is in flight, so nothing has to be cancelled
         $valid = ! $reset && $slot;
""",
  PENALTY='\n'.join([
   D + '"Branch misses              : 0  (next fetch waits for the branch)");',
   D + '"Branch penalty cycles      : 0  (every instruction takes 3 cycles)");',
   D + '"Check: 3 x instructions    = %0d", 3 * $cnt_instr);'])),
}
for name, v in versions.items():
    text = template
    v.update(PROGRAM=program, LAST=str(len(code) + PAD - 1), PRINT_C=print_c, PASS=passed)
    for key, value in v.items():
        text = text.replace('@%s@' % key, value.rstrip('\n'))
    assert not re.search(r'@[A-Z_]{2,}@', text)
    open(os.path.join(root, 'tlv', name), 'w').write(text)
    print('wrote tlv/' + name)
