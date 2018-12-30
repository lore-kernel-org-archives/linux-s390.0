From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] jump_label: move 'asm goto' support test to Kconfig
Date: Mon, 31 Dec 2018 00:14:15 +0900
Message-ID: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, masahiroy@kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Max Filippov <jcmvbkbc@gmail.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

Currently, CONFIG_JUMP_LABEL just means "I _want_ to use jump label".

The jump label is controlled by HAVE_JUMP_LABEL, which is defined
like this:

  #if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
  # define HAVE_JUMP_LABEL
  #endif

We can improve this by testing 'asm goto' support in Kconfig, then
make JUMP_LABEL depend on CC_HAS_ASM_GOTO.

Ugly #ifdef HAVE_JUMP_LABEL will go away, and CONFIG_JUMP_LABEL will
match to the real kernel capability.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This is a trivial conversion from the build system PoV.
I want to queue this up to kbuild tree.


 Makefile                                          |  7 -------
 arch/Kconfig                                      |  1 +
 arch/arm/kernel/jump_label.c                      |  4 ----
 arch/arm64/kernel/jump_label.c                    |  4 ----
 arch/mips/kernel/jump_label.c                     |  4 ----
 arch/powerpc/include/asm/asm-prototypes.h         |  2 +-
 arch/powerpc/kernel/jump_label.c                  |  2 --
 arch/powerpc/platforms/powernv/opal-tracepoints.c |  2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S    |  2 +-
 arch/powerpc/platforms/pseries/hvCall.S           |  4 ++--
 arch/powerpc/platforms/pseries/lpar.c             |  2 +-
 arch/s390/kernel/Makefile                         |  3 ++-
 arch/s390/kernel/jump_label.c                     |  4 ----
 arch/sparc/kernel/Makefile                        |  2 +-
 arch/sparc/kernel/jump_label.c                    |  4 ----
 arch/x86/Makefile                                 |  2 +-
 arch/x86/entry/calling.h                          |  2 +-
 arch/x86/include/asm/cpufeature.h                 |  2 +-
 arch/x86/include/asm/jump_label.h                 | 13 -------------
 arch/x86/include/asm/rmwcc.h                      |  6 +++---
 arch/x86/kernel/Makefile                          |  3 ++-
 arch/x86/kernel/jump_label.c                      |  4 ----
 arch/x86/kvm/emulate.c                            |  2 +-
 arch/xtensa/kernel/jump_label.c                   |  4 ----
 include/linux/dynamic_debug.h                     |  6 +++---
 include/linux/jump_label.h                        | 22 +++++++++-------------
 include/linux/jump_label_ratelimit.h              |  8 +++-----
 include/linux/module.h                            |  2 +-
 include/linux/netfilter.h                         |  4 ++--
 include/linux/netfilter_ingress.h                 |  2 +-
 init/Kconfig                                      |  3 +++
 kernel/jump_label.c                               | 10 +++-------
 kernel/module.c                                   |  2 +-
 kernel/sched/core.c                               |  2 +-
 kernel/sched/debug.c                              |  4 ++--
 kernel/sched/fair.c                               |  6 +++---
 kernel/sched/sched.h                              |  6 +++---
 lib/dynamic_debug.c                               |  2 +-
 net/core/dev.c                                    |  6 +++---
 net/netfilter/core.c                              |  6 +++---
 scripts/gcc-goto.sh                               |  2 +-
 tools/arch/x86/include/asm/rmwcc.h                |  6 +++---
 42 files changed, 65 insertions(+), 119 deletions(-)

diff --git a/Makefile b/Makefile
index 60a4732..04a8578 100644
--- a/Makefile
+++ b/Makefile
@@ -514,13 +514,6 @@ RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
-# check for 'asm goto'
-ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
-  CC_HAVE_ASM_GOTO := 1
-  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
-  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
-endif
-
 # The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
 # Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
 # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
diff --git a/arch/Kconfig b/arch/Kconfig
index e1e540f..1281dcc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -71,6 +71,7 @@ config KPROBES
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
+       depends on CC_HAS_ASM_GOTO
        help
          This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
index 90bce3d..303b3ab 100644
--- a/arch/arm/kernel/jump_label.c
+++ b/arch/arm/kernel/jump_label.c
@@ -4,8 +4,6 @@
 #include <asm/patch.h>
 #include <asm/insn.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 static void __arch_jump_label_transform(struct jump_entry *entry,
 					enum jump_label_type type,
 					bool is_static)
@@ -35,5 +33,3 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
 {
 	__arch_jump_label_transform(entry, type, true);
 }
-
-#endif
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index 646b9562..1eff270 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -20,8 +20,6 @@
 #include <linux/jump_label.h>
 #include <asm/insn.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
@@ -49,5 +47,3 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
 	 * NOP needs to be replaced by a branch.
 	 */
 }
-
-#endif	/* HAVE_JUMP_LABEL */
diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
index 32e3168..ab94392 100644
--- a/arch/mips/kernel/jump_label.c
+++ b/arch/mips/kernel/jump_label.c
@@ -16,8 +16,6 @@
 #include <asm/cacheflush.h>
 #include <asm/inst.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 /*
  * Define parameters for the standard MIPS and the microMIPS jump
  * instruction encoding respectively:
@@ -70,5 +68,3 @@ void arch_jump_label_transform(struct jump_entry *e,
 
 	mutex_unlock(&text_mutex);
 }
-
-#endif /* HAVE_JUMP_LABEL */
diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 6f201b1..1d911f6 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -38,7 +38,7 @@ extern struct static_key hcall_tracepoint_key;
 void __trace_hcall_entry(unsigned long opcode, unsigned long *args);
 void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf);
 /* OPAL tracing */
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 extern struct static_key opal_tracepoint_key;
 #endif
 
diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
index 6472472..0080c5f 100644
--- a/arch/powerpc/kernel/jump_label.c
+++ b/arch/powerpc/kernel/jump_label.c
@@ -11,7 +11,6 @@
 #include <linux/jump_label.h>
 #include <asm/code-patching.h>
 
-#ifdef HAVE_JUMP_LABEL
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
@@ -22,4 +21,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	else
 		patch_instruction(addr, PPC_INST_NOP);
 }
-#endif
diff --git a/arch/powerpc/platforms/powernv/opal-tracepoints.c b/arch/powerpc/platforms/powernv/opal-tracepoints.c
index 1ab7d26..f16a435 100644
--- a/arch/powerpc/platforms/powernv/opal-tracepoints.c
+++ b/arch/powerpc/platforms/powernv/opal-tracepoints.c
@@ -4,7 +4,7 @@
 #include <asm/trace.h>
 #include <asm/asm-prototypes.h>
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 struct static_key opal_tracepoint_key = STATIC_KEY_INIT;
 
 int opal_tracepoint_regfunc(void)
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 2515282..f4875fe 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -20,7 +20,7 @@
 	.section	".text"
 
 #ifdef CONFIG_TRACEPOINTS
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 #define OPAL_BRANCH(LABEL)					\
 	ARCH_STATIC_BRANCH(LABEL, opal_tracepoint_key)
 #else
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index d91412c..50dc942 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -19,7 +19,7 @@
 	
 #ifdef CONFIG_TRACEPOINTS
 
-#ifndef HAVE_JUMP_LABEL
+#ifndef CONFIG_JUMP_LABEL
 	.section	".toc","aw"
 
 	.globl hcall_tracepoint_refcount
@@ -79,7 +79,7 @@ hcall_tracepoint_refcount:
 	mr	r5,BUFREG;					\
 	__HCALL_INST_POSTCALL
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 #define HCALL_BRANCH(LABEL)					\
 	ARCH_STATIC_BRANCH(LABEL, hcall_tracepoint_key)
 #else
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 32d4452..f2a9f0a 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1040,7 +1040,7 @@ EXPORT_SYMBOL(arch_free_page);
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 #ifdef CONFIG_TRACEPOINTS
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 struct static_key hcall_tracepoint_key = STATIC_KEY_INIT;
 
 int hcall_tracepoint_regfunc(void)
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 386b1ab..e216e11 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -48,7 +48,7 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 obj-y	:= traps.o time.o process.o base.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o early_nobss.o
-obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
+obj-y	+= sysinfo.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
 obj-y	+= nospec-branch.o ipl_vmparm.o
@@ -72,6 +72,7 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 50a1798..3f10b56 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -10,8 +10,6 @@
 #include <linux/jump_label.h>
 #include <asm/ipl.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 struct insn {
 	u16 opcode;
 	s32 offset;
@@ -103,5 +101,3 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
 {
 	__jump_label_transform(entry, type, 1);
 }
-
-#endif
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index cf86408..97c0e19 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -118,4 +118,4 @@ pc--$(CONFIG_PERF_EVENTS) := perf_event.o
 obj-$(CONFIG_SPARC64)	+= $(pc--y)
 
 obj-$(CONFIG_UPROBES)	+= uprobes.o
-obj-$(CONFIG_SPARC64)	+= jump_label.o
+obj-$(CONFIG_JUMP_LABEL) += jump_label.o
diff --git a/arch/sparc/kernel/jump_label.c b/arch/sparc/kernel/jump_label.c
index 7f8eac5..a4cfaee 100644
--- a/arch/sparc/kernel/jump_label.c
+++ b/arch/sparc/kernel/jump_label.c
@@ -9,8 +9,6 @@
 
 #include <asm/cacheflush.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
@@ -47,5 +45,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	flushi(insn);
 	mutex_unlock(&text_mutex);
 }
-
-#endif
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 16c3145..9c5a67d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -289,7 +289,7 @@ vdso_install:
 
 archprepare: checkbin
 checkbin:
-ifndef CC_HAVE_ASM_GOTO
+ifndef CONFIG_CC_HAS_ASM_GOTO
 	@echo Compiler lacks asm-goto support.
 	@exit 1
 endif
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 20d0885..efb0d1b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -351,7 +351,7 @@ For 32-bit we have the following conventions - kernel is built with
  */
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
 #endif
 	call enter_from_user_mode
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index aced6c9..ce95b8c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,7 +140,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
-#if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)
+#if defined(__clang__) && !defined(CONFIG_CC_HAS_ASM_GOTO)
 
 /*
  * Workaround for the sake of BPF compilation which utilizes kernel
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 21efc9d..65191ce 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,19 +2,6 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
-#ifndef HAVE_JUMP_LABEL
-/*
- * For better or for worse, if jump labels (the gcc extension) are missing,
- * then the entire static branch patching infrastructure is compiled out.
- * If that happens, the code in here will malfunction.  Raise a compiler
- * error instead.
- *
- * In theory, jump labels and the static branch patching infrastructure
- * could be decoupled to fix this.
- */
-#error asm/jump_label.h included on a non-jump-label kernel
-#endif
-
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 46ac84b..8a9eba1 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -11,7 +11,7 @@
 
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
-#if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
+#if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CONFIG_CC_HAS_ASM_GOTO)
 
 /* Use asm goto */
 
@@ -27,7 +27,7 @@ cc_label:	c = true;						\
 	c;								\
 })
 
-#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
+#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CONFIG_CC_HAS_ASM_GOTO) */
 
 /* Use flags output or a set instruction */
 
@@ -40,7 +40,7 @@ cc_label:	c = true;						\
 	c;								\
 })
 
-#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
+#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CONFIG_CC_HAS_ASM_GOTO) */
 
 #define GEN_UNARY_RMWcc_4(op, var, cc, arg0)				\
 	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01..da0b6bc 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -49,7 +49,8 @@ obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
-obj-y			+= setup.o x86_init.o i8259.o irqinit.o jump_label.o
+obj-y			+= setup.o x86_init.o i8259.o irqinit.o
+obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index aac0c1f..f99bd26 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,8 +16,6 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 union jump_code_union {
 	char code[JUMP_LABEL_NOP_SIZE];
 	struct {
@@ -130,5 +128,3 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 	if (jlstate == JL_STATE_UPDATE)
 		__jump_label_transform(entry, type, text_poke_early, 1);
 }
-
-#endif
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 78e430f..c338984 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -456,7 +456,7 @@ FOP_END;
 
 /*
  * XXX: inoutclob user must know where the argument is being expanded.
- *      Relying on CC_HAVE_ASM_GOTO would allow us to remove _fault.
+ *      Relying on CONFIG_CC_HAS_ASM_GOTO would allow us to remove _fault.
  */
 #define asm_safe(insn, inoutclob...) \
 ({ \
diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
index d108f72..61cf649 100644
--- a/arch/xtensa/kernel/jump_label.c
+++ b/arch/xtensa/kernel/jump_label.c
@@ -10,8 +10,6 @@
 
 #include <asm/cacheflush.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 #define J_OFFSET_MASK 0x0003ffff
 #define J_SIGN_MASK (~(J_OFFSET_MASK >> 1))
 
@@ -95,5 +93,3 @@ void arch_jump_label_transform(struct jump_entry *e,
 
 	patch_text(jump_entry_code(e), &insn, JUMP_LABEL_NOP_SIZE);
 }
-
-#endif /* HAVE_JUMP_LABEL */
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2fd8006..b3419da 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -2,7 +2,7 @@
 #ifndef _DYNAMIC_DEBUG_H
 #define _DYNAMIC_DEBUG_H
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
+#if defined(CONFIG_JUMP_LABEL)
 #include <linux/jump_label.h>
 #endif
 
@@ -38,7 +38,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
 		struct static_key_false dd_key_false;
@@ -83,7 +83,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		dd_key_init(key, init)				\
 	}
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 
 #define dd_key_init(key, init) key = (init)
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 5df6a62..3e113a1 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -71,10 +71,6 @@
  * Additional babbling in: Documentation/static-keys.txt
  */
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
-# define HAVE_JUMP_LABEL
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -86,7 +82,7 @@ extern bool static_key_initialized;
 				    "%s(): static key '%pS' used before call to jump_label_init()", \
 				    __func__, (key))
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 
 struct static_key {
 	atomic_t enabled;
@@ -114,10 +110,10 @@ struct static_key {
 struct static_key {
 	atomic_t enabled;
 };
-#endif	/* HAVE_JUMP_LABEL */
+#endif	/* CONFIG_JUMP_LABEL */
 #endif /* __ASSEMBLY__ */
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 #include <asm/jump_label.h>
 
 #ifndef __ASSEMBLY__
@@ -192,7 +188,7 @@ enum jump_label_type {
 
 struct module;
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 
 #define JUMP_TYPE_FALSE		0UL
 #define JUMP_TYPE_TRUE		1UL
@@ -245,7 +241,7 @@ extern void static_key_disable_cpuslocked(struct static_key *key);
 	{ .enabled = { 0 },					\
 	  { .entries = (void *)JUMP_TYPE_FALSE } }
 
-#else  /* !HAVE_JUMP_LABEL */
+#else  /* !CONFIG_JUMP_LABEL */
 
 #include <linux/atomic.h>
 #include <linux/bug.h>
@@ -330,7 +326,7 @@ static inline void static_key_disable(struct static_key *key)
 #define STATIC_KEY_INIT_TRUE	{ .enabled = ATOMIC_INIT(1) }
 #define STATIC_KEY_INIT_FALSE	{ .enabled = ATOMIC_INIT(0) }
 
-#endif	/* HAVE_JUMP_LABEL */
+#endif	/* CONFIG_JUMP_LABEL */
 
 #define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
 #define jump_label_enabled static_key_enabled
@@ -394,7 +390,7 @@ extern bool ____wrong_branch_error(void);
 	static_key_count((struct static_key *)x) > 0;				\
 })
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 
 /*
  * Combine the right initial value (type) with the right branch order
@@ -476,12 +472,12 @@ extern bool ____wrong_branch_error(void);
 	unlikely(branch);							\
 })
 
-#else /* !HAVE_JUMP_LABEL */
+#else /* !CONFIG_JUMP_LABEL */
 
 #define static_branch_likely(x)		likely(static_key_enabled(&(x)->key))
 #define static_branch_unlikely(x)	unlikely(static_key_enabled(&(x)->key))
 
-#endif /* HAVE_JUMP_LABEL */
+#endif /* CONFIG_JUMP_LABEL */
 
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
index baa8eab..a49f2b4 100644
--- a/include/linux/jump_label_ratelimit.h
+++ b/include/linux/jump_label_ratelimit.h
@@ -5,21 +5,19 @@
 #include <linux/jump_label.h>
 #include <linux/workqueue.h>
 
-#if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
+#if defined(CONFIG_JUMP_LABEL)
 struct static_key_deferred {
 	struct static_key key;
 	unsigned long timeout;
 	struct delayed_work work;
 };
-#endif
 
-#ifdef HAVE_JUMP_LABEL
 extern void static_key_slow_dec_deferred(struct static_key_deferred *key);
 extern void static_key_deferred_flush(struct static_key_deferred *key);
 extern void
 jump_label_rate_limit(struct static_key_deferred *key, unsigned long rl);
 
-#else	/* !HAVE_JUMP_LABEL */
+#else	/* !CONFIG_JUMP_LABEL */
 struct static_key_deferred {
 	struct static_key  key;
 };
@@ -38,5 +36,5 @@ jump_label_rate_limit(struct static_key_deferred *key,
 {
 	STATIC_KEY_CHECK_USE(key);
 }
-#endif	/* HAVE_JUMP_LABEL */
+#endif	/* CONFIG_JUMP_LABEL */
 #endif	/* _LINUX_JUMP_LABEL_RATELIMIT_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index d5453eb..9a21fe3 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -436,7 +436,7 @@ struct module {
 	unsigned int num_bpf_raw_events;
 	struct bpf_raw_event_map *bpf_raw_events;
 #endif
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
 	unsigned int num_jump_entries;
 #endif
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index bbe99d2..72cb19c 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -176,7 +176,7 @@ void nf_unregister_net_hooks(struct net *net, const struct nf_hook_ops *reg,
 int nf_register_sockopt(struct nf_sockopt_ops *reg);
 void nf_unregister_sockopt(struct nf_sockopt_ops *reg);
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 extern struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 #endif
 
@@ -198,7 +198,7 @@ static inline int nf_hook(u_int8_t pf, unsigned int hook, struct net *net,
 	struct nf_hook_entries *hook_head = NULL;
 	int ret = 1;
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	if (__builtin_constant_p(pf) &&
 	    __builtin_constant_p(hook) &&
 	    !static_key_false(&nf_hooks_needed[pf][hook]))
diff --git a/include/linux/netfilter_ingress.h b/include/linux/netfilter_ingress.h
index 554c920..a13774b 100644
--- a/include/linux/netfilter_ingress.h
+++ b/include/linux/netfilter_ingress.h
@@ -8,7 +8,7 @@
 #ifdef CONFIG_NETFILTER_INGRESS
 static inline bool nf_hook_ingress_active(const struct sk_buff *skb)
 {
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	if (!static_key_false(&nf_hooks_needed[NFPROTO_NETDEV][NF_NETDEV_INGRESS]))
 		return false;
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 3e6be16..d47cb77 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -23,6 +23,9 @@ config CLANG_VERSION
 	int
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
 
+config CC_HAS_ASM_GOTO
+	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b28028b..bad96b4 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -18,8 +18,6 @@
 #include <linux/cpu.h>
 #include <asm/sections.h>
 
-#ifdef HAVE_JUMP_LABEL
-
 /* mutex to protect coming/going of the the jump_label table */
 static DEFINE_MUTEX(jump_label_mutex);
 
@@ -80,13 +78,13 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 static void jump_label_update(struct static_key *key);
 
 /*
- * There are similar definitions for the !HAVE_JUMP_LABEL case in jump_label.h.
+ * There are similar definitions for the !CONFIG_JUMP_LABEL case in jump_label.h.
  * The use of 'atomic_read()' requires atomic.h and its problematic for some
  * kernel headers such as kernel.h and others. Since static_key_count() is not
- * used in the branch statements as it is for the !HAVE_JUMP_LABEL case its ok
+ * used in the branch statements as it is for the !CONFIG_JUMP_LABEL case its ok
  * to have it be a function here. Similarly, for 'static_key_enable()' and
  * 'static_key_disable()', which require bug.h. This should allow jump_label.h
- * to be included from most/all places for HAVE_JUMP_LABEL.
+ * to be included from most/all places for CONFIG_JUMP_LABEL.
  */
 int static_key_count(struct static_key *key)
 {
@@ -791,5 +789,3 @@ static __init int jump_label_test(void)
 }
 early_initcall(jump_label_test);
 #endif /* STATIC_KEYS_SELFTEST */
-
-#endif /* HAVE_JUMP_LABEL */
diff --git a/kernel/module.c b/kernel/module.c
index fcbc012..2ad1b52 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3102,7 +3102,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					   sizeof(*mod->bpf_raw_events),
 					   &mod->num_bpf_raw_events);
 #endif
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
 					sizeof(*mod->jump_entries),
 					&mod->num_jump_entries);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6692017..3c8db9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -24,7 +24,7 @@
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
+#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
  * Debugging: various feature bits
  *
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02bd5f9..de3de99 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -73,7 +73,7 @@ static int sched_feat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 
 #define jump_label_key__true  STATIC_KEY_INIT_TRUE
 #define jump_label_key__false STATIC_KEY_INIT_FALSE
@@ -99,7 +99,7 @@ static void sched_feat_enable(int i)
 #else
 static void sched_feat_disable(int i) { };
 static void sched_feat_enable(int i) { };
-#endif /* HAVE_JUMP_LABEL */
+#endif /* CONFIG_JUMP_LABEL */
 
 static int sched_feat_set(char *cmp)
 {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d190750..24bcde1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4218,7 +4218,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 
 #ifdef CONFIG_CFS_BANDWIDTH
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 static struct static_key __cfs_bandwidth_used;
 
 static inline bool cfs_bandwidth_used(void)
@@ -4235,7 +4235,7 @@ void cfs_bandwidth_usage_dec(void)
 {
 	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);
 }
-#else /* HAVE_JUMP_LABEL */
+#else /* CONFIG_JUMP_LABEL */
 static bool cfs_bandwidth_used(void)
 {
 	return true;
@@ -4243,7 +4243,7 @@ static bool cfs_bandwidth_used(void)
 
 void cfs_bandwidth_usage_inc(void) {}
 void cfs_bandwidth_usage_dec(void) {}
-#endif /* HAVE_JUMP_LABEL */
+#endif /* CONFIG_JUMP_LABEL */
 
 /*
  * default period for cfs group bandwidth.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ba0892..d04530b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1488,7 +1488,7 @@ enum {
 
 #undef SCHED_FEAT
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
+#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 
 /*
  * To support run-time toggling of sched features, all the translation units
@@ -1508,7 +1508,7 @@ static __always_inline bool static_branch_##name(struct static_key *key) \
 extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
 
-#else /* !(SCHED_DEBUG && HAVE_JUMP_LABEL) */
+#else /* !(SCHED_DEBUG && CONFIG_JUMP_LABEL) */
 
 /*
  * Each translation unit has its own copy of sysctl_sched_features to allow
@@ -1524,7 +1524,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
-#endif /* SCHED_DEBUG && HAVE_JUMP_LABEL */
+#endif /* SCHED_DEBUG && CONFIG_JUMP_LABEL */
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c7c96bc..dbf2b45 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -188,7 +188,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			newflags = (dp->flags & mask) | flags;
 			if (newflags == dp->flags)
 				continue;
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
 				if (!(flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1b5a441..82f2002 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1821,7 +1821,7 @@ EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
 static DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 static atomic_t netstamp_needed_deferred;
 static atomic_t netstamp_wanted;
 static void netstamp_clear(struct work_struct *work)
@@ -1840,7 +1840,7 @@ static DECLARE_WORK(netstamp_work, netstamp_clear);
 
 void net_enable_timestamp(void)
 {
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	int wanted;
 
 	while (1) {
@@ -1860,7 +1860,7 @@ EXPORT_SYMBOL(net_enable_timestamp);
 
 void net_disable_timestamp(void)
 {
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	int wanted;
 
 	while (1) {
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index dc240cb..93aaec3 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL_GPL(nf_ipv6_ops);
 DEFINE_PER_CPU(bool, nf_skb_duplicated);
 EXPORT_SYMBOL_GPL(nf_skb_duplicated);
 
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 EXPORT_SYMBOL(nf_hooks_needed);
 #endif
@@ -347,7 +347,7 @@ static int __nf_register_net_hook(struct net *net, int pf,
 	if (pf == NFPROTO_NETDEV && reg->hooknum == NF_NETDEV_INGRESS)
 		net_inc_ingress_queue();
 #endif
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 	static_key_slow_inc(&nf_hooks_needed[pf][reg->hooknum]);
 #endif
 	BUG_ON(p == new_hooks);
@@ -405,7 +405,7 @@ static void __nf_unregister_net_hook(struct net *net, int pf,
 		if (pf == NFPROTO_NETDEV && reg->hooknum == NF_NETDEV_INGRESS)
 			net_dec_ingress_queue();
 #endif
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
 		static_key_slow_dec(&nf_hooks_needed[pf][reg->hooknum]);
 #endif
 	} else {
diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
index 083c526..8b980fb 100755
--- a/scripts/gcc-goto.sh
+++ b/scripts/gcc-goto.sh
@@ -3,7 +3,7 @@
 # Test for gcc 'asm goto' support
 # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
 
-cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
+cat << "END" | $@ -x c - -fno-PIE -c -o /dev/null
 int main(void)
 {
 #if defined(__arm__) || defined(__aarch64__)
diff --git a/tools/arch/x86/include/asm/rmwcc.h b/tools/arch/x86/include/asm/rmwcc.h
index dc90c0c..fee7983 100644
--- a/tools/arch/x86/include/asm/rmwcc.h
+++ b/tools/arch/x86/include/asm/rmwcc.h
@@ -2,7 +2,7 @@
 #ifndef _TOOLS_LINUX_ASM_X86_RMWcc
 #define _TOOLS_LINUX_ASM_X86_RMWcc
 
-#ifdef CC_HAVE_ASM_GOTO
+#ifdef CONFIG_CC_HAS_ASM_GOTO
 
 #define __GEN_RMWcc(fullop, var, cc, ...)				\
 do {									\
@@ -20,7 +20,7 @@ cc_label:								\
 #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
 	__GEN_RMWcc(op " %1, " arg0, var, cc, vcon (val))
 
-#else /* !CC_HAVE_ASM_GOTO */
+#else /* !CONFIG_CC_HAS_ASM_GOTO */
 
 #define __GEN_RMWcc(fullop, var, cc, ...)				\
 do {									\
@@ -37,6 +37,6 @@ do {									\
 #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)			\
 	__GEN_RMWcc(op " %2, " arg0, var, cc, vcon (val))
 
-#endif /* CC_HAVE_ASM_GOTO */
+#endif /* CONFIG_CC_HAS_ASM_GOTO */
 
 #endif /* _TOOLS_LINUX_ASM_X86_RMWcc */
-- 
2.7.4
