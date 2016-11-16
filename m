From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/1] sched: provide common cpu_relax_yield definition
Date: Wed, 16 Nov 2016 12:42:34 +0000
Message-ID: <20161116124233.GD1041@n2100.armlinux.org.uk>
References: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479298985-191589-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, sparclinux@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 16, 2016 at 01:23:05PM +0100, Christian Borntraeger wrote:
> No need to duplicate the same define everywhere. Since
> the only user is stop-machine and the only provider is
> s390, we can use a default implementation of cpu_relax_yield
> in sched.h.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks for that.  (Please change my address above when adding this ack...)

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> ---
>  arch/alpha/include/asm/processor.h      | 1 -
>  arch/arc/include/asm/processor.h        | 3 ---
>  arch/arm/include/asm/processor.h        | 2 --
>  arch/arm64/include/asm/processor.h      | 2 --
>  arch/avr32/include/asm/processor.h      | 1 -
>  arch/blackfin/include/asm/processor.h   | 1 -
>  arch/c6x/include/asm/processor.h        | 1 -
>  arch/cris/include/asm/processor.h       | 1 -
>  arch/frv/include/asm/processor.h        | 1 -
>  arch/h8300/include/asm/processor.h      | 1 -
>  arch/hexagon/include/asm/processor.h    | 1 -
>  arch/ia64/include/asm/processor.h       | 1 -
>  arch/m32r/include/asm/processor.h       | 1 -
>  arch/m68k/include/asm/processor.h       | 1 -
>  arch/metag/include/asm/processor.h      | 1 -
>  arch/microblaze/include/asm/processor.h | 1 -
>  arch/mips/include/asm/processor.h       | 1 -
>  arch/mn10300/include/asm/processor.h    | 1 -
>  arch/nios2/include/asm/processor.h      | 1 -
>  arch/openrisc/include/asm/processor.h   | 1 -
>  arch/parisc/include/asm/processor.h     | 1 -
>  arch/powerpc/include/asm/processor.h    | 2 --
>  arch/s390/include/asm/processor.h       | 1 +
>  arch/score/include/asm/processor.h      | 1 -
>  arch/sh/include/asm/processor.h         | 1 -
>  arch/sparc/include/asm/processor_32.h   | 1 -
>  arch/sparc/include/asm/processor_64.h   | 1 -
>  arch/tile/include/asm/processor.h       | 2 --
>  arch/unicore32/include/asm/processor.h  | 1 -
>  arch/x86/include/asm/processor.h        | 2 --
>  arch/x86/um/asm/processor.h             | 1 -
>  arch/xtensa/include/asm/processor.h     | 1 -
>  include/linux/sched.h                   | 4 ++++
>  33 files changed, 5 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
> index 31e8dbe..2fec2de 100644
> --- a/arch/alpha/include/asm/processor.h
> +++ b/arch/alpha/include/asm/processor.h
> @@ -58,7 +58,6 @@ unsigned long get_wchan(struct task_struct *p);
>    ((tsk) == current ? rdusp() : task_thread_info(tsk)->pcb.usp)
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  #define ARCH_HAS_PREFETCH
>  #define ARCH_HAS_PREFETCHW
> diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
> index d102a49..6e1242d 100644
> --- a/arch/arc/include/asm/processor.h
> +++ b/arch/arc/include/asm/processor.h
> @@ -60,15 +60,12 @@ struct task_struct;
>  #ifndef CONFIG_EZNPS_MTM_EXT
>  
>  #define cpu_relax()		barrier()
> -#define cpu_relax_yield()	cpu_relax()
>  
>  #else
>  
>  #define cpu_relax()     \
>  	__asm__ __volatile__ (".word %0" : : "i"(CTOP_INST_SCHD_RW) : "memory")
>  
> -#define cpu_relax_yield()	cpu_relax()
> -
>  #endif
>  
>  #define copy_segments(tsk, mm)      do { } while (0)
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 9e71c58b..c3d5fc1 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -82,8 +82,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define cpu_relax()			barrier()
>  #endif
>  
> -#define cpu_relax_yield()  	              cpu_relax()
> -
>  #define task_pt_regs(p) \
>  	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
>  
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 6132f64..747c65a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -149,8 +149,6 @@ static inline void cpu_relax(void)
>  	asm volatile("yield" ::: "memory");
>  }
>  
> -#define cpu_relax_yield()                     cpu_relax()
> -
>  /* Thread switching */
>  extern struct task_struct *cpu_switch_to(struct task_struct *prev,
>  					 struct task_struct *next);
> diff --git a/arch/avr32/include/asm/processor.h b/arch/avr32/include/asm/processor.h
> index ee62365..972adcc 100644
> --- a/arch/avr32/include/asm/processor.h
> +++ b/arch/avr32/include/asm/processor.h
> @@ -92,7 +92,6 @@ extern struct avr32_cpuinfo boot_cpu_data;
>  #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
>  
>  #define cpu_relax()		barrier()
> -#define cpu_relax_yield()	cpu_relax()
>  #define cpu_sync_pipeline()	asm volatile("sub pc, -2" : : : "memory")
>  
>  struct cpu_context {
> diff --git a/arch/blackfin/include/asm/processor.h b/arch/blackfin/include/asm/processor.h
> index 57acfb1..85d4af9 100644
> --- a/arch/blackfin/include/asm/processor.h
> +++ b/arch/blackfin/include/asm/processor.h
> @@ -92,7 +92,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
>  
>  #define cpu_relax()    	smp_mb()
> -#define cpu_relax_yield()      cpu_relax()
>  
>  /* Get the Silicon Revision of the chip */
>  static inline uint32_t __pure bfin_revid(void)
> diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
> index 1fd22e7..b9eb3da 100644
> --- a/arch/c6x/include/asm/processor.h
> +++ b/arch/c6x/include/asm/processor.h
> @@ -121,7 +121,6 @@ extern unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_ESP(task)	(task_pt_regs(task)->sp)
>  
>  #define cpu_relax()		do { } while (0)
> -#define cpu_relax_yield()             cpu_relax()
>  
>  extern const struct seq_operations cpuinfo_op;
>  
> diff --git a/arch/cris/include/asm/processor.h b/arch/cris/include/asm/processor.h
> index 1a57841..15b815d 100644
> --- a/arch/cris/include/asm/processor.h
> +++ b/arch/cris/include/asm/processor.h
> @@ -63,7 +63,6 @@ static inline void release_thread(struct task_struct *dead_task)
>  #define init_stack      (init_thread_union.stack)
>  
>  #define cpu_relax()     barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  void default_idle(void);
>  
> diff --git a/arch/frv/include/asm/processor.h b/arch/frv/include/asm/processor.h
> index c1e5f2a..ddaeb9c 100644
> --- a/arch/frv/include/asm/processor.h
> +++ b/arch/frv/include/asm/processor.h
> @@ -107,7 +107,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define	KSTK_ESP(tsk)	((tsk)->thread.frame0->sp)
>  
>  #define cpu_relax() barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  /* data cache prefetch */
>  #define ARCH_HAS_PREFETCH
> diff --git a/arch/h8300/include/asm/processor.h b/arch/h8300/include/asm/processor.h
> index 42d6053..65132d7 100644
> --- a/arch/h8300/include/asm/processor.h
> +++ b/arch/h8300/include/asm/processor.h
> @@ -127,7 +127,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
>  
>  #define cpu_relax()    barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  #define HARD_RESET_NOW() ({		\
>  	local_irq_disable();		\
> diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
> index 5d694cc..45a8254 100644
> --- a/arch/hexagon/include/asm/processor.h
> +++ b/arch/hexagon/include/asm/processor.h
> @@ -56,7 +56,6 @@ struct thread_struct {
>  }
>  
>  #define cpu_relax() __vmyield()
> -#define cpu_relax_yield() cpu_relax()
>  
>  /*
>   * Decides where the kernel will search for a free chunk of vm space during
> diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
> index 0c2c3b2..03911a3 100644
> --- a/arch/ia64/include/asm/processor.h
> +++ b/arch/ia64/include/asm/processor.h
> @@ -547,7 +547,6 @@ ia64_eoi (void)
>  }
>  
>  #define cpu_relax()	ia64_hint(ia64_hint_pause)
> -#define cpu_relax_yield() cpu_relax()
>  
>  static inline int
>  ia64_get_irr(unsigned int vector)
> diff --git a/arch/m32r/include/asm/processor.h b/arch/m32r/include/asm/processor.h
> index 9b83a13..5767367 100644
> --- a/arch/m32r/include/asm/processor.h
> +++ b/arch/m32r/include/asm/processor.h
> @@ -133,6 +133,5 @@ unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  #endif /* _ASM_M32R_PROCESSOR_H */
> diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
> index b0d0442..f5f790c 100644
> --- a/arch/m68k/include/asm/processor.h
> +++ b/arch/m68k/include/asm/processor.h
> @@ -156,6 +156,5 @@ unsigned long get_wchan(struct task_struct *p);
>  #define task_pt_regs(tsk)	((struct pt_regs *) ((tsk)->thread.esp0))
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  #endif
> diff --git a/arch/metag/include/asm/processor.h b/arch/metag/include/asm/processor.h
> index ee302a6..ec6a490 100644
> --- a/arch/metag/include/asm/processor.h
> +++ b/arch/metag/include/asm/processor.h
> @@ -152,7 +152,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define user_stack_pointer(regs)        ((regs)->ctx.AX[0].U0)
>  
>  #define cpu_relax()     barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  extern void setup_priv(void);
>  
> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
> index 08ec1f7..37ef196 100644
> --- a/arch/microblaze/include/asm/processor.h
> +++ b/arch/microblaze/include/asm/processor.h
> @@ -22,7 +22,6 @@
>  extern const struct seq_operations cpuinfo_op;
>  
>  # define cpu_relax()		barrier()
> -# define cpu_relax_yield() cpu_relax()
>  
>  #define task_pt_regs(tsk) \
>  		(((struct pt_regs *)(THREAD_SIZE + task_stack_page(tsk))) - 1)
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 8ea95e7..95b8c47 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -389,7 +389,6 @@ unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  /*
>   * Return_address is a replacement for __builtin_return_address(count)
> diff --git a/arch/mn10300/include/asm/processor.h b/arch/mn10300/include/asm/processor.h
> index d11397b..18e17ab 100644
> --- a/arch/mn10300/include/asm/processor.h
> +++ b/arch/mn10300/include/asm/processor.h
> @@ -69,7 +69,6 @@ extern void print_cpu_info(struct mn10300_cpuinfo *);
>  extern void dodgy_tsc(void);
>  
>  #define cpu_relax() barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  /*
>   * User space process size: 1.75GB (default).
> diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
> index d32c176..3bbbc3d 100644
> --- a/arch/nios2/include/asm/processor.h
> +++ b/arch/nios2/include/asm/processor.h
> @@ -88,7 +88,6 @@ extern unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_ESP(tsk)	((tsk)->thread.kregs->sp)
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
> index 7f47fc7..a908e6c 100644
> --- a/arch/openrisc/include/asm/processor.h
> +++ b/arch/openrisc/include/asm/processor.h
> @@ -92,7 +92,6 @@ extern unsigned long thread_saved_pc(struct task_struct *t);
>  #define init_stack      (init_thread_union.stack)
>  
>  #define cpu_relax()     barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_OPENRISC_PROCESSOR_H */
> diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
> index a4a07f4..ca40741 100644
> --- a/arch/parisc/include/asm/processor.h
> +++ b/arch/parisc/include/asm/processor.h
> @@ -309,7 +309,6 @@ extern unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_ESP(tsk)	((tsk)->thread.regs.gr[30])
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  /*
>   * parisc_requires_coherency() is used to identify the combined VIPT/PIPT
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 5684e68..dac83fc 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -404,8 +404,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
>  #define cpu_relax()	barrier()
>  #endif
>  
> -#define cpu_relax_yield() cpu_relax()
> -
>  /* Check that a certain kernel stack pointer is valid in task_struct p */
>  int validate_sp(unsigned long sp, struct task_struct *p,
>                         unsigned long nbytes);
> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 17c001a..9eab1cb 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -234,6 +234,7 @@ static inline unsigned short stap(void)
>  /*
>   * Give up the time slice of the virtual PU.
>   */
> +#define cpu_relax_yield cpu_relax_yield
>  void cpu_relax_yield(void);
>  
>  #define cpu_relax() barrier()
> diff --git a/arch/score/include/asm/processor.h b/arch/score/include/asm/processor.h
> index a1e97c0..d9a922d 100644
> --- a/arch/score/include/asm/processor.h
> +++ b/arch/score/include/asm/processor.h
> @@ -24,7 +24,6 @@ extern unsigned long get_wchan(struct task_struct *p);
>  #define current_text_addr() ({ __label__ _l; _l: &&_l; })
>  
>  #define cpu_relax()		barrier()
> -#define cpu_relax_yield()	cpu_relax()
>  #define release_thread(thread)	do {} while (0)
>  
>  /*
> diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
> index 9454ff1..5addd69 100644
> --- a/arch/sh/include/asm/processor.h
> +++ b/arch/sh/include/asm/processor.h
> @@ -97,7 +97,6 @@ extern struct sh_cpuinfo cpu_data[];
>  
>  #define cpu_sleep()	__asm__ __volatile__ ("sleep" : : : "memory")
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  void default_idle(void);
>  void stop_this_cpu(void *);
> diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
> index fc32b73..365d4cb 100644
> --- a/arch/sparc/include/asm/processor_32.h
> +++ b/arch/sparc/include/asm/processor_32.h
> @@ -119,7 +119,6 @@ extern struct task_struct *last_task_used_math;
>  int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
>  
>  #define cpu_relax()	barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  extern void (*sparc_idle)(void);
>  
> diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
> index 12787df..6448cfc 100644
> --- a/arch/sparc/include/asm/processor_64.h
> +++ b/arch/sparc/include/asm/processor_64.h
> @@ -216,7 +216,6 @@ unsigned long get_wchan(struct task_struct *task);
>  				     "nop\n\t"				\
>  				     ".previous"			\
>  				     ::: "memory")
> -#define cpu_relax_yield() cpu_relax()
>  
>  /* Prefetch support.  This is tuned for UltraSPARC-III and later.
>   * UltraSPARC-I will treat these as nops, and UltraSPARC-II has
> diff --git a/arch/tile/include/asm/processor.h b/arch/tile/include/asm/processor.h
> index c1c228b..0bc9968 100644
> --- a/arch/tile/include/asm/processor.h
> +++ b/arch/tile/include/asm/processor.h
> @@ -264,8 +264,6 @@ static inline void cpu_relax(void)
>  	barrier();
>  }
>  
> -#define cpu_relax_yield() cpu_relax()
> -
>  /* Info on this processor (see fs/proc/cpuinfo.c) */
>  struct seq_operations;
>  extern const struct seq_operations cpuinfo_op;
> diff --git a/arch/unicore32/include/asm/processor.h b/arch/unicore32/include/asm/processor.h
> index eeefe7c..4eaa421 100644
> --- a/arch/unicore32/include/asm/processor.h
> +++ b/arch/unicore32/include/asm/processor.h
> @@ -71,7 +71,6 @@ extern void release_thread(struct task_struct *);
>  unsigned long get_wchan(struct task_struct *p);
>  
>  #define cpu_relax()			barrier()
> -#define cpu_relax_yield()		cpu_relax()
>  
>  #define task_pt_regs(p) \
>  	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 7513c99..c84605b 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -588,8 +588,6 @@ static __always_inline void cpu_relax(void)
>  	rep_nop();
>  }
>  
> -#define cpu_relax_yield() cpu_relax()
> -
>  /* Stop speculative execution and prefetching of modified code. */
>  static inline void sync_core(void)
>  {
> diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
> index b4bd63b..c77db22 100644
> --- a/arch/x86/um/asm/processor.h
> +++ b/arch/x86/um/asm/processor.h
> @@ -26,7 +26,6 @@ static inline void rep_nop(void)
>  }
>  
>  #define cpu_relax()		rep_nop()
> -#define cpu_relax_yield()	cpu_relax()
>  
>  #define task_pt_regs(t) (&(t)->thread.regs)
>  
> diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
> index 7d8d6be..86ffcd6 100644
> --- a/arch/xtensa/include/asm/processor.h
> +++ b/arch/xtensa/include/asm/processor.h
> @@ -206,7 +206,6 @@ extern unsigned long get_wchan(struct task_struct *p);
>  #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
>  
>  #define cpu_relax()  barrier()
> -#define cpu_relax_yield() cpu_relax()
>  
>  /* Special register access. */
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 348f51b..c1aa3b0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2444,6 +2444,10 @@ static inline void calc_load_enter_idle(void) { }
>  static inline void calc_load_exit_idle(void) { }
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
> +#ifndef cpu_relax_yield
> +#define cpu_relax_yield() cpu_relax()
> +#endif
> +
>  /*
>   * Do not use outside of architecture code which knows its limitations.
>   *
> -- 
> 2.5.5
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
