Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] s390: Convert IS_ENABLED uses to __is_defined
Date: Tue,  9 Apr 2019 09:33:12 -0700
Message-Id: <3c15d21d2b6896e76e8801dc07de2bae1dadceb1.1554827560.git.joe@perches.com>
Sender: bpf-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/bpf/>
List-Post: <mailto:bpf@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

IS_ENABLED should be reserved for CONFIG_<FOO> uses so convert
the uses of IS_ENABLED with a #define to __is_defined.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/kernel/nospec-branch.c | 6 +++---
 arch/s390/kernel/nospec-sysfs.c  | 2 +-
 arch/s390/net/bpf_jit_comp.c     | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index bdddaae96559..8e484130b9b8 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -37,7 +37,7 @@ static int __init nospec_report(void)
 {
 	if (test_facility(156))
 		pr_info("Spectre V2 mitigation: etokens\n");
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+	if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable)
 		pr_info("Spectre V2 mitigation: execute trampolines\n");
 	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
 		pr_info("Spectre V2 mitigation: limited branch prediction\n");
@@ -63,10 +63,10 @@ void __init nospec_auto_detect(void)
 		 * The machine supports etokens.
 		 * Disable expolines and disable nobp.
 		 */
-		if (IS_ENABLED(CC_USING_EXPOLINE))
+		if (__is_defined(CC_USING_EXPOLINE))
 			nospec_disable = 1;
 		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
-	} else if (IS_ENABLED(CC_USING_EXPOLINE)) {
+	} else if (__is_defined(CC_USING_EXPOLINE)) {
 		/*
 		 * The kernel has been compiled with expolines.
 		 * Keep expolines enabled and disable nobp.
diff --git a/arch/s390/kernel/nospec-sysfs.c b/arch/s390/kernel/nospec-sysfs.c
index e30e580ae362..48f472bf9290 100644
--- a/arch/s390/kernel/nospec-sysfs.c
+++ b/arch/s390/kernel/nospec-sysfs.c
@@ -15,7 +15,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
 {
 	if (test_facility(156))
 		return sprintf(buf, "Mitigation: etokens\n");
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+	if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable)
 		return sprintf(buf, "Mitigation: execute trampolines\n");
 	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
 		return sprintf(buf, "Mitigation: limited branch prediction\n");
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 51dd0267d014..5e7c63033159 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -455,7 +455,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
 	save_restore_regs(jit, REGS_RESTORE, stack_depth);
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable) {
+	if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable) {
 		jit->r14_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r14 thunk */
 		if (test_facility(35)) {
@@ -473,7 +473,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	/* br %r14 */
 	_EMIT2(0x07fe);
 
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable &&
+	if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable &&
 	    (jit->seen & SEEN_FUNC)) {
 		jit->r1_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r1 thunk */
@@ -999,7 +999,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		/* lg %w1,<d(imm)>(%l) */
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_W1, REG_0, REG_L,
 			      EMIT_CONST_U64(func));
-		if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable) {
+		if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable) {
 			/* brasl %r14,__s390_indirect_jump_r1 */
 			EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
 		} else {
-- 
2.15.0
