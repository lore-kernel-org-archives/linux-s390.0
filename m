From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v2 1/5] processor.h: introduce cpu_relax_yield
Date: Tue, 25 Oct 2016 11:03:11 +0200
Message-ID: <1477386195-32736-2-git-send-email-borntraeger@de.ibm.com>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, sparclinux@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

For spinning loops people do often use barrier() or cpu_relax().
For most architectures cpu_relax and barrier are the same, but on
some architectures cpu_relax can add some latency.
For example on power,sparc64 and arc, cpu_relax can shift the CPU
towards other hardware threads in an SMT environment.
On s390 cpu_relax does even more, it uses an hypercall to the
hypervisor to give up the timeslice.
In contrast to the SMT yielding this can result in larger latencies.
In some places this latency is unwanted, so another variant
"cpu_relax_lowlatency" was introduced. Before this is used in more
and more places, lets revert the logic and provide a cpu_relax_yield
that can be called in places where yielding is more important than
latency. By default this is the same as cpu_relax on all architectures.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/alpha/include/asm/processor.h      | 1 +
 arch/arc/include/asm/processor.h        | 2 ++
 arch/arm/include/asm/processor.h        | 1 +
 arch/arm64/include/asm/processor.h      | 1 +
 arch/avr32/include/asm/processor.h      | 1 +
 arch/blackfin/include/asm/processor.h   | 1 +
 arch/c6x/include/asm/processor.h        | 1 +
 arch/cris/include/asm/processor.h       | 1 +
 arch/frv/include/asm/processor.h        | 1 +
 arch/h8300/include/asm/processor.h      | 1 +
 arch/hexagon/include/asm/processor.h    | 1 +
 arch/ia64/include/asm/processor.h       | 1 +
 arch/m32r/include/asm/processor.h       | 1 +
 arch/m68k/include/asm/processor.h       | 1 +
 arch/metag/include/asm/processor.h      | 1 +
 arch/microblaze/include/asm/processor.h | 1 +
 arch/mips/include/asm/processor.h       | 1 +
 arch/mn10300/include/asm/processor.h    | 1 +
 arch/nios2/include/asm/processor.h      | 1 +
 arch/openrisc/include/asm/processor.h   | 1 +
 arch/parisc/include/asm/processor.h     | 1 +
 arch/powerpc/include/asm/processor.h    | 1 +
 arch/s390/include/asm/processor.h       | 3 ++-
 arch/s390/kernel/processor.c            | 4 ++--
 arch/score/include/asm/processor.h      | 1 +
 arch/sh/include/asm/processor.h         | 1 +
 arch/sparc/include/asm/processor_32.h   | 1 +
 arch/sparc/include/asm/processor_64.h   | 1 +
 arch/tile/include/asm/processor.h       | 1 +
 arch/unicore32/include/asm/processor.h  | 1 +
 arch/x86/include/asm/processor.h        | 1 +
 arch/x86/um/asm/processor.h             | 1 +
 arch/xtensa/include/asm/processor.h     | 1 +
 33 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index 43a7559..0556fda 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -58,6 +58,7 @@ unsigned long get_wchan(struct task_struct *p);
   ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 #define ARCH_HAS_PREFETCH
diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index 16b630f..6c158d5 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -60,6 +60,7 @@ struct task_struct;
 #ifndef CONFIG_EZNPS_MTM_EXT
 
 #define cpu_relax()		barrier()
+#define cpu_relax_yield()	cpu_relax()
 #define cpu_relax_lowlatency()	cpu_relax()
 
 #else
@@ -67,6 +68,7 @@ struct task_struct;
 #define cpu_relax()     \
 	__asm__ __volatile__ (".word %0" : : "i"(CTOP_INST_SCHD_RW) : "memory")
 
+#define cpu_relax_yield()	cpu_relax()
 #define cpu_relax_lowlatency()	barrier()
 
 #endif
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 8a1e8e9..db660e0 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -82,6 +82,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define cpu_relax()			barrier()
 #endif
 
+#define cpu_relax_yield()  	              cpu_relax()
 #define cpu_relax_lowlatency()                cpu_relax()
 
 #define task_pt_regs(p) \
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 60e3482..3f9b0e5 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -149,6 +149,7 @@ static inline void cpu_relax(void)
 	asm volatile("yield" ::: "memory");
 }
 
+#define cpu_relax_yield()                     cpu_relax()
 #define cpu_relax_lowlatency()                cpu_relax()
 
 /* Thread switching */
diff --git a/arch/avr32/include/asm/processor.h b/arch/avr32/include/asm/processor.h
index 941593c..e412e8b 100644
--- a/arch/avr32/include/asm/processor.h
+++ b/arch/avr32/include/asm/processor.h
@@ -92,6 +92,7 @@ extern struct avr32_cpuinfo boot_cpu_data;
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
 
 #define cpu_relax()		barrier()
+#define cpu_relax_yield()	cpu_relax()
 #define cpu_relax_lowlatency()        cpu_relax()
 #define cpu_sync_pipeline()	asm volatile("sub pc, -2" : : : "memory")
 
diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
index 0c265ab..8b8704a 100644
--- a/arch/blackfin/include/asm/processor.h
+++ b/arch/blackfin/include/asm/processor.h
@@ -92,6 +92,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
 #define cpu_relax()    	smp_mb()
+#define cpu_relax_yield()      cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* Get the Silicon Revision of the chip */
diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
index f2ef31b..914d730 100644
--- a/arch/c6x/include/asm/processor.h
+++ b/arch/c6x/include/asm/processor.h
@@ -121,6 +121,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(task)	(task_pt_regs(task)->sp)
 
 #define cpu_relax()		do { } while (0)
+#define cpu_relax_yield()             cpu_relax()
 #define cpu_relax_lowlatency()        cpu_relax()
 
 extern const struct seq_operations cpuinfo_op;
diff --git a/arch/cris/include/asm/processor.h b/arch/cris/include/asm/processor.h
index 862126b..01dd52e 100644
--- a/arch/cris/include/asm/processor.h
+++ b/arch/cris/include/asm/processor.h
@@ -63,6 +63,7 @@ static inline void release_thread(struct task_struct *dead_task)
 #define init_stack      (init_thread_union.stack)
 
 #define cpu_relax()     barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 void default_idle(void);
diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
index 73f0a79..4d00d65 100644
--- a/arch/frv/include/asm/processor.h
+++ b/arch/frv/include/asm/processor.h
@@ -107,6 +107,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define	KSTK_ESP(tsk)	((tsk)->thread.frame0->sp)
 
 #define cpu_relax() barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* data cache prefetch */
diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
index 111df73..683a061 100644
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -127,6 +127,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
 #define cpu_relax()    barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency()	cpu_relax()
 
 #define HARD_RESET_NOW() ({		\
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
index d850113..1558ddb 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -56,6 +56,7 @@ struct thread_struct {
 }
 
 #define cpu_relax() __vmyield()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /*
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index ce53c50..4654b71 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -547,6 +547,7 @@ ia64_eoi (void)
 }
 
 #define cpu_relax()	ia64_hint(ia64_hint_pause)
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 static inline int
diff --git a/arch/m32r/include/asm/processor.h b/arch/m32r/include/asm/processor.h
index 9f8fd9b..b262037 100644
--- a/arch/m32r/include/asm/processor.h
+++ b/arch/m32r/include/asm/processor.h
@@ -133,6 +133,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 #endif /* _ASM_M32R_PROCESSOR_H */
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index c84a218..13e07ae 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -156,6 +156,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk)	((struct pt_regs *) ((tsk)->thread.esp0))
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 #endif
diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
index a0333eb..61d6e27 100644
--- a/arch/metag/include/asm/processor.h
+++ b/arch/metag/include/asm/processor.h
@@ -152,6 +152,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define user_stack_pointer(regs)        ((regs)->ctx.AX[0].U0)
 
 #define cpu_relax()     barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency()  cpu_relax()
 
 extern void setup_priv(void);
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index c38d0dd..fd7dd11 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -22,6 +22,7 @@
 extern const struct seq_operations cpuinfo_op;
 
 # define cpu_relax()		barrier()
+# define cpu_relax_yield() cpu_relax()
 # define cpu_relax_lowlatency()	cpu_relax()
 
 #define task_pt_regs(tsk) \
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 0d36c87..9a656f6 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -389,6 +389,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /*
diff --git a/arch/mn10300/include/asm/processor.h b/arch/mn10300/include/asm/processor.h
index b10ba12..89f63d1 100644
--- a/arch/mn10300/include/asm/processor.h
+++ b/arch/mn10300/include/asm/processor.h
@@ -69,6 +69,7 @@ extern void print_cpu_info(struct mn10300_cpuinfo *);
 extern void dodgy_tsc(void);
 
 #define cpu_relax() barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /*
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index 1c953f0..303e593 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -88,6 +88,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)	((tsk)->thread.kregs->sp)
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency()  cpu_relax()
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 70334c9..6ecfc2a 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -92,6 +92,7 @@ extern unsigned long thread_saved_pc(struct task_struct *t);
 #define init_stack      (init_thread_union.stack)
 
 #define cpu_relax()     barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 2e674e1..ea2ff9f 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -309,6 +309,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)	((tsk)->thread.regs.gr[30])
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /*
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c07c31b..908fa7c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -404,6 +404,7 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 #define cpu_relax()	barrier()
 #endif
 
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* Check that a certain kernel stack pointer is valid in task_struct p */
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 0332317..d05965b 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -234,8 +234,9 @@ static inline unsigned short stap(void)
 /*
  * Give up the time slice of the virtual PU.
  */
-void cpu_relax(void);
+void cpu_relax_yield(void);
 
+#define cpu_relax() cpu_relax_yield()
 #define cpu_relax_lowlatency()  barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 81d0808..9e60ef1 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -53,7 +53,7 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax(void)
+void notrace cpu_relax_yield(void)
 {
 	if (!smp_cpu_mtid && MACHINE_HAS_DIAG44) {
 		diag_stat_inc(DIAG_STAT_X044);
@@ -61,7 +61,7 @@ void notrace cpu_relax(void)
 	}
 	barrier();
 }
-EXPORT_SYMBOL(cpu_relax);
+EXPORT_SYMBOL(cpu_relax_yield);
 
 /*
  * cpu_init - initializes state that is per-CPU.
diff --git a/arch/score/include/asm/processor.h b/arch/score/include/asm/processor.h
index 851f441..e8e87b4 100644
--- a/arch/score/include/asm/processor.h
+++ b/arch/score/include/asm/processor.h
@@ -24,6 +24,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define current_text_addr() ({ __label__ _l; _l: &&_l; })
 
 #define cpu_relax()		barrier()
+#define cpu_relax_yield()	cpu_relax()
 #define cpu_relax_lowlatency()        cpu_relax()
 #define release_thread(thread)	do {} while (0)
 
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index f9a0994..099a991 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -97,6 +97,7 @@ extern struct sh_cpuinfo cpu_data[];
 
 #define cpu_sleep()	__asm__ __volatile__ ("sleep" : : : "memory")
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 void default_idle(void);
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 812fd08..50e908a3c 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -119,6 +119,7 @@ extern struct task_struct *last_task_used_math;
 int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
 
 #define cpu_relax()	barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 extern void (*sparc_idle)(void);
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index ce2595c..3e8fac7 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -216,6 +216,7 @@ unsigned long get_wchan(struct task_struct *task);
 				     "nop\n\t"				\
 				     ".previous"			\
 				     ::: "memory")
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* Prefetch support.  This is tuned for UltraSPARC-III and later.
diff --git a/arch/tile/include/asm/processor.h b/arch/tile/include/asm/processor.h
index 0684e88..91a39a5 100644
--- a/arch/tile/include/asm/processor.h
+++ b/arch/tile/include/asm/processor.h
@@ -264,6 +264,7 @@ static inline void cpu_relax(void)
 	barrier();
 }
 
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* Info on this processor (see fs/proc/cpuinfo.c) */
diff --git a/arch/unicore32/include/asm/processor.h b/arch/unicore32/include/asm/processor.h
index 8d21b7a..fc54d5d 100644
--- a/arch/unicore32/include/asm/processor.h
+++ b/arch/unicore32/include/asm/processor.h
@@ -71,6 +71,7 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
+#define cpu_relax_yield()		cpu_relax()
 #define cpu_relax_lowlatency()                cpu_relax()
 
 #define task_pt_regs(p) \
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 984a7bf..44adada 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -588,6 +588,7 @@ static __always_inline void cpu_relax(void)
 	rep_nop();
 }
 
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* Stop speculative execution and prefetching of modified code. */
diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index 233ee09..01597af 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -26,6 +26,7 @@ static inline void rep_nop(void)
 }
 
 #define cpu_relax()		rep_nop()
+#define cpu_relax_yield()	cpu_relax()
 #define cpu_relax_lowlatency()	cpu_relax()
 
 #define task_pt_regs(t) (&(t)->thread.regs)
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index b42d68b..fe14dc2 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -206,6 +206,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
 
 #define cpu_relax()  barrier()
+#define cpu_relax_yield() cpu_relax()
 #define cpu_relax_lowlatency() cpu_relax()
 
 /* Special register access. */
-- 
2.5.5
