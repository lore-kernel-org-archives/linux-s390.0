Return-Path: <SRS0=ZPcH=QL=vger.kernel.org=netdev-owner@kernel.org>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] s390: bpf: fix JMP32 code-gen
Date: Mon,  4 Feb 2019 16:44:55 +0100
Message-Id: <20190204154455.88687-1-heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jiong Wang <jiong.wang@netronome.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Commit 626a5f66da0d19 ("s390: bpf: implement jitting of JMP32") added
JMP32 code-gen support for s390. However it triggers the warning below
due to some unusual gotos in the original s390 bpf jit code.

Add a couple of additional "is_jmp32" initializations to fix this.
Also fix the wrong opcode for the "llilf" instruction that was
introduced with the same commit.

arch/s390/net/bpf_jit_comp.c: In function 'bpf_jit_insn':
arch/s390/net/bpf_jit_comp.c:248:55: warning: 'is_jmp32' may be used uninitialized in this function [-Wmaybe-uninitialized]
  _EMIT6(op1 | reg(b1, b2) << 16 | (rel & 0xffff), op2 | mask); \
                                                       ^
arch/s390/net/bpf_jit_comp.c:1211:8: note: 'is_jmp32' was declared here
   bool is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;

Fixes: 626a5f66da0d19 ("s390: bpf: implement jitting of JMP32")
Cc: Jiong Wang <jiong.wang@netronome.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ce9defdff62a..51dd0267d014 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1154,7 +1154,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		mask = 0x7000; /* jnz */
 		if (BPF_CLASS(insn->code) == BPF_JMP32) {
 			/* llilf %w1,imm (load zero extend imm) */
-			EMIT6_IMM(0xc0010000, REG_W1, imm);
+			EMIT6_IMM(0xc00f0000, REG_W1, imm);
 			/* nr %w1,%dst */
 			EMIT2(0x1400, REG_W1, dst_reg);
 		} else {
@@ -1216,6 +1216,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 			  REG_W1, dst_reg, src_reg);
 		goto branch_oc;
 branch_ks:
+		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 		/* lgfi %w1,imm (load sign extend imm) */
 		EMIT6_IMM(0xc0010000, REG_W1, imm);
 		/* crj or cgrj %dst,%w1,mask,off */
@@ -1223,6 +1224,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 			    dst_reg, REG_W1, i, off, mask);
 		break;
 branch_ku:
+		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 		/* lgfi %w1,imm (load sign extend imm) */
 		EMIT6_IMM(0xc0010000, REG_W1, imm);
 		/* clrj or clgrj %dst,%w1,mask,off */
@@ -1230,11 +1232,13 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 			    dst_reg, REG_W1, i, off, mask);
 		break;
 branch_xs:
+		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 		/* crj or cgrj %dst,%src,mask,off */
 		EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0076 : 0x0064),
 			    dst_reg, src_reg, i, off, mask);
 		break;
 branch_xu:
+		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 		/* clrj or clgrj %dst,%src,mask,off */
 		EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0077 : 0x0065),
 			    dst_reg, src_reg, i, off, mask);
-- 
2.16.4
