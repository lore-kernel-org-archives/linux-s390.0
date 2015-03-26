Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Mar 2015 10:52:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.0-rc6
Message-ID: <20150326105206.31837e14@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

A couple of bug fixes for s390. The ftrace comile fix is quite large
for a -rc6 release, but it would be nice to have it in 4.0.

Heiko Carstens (2):
      s390/ftrace: fix compile error if CONFIG_KPROBES is disabled
      s390/smp: reenable smt after resume

Hendrik Brueckner (1):
      s390/cpum_sf: add diagnostic sampling event only if it is authorized

Martin Schwidefsky (1):
      s390/mm: limit STACK_RND_MASK for compat tasks

 arch/s390/include/asm/elf.h     |  2 +-
 arch/s390/kernel/ftrace.c       | 61 ++++++++++++++++++++++++++++++-----------
 arch/s390/kernel/perf_cpum_sf.c |  7 +++--
 arch/s390/kernel/swsusp_asm64.S | 11 ++++++++
 4 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index c9df40b..c9c875d 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -211,7 +211,7 @@ do {								\
 
 extern unsigned long mmap_rnd_mask;
 
-#define STACK_RND_MASK	(mmap_rnd_mask)
+#define STACK_RND_MASK	(test_thread_flag(TIF_31BIT) ? 0x7ff : mmap_rnd_mask)
 
 #define ARCH_DLINFO							    \
 do {									    \
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 82c1989..6c79f1b 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -57,6 +57,44 @@
 
 unsigned long ftrace_plt;
 
+static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
+{
+#ifdef CC_USING_HOTPATCH
+	/* brcl 0,0 */
+	insn->opc = 0xc004;
+	insn->disp = 0;
+#else
+	/* stg r14,8(r15) */
+	insn->opc = 0xe3e0;
+	insn->disp = 0xf0080024;
+#endif
+}
+
+static inline int is_kprobe_on_ftrace(struct ftrace_insn *insn)
+{
+#ifdef CONFIG_KPROBES
+	if (insn->opc == BREAKPOINT_INSTRUCTION)
+		return 1;
+#endif
+	return 0;
+}
+
+static inline void ftrace_generate_kprobe_nop_insn(struct ftrace_insn *insn)
+{
+#ifdef CONFIG_KPROBES
+	insn->opc = BREAKPOINT_INSTRUCTION;
+	insn->disp = KPROBE_ON_FTRACE_NOP;
+#endif
+}
+
+static inline void ftrace_generate_kprobe_call_insn(struct ftrace_insn *insn)
+{
+#ifdef CONFIG_KPROBES
+	insn->opc = BREAKPOINT_INSTRUCTION;
+	insn->disp = KPROBE_ON_FTRACE_CALL;
+#endif
+}
+
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
@@ -72,16 +110,9 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		return -EFAULT;
 	if (addr == MCOUNT_ADDR) {
 		/* Initial code replacement */
-#ifdef CC_USING_HOTPATCH
-		/* We expect to see brcl 0,0 */
-		ftrace_generate_nop_insn(&orig);
-#else
-		/* We expect to see stg r14,8(r15) */
-		orig.opc = 0xe3e0;
-		orig.disp = 0xf0080024;
-#endif
+		ftrace_generate_orig_insn(&orig);
 		ftrace_generate_nop_insn(&new);
-	} else if (old.opc == BREAKPOINT_INSTRUCTION) {
+	} else if (is_kprobe_on_ftrace(&old)) {
 		/*
 		 * If we find a breakpoint instruction, a kprobe has been
 		 * placed at the beginning of the function. We write the
@@ -89,9 +120,8 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		 * bytes of the original instruction so that the kprobes
 		 * handler can execute a nop, if it reaches this breakpoint.
 		 */
-		new.opc = orig.opc = BREAKPOINT_INSTRUCTION;
-		orig.disp = KPROBE_ON_FTRACE_CALL;
-		new.disp = KPROBE_ON_FTRACE_NOP;
+		ftrace_generate_kprobe_call_insn(&orig);
+		ftrace_generate_kprobe_nop_insn(&new);
 	} else {
 		/* Replace ftrace call with a nop. */
 		ftrace_generate_call_insn(&orig, rec->ip);
@@ -111,7 +141,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	if (probe_kernel_read(&old, (void *) rec->ip, sizeof(old)))
 		return -EFAULT;
-	if (old.opc == BREAKPOINT_INSTRUCTION) {
+	if (is_kprobe_on_ftrace(&old)) {
 		/*
 		 * If we find a breakpoint instruction, a kprobe has been
 		 * placed at the beginning of the function. We write the
@@ -119,9 +149,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		 * bytes of the original instruction so that the kprobes
 		 * handler can execute a brasl if it reaches this breakpoint.
 		 */
-		new.opc = orig.opc = BREAKPOINT_INSTRUCTION;
-		orig.disp = KPROBE_ON_FTRACE_NOP;
-		new.disp = KPROBE_ON_FTRACE_CALL;
+		ftrace_generate_kprobe_nop_insn(&orig);
+		ftrace_generate_kprobe_call_insn(&new);
 	} else {
 		/* Replace nop with an ftrace call. */
 		ftrace_generate_nop_insn(&orig);
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index c3f8d15..e6a1578 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1415,7 +1415,7 @@ CPUMF_EVENT_ATTR(SF, SF_CYCLES_BASIC_DIAG, PERF_EVENT_CPUM_SF_DIAG);
 
 static struct attribute *cpumsf_pmu_events_attr[] = {
 	CPUMF_EVENT_PTR(SF, SF_CYCLES_BASIC),
-	CPUMF_EVENT_PTR(SF, SF_CYCLES_BASIC_DIAG),
+	NULL,
 	NULL,
 };
 
@@ -1606,8 +1606,11 @@ static int __init init_cpum_sampling_pmu(void)
 		return -EINVAL;
 	}
 
-	if (si.ad)
+	if (si.ad) {
 		sfb_set_limits(CPUM_SF_MIN_SDB, CPUM_SF_MAX_SDB);
+		cpumsf_pmu_events_attr[1] =
+			CPUMF_EVENT_PTR(SF, SF_CYCLES_BASIC_DIAG);
+	}
 
 	sfdbg = debug_register(KMSG_COMPONENT, 2, 1, 80);
 	if (!sfdbg)
diff --git a/arch/s390/kernel/swsusp_asm64.S b/arch/s390/kernel/swsusp_asm64.S
index 6b09fdf..ca62946 100644
--- a/arch/s390/kernel/swsusp_asm64.S
+++ b/arch/s390/kernel/swsusp_asm64.S
@@ -177,6 +177,17 @@ restart_entry:
 	lhi	%r1,1
 	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
 	sam64
+#ifdef CONFIG_SMP
+	larl	%r1,smp_cpu_mt_shift
+	icm	%r1,15,0(%r1)
+	jz	smt_done
+	llgfr	%r1,%r1
+smt_loop:
+	sigp	%r1,%r0,SIGP_SET_MULTI_THREADING
+	brc	8,smt_done			/* accepted */
+	brc	2,smt_loop			/* busy, try again */
+smt_done:
+#endif
 	larl	%r1,.Lnew_pgm_check_psw
 	lpswe	0(%r1)
 pgm_check_entry:
