From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/5] remove cpu_relax_lowlatency
Date: Fri, 21 Oct 2016 13:58:58 +0200
Message-ID: <1477051138-1610-6-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As there are no users left, we can remove cpu_relax_lowlatency.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/alpha/include/asm/processor.h      | 1 -
 arch/arm/include/asm/processor.h        | 1 -
 arch/arm64/include/asm/processor.h      | 1 -
 arch/avr32/include/asm/processor.h      | 1 -
 arch/blackfin/include/asm/processor.h   | 1 -
 arch/c6x/include/asm/processor.h        | 1 -
 arch/cris/include/asm/processor.h       | 1 -
 arch/frv/include/asm/processor.h        | 1 -
 arch/h8300/include/asm/processor.h      | 1 -
 arch/hexagon/include/asm/processor.h    | 1 -
 arch/ia64/include/asm/processor.h       | 1 -
 arch/m32r/include/asm/processor.h       | 1 -
 arch/m68k/include/asm/processor.h       | 1 -
 arch/metag/include/asm/processor.h      | 1 -
 arch/microblaze/include/asm/processor.h | 1 -
 arch/mips/include/asm/processor.h       | 1 -
 arch/mn10300/include/asm/processor.h    | 1 -
 arch/nios2/include/asm/processor.h      | 1 -
 arch/openrisc/include/asm/processor.h   | 1 -
 arch/parisc/include/asm/processor.h     | 1 -
 arch/powerpc/include/asm/processor.h    | 1 -
 arch/s390/include/asm/processor.h       | 1 -
 arch/score/include/asm/processor.h      | 1 -
 arch/sh/include/asm/processor.h         | 1 -
 arch/sparc/include/asm/processor_32.h   | 1 -
 arch/sparc/include/asm/processor_64.h   | 1 -
 arch/tile/include/asm/processor.h       | 1 -
 arch/unicore32/include/asm/processor.h  | 1 -
 arch/x86/include/asm/processor.h        | 1 -
 arch/xtensa/include/asm/processor.h     | 1 -
 30 files changed, 30 deletions(-)

diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index 0556fda..31e8dbe 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -59,7 +59,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index db660e0..9e71c58b 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -83,7 +83,6 @@ unsigned long get_wchan(struct task_struct *p);
 #endif
 
 #define cpu_relax_yield()  	              cpu_relax()
-#define cpu_relax_lowlatency()                cpu_relax()
 
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 797ee20..9274bf4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -150,7 +150,6 @@ static inline void cpu_relax(void)
 }
 
 #define cpu_relax_yield()                     cpu_relax()
-#define cpu_relax_lowlatency()                cpu_relax()
 
 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
diff --git a/arch/avr32/include/asm/processor.h b/arch/avr32/include/asm/processor.h
index e412e8b..ee62365 100644
--- a/arch/avr32/include/asm/processor.h
+++ b/arch/avr32/include/asm/processor.h
@@ -93,7 +93,6 @@ extern struct avr32_cpuinfo boot_cpu_data;
 
 #define cpu_relax()		barrier()
 #define cpu_relax_yield()	cpu_relax()
-#define cpu_relax_lowlatency()        cpu_relax()
 #define cpu_sync_pipeline()	asm volatile("sub pc, -2" : : : "memory")
 
 struct cpu_context {
diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
index 8b8704a..57acfb1 100644
--- a/arch/blackfin/include/asm/processor.h
+++ b/arch/blackfin/include/asm/processor.h
@@ -93,7 +93,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()    	smp_mb()
 #define cpu_relax_yield()      cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* Get the Silicon Revision of the chip */
 static inline uint32_t __pure bfin_revid(void)
diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
index 914d730..1fd22e7 100644
--- a/arch/c6x/include/asm/processor.h
+++ b/arch/c6x/include/asm/processor.h
@@ -122,7 +122,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()		do { } while (0)
 #define cpu_relax_yield()             cpu_relax()
-#define cpu_relax_lowlatency()        cpu_relax()
 
 extern const struct seq_operations cpuinfo_op;
 
diff --git a/arch/cris/include/asm/processor.h b/arch/cris/include/asm/processor.h
index 01dd52e..1a57841 100644
--- a/arch/cris/include/asm/processor.h
+++ b/arch/cris/include/asm/processor.h
@@ -64,7 +64,6 @@ static inline void release_thread(struct task_struct *dead_task)
 
 #define cpu_relax()     barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 void default_idle(void);
 
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
index 4d00d65..c1e5f2a 100644
--- a/arch/frv/include/asm/processor.h
+++ b/arch/frv/include/asm/processor.h
@@ -108,7 +108,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax() barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* data cache prefetch */
 #define ARCH_HAS_PREFETCH
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 683a061..42d6053 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -128,7 +128,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()    barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency()	cpu_relax()
 
 #define HARD_RESET_NOW() ({		\
 	local_irq_disable();		\
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
index 1558ddb..5d694cc 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -57,7 +57,6 @@ struct thread_struct {
 
 #define cpu_relax() __vmyield()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /*
  * Decides where the kernel will search for a free chunk of vm space during
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 4654b71..0c2c3b2 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -548,7 +548,6 @@ ia64_eoi (void)
 
 #define cpu_relax()	ia64_hint(ia64_hint_pause)
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 static inline int
 ia64_get_irr(unsigned int vector)
diff --git a/arch/m32r/include/asm/processor.h b/arch/m32r/include/asm/processor.h
index b262037..9b83a13 100644
--- a/arch/m32r/include/asm/processor.h
+++ b/arch/m32r/include/asm/processor.h
@@ -134,6 +134,5 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 #endif /* _ASM_M32R_PROCESSOR_H */
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index 13e07ae..b0d0442 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -157,6 +157,5 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 #endif
diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
index 61d6e27..ee302a6 100644
--- a/arch/metag/include/asm/processor.h
+++ b/arch/metag/include/asm/processor.h
@@ -153,7 +153,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()     barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency()  cpu_relax()
 
 extern void setup_priv(void);
 
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index fd7dd11..08ec1f7 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -23,7 +23,6 @@ extern const struct seq_operations cpuinfo_op;
 
 # define cpu_relax()		barrier()
 # define cpu_relax_yield() cpu_relax()
-# define cpu_relax_lowlatency()	cpu_relax()
 
 #define task_pt_regs(tsk) \
 		(((struct pt_regs *)(THREAD_SIZE + task_stack_page(tsk))) - 1)
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 9a656f6..8ea95e7 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -390,7 +390,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /*
  * Return_address is a replacement for __builtin_return_address(count)
diff --git a/arch/mn10300/include/asm/processor.h b/arch/mn10300/include/asm/processor.h
index 89f63d1..d11397b 100644
--- a/arch/mn10300/include/asm/processor.h
+++ b/arch/mn10300/include/asm/processor.h
@@ -70,7 +70,6 @@ extern void dodgy_tsc(void);
 
 #define cpu_relax() barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /*
  * User space process size: 1.75GB (default).
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index 303e593..d32c176 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -89,7 +89,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency()  cpu_relax()
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 6ecfc2a..7f47fc7 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -93,7 +93,6 @@ extern unsigned long thread_saved_pc(struct task_struct *t);
 
 #define cpu_relax()     barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_OPENRISC_PROCESSOR_H */
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index ea2ff9f..a4a07f4 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -310,7 +310,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /*
  * parisc_requires_coherency() is used to identify the combined VIPT/PIPT
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 908fa7c..5684e68 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -405,7 +405,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 #endif
 
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* Check that a certain kernel stack pointer is valid in task_struct p */
 int validate_sp(unsigned long sp, struct task_struct *p,
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 5d262cf..17c001a 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -237,7 +237,6 @@ static inline unsigned short stap(void)
 void cpu_relax_yield(void);
 
 #define cpu_relax() barrier()
-#define cpu_relax_lowlatency()  barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
 #define ECAG_CPU_ATTRIBUTE	1
diff --git a/arch/score/include/asm/processor.h b/arch/score/include/asm/processor.h
index e8e87b4..a1e97c0 100644
--- a/arch/score/include/asm/processor.h
+++ b/arch/score/include/asm/processor.h
@@ -25,7 +25,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()		barrier()
 #define cpu_relax_yield()	cpu_relax()
-#define cpu_relax_lowlatency()        cpu_relax()
 #define release_thread(thread)	do {} while (0)
 
 /*
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 099a991..9454ff1 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -98,7 +98,6 @@ extern struct sh_cpuinfo cpu_data[];
 #define cpu_sleep()	__asm__ __volatile__ ("sleep" : : : "memory")
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 void default_idle(void);
 void stop_this_cpu(void *);
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 50e908a3c..fc32b73 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -120,7 +120,6 @@ int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
 
 #define cpu_relax()	barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 extern void (*sparc_idle)(void);
 
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 3e8fac7..12787df 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -217,7 +217,6 @@ unsigned long get_wchan(struct task_struct *task);
 				     ".previous"			\
 				     ::: "memory")
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* Prefetch support.  This is tuned for UltraSPARC-III and later.
  * UltraSPARC-I will treat these as nops, and UltraSPARC-II has
diff --git a/arch/tile/include/asm/processor.h b/arch/tile/include/asm/processor.h
index 91a39a5..c1c228b 100644
--- a/arch/tile/include/asm/processor.h
+++ b/arch/tile/include/asm/processor.h
@@ -265,7 +265,6 @@ static inline void cpu_relax(void)
 }
 
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* Info on this processor (see fs/proc/cpuinfo.c) */
 struct seq_operations;
diff --git a/arch/unicore32/include/asm/processor.h b/arch/unicore32/include/asm/processor.h
index fc54d5d..eeefe7c 100644
--- a/arch/unicore32/include/asm/processor.h
+++ b/arch/unicore32/include/asm/processor.h
@@ -72,7 +72,6 @@ unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
 #define cpu_relax_yield()		cpu_relax()
-#define cpu_relax_lowlatency()                cpu_relax()
 
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 44adada..7513c99 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -589,7 +589,6 @@ static __always_inline void cpu_relax(void)
 }
 
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* Stop speculative execution and prefetching of modified code. */
 static inline void sync_core(void)
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index fe14dc2..7d8d6be 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -207,7 +207,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()  barrier()
 #define cpu_relax_yield() cpu_relax()
-#define cpu_relax_lowlatency() cpu_relax()
 
 /* Special register access. */
 
-- 
2.5.5
