"""Instruction-level reference model: runs asm/gemm.hex one instruction at a time
(no pipeline) and counts what the program does."""
import os, collections
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
code = [int(x, 16) for x in open(os.path.join(root, 'asm', 'gemm.hex'))]
reg, mem, pc = [0] * 32, [0] * 64, 0
count = collections.Counter()
per_branch = collections.defaultdict(lambda: [0, 0])    # PC: [executed, taken]
sx = lambda v, b: v - (1 << b) if v >> (b - 1) & 1 else v
signed = lambda v: sx(v, 32)
while True:
    i = code[pc // 4]
    if i == 0x0000006f:
        break
    op, rd, f3 = i & 127, i >> 7 & 31, i >> 12 & 7
    a, b = reg[i >> 15 & 31], reg[i >> 20 & 31]
    imm_i = sx(i >> 20, 12)
    nxt, w = pc + 4, None
    count['instructions'] += 1
    if op in (0x13, 0x33):
        r = op == 0x33
        y = b if r else imm_i & 0xffffffff
        alt = i >> 30 & 1
        if f3 == 0: w = a - y if (r and alt) else a + y
        elif f3 == 1: w = a << (y & 31)
        elif f3 == 2: w = int(signed(a) < signed(y))
        elif f3 == 3: w = int(a < y)
        elif f3 == 4: w = a ^ y
        elif f3 == 5: w = (signed(a) if alt else a) >> (y & 31)
        elif f3 == 6: w = a | y
        else: w = a & y
    elif op == 0x03:
        assert f3 == 2, 'only lw is supported'
        addr = (a + imm_i) & 0xffffffff
        assert addr % 4 == 0 and addr < 256
        w = mem[addr // 4]; count['loads'] += 1
    elif op == 0x23:
        assert f3 == 2, 'only sw is supported'
        addr = (a + sx((i >> 25) << 5 | rd, 12)) & 0xffffffff
        assert addr % 4 == 0 and addr < 256
        mem[addr // 4] = b; count['stores'] += 1
    elif op == 0x63:
        off = sx((i >> 31) << 12 | (i >> 7 & 1) << 11 | (i >> 25 & 63) << 5 | (i >> 8 & 15) << 1, 13)
        t = [a == b, a != b, None, None, signed(a) < signed(b), signed(a) >= signed(b), a < b, a >= b][f3]
        count['branches'] += 1
        per_branch[pc][0] += 1
        per_branch[pc][1] += int(t)
        if t:
            nxt = pc + off; count['taken branches'] += 1
    elif op == 0x6f:
        off = sx((i >> 31) << 20 | (i >> 12 & 255) << 12 | (i >> 20 & 1) << 11 | (i >> 21 & 1023) << 1, 21)
        w, nxt = pc + 4, pc + off; count['jumps'] += 1
    elif op == 0x67:
        w, nxt = pc + 4, (a + imm_i) & 0xfffffffe; count['jumps'] += 1
    elif op == 0x37: w = i & 0xfffff000
    elif op == 0x17: w = pc + (i & 0xfffff000)
    else:
        raise SystemExit('unknown instruction %08x' % i)
    if w is not None and rd:
        reg[rd] = w & 0xffffffff
    pc = nxt
for k in ['instructions', 'branches', 'taken branches', 'loads', 'stores', 'jumps']:
    print('%-15s %d' % (k, count[k]))
print('C =', mem[24:28])
print('branch PC: executed / taken (miss)')
for a, (e, t) in sorted(per_branch.items()):
    print('  0x%03x: %3d / %3d' % (a, e, t))
n, pen = count['instructions'], count['taken branches'] + count['loads'] + count['jumps']
print('expected cycles: pipelined %d, non-pipelined %d' % (n + 2 * pen, 3 * n))
