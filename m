Return-Path: <linux-kernel-owner+w=401wt.eu-S1754053AbYL2Kvf@vger.kernel.org>
Subject: [GIT PULL] cputime patches for 2.6.29
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Mon, 29 Dec 2008 11:51:16 +0100
Message-Id: <1230547877.26091.18.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

and another one: the cputime accouting patches I've been working on the
last few weeks. The whole thing started with the observation that the
figures for the idle time from the hypervisor differ from the Linux
numbers. The bug is in Linux, the cpu cycles used by the idle process
are accounted as idle time instead of system time. To fix this I had to
split out the idle time accounting from account_system_time.

Please pull from 'cputime' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git cputime

to receive the following updates:

Martin Schwidefsky (6):
      fix scaled & unscaled cputime accounting
      idle cputime accounting
      improve precision of process accounting.
      improve precision of idle time detection.
      improve idle cputime accounting
      fast vdso implementation for CLOCK_THREAD_CPUTIME_ID

 arch/ia64/kernel/time.c                 |   18 +-
 arch/powerpc/kernel/process.c           |    1 +
 arch/powerpc/kernel/time.c              |   18 +-
 arch/s390/include/asm/cpu.h             |    7 +-
 arch/s390/include/asm/cputime.h         |   42 ++--
 arch/s390/include/asm/lowcore.h         |   49 ++--
 arch/s390/include/asm/system.h          |    4 +-
 arch/s390/include/asm/thread_info.h     |    2 +
 arch/s390/include/asm/timer.h           |   16 +-
 arch/s390/include/asm/vdso.h            |   15 +-
 arch/s390/kernel/asm-offsets.c          |    5 +
 arch/s390/kernel/entry.S                |    5 +-
 arch/s390/kernel/entry64.S              |   50 ++--
 arch/s390/kernel/head64.S               |    2 +
 arch/s390/kernel/process.c              |   43 +---
 arch/s390/kernel/s390_ext.c             |    2 +-
 arch/s390/kernel/setup.c                |    2 +
 arch/s390/kernel/smp.c                  |   34 ++-
 arch/s390/kernel/vdso.c                 |  123 ++++++++-
 arch/s390/kernel/vdso64/clock_getres.S  |    5 +
 arch/s390/kernel/vdso64/clock_gettime.S |   39 +++-
 arch/s390/kernel/vtime.c                |  478 ++++++++++++++++---------------
 arch/x86/xen/time.c                     |   10 +-
 drivers/s390/cio/cio.c                  |    2 +-
 drivers/s390/s390mach.c                 |    3 +
 include/linux/kernel_stat.h             |   13 +-
 include/linux/sched.h                   |    1 -
 kernel/sched.c                          |  116 +++++---
 kernel/time/tick-sched.c                |   12 +-
 kernel/timer.c                          |   15 -
 30 files changed, 675 insertions(+), 457 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 65c10a4..f0ebb34 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -93,13 +93,14 @@ void ia64_account_on_switch(struct task_struct *prev, struct task_struct *next)
 	now = ia64_get_itc();
 
 	delta_stime = cycle_to_cputime(pi->ac_stime + (now - pi->ac_stamp));
-	account_system_time(prev, 0, delta_stime);
-	account_system_time_scaled(prev, delta_stime);
+	if (idle_task(smp_processor_id()) != prev)
+		account_system_time(prev, 0, delta_stime, delta_stime);
+	else
+		account_idle_time(delta_stime);
 
 	if (pi->ac_utime) {
 		delta_utime = cycle_to_cputime(pi->ac_utime);
-		account_user_time(prev, delta_utime);
-		account_user_time_scaled(prev, delta_utime);
+		account_user_time(prev, delta_utime, delta_utime);
 	}
 
 	pi->ac_stamp = ni->ac_stamp = now;
@@ -122,8 +123,10 @@ void account_system_vtime(struct task_struct *tsk)
 	now = ia64_get_itc();
 
 	delta_stime = cycle_to_cputime(ti->ac_stime + (now - ti->ac_stamp));
-	account_system_time(tsk, 0, delta_stime);
-	account_system_time_scaled(tsk, delta_stime);
+	if (irq_count() || idle_task(smp_processor_id()) != tsk)
+		account_system_time(tsk, 0, delta_stime, delta_stime);
+	else
+		account_idle_time(delta_stime);
 	ti->ac_stime = 0;
 
 	ti->ac_stamp = now;
@@ -143,8 +146,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 
 	if (ti->ac_utime) {
 		delta_utime = cycle_to_cputime(ti->ac_utime);
-		account_user_time(p, delta_utime);
-		account_user_time_scaled(p, delta_utime);
+		account_user_time(p, delta_utime, delta_utime);
 		ti->ac_utime = 0;
 	}
 }
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 51b201d..fb7049c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -33,6 +33,7 @@
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index e1f3a51..3be355c 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -256,8 +256,10 @@ void account_system_vtime(struct task_struct *tsk)
 		delta += sys_time;
 		get_paca()->system_time = 0;
 	}
-	account_system_time(tsk, 0, delta);
-	account_system_time_scaled(tsk, deltascaled);
+	if (in_irq() || idle_task(smp_processor_id()) != tsk)
+		account_system_time(tsk, 0, delta, deltascaled);
+	else
+		account_idle_time(delta);
 	per_cpu(cputime_last_delta, smp_processor_id()) = delta;
 	per_cpu(cputime_scaled_last_delta, smp_processor_id()) = deltascaled;
 	local_irq_restore(flags);
@@ -275,10 +277,8 @@ void account_process_tick(struct task_struct *tsk, int user_tick)
 
 	utime = get_paca()->user_time;
 	get_paca()->user_time = 0;
-	account_user_time(tsk, utime);
-
 	utimescaled = cputime_to_scaled(utime);
-	account_user_time_scaled(tsk, utimescaled);
+	account_user_time(tsk, utime, utimescaled);
 }
 
 /*
@@ -338,8 +338,12 @@ void calculate_steal_time(void)
 	tb = mftb();
 	purr = mfspr(SPRN_PURR);
 	stolen = (tb - pme->tb) - (purr - pme->purr);
-	if (stolen > 0)
-		account_steal_time(current, stolen);
+	if (stolen > 0) {
+		if (idle_task(smp_processor_id()) != current)
+			account_steal_time(stolen);
+		else
+			account_idle_time(stolen);
+	}
 	pme->tb = tb;
 	pme->purr = purr;
 }
diff --git a/arch/s390/include/asm/cpu.h b/arch/s390/include/asm/cpu.h
index e5a6a9b..d60a2ee 100644
--- a/arch/s390/include/asm/cpu.h
+++ b/arch/s390/include/asm/cpu.h
@@ -14,7 +14,6 @@
 
 struct s390_idle_data {
 	spinlock_t lock;
-	unsigned int in_idle;
 	unsigned long long idle_count;
 	unsigned long long idle_enter;
 	unsigned long long idle_time;
@@ -22,12 +21,12 @@ struct s390_idle_data {
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
 
-void s390_idle_leave(void);
+void vtime_start_cpu(void);
 
 static inline void s390_idle_check(void)
 {
-	if ((&__get_cpu_var(s390_idle))->in_idle)
-		s390_idle_leave();
+	if ((&__get_cpu_var(s390_idle))->idle_enter != 0ULL)
+		vtime_start_cpu();
 }
 
 #endif /* _ASM_S390_CPU_H_ */
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index 133ce05..5217264 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -11,7 +11,7 @@
 
 #include <asm/div64.h>
 
-/* We want to use micro-second resolution. */
+/* We want to use full resolution of the CPU timer: 2**-12 micro-seconds. */
 
 typedef unsigned long long cputime_t;
 typedef unsigned long long cputime64_t;
@@ -53,9 +53,9 @@ __div(unsigned long long n, unsigned int base)
 #define cputime_ge(__a, __b)		((__a) >= (__b))
 #define cputime_lt(__a, __b)		((__a) <  (__b))
 #define cputime_le(__a, __b)		((__a) <= (__b))
-#define cputime_to_jiffies(__ct)	(__div((__ct), 1000000 / HZ))
+#define cputime_to_jiffies(__ct)	(__div((__ct), 4096000000ULL / HZ))
 #define cputime_to_scaled(__ct)		(__ct)
-#define jiffies_to_cputime(__hz)	((cputime_t)(__hz) * (1000000 / HZ))
+#define jiffies_to_cputime(__hz)	((cputime_t)(__hz) * (4096000000ULL / HZ))
 
 #define cputime64_zero			(0ULL)
 #define cputime64_add(__a, __b)		((__a) + (__b))
@@ -64,7 +64,7 @@ __div(unsigned long long n, unsigned int base)
 static inline u64
 cputime64_to_jiffies64(cputime64_t cputime)
 {
-	do_div(cputime, 1000000 / HZ);
+	do_div(cputime, 4096000000ULL / HZ);
 	return cputime;
 }
 
@@ -74,13 +74,13 @@ cputime64_to_jiffies64(cputime64_t cputime)
 static inline unsigned int
 cputime_to_msecs(const cputime_t cputime)
 {
-	return __div(cputime, 1000);
+	return __div(cputime, 4096000);
 }
 
 static inline cputime_t
 msecs_to_cputime(const unsigned int m)
 {
-	return (cputime_t) m * 1000;
+	return (cputime_t) m * 4096000;
 }
 
 /*
@@ -89,13 +89,13 @@ msecs_to_cputime(const unsigned int m)
 static inline unsigned int
 cputime_to_secs(const cputime_t cputime)
 {
-	return __div(cputime, 1000000);
+	return __div(cputime, 2048000000) >> 1;
 }
 
 static inline cputime_t
 secs_to_cputime(const unsigned int s)
 {
-	return (cputime_t) s * 1000000;
+	return (cputime_t) s * 4096000000ULL;
 }
 
 /*
@@ -104,7 +104,7 @@ secs_to_cputime(const unsigned int s)
 static inline cputime_t
 timespec_to_cputime(const struct timespec *value)
 {
-        return value->tv_nsec / 1000 + (u64) value->tv_sec * 1000000;
+	return value->tv_nsec * 4096 / 1000 + (u64) value->tv_sec * 4096000000ULL;
 }
 
 static inline void
@@ -114,12 +114,12 @@ cputime_to_timespec(const cputime_t cputime, struct timespec *value)
 	register_pair rp;
 
 	rp.pair = cputime >> 1;
-	asm ("dr %0,%1" : "+d" (rp) : "d" (1000000 >> 1));
-	value->tv_nsec = rp.subreg.even * 1000;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (2048000000UL));
+	value->tv_nsec = rp.subreg.even * 1000 / 4096;
 	value->tv_sec = rp.subreg.odd;
 #else
-	value->tv_nsec = (cputime % 1000000) * 1000;
-	value->tv_sec = cputime / 1000000;
+	value->tv_nsec = (cputime % 4096000000ULL) * 1000 / 4096;
+	value->tv_sec = cputime / 4096000000ULL;
 #endif
 }
 
@@ -131,7 +131,7 @@ cputime_to_timespec(const cputime_t cputime, struct timespec *value)
 static inline cputime_t
 timeval_to_cputime(const struct timeval *value)
 {
-        return value->tv_usec + (u64) value->tv_sec * 1000000;
+	return value->tv_usec * 4096 + (u64) value->tv_sec * 4096000000ULL;
 }
 
 static inline void
@@ -141,12 +141,12 @@ cputime_to_timeval(const cputime_t cputime, struct timeval *value)
 	register_pair rp;
 
 	rp.pair = cputime >> 1;
-	asm ("dr %0,%1" : "+d" (rp) : "d" (1000000 >> 1));
-	value->tv_usec = rp.subreg.even;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (2048000000UL));
+	value->tv_usec = rp.subreg.even / 4096;
 	value->tv_sec = rp.subreg.odd;
 #else
-	value->tv_usec = cputime % 1000000;
-	value->tv_sec = cputime / 1000000;
+	value->tv_usec = cputime % 4096000000ULL;
+	value->tv_sec = cputime / 4096000000ULL;
 #endif
 }
 
@@ -156,13 +156,13 @@ cputime_to_timeval(const cputime_t cputime, struct timeval *value)
 static inline clock_t
 cputime_to_clock_t(cputime_t cputime)
 {
-	return __div(cputime, 1000000 / USER_HZ);
+	return __div(cputime, 4096000000ULL / USER_HZ);
 }
 
 static inline cputime_t
 clock_t_to_cputime(unsigned long x)
 {
-	return (cputime_t) x * (1000000 / USER_HZ);
+	return (cputime_t) x * (4096000000ULL / USER_HZ);
 }
 
 /*
@@ -171,7 +171,7 @@ clock_t_to_cputime(unsigned long x)
 static inline clock_t
 cputime64_to_clock_t(cputime64_t cputime)
 {
-       return __div(cputime, 1000000 / USER_HZ);
+       return __div(cputime, 4096000000ULL / USER_HZ);
 }
 
 #endif /* _S390_CPUTIME_H */
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 0bc51d5..ffdef5f 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -67,11 +67,11 @@
 #define __LC_SYNC_ENTER_TIMER		0x248
 #define __LC_ASYNC_ENTER_TIMER		0x250
 #define __LC_EXIT_TIMER			0x258
-#define __LC_LAST_UPDATE_TIMER		0x260
-#define __LC_USER_TIMER			0x268
-#define __LC_SYSTEM_TIMER		0x270
-#define __LC_LAST_UPDATE_CLOCK		0x278
-#define __LC_STEAL_CLOCK		0x280
+#define __LC_USER_TIMER			0x260
+#define __LC_SYSTEM_TIMER		0x268
+#define __LC_STEAL_TIMER		0x270
+#define __LC_LAST_UPDATE_TIMER		0x278
+#define __LC_LAST_UPDATE_CLOCK		0x280
 #define __LC_RETURN_MCCK_PSW            0x288
 #define __LC_KERNEL_STACK               0xC40
 #define __LC_THREAD_INFO		0xC44
@@ -89,11 +89,11 @@
 #define __LC_SYNC_ENTER_TIMER		0x250
 #define __LC_ASYNC_ENTER_TIMER		0x258
 #define __LC_EXIT_TIMER			0x260
-#define __LC_LAST_UPDATE_TIMER		0x268
-#define __LC_USER_TIMER			0x270
-#define __LC_SYSTEM_TIMER		0x278
-#define __LC_LAST_UPDATE_CLOCK		0x280
-#define __LC_STEAL_CLOCK		0x288
+#define __LC_USER_TIMER			0x268
+#define __LC_SYSTEM_TIMER		0x270
+#define __LC_STEAL_TIMER		0x278
+#define __LC_LAST_UPDATE_TIMER		0x280
+#define __LC_LAST_UPDATE_CLOCK		0x288
 #define __LC_RETURN_MCCK_PSW            0x290
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_THREAD_INFO		0xD48
@@ -106,8 +106,10 @@
 #define __LC_IPLDEV                     0xDB8
 #define __LC_CURRENT			0xDD8
 #define __LC_INT_CLOCK			0xDE8
+#define __LC_VDSO_PER_CPU		0xE38
 #endif /* __s390x__ */
 
+#define __LC_PASTE			0xE40
 
 #define __LC_PANIC_MAGIC		0xE00
 #ifndef __s390x__
@@ -252,11 +254,11 @@ struct _lowcore
 	__u64        sync_enter_timer;         /* 0x248 */
 	__u64        async_enter_timer;        /* 0x250 */
 	__u64        exit_timer;               /* 0x258 */
-	__u64        last_update_timer;        /* 0x260 */
-	__u64        user_timer;               /* 0x268 */
-	__u64        system_timer;             /* 0x270 */
-	__u64        last_update_clock;        /* 0x278 */
-	__u64        steal_clock;              /* 0x280 */
+	__u64	     user_timer;	       /* 0x260 */
+	__u64	     system_timer;	       /* 0x268 */
+	__u64	     steal_timer;	       /* 0x270 */
+	__u64	     last_update_timer;        /* 0x278 */
+	__u64	     last_update_clock;        /* 0x280 */
         psw_t        return_mcck_psw;          /* 0x288 */
 	__u8         pad8[0xc00-0x290];        /* 0x290 */
 
@@ -343,11 +345,11 @@ struct _lowcore
 	__u64        sync_enter_timer;         /* 0x250 */
 	__u64        async_enter_timer;        /* 0x258 */
 	__u64        exit_timer;               /* 0x260 */
-	__u64        last_update_timer;        /* 0x268 */
-	__u64        user_timer;               /* 0x270 */
-	__u64        system_timer;             /* 0x278 */
-	__u64        last_update_clock;        /* 0x280 */
-	__u64        steal_clock;              /* 0x288 */
+	__u64	     user_timer;	       /* 0x268 */
+	__u64	     system_timer;	       /* 0x270 */
+	__u64	     steal_timer;	       /* 0x278 */
+	__u64	     last_update_timer;        /* 0x280 */
+	__u64	     last_update_clock;        /* 0x288 */
         psw_t        return_mcck_psw;          /* 0x290 */
         __u8         pad8[0xc00-0x2a0];        /* 0x2a0 */
         /* System info area */
@@ -381,7 +383,12 @@ struct _lowcore
         /* whether the kernel died with panic() or not */
         __u32        panic_magic;              /* 0xe00 */
 
-	__u8         pad13[0x11b8-0xe04];      /* 0xe04 */
+	/* Per cpu primary space access list */
+	__u8	     pad_0xe04[0xe3c-0xe04];   /* 0xe04 */
+	__u32	     vdso_per_cpu_data;	       /* 0xe3c */
+	__u32	     paste[16];		       /* 0xe40 */
+
+	__u8	     pad13[0x11b8-0xe80];      /* 0xe80 */
 
 	/* 64 bit extparam used for pfault, diag 250 etc  */
 	__u64        ext_params2;               /* 0x11B8 */
diff --git a/arch/s390/include/asm/system.h b/arch/s390/include/asm/system.h
index 024ef42..3a8b26e 100644
--- a/arch/s390/include/asm/system.h
+++ b/arch/s390/include/asm/system.h
@@ -99,7 +99,7 @@ static inline void restore_access_regs(unsigned int *acrs)
 	prev = __switch_to(prev,next);					     \
 } while (0)
 
-extern void account_vtime(struct task_struct *);
+extern void account_vtime(struct task_struct *, struct task_struct *);
 extern void account_tick_vtime(struct task_struct *);
 extern void account_system_vtime(struct task_struct *);
 
@@ -121,7 +121,7 @@ static inline void cmma_init(void) { }
 
 #define finish_arch_switch(prev) do {					     \
 	set_fs(current->thread.mm_segment);				     \
-	account_vtime(prev);						     \
+	account_vtime(prev, current);					     \
 } while (0)
 
 #define nop() asm volatile("nop")
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index c1eaf96..c544aa5 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -47,6 +47,8 @@ struct thread_info {
 	unsigned int		cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	struct restart_block	restart_block;
+	__u64			user_timer;
+	__u64			system_timer;
 };
 
 /*
diff --git a/arch/s390/include/asm/timer.h b/arch/s390/include/asm/timer.h
index 61705d6..e4bcab7 100644
--- a/arch/s390/include/asm/timer.h
+++ b/arch/s390/include/asm/timer.h
@@ -23,20 +23,18 @@ struct vtimer_list {
 	__u64 expires;
 	__u64 interval;
 
-	spinlock_t lock;
-	unsigned long magic;
-
 	void (*function)(unsigned long);
 	unsigned long data;
 };
 
-/* the offset value will wrap after ca. 71 years */
+/* the vtimer value will wrap after ca. 71 years */
 struct vtimer_queue {
 	struct list_head list;
 	spinlock_t lock;
-	__u64 to_expire;	  /* current event expire time */
-	__u64 offset;		  /* list offset to zero */
-	__u64 idle;		  /* temp var for idle */
+	__u64 timer;		/* last programmed timer */
+	__u64 elapsed;		/* elapsed time of timer expire values */
+	__u64 idle;		/* temp var for idle */
+	int do_spt;		/* =1: reprogram cpu timer in idle */
 };
 
 extern void init_virt_timer(struct vtimer_list *timer);
@@ -48,8 +46,8 @@ extern int del_virt_timer(struct vtimer_list *timer);
 extern void init_cpu_vtimer(void);
 extern void vtime_init(void);
 
-extern void vtime_start_cpu_timer(void);
-extern void vtime_stop_cpu_timer(void);
+extern void vtime_stop_cpu(void);
+extern void vtime_start_leave(void);
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index a44f4fe..7bdd7c8 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -12,9 +12,9 @@
 #ifndef __ASSEMBLY__
 
 /*
- * Note about this structure:
+ * Note about the vdso_data and vdso_per_cpu_data structures:
  *
- * NEVER USE THIS IN USERSPACE CODE DIRECTLY. The layout of this
+ * NEVER USE THEM IN USERSPACE CODE DIRECTLY. The layout of the
  * structure is supposed to be known only to the function in the vdso
  * itself and may change without notice.
  */
@@ -28,10 +28,21 @@ struct vdso_data {
 	__u64 wtom_clock_nsec;		/*				0x28 */
 	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x30 */
 	__u32 tz_dsttime;		/* Type of dst correction	0x34 */
+	__u32 ectg_available;
+};
+
+struct vdso_per_cpu_data {
+	__u64 ectg_timer_base;
+	__u64 ectg_user_time;
 };
 
 extern struct vdso_data *vdso_data;
 
+#ifdef CONFIG_64BIT
+int vdso_alloc_per_cpu(int cpu, struct _lowcore *lowcore);
+void vdso_free_per_cpu(int cpu, struct _lowcore *lowcore);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index e641f60..67a6001 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -48,6 +48,11 @@ int main(void)
 	DEFINE(__VDSO_WTOM_SEC, offsetof(struct vdso_data, wtom_clock_sec));
 	DEFINE(__VDSO_WTOM_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
 	DEFINE(__VDSO_TIMEZONE, offsetof(struct vdso_data, tz_minuteswest));
+	DEFINE(__VDSO_ECTG_OK, offsetof(struct vdso_data, ectg_available));
+	DEFINE(__VDSO_ECTG_BASE,
+	       offsetof(struct vdso_per_cpu_data, ectg_timer_base));
+	DEFINE(__VDSO_ECTG_USER,
+	       offsetof(struct vdso_per_cpu_data, ectg_user_time));
 	/* constants used by the vdso */
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 55de521..1268aa2 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -583,8 +583,8 @@ kernel_per:
 
 	.globl io_int_handler
 io_int_handler:
-	stpt	__LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
+	stpt	__LC_ASYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
 	SAVE_ALL_ASYNC __LC_IO_OLD_PSW,__LC_SAVE_AREA+16
 	CREATE_STACK_FRAME __LC_IO_OLD_PSW,__LC_SAVE_AREA+16
@@ -723,8 +723,8 @@ io_notify_resume:
 
 	.globl	ext_int_handler
 ext_int_handler:
-	stpt	__LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
+	stpt	__LC_ASYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA+16
 	SAVE_ALL_ASYNC __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16
 	CREATE_STACK_FRAME __LC_EXT_OLD_PSW,__LC_SAVE_AREA+16
@@ -750,6 +750,7 @@ __critical_end:
 
 	.globl mcck_int_handler
 mcck_int_handler:
+	stck	__LC_INT_CLOCK
 	spt	__LC_CPU_TIMER_SAVE_AREA	# revalidate cpu timer
 	lm	%r0,%r15,__LC_GPREGS_SAVE_AREA	# revalidate gprs
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 16bb4fd..c6fbde1 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -177,8 +177,11 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 	.if !\sync
 	ni	\psworg+1,0xfd		# clear wait state bit
 	.endif
-	lmg	%r0,%r15,SP_R0(%r15)	# load gprs 0-15 of user
+	lg	%r14,__LC_VDSO_PER_CPU
+	lmg	%r0,%r13,SP_R0(%r15)	# load gprs 0-13 of user
 	stpt	__LC_EXIT_TIMER
+	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
+	lmg	%r14,%r15,SP_R14(%r15)	# load grps 14-15 of user
 	lpswe	\psworg			# back to caller
 	.endm
 
@@ -559,8 +562,8 @@ kernel_per:
  */
 	.globl io_int_handler
 io_int_handler:
-	stpt	__LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
+	stpt	__LC_ASYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
 	SAVE_ALL_ASYNC __LC_IO_OLD_PSW,__LC_SAVE_AREA+32
 	CREATE_STACK_FRAME __LC_IO_OLD_PSW,__LC_SAVE_AREA+32
@@ -721,8 +724,8 @@ io_notify_resume:
  */
 	.globl	ext_int_handler
 ext_int_handler:
-	stpt	__LC_ASYNC_ENTER_TIMER
 	stck	__LC_INT_CLOCK
+	stpt	__LC_ASYNC_ENTER_TIMER
 	SAVE_ALL_BASE __LC_SAVE_AREA+32
 	SAVE_ALL_ASYNC __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32
 	CREATE_STACK_FRAME __LC_EXT_OLD_PSW,__LC_SAVE_AREA+32
@@ -746,6 +749,7 @@ __critical_end:
  */
 	.globl mcck_int_handler
 mcck_int_handler:
+	stck	__LC_INT_CLOCK
 	la	%r1,4095		# revalidate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
@@ -979,23 +983,23 @@ cleanup_sysc_return:
 
 cleanup_sysc_leave:
 	clc	8(8,%r12),BASED(cleanup_sysc_leave_insn)
-	je	2f
-	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	je	3f
 	clc	8(8,%r12),BASED(cleanup_sysc_leave_insn+8)
-	je	2f
-	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
+	jhe	0f
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+0:	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
 	cghi	%r12,__LC_MCK_OLD_PSW
-	jne	0f
+	jne	1f
 	mvc	__LC_SAVE_AREA+64(32),SP_R12(%r15)
-	j	1f
-0:	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
-1:	lmg	%r0,%r11,SP_R0(%r15)
+	j	2f
+1:	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
+2:	lmg	%r0,%r11,SP_R0(%r15)
 	lg	%r15,SP_R15(%r15)
-2:	la	%r12,__LC_RETURN_PSW
+3:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_sysc_leave_insn:
 	.quad	sysc_done - 4
-	.quad	sysc_done - 8
+	.quad	sysc_done - 16
 
 cleanup_io_return:
 	mvc	__LC_RETURN_PSW(8),0(%r12)
@@ -1005,23 +1009,23 @@ cleanup_io_return:
 
 cleanup_io_leave:
 	clc	8(8,%r12),BASED(cleanup_io_leave_insn)
-	je	2f
-	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+	je	3f
 	clc	8(8,%r12),BASED(cleanup_io_leave_insn+8)
-	je	2f
-	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
+	jhe	0f
+	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
+0:	mvc	__LC_RETURN_PSW(16),SP_PSW(%r15)
 	cghi	%r12,__LC_MCK_OLD_PSW
-	jne	0f
+	jne	1f
 	mvc	__LC_SAVE_AREA+64(32),SP_R12(%r15)
-	j	1f
-0:	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
-1:	lmg	%r0,%r11,SP_R0(%r15)
+	j	2f
+1:	mvc	__LC_SAVE_AREA+32(32),SP_R12(%r15)
+2:	lmg	%r0,%r11,SP_R0(%r15)
 	lg	%r15,SP_R15(%r15)
-2:	la	%r12,__LC_RETURN_PSW
+3:	la	%r12,__LC_RETURN_PSW
 	br	%r14
 cleanup_io_leave_insn:
 	.quad	io_done - 4
-	.quad	io_done - 8
+	.quad	io_done - 16
 
 /*
  * Integer constants
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index 3ccd36b..f9f70aa 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -87,6 +87,8 @@ startup_continue:
 	lg	%r12,.Lparmaddr-.LPG1(%r13)	# pointer to parameter area
 					# move IPL device to lowcore
 	mvc	__LC_IPLDEV(4),IPL_DEVICE+4-PARMAREA(%r12)
+	lghi	%r0,__LC_PASTE
+	stg	%r0,__LC_VDSO_PER_CPU
 #
 # Setup stack
 #
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 04f8c67..b6110bd 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -38,6 +38,7 @@
 #include <linux/utsname.h>
 #include <linux/tick.h>
 #include <linux/elfcore.h>
+#include <linux/kernel_stat.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -45,7 +46,6 @@
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/timer.h>
-#include <asm/cpu.h>
 #include "entry.h"
 
 asmlinkage void ret_from_fork(void) asm ("ret_from_fork");
@@ -75,36 +75,6 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 	return sf->gprs[8];
 }
 
-DEFINE_PER_CPU(struct s390_idle_data, s390_idle) = {
-	.lock = __SPIN_LOCK_UNLOCKED(s390_idle.lock)
-};
-
-static int s390_idle_enter(void)
-{
-	struct s390_idle_data *idle;
-
-	idle = &__get_cpu_var(s390_idle);
-	spin_lock(&idle->lock);
-	idle->idle_count++;
-	idle->in_idle = 1;
-	idle->idle_enter = get_clock();
-	spin_unlock(&idle->lock);
-	vtime_stop_cpu_timer();
-	return NOTIFY_OK;
-}
-
-void s390_idle_leave(void)
-{
-	struct s390_idle_data *idle;
-
-	vtime_start_cpu_timer();
-	idle = &__get_cpu_var(s390_idle);
-	spin_lock(&idle->lock);
-	idle->idle_time += get_clock() - idle->idle_enter;
-	idle->in_idle = 0;
-	spin_unlock(&idle->lock);
-}
-
 extern void s390_handle_mcck(void);
 /*
  * The idle loop on a S390...
@@ -117,10 +87,6 @@ static void default_idle(void)
 		local_irq_enable();
 		return;
 	}
-	if (s390_idle_enter() == NOTIFY_BAD) {
-		local_irq_enable();
-		return;
-	}
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_is_offline(smp_processor_id())) {
 		preempt_enable_no_resched();
@@ -130,7 +96,6 @@ static void default_idle(void)
 	local_mcck_disable();
 	if (test_thread_flag(TIF_MCCK_PENDING)) {
 		local_mcck_enable();
-		s390_idle_leave();
 		local_irq_enable();
 		s390_handle_mcck();
 		return;
@@ -138,9 +103,9 @@ static void default_idle(void)
 	trace_hardirqs_on();
 	/* Don't trace preempt off for idle. */
 	stop_critical_timings();
-	/* Wait for external, I/O or machine check interrupt. */
-	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
-			PSW_MASK_IO | PSW_MASK_EXT);
+	/* Stop virtual timer and halt the cpu. */
+	vtime_stop_cpu();
+	/* Reenable preemption tracer. */
 	start_critical_timings();
 }
 
diff --git a/arch/s390/kernel/s390_ext.c b/arch/s390/kernel/s390_ext.c
index e019b41..a0d2d55 100644
--- a/arch/s390/kernel/s390_ext.c
+++ b/arch/s390/kernel/s390_ext.c
@@ -119,8 +119,8 @@ void do_extint(struct pt_regs *regs, unsigned short code)
 	struct pt_regs *old_regs;
 
 	old_regs = set_irq_regs(regs);
-	irq_enter();
 	s390_idle_check();
+	irq_enter();
 	if (S390_lowcore.int_clock >= S390_lowcore.clock_comparator)
 		/* Serve timer interrupts first. */
 		clock_comparator_work();
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b7a1efd..d825f49 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -427,6 +427,8 @@ setup_lowcore(void)
 		/* enable extended save area */
 		__ctl_set_bit(14, 29);
 	}
+#else
+	lc->vdso_per_cpu_data = (unsigned long) &lc->paste[0];
 #endif
 	set_prefix((u32)(unsigned long) lc);
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 6fc7854..b3461e8 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -47,6 +47,7 @@
 #include <asm/lowcore.h>
 #include <asm/sclp.h>
 #include <asm/cpu.h>
+#include <asm/vdso.h>
 #include "entry.h"
 
 /*
@@ -506,6 +507,9 @@ static int __cpuinit smp_alloc_lowcore(int cpu)
 			goto out;
 		lowcore->extended_save_area_addr = (u32) save_area;
 	}
+#else
+	if (vdso_alloc_per_cpu(cpu, lowcore))
+		goto out;
 #endif
 	lowcore_ptr[cpu] = lowcore;
 	return 0;
@@ -528,6 +532,8 @@ static void smp_free_lowcore(int cpu)
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
 		free_page((unsigned long) lowcore->extended_save_area_addr);
+#else
+	vdso_free_per_cpu(cpu, lowcore);
 #endif
 	free_page(lowcore->panic_stack - PAGE_SIZE);
 	free_pages(lowcore->async_stack - ASYNC_SIZE, ASYNC_ORDER);
@@ -670,6 +676,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	lowcore = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, lc_order);
 	panic_stack = __get_free_page(GFP_KERNEL);
 	async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
+	BUG_ON(!lowcore || !panic_stack || !async_stack);
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
 		save_area = get_zeroed_page(GFP_KERNEL);
@@ -683,6 +690,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE)
 		lowcore->extended_save_area_addr = (u32) save_area;
+#else
+	BUG_ON(vdso_alloc_per_cpu(smp_processor_id(), lowcore));
 #endif
 	set_prefix((u32)(unsigned long) lowcore);
 	local_mcck_enable();
@@ -851,9 +860,11 @@ static ssize_t show_idle_count(struct sys_device *dev,
 	unsigned long long idle_count;
 
 	idle = &per_cpu(s390_idle, dev->id);
-	spin_lock_irq(&idle->lock);
+	spin_lock(&idle->lock);
 	idle_count = idle->idle_count;
-	spin_unlock_irq(&idle->lock);
+	if (idle->idle_enter)
+		idle_count++;
+	spin_unlock(&idle->lock);
 	return sprintf(buf, "%llu\n", idle_count);
 }
 static SYSDEV_ATTR(idle_count, 0444, show_idle_count, NULL);
@@ -862,18 +873,17 @@ static ssize_t show_idle_time(struct sys_device *dev,
 				struct sysdev_attribute *attr, char *buf)
 {
 	struct s390_idle_data *idle;
-	unsigned long long new_time;
+	unsigned long long now, idle_time, idle_enter;
 
 	idle = &per_cpu(s390_idle, dev->id);
-	spin_lock_irq(&idle->lock);
-	if (idle->in_idle) {
-		new_time = get_clock();
-		idle->idle_time += new_time - idle->idle_enter;
-		idle->idle_enter = new_time;
-	}
-	new_time = idle->idle_time;
-	spin_unlock_irq(&idle->lock);
-	return sprintf(buf, "%llu\n", new_time >> 12);
+	spin_lock(&idle->lock);
+	now = get_clock();
+	idle_time = idle->idle_time;
+	idle_enter = idle->idle_enter;
+	if (idle_enter != 0ULL && idle_enter < now)
+		idle_time += now - idle_enter;
+	spin_unlock(&idle->lock);
+	return sprintf(buf, "%llu\n", idle_time >> 12);
 }
 static SYSDEV_ATTR(idle_time_us, 0444, show_idle_time, NULL);
 
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 10a6cce..25a6a82 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -31,9 +31,6 @@
 #include <asm/sections.h>
 #include <asm/vdso.h>
 
-/* Max supported size for symbol names */
-#define MAX_SYMNAME	64
-
 #if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
@@ -71,6 +68,119 @@ static union {
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
 /*
+ * Setup vdso data page.
+ */
+static void vdso_init_data(struct vdso_data *vd)
+{
+	unsigned int facility_list;
+
+	facility_list = stfl();
+	vd->ectg_available = switch_amode && (facility_list & 1);
+}
+
+#ifdef CONFIG_64BIT
+/*
+ * Setup per cpu vdso data page.
+ */
+static void vdso_init_per_cpu_data(int cpu, struct vdso_per_cpu_data *vpcd)
+{
+}
+
+/*
+ * Allocate/free per cpu vdso data.
+ */
+#ifdef CONFIG_64BIT
+#define SEGMENT_ORDER	2
+#else
+#define SEGMENT_ORDER	1
+#endif
+
+int vdso_alloc_per_cpu(int cpu, struct _lowcore *lowcore)
+{
+	unsigned long segment_table, page_table, page_frame;
+	u32 *psal, *aste;
+	int i;
+
+	lowcore->vdso_per_cpu_data = __LC_PASTE;
+
+	if (!switch_amode || !vdso_enabled)
+		return 0;
+
+	segment_table = __get_free_pages(GFP_KERNEL, SEGMENT_ORDER);
+	page_table = get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	page_frame = get_zeroed_page(GFP_KERNEL);
+	if (!segment_table || !page_table || !page_frame)
+		goto out;
+
+	clear_table((unsigned long *) segment_table, _SEGMENT_ENTRY_EMPTY,
+		    PAGE_SIZE << SEGMENT_ORDER);
+	clear_table((unsigned long *) page_table, _PAGE_TYPE_EMPTY,
+		    256*sizeof(unsigned long));
+
+	*(unsigned long *) segment_table = _SEGMENT_ENTRY + page_table;
+	*(unsigned long *) page_table = _PAGE_RO + page_frame;
+
+	psal = (u32 *) (page_table + 256*sizeof(unsigned long));
+	aste = psal + 32;
+
+	for (i = 4; i < 32; i += 4)
+		psal[i] = 0x80000000;
+
+	lowcore->paste[4] = (u32)(addr_t) psal;
+	psal[0] = 0x20000000;
+	psal[2] = (u32)(addr_t) aste;
+	*(unsigned long *) (aste + 2) = segment_table +
+		_ASCE_TABLE_LENGTH + _ASCE_USER_BITS + _ASCE_TYPE_SEGMENT;
+	aste[4] = (u32)(addr_t) psal;
+	lowcore->vdso_per_cpu_data = page_frame;
+
+	vdso_init_per_cpu_data(cpu, (struct vdso_per_cpu_data *) page_frame);
+	return 0;
+
+out:
+	free_page(page_frame);
+	free_page(page_table);
+	free_pages(segment_table, SEGMENT_ORDER);
+	return -ENOMEM;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+void vdso_free_per_cpu(int cpu, struct _lowcore *lowcore)
+{
+	unsigned long segment_table, page_table, page_frame;
+	u32 *psal, *aste;
+
+	if (!switch_amode || !vdso_enabled)
+		return;
+
+	psal = (u32 *)(addr_t) lowcore->paste[4];
+	aste = (u32 *)(addr_t) psal[2];
+	segment_table = *(unsigned long *)(aste + 2) & PAGE_MASK;
+	page_table = *(unsigned long *) segment_table;
+	page_frame = *(unsigned long *) page_table;
+
+	free_page(page_frame);
+	free_page(page_table);
+	free_pages(segment_table, SEGMENT_ORDER);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static void __vdso_init_cr5(void *dummy)
+{
+	unsigned long cr5;
+
+	cr5 = offsetof(struct _lowcore, paste);
+	__ctl_load(cr5, 5, 5);
+}
+
+static void vdso_init_cr5(void)
+{
+	if (switch_amode && vdso_enabled)
+		on_each_cpu(__vdso_init_cr5, NULL, 1);
+}
+#endif /* CONFIG_64BIT */
+
+/*
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
  */
@@ -172,6 +282,9 @@ static int __init vdso_init(void)
 {
 	int i;
 
+	if (!vdso_enabled)
+		return 0;
+	vdso_init_data(vdso_data);
 #if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
 	/* Calculate the size of the 32 bit vDSO */
 	vdso32_pages = ((&vdso32_end - &vdso32_start
@@ -208,6 +321,10 @@ static int __init vdso_init(void)
 	}
 	vdso64_pagelist[vdso64_pages - 1] = virt_to_page(vdso_data);
 	vdso64_pagelist[vdso64_pages] = NULL;
+#ifndef CONFIG_SMP
+	BUG_ON(vdso_alloc_per_cpu(0, S390_lowcore));
+#endif
+	vdso_init_cr5();
 #endif /* CONFIG_64BIT */
 
 	get_page(virt_to_page(vdso_data));
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
index 488e31a..9ce8caa 100644
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ b/arch/s390/kernel/vdso64/clock_getres.S
@@ -22,7 +22,12 @@ __kernel_clock_getres:
 	cghi	%r2,CLOCK_REALTIME
 	je	0f
 	cghi	%r2,CLOCK_MONOTONIC
+	je	0f
+	cghi	%r2,-2		/* CLOCK_THREAD_CPUTIME_ID for this thread */
 	jne	2f
+	larl	%r5,_vdso_data
+	icm	%r0,15,__LC_ECTG_OK(%r5)
+	jz	2f
 0:	ltgr	%r3,%r3
 	jz	1f				/* res == NULL */
 	larl	%r1,3f
diff --git a/arch/s390/kernel/vdso64/clock_gettime.S b/arch/s390/kernel/vdso64/clock_gettime.S
index 738a410..79dbfee 100644
--- a/arch/s390/kernel/vdso64/clock_gettime.S
+++ b/arch/s390/kernel/vdso64/clock_gettime.S
@@ -22,8 +22,10 @@ __kernel_clock_gettime:
 	larl	%r5,_vdso_data
 	cghi	%r2,CLOCK_REALTIME
 	je	4f
+	cghi	%r2,-2		/* CLOCK_THREAD_CPUTIME_ID for this thread */
+	je	9f
 	cghi	%r2,CLOCK_MONOTONIC
-	jne	9f
+	jne	12f
 
 	/* CLOCK_MONOTONIC */
 	ltgr	%r3,%r3
@@ -42,7 +44,7 @@ __kernel_clock_gettime:
 	alg	%r0,__VDSO_WTOM_SEC(%r5)
 	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
 	jne	0b
-	larl	%r5,10f
+	larl	%r5,13f
 1:	clg	%r1,0(%r5)
 	jl	2f
 	slg	%r1,0(%r5)
@@ -68,7 +70,7 @@ __kernel_clock_gettime:
 	lg	%r0,__VDSO_XTIME_SEC(%r5)
 	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
 	jne	5b
-	larl	%r5,10f
+	larl	%r5,13f
 6:	clg	%r1,0(%r5)
 	jl	7f
 	slg	%r1,0(%r5)
@@ -79,11 +81,38 @@ __kernel_clock_gettime:
 8:	lghi	%r2,0
 	br	%r14
 
+	/* CLOCK_THREAD_CPUTIME_ID for this thread */
+9:	icm	%r0,15,__VDSO_ECTG_OK(%r5)
+	jz	12f
+	ear	%r2,%a4
+	llilh	%r4,0x0100
+	sar	%a4,%r4
+	lghi	%r4,0
+	sacf	512				/* Magic ectg instruction */
+	.insn	ssf,0xc80100000000,__VDSO_ECTG_BASE(4),__VDSO_ECTG_USER(4),4
+	sacf	0
+	sar	%a4,%r2
+	algr	%r1,%r0				/* r1 = cputime as TOD value */
+	mghi	%r1,1000			/* convert to nanoseconds */
+	srlg	%r1,%r1,12			/* r1 = cputime in nanosec */
+	lgr	%r4,%r1
+	larl	%r5,13f
+	srlg	%r1,%r1,9			/* divide by 1000000000 */
+	mlg	%r0,8(%r5)
+	srlg	%r0,%r0,11			/* r0 = tv_sec */
+	stg	%r0,0(%r3)
+	msg	%r0,0(%r5)			/* calculate tv_nsec */
+	slgr	%r4,%r0				/* r4 = tv_nsec */
+	stg	%r4,8(%r3)
+	lghi	%r2,0
+	br	%r14
+
 	/* Fallback to system call */
-9:	lghi	%r1,__NR_clock_gettime
+12:	lghi	%r1,__NR_clock_gettime
 	svc	0
 	br	%r14
 
-10:	.quad	1000000000
+13:	.quad	1000000000
+14:	.quad	19342813113834067
 	.cfi_endproc
 	.size	__kernel_clock_gettime,.-__kernel_clock_gettime
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 75a6e62..3b59bc8 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -23,19 +23,43 @@
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
 #include <asm/irq_regs.h>
+#include <asm/cpu.h>
 
 static ext_int_info_t ext_int_info_timer;
+
 static DEFINE_PER_CPU(struct vtimer_queue, virt_cpu_timer);
 
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle) = {
+	.lock = __SPIN_LOCK_UNLOCKED(s390_idle.lock)
+};
+
+static inline __u64 get_vtimer(void)
+{
+	__u64 timer;
+
+	asm volatile("STPT %0" : "=m" (timer));
+	return timer;
+}
+
+static inline void set_vtimer(__u64 expires)
+{
+	__u64 timer;
+
+	asm volatile ("  STPT %0\n"  /* Store current cpu timer value */
+		      "  SPT %1"     /* Set new value immediatly afterwards */
+		      : "=m" (timer) : "m" (expires) );
+	S390_lowcore.system_timer += S390_lowcore.last_update_timer - timer;
+	S390_lowcore.last_update_timer = expires;
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void account_process_tick(struct task_struct *tsk, int user_tick)
+static void do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 {
-	cputime_t cputime;
-	__u64 timer, clock;
-	int rcu_user_flag;
+	struct thread_info *ti = task_thread_info(tsk);
+	__u64 timer, clock, user, system, steal;
 
 	timer = S390_lowcore.last_update_timer;
 	clock = S390_lowcore.last_update_clock;
@@ -44,50 +68,41 @@ void account_process_tick(struct task_struct *tsk, int user_tick)
 		      : "=m" (S390_lowcore.last_update_timer),
 		        "=m" (S390_lowcore.last_update_clock) );
 	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
-	S390_lowcore.steal_clock += S390_lowcore.last_update_clock - clock;
-
-	cputime = S390_lowcore.user_timer >> 12;
-	rcu_user_flag = cputime != 0;
-	S390_lowcore.user_timer -= cputime << 12;
-	S390_lowcore.steal_clock -= cputime << 12;
-	account_user_time(tsk, cputime);
-
-	cputime =  S390_lowcore.system_timer >> 12;
-	S390_lowcore.system_timer -= cputime << 12;
-	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, HARDIRQ_OFFSET, cputime);
-
-	cputime = S390_lowcore.steal_clock;
-	if ((__s64) cputime > 0) {
-		cputime >>= 12;
-		S390_lowcore.steal_clock -= cputime << 12;
-		account_steal_time(tsk, cputime);
+	S390_lowcore.steal_timer += S390_lowcore.last_update_clock - clock;
+
+	user = S390_lowcore.user_timer - ti->user_timer;
+	S390_lowcore.steal_timer -= user;
+	ti->user_timer = S390_lowcore.user_timer;
+	account_user_time(tsk, user, user);
+
+	system = S390_lowcore.system_timer - ti->system_timer;
+	S390_lowcore.steal_timer -= system;
+	ti->system_timer = S390_lowcore.system_timer;
+	account_system_time(tsk, hardirq_offset, system, system);
+
+	steal = S390_lowcore.steal_timer;
+	if ((s64) steal > 0) {
+		S390_lowcore.steal_timer = 0;
+		account_steal_time(steal);
 	}
 }
 
-/*
- * Update process times based on virtual cpu times stored by entry.S
- * to the lowcore fields user_timer, system_timer & steal_clock.
- */
-void account_vtime(struct task_struct *tsk)
+void account_vtime(struct task_struct *prev, struct task_struct *next)
 {
-	cputime_t cputime;
-	__u64 timer;
-
-	timer = S390_lowcore.last_update_timer;
-	asm volatile ("  STPT %0"    /* Store current cpu timer value */
-		      : "=m" (S390_lowcore.last_update_timer) );
-	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
-
-	cputime = S390_lowcore.user_timer >> 12;
-	S390_lowcore.user_timer -= cputime << 12;
-	S390_lowcore.steal_clock -= cputime << 12;
-	account_user_time(tsk, cputime);
+	struct thread_info *ti;
+
+	do_account_vtime(prev, 0);
+	ti = task_thread_info(prev);
+	ti->user_timer = S390_lowcore.user_timer;
+	ti->system_timer = S390_lowcore.system_timer;
+	ti = task_thread_info(next);
+	S390_lowcore.user_timer = ti->user_timer;
+	S390_lowcore.system_timer = ti->system_timer;
+}
 
-	cputime =  S390_lowcore.system_timer >> 12;
-	S390_lowcore.system_timer -= cputime << 12;
-	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, 0, cputime);
+void account_process_tick(struct task_struct *tsk, int user_tick)
+{
+	do_account_vtime(tsk, HARDIRQ_OFFSET);
 }
 
 /*
@@ -96,80 +111,123 @@ void account_vtime(struct task_struct *tsk)
  */
 void account_system_vtime(struct task_struct *tsk)
 {
-	cputime_t cputime;
-	__u64 timer;
+	struct thread_info *ti = task_thread_info(tsk);
+	__u64 timer, system;
 
 	timer = S390_lowcore.last_update_timer;
-	asm volatile ("  STPT %0"    /* Store current cpu timer value */
-		      : "=m" (S390_lowcore.last_update_timer) );
+	S390_lowcore.last_update_timer = get_vtimer();
 	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
 
-	cputime =  S390_lowcore.system_timer >> 12;
-	S390_lowcore.system_timer -= cputime << 12;
-	S390_lowcore.steal_clock -= cputime << 12;
-	account_system_time(tsk, 0, cputime);
+	system = S390_lowcore.system_timer - ti->system_timer;
+	S390_lowcore.steal_timer -= system;
+	ti->system_timer = S390_lowcore.system_timer;
+	account_system_time(tsk, 0, system, system);
 }
 EXPORT_SYMBOL_GPL(account_system_vtime);
 
-static inline void set_vtimer(__u64 expires)
-{
-	__u64 timer;
-
-	asm volatile ("  STPT %0\n"  /* Store current cpu timer value */
-		      "  SPT %1"     /* Set new value immediatly afterwards */
-		      : "=m" (timer) : "m" (expires) );
-	S390_lowcore.system_timer += S390_lowcore.last_update_timer - timer;
-	S390_lowcore.last_update_timer = expires;
-
-	/* store expire time for this CPU timer */
-	__get_cpu_var(virt_cpu_timer).to_expire = expires;
-}
-
-void vtime_start_cpu_timer(void)
+void vtime_start_cpu(void)
 {
-	struct vtimer_queue *vt_list;
-
-	vt_list = &__get_cpu_var(virt_cpu_timer);
-
-	/* CPU timer interrupt is pending, don't reprogramm it */
-	if (vt_list->idle & 1LL<<63)
-		return;
+	struct s390_idle_data *idle = &__get_cpu_var(s390_idle);
+	struct vtimer_queue *vq = &__get_cpu_var(virt_cpu_timer);
+	__u64 idle_time, expires;
+
+	/* Account time spent with enabled wait psw loaded as idle time. */
+	idle_time = S390_lowcore.int_clock - idle->idle_enter;
+	account_idle_time(idle_time);
+	S390_lowcore.last_update_clock = S390_lowcore.int_clock;
+
+	/* Account system time spent going idle. */
+	S390_lowcore.system_timer += S390_lowcore.last_update_timer - vq->idle;
+	S390_lowcore.last_update_timer = S390_lowcore.async_enter_timer;
+
+	/* Restart vtime CPU timer */
+	if (vq->do_spt) {
+		/* Program old expire value but first save progress. */
+		expires = vq->idle - S390_lowcore.async_enter_timer;
+		expires += get_vtimer();
+		set_vtimer(expires);
+	} else {
+		/* Don't account the CPU timer delta while the cpu was idle. */
+		vq->elapsed -= vq->idle - S390_lowcore.async_enter_timer;
+	}
 
-	if (!list_empty(&vt_list->list))
-		set_vtimer(vt_list->idle);
+	spin_lock(&idle->lock);
+	idle->idle_time += idle_time;
+	idle->idle_enter = 0ULL;
+	idle->idle_count++;
+	spin_unlock(&idle->lock);
 }
 
-void vtime_stop_cpu_timer(void)
+void vtime_stop_cpu(void)
 {
-	struct vtimer_queue *vt_list;
-
-	vt_list = &__get_cpu_var(virt_cpu_timer);
-
-	/* nothing to do */
-	if (list_empty(&vt_list->list)) {
-		vt_list->idle = VTIMER_MAX_SLICE;
-		goto fire;
+	struct s390_idle_data *idle = &__get_cpu_var(s390_idle);
+	struct vtimer_queue *vq = &__get_cpu_var(virt_cpu_timer);
+	psw_t psw;
+
+	/* Wait for external, I/O or machine check interrupt. */
+	psw.mask = psw_kernel_bits|PSW_MASK_WAIT|PSW_MASK_IO|PSW_MASK_EXT;
+
+	/* Check if the CPU timer needs to be reprogrammed. */
+	if (vq->do_spt) {
+		__u64 vmax = VTIMER_MAX_SLICE;
+		/*
+		 * The inline assembly is equivalent to
+		 *	vq->idle = get_cpu_timer();
+		 *	set_cpu_timer(VTIMER_MAX_SLICE);
+		 *	idle->idle_enter = get_clock();
+		 *	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
+		 *			   PSW_MASK_IO | PSW_MASK_EXT);
+		 * The difference is that the inline assembly makes sure that
+		 * the last three instruction are stpt, stck and lpsw in that
+		 * order. This is done to increase the precision.
+		 */
+		asm volatile(
+#ifndef __s390x__
+			"	basr	1,0\n"
+			"0:	ahi	1,1f-0b\n"
+			"	st	1,4(%2)\n"
+#else /* __s390x__ */
+			"	larl	1,1f\n"
+			"	stg	1,8(%2)\n"
+#endif /* __s390x__ */
+			"	stpt	0(%4)\n"
+			"	spt	0(%5)\n"
+			"	stck	0(%3)\n"
+			"	lpswe	0(%2)\n"
+			"1:"
+			: "=m" (idle->idle_enter), "=m" (vq->idle)
+			: "a" (&psw), "a" (&idle->idle_enter),
+			  "a" (&vq->idle), "a" (&vmax), "m" (vmax), "m" (psw)
+			: "memory", "cc", "1");
+	} else {
+		/*
+		 * The inline assembly is equivalent to
+		 *	vq->idle = get_cpu_timer();
+		 *	idle->idle_enter = get_clock();
+		 *	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
+		 *			   PSW_MASK_IO | PSW_MASK_EXT);
+		 * The difference is that the inline assembly makes sure that
+		 * the last three instruction are stpt, stck and lpsw in that
+		 * order. This is done to increase the precision.
+		 */
+		asm volatile(
+#ifndef __s390x__
+			"	basr	1,0\n"
+			"0:	ahi	1,1f-0b\n"
+			"	st	1,4(%2)\n"
+#else /* __s390x__ */
+			"	larl	1,1f\n"
+			"	stg	1,8(%2)\n"
+#endif /* __s390x__ */
+			"	stpt	0(%4)\n"
+			"	stck	0(%3)\n"
+			"	lpswe	0(%2)\n"
+			"1:"
+			: "=m" (idle->idle_enter), "=m" (vq->idle)
+			: "a" (&psw), "a" (&idle->idle_enter),
+			  "a" (&vq->idle), "m" (psw)
+			: "memory", "cc", "1");
 	}
-
-	/* store the actual expire value */
-	asm volatile ("STPT %0" : "=m" (vt_list->idle));
-
-	/*
-	 * If the CPU timer is negative we don't reprogramm
-	 * it because we will get instantly an interrupt.
-	 */
-	if (vt_list->idle & 1LL<<63)
-		return;
-
-	vt_list->offset += vt_list->to_expire - vt_list->idle;
-
-	/*
-	 * We cannot halt the CPU timer, we just write a value that
-	 * nearly never expires (only after 71 years) and re-write
-	 * the stored expire value if we continue the timer
-	 */
- fire:
-	set_vtimer(VTIMER_MAX_SLICE);
 }
 
 /*
@@ -195,30 +253,23 @@ static void list_add_sorted(struct vtimer_list *timer, struct list_head *head)
  */
 static void do_callbacks(struct list_head *cb_list)
 {
-	struct vtimer_queue *vt_list;
+	struct vtimer_queue *vq;
 	struct vtimer_list *event, *tmp;
-	void (*fn)(unsigned long);
-	unsigned long data;
 
 	if (list_empty(cb_list))
 		return;
 
-	vt_list = &__get_cpu_var(virt_cpu_timer);
+	vq = &__get_cpu_var(virt_cpu_timer);
 
 	list_for_each_entry_safe(event, tmp, cb_list, entry) {
-		fn = event->function;
-		data = event->data;
-		fn(data);
-
-		if (!event->interval)
-			/* delete one shot timer */
-			list_del_init(&event->entry);
-		else {
-			/* move interval timer back to list */
-			spin_lock(&vt_list->lock);
-			list_del_init(&event->entry);
-			list_add_sorted(event, &vt_list->list);
-			spin_unlock(&vt_list->lock);
+		list_del_init(&event->entry);
+		(event->function)(event->data);
+		if (event->interval) {
+			/* Recharge interval timer */
+			event->expires = event->interval + vq->elapsed;
+			spin_lock(&vq->lock);
+			list_add_sorted(event, &vq->list);
+			spin_unlock(&vq->lock);
 		}
 	}
 }
@@ -228,64 +279,57 @@ static void do_callbacks(struct list_head *cb_list)
  */
 static void do_cpu_timer_interrupt(__u16 error_code)
 {
-	__u64 next, delta;
-	struct vtimer_queue *vt_list;
+	struct vtimer_queue *vq;
 	struct vtimer_list *event, *tmp;
-	struct list_head *ptr;
-	/* the callback queue */
-	struct list_head cb_list;
+	struct list_head cb_list;	/* the callback queue */
+	__u64 elapsed, next;
 
 	INIT_LIST_HEAD(&cb_list);
-	vt_list = &__get_cpu_var(virt_cpu_timer);
+	vq = &__get_cpu_var(virt_cpu_timer);
 
 	/* walk timer list, fire all expired events */
-	spin_lock(&vt_list->lock);
-
-	if (vt_list->to_expire < VTIMER_MAX_SLICE)
-		vt_list->offset += vt_list->to_expire;
-
-	list_for_each_entry_safe(event, tmp, &vt_list->list, entry) {
-		if (event->expires > vt_list->offset)
-			/* found first unexpired event, leave */
-			break;
-
-		/* re-charge interval timer, we have to add the offset */
-		if (event->interval)
-			event->expires = event->interval + vt_list->offset;
-
-		/* move expired timer to the callback queue */
-		list_move_tail(&event->entry, &cb_list);
+	spin_lock(&vq->lock);
+
+	elapsed = vq->elapsed + (vq->timer - S390_lowcore.async_enter_timer);
+	BUG_ON((s64) elapsed < 0);
+	vq->elapsed = 0;
+	list_for_each_entry_safe(event, tmp, &vq->list, entry) {
+		if (event->expires < elapsed)
+			/* move expired timer to the callback queue */
+			list_move_tail(&event->entry, &cb_list);
+		else
+			event->expires -= elapsed;
 	}
-	spin_unlock(&vt_list->lock);
+	spin_unlock(&vq->lock);
+
+	vq->do_spt = list_empty(&cb_list);
 	do_callbacks(&cb_list);
 
 	/* next event is first in list */
-	spin_lock(&vt_list->lock);
-	if (!list_empty(&vt_list->list)) {
-		ptr = vt_list->list.next;
-		event = list_entry(ptr, struct vtimer_list, entry);
-		next = event->expires - vt_list->offset;
-
-		/* add the expired time from this interrupt handler
-		 * and the callback functions
-		 */
-		asm volatile ("STPT %0" : "=m" (delta));
-		delta = 0xffffffffffffffffLL - delta + 1;
-		vt_list->offset += delta;
-		next -= delta;
-	} else {
-		vt_list->offset = 0;
-		next = VTIMER_MAX_SLICE;
-	}
-	spin_unlock(&vt_list->lock);
-	set_vtimer(next);
+	next = VTIMER_MAX_SLICE;
+	spin_lock(&vq->lock);
+	if (!list_empty(&vq->list)) {
+		event = list_first_entry(&vq->list, struct vtimer_list, entry);
+		next = event->expires;
+	} else
+		vq->do_spt = 0;
+	spin_unlock(&vq->lock);
+	/*
+	 * To improve precision add the time spent by the
+	 * interrupt handler to the elapsed time.
+	 * Note: CPU timer counts down and we got an interrupt,
+	 *	 the current content is negative
+	 */
+	elapsed = S390_lowcore.async_enter_timer - get_vtimer();
+	set_vtimer(next - elapsed);
+	vq->timer = next - elapsed;
+	vq->elapsed = elapsed;
 }
 
 void init_virt_timer(struct vtimer_list *timer)
 {
 	timer->function = NULL;
 	INIT_LIST_HEAD(&timer->entry);
-	spin_lock_init(&timer->lock);
 }
 EXPORT_SYMBOL(init_virt_timer);
 
@@ -299,44 +343,40 @@ static inline int vtimer_pending(struct vtimer_list *timer)
  */
 static void internal_add_vtimer(struct vtimer_list *timer)
 {
+	struct vtimer_queue *vq;
 	unsigned long flags;
-	__u64 done;
-	struct vtimer_list *event;
-	struct vtimer_queue *vt_list;
+	__u64 left, expires;
 
-	vt_list = &per_cpu(virt_cpu_timer, timer->cpu);
-	spin_lock_irqsave(&vt_list->lock, flags);
+	vq = &per_cpu(virt_cpu_timer, timer->cpu);
+	spin_lock_irqsave(&vq->lock, flags);
 
 	BUG_ON(timer->cpu != smp_processor_id());
 
-	/* if list is empty we only have to set the timer */
-	if (list_empty(&vt_list->list)) {
-		/* reset the offset, this may happen if the last timer was
-		 * just deleted by mod_virt_timer and the interrupt
-		 * didn't happen until here
-		 */
-		vt_list->offset = 0;
-		goto fire;
+	if (list_empty(&vq->list)) {
+		/* First timer on this cpu, just program it. */
+		list_add(&timer->entry, &vq->list);
+		set_vtimer(timer->expires);
+		vq->timer = timer->expires;
+		vq->elapsed = 0;
+	} else {
+		/* Check progress of old timers. */
+		expires = timer->expires;
+		left = get_vtimer();
+		if (likely((s64) expires < (s64) left)) {
+			/* The new timer expires before the current timer. */
+			set_vtimer(expires);
+			vq->elapsed += vq->timer - left;
+			vq->timer = expires;
+		} else {
+			vq->elapsed += vq->timer - left;
+			vq->timer = left;
+		}
+		/* Insert new timer into per cpu list. */
+		timer->expires += vq->elapsed;
+		list_add_sorted(timer, &vq->list);
 	}
 
-	/* save progress */
-	asm volatile ("STPT %0" : "=m" (done));
-
-	/* calculate completed work */
-	done = vt_list->to_expire - done + vt_list->offset;
-	vt_list->offset = 0;
-
-	list_for_each_entry(event, &vt_list->list, entry)
-		event->expires -= done;
-
- fire:
-	list_add_sorted(timer, &vt_list->list);
-
-	/* get first element, which is the next vtimer slice */
-	event = list_entry(vt_list->list.next, struct vtimer_list, entry);
-
-	set_vtimer(event->expires);
-	spin_unlock_irqrestore(&vt_list->lock, flags);
+	spin_unlock_irqrestore(&vq->lock, flags);
 	/* release CPU acquired in prepare_vtimer or mod_virt_timer() */
 	put_cpu();
 }
@@ -381,14 +421,15 @@ EXPORT_SYMBOL(add_virt_timer_periodic);
  * If we change a pending timer the function must be called on the CPU
  * where the timer is running on, e.g. by smp_call_function_single()
  *
- * The original mod_timer adds the timer if it is not pending. For compatibility
- * we do the same. The timer will be added on the current CPU as a oneshot timer.
+ * The original mod_timer adds the timer if it is not pending. For
+ * compatibility we do the same. The timer will be added on the current
+ * CPU as a oneshot timer.
  *
  * returns whether it has modified a pending timer (1) or not (0)
  */
 int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
 {
-	struct vtimer_queue *vt_list;
+	struct vtimer_queue *vq;
 	unsigned long flags;
 	int cpu;
 
@@ -404,17 +445,17 @@ int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
 		return 1;
 
 	cpu = get_cpu();
-	vt_list = &per_cpu(virt_cpu_timer, cpu);
+	vq = &per_cpu(virt_cpu_timer, cpu);
 
 	/* check if we run on the right CPU */
 	BUG_ON(timer->cpu != cpu);
 
 	/* disable interrupts before test if timer is pending */
-	spin_lock_irqsave(&vt_list->lock, flags);
+	spin_lock_irqsave(&vq->lock, flags);
 
 	/* if timer isn't pending add it on the current CPU */
 	if (!vtimer_pending(timer)) {
-		spin_unlock_irqrestore(&vt_list->lock, flags);
+		spin_unlock_irqrestore(&vq->lock, flags);
 		/* we do not activate an interval timer with mod_virt_timer */
 		timer->interval = 0;
 		timer->expires = expires;
@@ -431,7 +472,7 @@ int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
 		timer->interval = expires;
 
 	/* the timer can't expire anymore so we can release the lock */
-	spin_unlock_irqrestore(&vt_list->lock, flags);
+	spin_unlock_irqrestore(&vq->lock, flags);
 	internal_add_vtimer(timer);
 	return 1;
 }
@@ -445,25 +486,19 @@ EXPORT_SYMBOL(mod_virt_timer);
 int del_virt_timer(struct vtimer_list *timer)
 {
 	unsigned long flags;
-	struct vtimer_queue *vt_list;
+	struct vtimer_queue *vq;
 
 	/* check if timer is pending */
 	if (!vtimer_pending(timer))
 		return 0;
 
-	vt_list = &per_cpu(virt_cpu_timer, timer->cpu);
-	spin_lock_irqsave(&vt_list->lock, flags);
+	vq = &per_cpu(virt_cpu_timer, timer->cpu);
+	spin_lock_irqsave(&vq->lock, flags);
 
 	/* we don't interrupt a running timer, just let it expire! */
 	list_del_init(&timer->entry);
 
-	/* last timer removed */
-	if (list_empty(&vt_list->list)) {
-		vt_list->to_expire = 0;
-		vt_list->offset = 0;
-	}
-
-	spin_unlock_irqrestore(&vt_list->lock, flags);
+	spin_unlock_irqrestore(&vq->lock, flags);
 	return 1;
 }
 EXPORT_SYMBOL(del_virt_timer);
@@ -473,24 +508,19 @@ EXPORT_SYMBOL(del_virt_timer);
  */
 void init_cpu_vtimer(void)
 {
-	struct vtimer_queue *vt_list;
+	struct vtimer_queue *vq;
 
 	/* kick the virtual timer */
-	S390_lowcore.exit_timer = VTIMER_MAX_SLICE;
-	S390_lowcore.last_update_timer = VTIMER_MAX_SLICE;
-	asm volatile ("SPT %0" : : "m" (S390_lowcore.last_update_timer));
 	asm volatile ("STCK %0" : "=m" (S390_lowcore.last_update_clock));
+	asm volatile ("STPT %0" : "=m" (S390_lowcore.last_update_timer));
+
+	/* initialize per cpu vtimer structure */
+	vq = &__get_cpu_var(virt_cpu_timer);
+	INIT_LIST_HEAD(&vq->list);
+	spin_lock_init(&vq->lock);
 
 	/* enable cpu timer interrupts */
 	__ctl_set_bit(0,10);
-
-	vt_list = &__get_cpu_var(virt_cpu_timer);
-	INIT_LIST_HEAD(&vt_list->list);
-	spin_lock_init(&vt_list->lock);
-	vt_list->to_expire = 0;
-	vt_list->offset = 0;
-	vt_list->idle = 0;
-
 }
 
 void __init vtime_init(void)
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index c9f7cda..732e52d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -132,8 +132,7 @@ static void do_stolen_accounting(void)
 	*snap = state;
 
 	/* Add the appropriate number of ticks of stolen time,
-	   including any left-overs from last time.  Passing NULL to
-	   account_steal_time accounts the time as stolen. */
+	   including any left-overs from last time. */
 	stolen = runnable + offline + __get_cpu_var(residual_stolen);
 
 	if (stolen < 0)
@@ -141,11 +140,10 @@ static void do_stolen_accounting(void)
 
 	ticks = iter_div_u64_rem(stolen, NS_PER_TICK, &stolen);
 	__get_cpu_var(residual_stolen) = stolen;
-	account_steal_time(NULL, ticks);
+	account_steal_ticks(ticks);
 
 	/* Add the appropriate number of ticks of blocked time,
-	   including any left-overs from last time.  Passing idle to
-	   account_steal_time accounts the time as idle/wait. */
+	   including any left-overs from last time. */
 	blocked += __get_cpu_var(residual_blocked);
 
 	if (blocked < 0)
@@ -153,7 +151,7 @@ static void do_stolen_accounting(void)
 
 	ticks = iter_div_u64_rem(blocked, NS_PER_TICK, &blocked);
 	__get_cpu_var(residual_blocked) = blocked;
-	account_steal_time(idle_task(smp_processor_id()), ticks);
+	account_idle_ticks(ticks);
 }
 
 /*
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 8a8df75..06b7182 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -632,8 +632,8 @@ do_IRQ (struct pt_regs *regs)
 	struct pt_regs *old_regs;
 
 	old_regs = set_irq_regs(regs);
-	irq_enter();
 	s390_idle_check();
+	irq_enter();
 	if (S390_lowcore.int_clock >= S390_lowcore.clock_comparator)
 		/* Serve timer interrupts first. */
 		clock_comparator_work();
diff --git a/drivers/s390/s390mach.c b/drivers/s390/s390mach.c
index 834e9ee..92b0417 100644
--- a/drivers/s390/s390mach.c
+++ b/drivers/s390/s390mach.c
@@ -18,6 +18,7 @@
 #include <asm/etr.h>
 #include <asm/lowcore.h>
 #include <asm/cio.h>
+#include <asm/cpu.h>
 #include "s390mach.h"
 
 static struct semaphore m_sem;
@@ -369,6 +370,8 @@ s390_do_machine_check(struct pt_regs *regs)
 
 	lockdep_off();
 
+	s390_idle_check();
+
 	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
 	mcck = &__get_cpu_var(cpu_mcck);
 	umode = user_mode(regs);
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 4a145ca..a1b3171 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -67,10 +67,13 @@ static inline unsigned int kstat_irqs(unsigned int irq)
 }
 
 extern unsigned long long task_delta_exec(struct task_struct *);
-extern void account_user_time(struct task_struct *, cputime_t);
-extern void account_user_time_scaled(struct task_struct *, cputime_t);
-extern void account_system_time(struct task_struct *, int, cputime_t);
-extern void account_system_time_scaled(struct task_struct *, cputime_t);
-extern void account_steal_time(struct task_struct *, cputime_t);
+extern void account_user_time(struct task_struct *, cputime_t, cputime_t);
+extern void account_system_time(struct task_struct *, int, cputime_t, cputime_t);
+extern void account_steal_time(cputime_t);
+extern void account_idle_time(cputime_t);
+
+extern void account_process_tick(struct task_struct *, int user);
+extern void account_steal_ticks(unsigned long ticks);
+extern void account_idle_ticks(unsigned long ticks);
 
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8395e71..b475d4d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -284,7 +284,6 @@ long io_schedule_timeout(long timeout);
 
 extern void cpu_init (void);
 extern void trap_init(void);
-extern void account_process_tick(struct task_struct *task, int user);
 extern void update_process_times(int user);
 extern void scheduler_tick(void);
 
diff --git a/kernel/sched.c b/kernel/sched.c
index 748ff92..3141eaf 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4082,13 +4082,17 @@ unsigned long long task_delta_exec(struct task_struct *p)
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in user space since the last update
+ * @cputime_scaled: cputime scaled by cpu frequency
  */
-void account_user_time(struct task_struct *p, cputime_t cputime)
+void account_user_time(struct task_struct *p, cputime_t cputime,
+		       cputime_t cputime_scaled)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	cputime64_t tmp;
 
+	/* Add user time to process. */
 	p->utime = cputime_add(p->utime, cputime);
+	p->utimescaled = cputime_add(p->utimescaled, cputime_scaled);
 	account_group_user_time(p, cputime);
 
 	/* Add user time to cpustat. */
@@ -4105,51 +4109,48 @@ void account_user_time(struct task_struct *p, cputime_t cputime)
  * Account guest cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in virtual machine since the last update
+ * @cputime_scaled: cputime scaled by cpu frequency
  */
-static void account_guest_time(struct task_struct *p, cputime_t cputime)
+static void account_guest_time(struct task_struct *p, cputime_t cputime,
+			       cputime_t cputime_scaled)
 {
 	cputime64_t tmp;
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 
 	tmp = cputime_to_cputime64(cputime);
 
+	/* Add guest time to process. */
 	p->utime = cputime_add(p->utime, cputime);
+	p->utimescaled = cputime_add(p->utimescaled, cputime_scaled);
 	account_group_user_time(p, cputime);
 	p->gtime = cputime_add(p->gtime, cputime);
 
+	/* Add guest time to cpustat. */
 	cpustat->user = cputime64_add(cpustat->user, tmp);
 	cpustat->guest = cputime64_add(cpustat->guest, tmp);
 }
 
 /*
- * Account scaled user cpu time to a process.
- * @p: the process that the cpu time gets accounted to
- * @cputime: the cpu time spent in user space since the last update
- */
-void account_user_time_scaled(struct task_struct *p, cputime_t cputime)
-{
-	p->utimescaled = cputime_add(p->utimescaled, cputime);
-}
-
-/*
  * Account system cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in kernel space since the last update
+ * @cputime_scaled: cputime scaled by cpu frequency
  */
 void account_system_time(struct task_struct *p, int hardirq_offset,
-			 cputime_t cputime)
+			 cputime_t cputime, cputime_t cputime_scaled)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
-	struct rq *rq = this_rq();
 	cputime64_t tmp;
 
 	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
-		account_guest_time(p, cputime);
+		account_guest_time(p, cputime, cputime_scaled);
 		return;
 	}
 
+	/* Add system time to process. */
 	p->stime = cputime_add(p->stime, cputime);
+	p->stimescaled = cputime_add(p->stimescaled, cputime_scaled);
 	account_group_system_time(p, cputime);
 
 	/* Add system time to cpustat. */
@@ -4158,49 +4159,84 @@ void account_system_time(struct task_struct *p, int hardirq_offset,
 		cpustat->irq = cputime64_add(cpustat->irq, tmp);
 	else if (softirq_count())
 		cpustat->softirq = cputime64_add(cpustat->softirq, tmp);
-	else if (p != rq->idle)
-		cpustat->system = cputime64_add(cpustat->system, tmp);
-	else if (atomic_read(&rq->nr_iowait) > 0)
-		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
-		cpustat->idle = cputime64_add(cpustat->idle, tmp);
+		cpustat->system = cputime64_add(cpustat->system, tmp);
+
 	/* Account for system time used */
 	acct_update_integrals(p);
 }
 
 /*
- * Account scaled system cpu time to a process.
- * @p: the process that the cpu time gets accounted to
- * @hardirq_offset: the offset to subtract from hardirq_count()
- * @cputime: the cpu time spent in kernel space since the last update
+ * Account for involuntary wait time.
+ * @steal: the cpu time spent in involuntary wait
  */
-void account_system_time_scaled(struct task_struct *p, cputime_t cputime)
+void account_steal_time(cputime_t cputime)
 {
-	p->stimescaled = cputime_add(p->stimescaled, cputime);
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	cputime64_t cputime64 = cputime_to_cputime64(cputime);
+
+	cpustat->steal = cputime64_add(cpustat->steal, cputime64);
 }
 
 /*
- * Account for involuntary wait time.
- * @p: the process from which the cpu time has been stolen
- * @steal: the cpu time spent in involuntary wait
+ * Account for idle time.
+ * @cputime: the cpu time spent in idle wait
  */
-void account_steal_time(struct task_struct *p, cputime_t steal)
+void account_idle_time(cputime_t cputime)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
-	cputime64_t tmp = cputime_to_cputime64(steal);
+	cputime64_t cputime64 = cputime_to_cputime64(cputime);
 	struct rq *rq = this_rq();
 
-	if (p == rq->idle) {
-		p->stime = cputime_add(p->stime, steal);
-		account_group_system_time(p, steal);
-		if (atomic_read(&rq->nr_iowait) > 0)
-			cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
-		else
-			cpustat->idle = cputime64_add(cpustat->idle, tmp);
-	} else
-		cpustat->steal = cputime64_add(cpustat->steal, tmp);
+	if (atomic_read(&rq->nr_iowait) > 0)
+		cpustat->iowait = cputime64_add(cpustat->iowait, cputime64);
+	else
+		cpustat->idle = cputime64_add(cpustat->idle, cputime64);
 }
 
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING
+
+/*
+ * Account a single tick of cpu time.
+ * @p: the process that the cpu time gets accounted to
+ * @user_tick: indicates if the tick is a user or a system tick
+ */
+void account_process_tick(struct task_struct *p, int user_tick)
+{
+	cputime_t one_jiffy = jiffies_to_cputime(1);
+	cputime_t one_jiffy_scaled = cputime_to_scaled(one_jiffy);
+	struct rq *rq = this_rq();
+
+	if (user_tick)
+		account_user_time(p, one_jiffy, one_jiffy_scaled);
+	else if (p != rq->idle)
+		account_system_time(p, HARDIRQ_OFFSET, one_jiffy,
+				    one_jiffy_scaled);
+	else
+		account_idle_time(one_jiffy);
+}
+
+/*
+ * Account multiple ticks of steal time.
+ * @p: the process from which the cpu time has been stolen
+ * @ticks: number of stolen ticks
+ */
+void account_steal_ticks(unsigned long ticks)
+{
+	account_steal_time(jiffies_to_cputime(ticks));
+}
+
+/*
+ * Account multiple ticks of idle time.
+ * @ticks: number of stolen ticks
+ */
+void account_idle_ticks(unsigned long ticks)
+{
+	account_idle_time(jiffies_to_cputime(ticks));
+}
+
+#endif
+
 /*
  * Use precise platform statistics if available:
  */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 342fc9c..f811685 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -412,7 +412,9 @@ void tick_nohz_restart_sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING
 	unsigned long ticks;
+#endif
 	ktime_t now;
 
 	local_irq_disable();
@@ -434,6 +436,7 @@ void tick_nohz_restart_sched_tick(void)
 	tick_do_update_jiffies64(now);
 	cpu_clear(cpu, nohz_cpu_mask);
 
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING
 	/*
 	 * We stopped the tick in idle. Update process times would miss the
 	 * time we slept as update_process_times does only a 1 tick
@@ -443,12 +446,9 @@ void tick_nohz_restart_sched_tick(void)
 	/*
 	 * We might be one off. Do not randomly account a huge number of ticks!
 	 */
-	if (ticks && ticks < LONG_MAX) {
-		add_preempt_count(HARDIRQ_OFFSET);
-		account_system_time(current, HARDIRQ_OFFSET,
-				    jiffies_to_cputime(ticks));
-		sub_preempt_count(HARDIRQ_OFFSET);
-	}
+	if (ticks && ticks < LONG_MAX)
+		account_idle_ticks(ticks);
+#endif
 
 	touch_softlockup_watchdog();
 	/*
diff --git a/kernel/timer.c b/kernel/timer.c
index 566257d..dee3f64 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1018,21 +1018,6 @@ unsigned long get_next_timer_interrupt(unsigned long now)
 }
 #endif
 
-#ifndef CONFIG_VIRT_CPU_ACCOUNTING
-void account_process_tick(struct task_struct *p, int user_tick)
-{
-	cputime_t one_jiffy = jiffies_to_cputime(1);
-
-	if (user_tick) {
-		account_user_time(p, one_jiffy);
-		account_user_time_scaled(p, cputime_to_scaled(one_jiffy));
-	} else {
-		account_system_time(p, HARDIRQ_OFFSET, one_jiffy);
-		account_system_time_scaled(p, cputime_to_scaled(one_jiffy));
-	}
-}
-#endif
-
 /*
  * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.
