Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/2] s390: convert to GENERIC_VDSO
Date: Mon,  3 Aug 2020 07:56:45 +0200
Message-Id: <20200803055645.79042-3-svens@linux.ibm.com>
In-Reply-To: <20200803055645.79042-1-svens@linux.ibm.com>
References: <20200803055645.79042-1-svens@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>

This patch converts s390 to the generic vDSO. There are a few special
things on s390:

- vDSO can be called without a stack frame - glibc did this in the past.
  So we need to allocate a stackframe on our own.

- The former assembly code used stcke to get the TOD clock and applied
  time steering to it. We need to do the same in the new code. This is done
  in the architecture specific __arch_get_hw_counter function. The steering
  information is stored in an architecure specific area in the vDSO data.

- CPUCLOCK_VIRT is now handled with a syscall fallback, which might
  be slower/less accurate than the old implementation.

The getcpu() function stays as an assembly function because there is no
generic implementation and the code is just a few lines.

Performance number from my system do 100 mio gettimeofday() calls:

Plain syscall: 8.6s
Generic VDSO:  1.3s
old ASM VDSO:  1s

So it's a bit slower but still much faster than syscalls.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                           |   3 +
 arch/s390/include/asm/clocksource.h         |   7 +
 arch/s390/include/asm/vdso.h                |  25 +--
 arch/s390/include/asm/vdso/clocksource.h    |   8 +
 arch/s390/include/asm/vdso/data.h           |  14 ++
 arch/s390/include/asm/vdso/gettimeofday.h   |  78 ++++++++++
 arch/s390/include/asm/vdso/processor.h      |   5 +
 arch/s390/include/asm/vdso/vdso.h           |   0
 arch/s390/include/asm/vdso/vsyscall.h       |  26 ++++
 arch/s390/kernel/asm-offsets.c              |  20 ---
 arch/s390/kernel/entry.S                    |   6 -
 arch/s390/kernel/setup.c                    |   1 -
 arch/s390/kernel/time.c                     |  70 ++-------
 arch/s390/kernel/vdso.c                     |  29 +---
 arch/s390/kernel/vdso64/Makefile            |  19 ++-
 arch/s390/kernel/vdso64/clock_getres.S      |  50 ------
 arch/s390/kernel/vdso64/clock_gettime.S     | 163 --------------------
 arch/s390/kernel/vdso64/gettimeofday.S      |  71 ---------
 arch/s390/kernel/vdso64/vdso64_generic.c    |  18 +++
 arch/s390/kernel/vdso64/vdso_user_wrapper.S |  38 +++++
 20 files changed, 232 insertions(+), 419 deletions(-)
 create mode 100644 arch/s390/include/asm/clocksource.h
 create mode 100644 arch/s390/include/asm/vdso/clocksource.h
 create mode 100644 arch/s390/include/asm/vdso/data.h
 create mode 100644 arch/s390/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/s390/include/asm/vdso/processor.h
 create mode 100644 arch/s390/include/asm/vdso/vdso.h
 create mode 100644 arch/s390/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/s390/kernel/vdso64/clock_getres.S
 delete mode 100644 arch/s390/kernel/vdso64/clock_gettime.S
 delete mode 100644 arch/s390/kernel/vdso64/gettimeofday.S
 create mode 100644 arch/s390/kernel/vdso64/vdso64_generic.c
 create mode 100644 arch/s390/kernel/vdso64/vdso_user_wrapper.S

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c7d7ede6300c..eb50f748e151 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -73,6 +73,7 @@ config S390
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
@@ -118,6 +119,7 @@ config S390
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_FIND_FIRST_BIT
+	select GENERIC_GETTIMEOFDAY
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
@@ -149,6 +151,7 @@ config S390
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
+	select HAVE_GENERIC_VDSO
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
diff --git a/arch/s390/include/asm/clocksource.h b/arch/s390/include/asm/clocksource.h
new file mode 100644
index 000000000000..03434369fce4
--- /dev/null
+++ b/arch/s390/include/asm/clocksource.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* s390-specific clocksource additions */
+
+#ifndef _ASM_S390_CLOCKSOURCE_H
+#define _ASM_S390_CLOCKSOURCE_H
+
+#endif /* _ASM_S390_CLOCKSOURCE_H */
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 0cd085cdeb4f..82f86b3c394b 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -2,6 +2,8 @@
 #ifndef __S390_VDSO_H__
 #define __S390_VDSO_H__
 
+#include <vdso/datapage.h>
+
 /* Default link addresses for the vDSOs */
 #define VDSO32_LBASE	0
 #define VDSO64_LBASE	0
@@ -18,30 +20,7 @@
  * itself and may change without notice.
  */
 
-struct vdso_data {
-	__u64 tb_update_count;		/* Timebase atomicity ctr	0x00 */
-	__u64 xtime_tod_stamp;		/* TOD clock for xtime		0x08 */
-	__u64 xtime_clock_sec;		/* Kernel time			0x10 */
-	__u64 xtime_clock_nsec;		/*				0x18 */
-	__u64 xtime_coarse_sec;		/* Coarse kernel time		0x20 */
-	__u64 xtime_coarse_nsec;	/*				0x28 */
-	__u64 wtom_clock_sec;		/* Wall to monotonic clock	0x30 */
-	__u64 wtom_clock_nsec;		/*				0x38 */
-	__u64 wtom_coarse_sec;		/* Coarse wall to monotonic	0x40 */
-	__u64 wtom_coarse_nsec;		/*				0x48 */
-	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x50 */
-	__u32 tz_dsttime;		/* Type of dst correction	0x54 */
-	__u32 ectg_available;		/* ECTG instruction present	0x58 */
-	__u32 tk_mult;			/* Mult. used for xtime_nsec	0x5c */
-	__u32 tk_shift;			/* Shift used for xtime_nsec	0x60 */
-	__u32 ts_dir;			/* TOD steering direction	0x64 */
-	__u64 ts_end;			/* TOD steering end		0x68 */
-	__u32 hrtimer_res;		/* hrtimer resolution		0x70 */
-};
-
 struct vdso_per_cpu_data {
-	__u64 ectg_timer_base;
-	__u64 ectg_user_time;
 	/*
 	 * Note: node_id and cpu_nr must be at adjacent memory locations.
 	 * VDSO userspace must read both values with a single instruction.
diff --git a/arch/s390/include/asm/vdso/clocksource.h b/arch/s390/include/asm/vdso/clocksource.h
new file mode 100644
index 000000000000..a93eda0ce7bb
--- /dev/null
+++ b/arch/s390/include/asm/vdso/clocksource.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_CLOCKSOURCE_H
+#define __ASM_VDSO_CLOCKSOURCE_H
+
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_TOD
+
+#endif /* __ASM_VDSO_CLOCKSOURCE_H */
diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/data.h
new file mode 100644
index 000000000000..c0af12ed891c
--- /dev/null
+++ b/arch/s390/include/asm/vdso/data.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __S390_ASM_VDSO_DATA_H
+#define __S390_ASM_VDSO_DATA_H
+
+#include <linux/types.h>
+#include <vdso/datapage.h>
+
+struct arch_vdso_data {
+	__u64 tod_steering_delta;
+	__u64 tod_steering_end;
+	__u32 tb_update_cnt;
+};
+
+#endif /* __S390_ASM_VDSO_DATA_H */
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..d128d5ae7e1b
--- /dev/null
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_VDSO_GETTIMEOFDAY_H
+#define ASM_VDSO_GETTIMEOFDAY_H
+
+#define VDSO_HAS_TIME 1
+
+#define VDSO_HAS_CLOCK_GETRES 1
+
+#include <asm/timex.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+#include <linux/compiler.h>
+
+#define vdso_calc_delta __arch_vdso_calc_delta
+static __always_inline u64 __arch_vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	return (cycles - last) * mult;
+}
+
+static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return _vdso_data;
+}
+
+static inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	const struct vdso_data *vdso = __arch_get_vdso_data();
+	u64 adj, now;
+	int cnt;
+
+	do {
+		do {
+			cnt = READ_ONCE(vdso->arch.tb_update_cnt);
+		} while (cnt & 1);
+
+		now = get_tod_clock();
+		adj = vdso->arch.tod_steering_end - now;
+		if (unlikely((s64) adj > 0))
+			now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);
+	} while (cnt != READ_ONCE(vdso->arch.tb_update_cnt));
+	return now;
+}
+
+static __always_inline
+long clock_gettime_fallback(clockid_t clkid, struct __kernel_timespec *ts)
+{
+	register unsigned long r1 __asm__("r1") = __NR_clock_gettime;
+	register unsigned long r2 __asm__("r2") = (unsigned long)clkid;
+	register void *r3 __asm__("r3") = ts;
+
+	asm ("svc 0\n" : "+d" (r2) : "d" (r1), "d" (r3) : "cc", "memory");
+	return r2;
+}
+
+static __always_inline
+long gettimeofday_fallback(register struct __kernel_old_timeval *tv,
+			   register struct timezone *tz)
+{
+	register unsigned long r1 __asm__("r1") = __NR_gettimeofday;
+	register unsigned long r2 __asm__("r2") = (unsigned long)tv;
+	register void *r3 __asm__("r3") = tz;
+
+	asm ("svc 0\n" : "+d" (r2) : "d" (r1), "d" (r3) : "cc", "memory");
+	return r2;
+}
+
+static __always_inline
+long clock_getres_fallback(clockid_t clkid, struct __kernel_timespec *ts)
+{
+	register unsigned long r1 __asm__("r1") = __NR_clock_getres;
+	register unsigned long r2 __asm__("r2") = (unsigned long)clkid;
+	register void *r3 __asm__("r3") = ts;
+
+	asm ("svc 0\n" : "+d" (r2) : "d" (r1), "d" (r3) : "cc", "memory");
+	return r2;
+}
+
+#endif
diff --git a/arch/s390/include/asm/vdso/processor.h b/arch/s390/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..c47deb472e2a
--- /dev/null
+++ b/arch/s390/include/asm/vdso/processor.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/s390/include/asm/vdso/vdso.h b/arch/s390/include/asm/vdso/vdso.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..6c67c08cefdd
--- /dev/null
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/hrtimer.h>
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+#include <asm/vdso.h>
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+
+static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
+{
+	return vdso_data;
+}
+#define __arch_get_k_vdso_data __s390_get_k_vdso_data
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 5d8cc1864566..ece58f2217cb 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -59,26 +59,6 @@ int main(void)
 	OFFSET(__SF_SIE_REASON, stack_frame, empty1[2]);
 	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[3]);
 	BLANK();
-	/* timeval/timezone offsets for use by vdso */
-	OFFSET(__VDSO_UPD_COUNT, vdso_data, tb_update_count);
-	OFFSET(__VDSO_XTIME_STAMP, vdso_data, xtime_tod_stamp);
-	OFFSET(__VDSO_XTIME_SEC, vdso_data, xtime_clock_sec);
-	OFFSET(__VDSO_XTIME_NSEC, vdso_data, xtime_clock_nsec);
-	OFFSET(__VDSO_XTIME_CRS_SEC, vdso_data, xtime_coarse_sec);
-	OFFSET(__VDSO_XTIME_CRS_NSEC, vdso_data, xtime_coarse_nsec);
-	OFFSET(__VDSO_WTOM_SEC, vdso_data, wtom_clock_sec);
-	OFFSET(__VDSO_WTOM_NSEC, vdso_data, wtom_clock_nsec);
-	OFFSET(__VDSO_WTOM_CRS_SEC, vdso_data, wtom_coarse_sec);
-	OFFSET(__VDSO_WTOM_CRS_NSEC, vdso_data, wtom_coarse_nsec);
-	OFFSET(__VDSO_TIMEZONE, vdso_data, tz_minuteswest);
-	OFFSET(__VDSO_ECTG_OK, vdso_data, ectg_available);
-	OFFSET(__VDSO_TK_MULT, vdso_data, tk_mult);
-	OFFSET(__VDSO_TK_SHIFT, vdso_data, tk_shift);
-	OFFSET(__VDSO_TS_DIR, vdso_data, ts_dir);
-	OFFSET(__VDSO_TS_END, vdso_data, ts_end);
-	OFFSET(__VDSO_CLOCK_REALTIME_RES, vdso_data, hrtimer_res);
-	OFFSET(__VDSO_ECTG_BASE, vdso_per_cpu_data, ectg_timer_base);
-	OFFSET(__VDSO_ECTG_USER, vdso_per_cpu_data, ectg_user_time);
 	OFFSET(__VDSO_GETCPU_VAL, vdso_per_cpu_data, getcpu_val);
 	BLANK();
 	/* constants used by the vdso */
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 969b35b177dd..5de00e1f8830 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -435,10 +435,8 @@ ENTRY(system_call)
 	jz	.Lsysc_skip_fpu
 	brasl	%r14,load_fpu_regs
 .Lsysc_skip_fpu:
-	lg	%r14,__LC_VDSO_PER_CPU
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	stpt	__LC_EXIT_TIMER
-	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 	lmg	%r0,%r15,__PT_R0(%r11)
 	b	__LC_RETURN_LPSWE
 
@@ -797,13 +795,11 @@ ENTRY(io_int_handler)
 	TRACE_IRQS_ON
 0:
 #endif
-	lg	%r14,__LC_VDSO_PER_CPU
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
 	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 	stpt	__LC_EXIT_TIMER
-	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 .Lio_exit_kernel:
 	lmg	%r0,%r15,__PT_R0(%r11)
 	b	__LC_RETURN_LPSWE
@@ -1213,14 +1209,12 @@ ENTRY(mcck_int_handler)
 	brasl	%r14,s390_handle_mcck
 	TRACE_IRQS_ON
 .Lmcck_return:
-	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
 	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 	stpt	__LC_EXIT_TIMER
-	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
 	b	__LC_RETURN_MCCK_LPSWE
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 07aa15ba43b3..0a5cb423aae2 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -402,7 +402,6 @@ static void __init setup_lowcore_dat_off(void)
 	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
 	       sizeof(lc->alt_stfle_fac_list));
 	nmi_alloc_boot_cpu(lc);
-	vdso_alloc_boot_cpu(lc);
 	lc->sync_enter_timer = S390_lowcore.sync_enter_timer;
 	lc->async_enter_timer = S390_lowcore.async_enter_timer;
 	lc->exit_timer = S390_lowcore.exit_timer;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b1113b519432..1fda13a1f536 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -41,6 +41,8 @@
 #include <linux/gfp.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
+#include <vdso/clocksource.h>
+#include <vdso/helpers.h>
 #include <asm/facility.h>
 #include <asm/delay.h>
 #include <asm/div64.h>
@@ -84,7 +86,7 @@ void __init time_early_init(void)
 
 	/* Initialize TOD steering parameters */
 	tod_steering_end = *(unsigned long long *) &tod_clock_base[1];
-	vdso_data->ts_end = tod_steering_end;
+	vdso_data->arch.tod_steering_end = tod_steering_end;
 
 	if (!test_facility(28))
 		return;
@@ -257,6 +259,7 @@ static struct clocksource clocksource_tod = {
 	.mult		= 1000,
 	.shift		= 12,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.vdso_clock_mode = VDSO_CLOCKMODE_TOD,
 };
 
 struct clocksource * __init clocksource_default_clock(void)
@@ -264,56 +267,6 @@ struct clocksource * __init clocksource_default_clock(void)
 	return &clocksource_tod;
 }
 
-void update_vsyscall(struct timekeeper *tk)
-{
-	u64 nsecps;
-
-	if (tk->tkr_mono.clock != &clocksource_tod)
-		return;
-
-	/* Make userspace gettimeofday spin until we're done. */
-	++vdso_data->tb_update_count;
-	smp_wmb();
-	vdso_data->xtime_tod_stamp = tk->tkr_mono.cycle_last;
-	vdso_data->xtime_clock_sec = tk->xtime_sec;
-	vdso_data->xtime_clock_nsec = tk->tkr_mono.xtime_nsec;
-	vdso_data->wtom_clock_sec =
-		tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	vdso_data->wtom_clock_nsec = tk->tkr_mono.xtime_nsec +
-		+ ((u64) tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
-	nsecps = (u64) NSEC_PER_SEC << tk->tkr_mono.shift;
-	while (vdso_data->wtom_clock_nsec >= nsecps) {
-		vdso_data->wtom_clock_nsec -= nsecps;
-		vdso_data->wtom_clock_sec++;
-	}
-
-	vdso_data->xtime_coarse_sec = tk->xtime_sec;
-	vdso_data->xtime_coarse_nsec =
-		(long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
-	vdso_data->wtom_coarse_sec =
-		vdso_data->xtime_coarse_sec + tk->wall_to_monotonic.tv_sec;
-	vdso_data->wtom_coarse_nsec =
-		vdso_data->xtime_coarse_nsec + tk->wall_to_monotonic.tv_nsec;
-	while (vdso_data->wtom_coarse_nsec >= NSEC_PER_SEC) {
-		vdso_data->wtom_coarse_nsec -= NSEC_PER_SEC;
-		vdso_data->wtom_coarse_sec++;
-	}
-
-	vdso_data->tk_mult = tk->tkr_mono.mult;
-	vdso_data->tk_shift = tk->tkr_mono.shift;
-	vdso_data->hrtimer_res = hrtimer_resolution;
-	smp_wmb();
-	++vdso_data->tb_update_count;
-}
-
-extern struct timezone sys_tz;
-
-void update_vsyscall_tz(void)
-{
-	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
-	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
-}
-
 /*
  * Initialize the TOD clock and the CPU timer of
  * the boot cpu.
@@ -431,7 +384,6 @@ static void clock_sync_global(unsigned long long delta)
 		/* Epoch overflow */
 		tod_clock_base[0]++;
 	/* Adjust TOD steering parameters. */
-	vdso_data->tb_update_count++;
 	now = get_tod_clock();
 	adj = tod_steering_end - now;
 	if (unlikely((s64) adj >= 0))
@@ -443,9 +395,8 @@ static void clock_sync_global(unsigned long long delta)
 		panic("TOD clock sync offset %lli is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
-	vdso_data->ts_dir = (tod_steering_delta < 0) ? 0 : 1;
-	vdso_data->ts_end = tod_steering_end;
-	vdso_data->tb_update_count++;
+	vdso_data->arch.tod_steering_end = tod_steering_end;
+
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
 		lpar_offset = qto.tod_epoch_difference;
@@ -599,6 +550,13 @@ static int stp_sync_clock(void *data)
 		if (stp_info.todoff[0] || stp_info.todoff[1] ||
 		    stp_info.todoff[2] || stp_info.todoff[3] ||
 		    stp_info.tmd != 2) {
+			vdso_data->arch.tb_update_cnt++;
+			/*
+			 * This barrier isn't really needed as we're called
+			 * from stop_machine_cpuslocked(). However it doesn't
+			 * hurt in case the code gets changed.
+			 */
+			smp_wmb();
 			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
 					&clock_delta);
 			if (rc == 0) {
@@ -609,6 +567,8 @@ static int stp_sync_clock(void *data)
 				if (rc == 0 && stp_info.tmd != 2)
 					rc = -EAGAIN;
 			}
+			smp_wmb(); /* see comment above */
+			vdso_data->arch.tb_update_cnt++;
 		}
 		sync->in_sync = rc ? -EAGAIN : 1;
 		xchg(&first, 0);
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index c4baefaa6e34..f9da5b149141 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -20,6 +20,8 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 #include <linux/compat.h>
+#include <linux/binfmts.h>
+#include <vdso/datapage.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
@@ -96,35 +98,12 @@ static union {
 	struct vdso_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
-
-/*
- * Setup vdso data page.
- */
-static void __init vdso_init_data(struct vdso_data *vd)
-{
-	vd->ectg_available = test_facility(31);
-}
-
+struct vdso_data *vdso_data = (struct vdso_data *)&vdso_data_store.data;
 /*
  * Allocate/free per cpu vdso data.
  */
 #define SEGMENT_ORDER	2
 
-/*
- * The initial vdso_data structure for the boot CPU. Eventually
- * it is replaced with a properly allocated structure in vdso_init.
- * This is necessary because a valid S390_lowcore.vdso_per_cpu_data
- * pointer is required to be able to return from an interrupt or
- * program check. See the exit paths in entry.S.
- */
-struct vdso_data boot_vdso_data __initdata;
-
-void __init vdso_alloc_boot_cpu(struct lowcore *lowcore)
-{
-	lowcore->vdso_per_cpu_data = (unsigned long) &boot_vdso_data;
-}
-
 int vdso_alloc_per_cpu(struct lowcore *lowcore)
 {
 	unsigned long segment_table, page_table, page_frame;
@@ -246,8 +225,6 @@ static int __init vdso_init(void)
 {
 	int i;
 
-	vdso_init_data(vdso_data);
-
 	/* Calculate the size of the 64 bit vDSO */
 	vdso64_pages = ((&vdso64_end - &vdso64_start
 			 + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 4a66a1cb919b..f1c0570780d1 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -1,14 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0
-# List of files in the vdso, has to be asm only for now
+# List of files in the vdso
 
 KCOV_INSTRUMENT := n
+ARCH_REL_TYPE_ABS := R_390_COPY|R_390_GLOB_DAT|R_390_JMP_SLOT|R_390_RELATIVE
+ARCH_REL_TYPE_ABS += R_390_GOT|R_390_PLT
 
-obj-vdso64 = gettimeofday.o clock_getres.o clock_gettime.o note.o getcpu.o
+include $(srctree)/lib/vdso/Makefile
+obj-vdso64 = vdso_user_wrapper.o note.o getcpu.o
+obj-cvdso64 = vdso64_generic.o
+CFLAGS_REMOVE_vdso64_generic.o = -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE)
 
 # Build rules
 
-targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
+targets := $(obj-vdso64) $(obj-cvdso64) vdso64.so vdso64.so.dbg
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
+obj-cvdso64 := $(addprefix $(obj)/, $(obj-cvdso64))
 
 KBUILD_AFLAGS += -DBUILD_VDSO
 KBUILD_CFLAGS += -DBUILD_VDSO
@@ -37,7 +43,7 @@ KASAN_SANITIZE := n
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) FORCE
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) FORCE
 	$(call if_changed,ld)
 
 # strip rule for the .so file
@@ -49,9 +55,14 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 $(obj-vdso64): %.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 
+$(obj-cvdso64): %.o: %.c FORCE
+	$(call if_changed_dep,vdso64cc)
+
 # actual build commands
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
+quiet_cmd_vdso64cc = VDSO64C $@
+      cmd_vdso64cc = $(CC) $(c_flags) -c -o $@ $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
deleted file mode 100644
index 0c79caa32b59..000000000000
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Userland implementation of clock_getres() for 64 bits processes in a
- * s390 kernel for use in the vDSO
- *
- *  Copyright IBM Corp. 2008
- *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-#include <asm/vdso.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-#include <asm/dwarf.h>
-
-	.text
-	.align 4
-	.globl __kernel_clock_getres
-	.type  __kernel_clock_getres,@function
-__kernel_clock_getres:
-	CFI_STARTPROC
-	larl	%r1,3f
-	lg	%r0,0(%r1)
-	cghi	%r2,__CLOCK_REALTIME_COARSE
-	je	0f
-	cghi	%r2,__CLOCK_MONOTONIC_COARSE
-	je	0f
-	larl	%r1,_vdso_data
-	llgf	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
-	cghi	%r2,__CLOCK_REALTIME
-	je	0f
-	cghi	%r2,__CLOCK_MONOTONIC
-	je	0f
-	cghi	%r2,__CLOCK_THREAD_CPUTIME_ID
-	je	0f
-	cghi	%r2,-2		/* Per-thread CPUCLOCK with PID=0, VIRT=1 */
-	jne	2f
-	larl	%r5,_vdso_data
-	icm	%r0,15,__LC_ECTG_OK(%r5)
-	jz	2f
-0:	ltgr	%r3,%r3
-	jz	1f				/* res == NULL */
-	xc	0(8,%r3),0(%r3)			/* set tp->tv_sec to zero */
-	stg	%r0,8(%r3)			/* store tp->tv_usec */
-1:	lghi	%r2,0
-	br	%r14
-2:	lghi	%r1,__NR_clock_getres		/* fallback to svc */
-	svc	0
-	br	%r14
-	CFI_ENDPROC
-3:	.quad	__CLOCK_COARSE_RES
-	.size	__kernel_clock_getres,.-__kernel_clock_getres
diff --git a/arch/s390/kernel/vdso64/clock_gettime.S b/arch/s390/kernel/vdso64/clock_gettime.S
deleted file mode 100644
index 9d2ee79b90f2..000000000000
--- a/arch/s390/kernel/vdso64/clock_gettime.S
+++ /dev/null
@@ -1,163 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Userland implementation of clock_gettime() for 64 bits processes in a
- * s390 kernel for use in the vDSO
- *
- *  Copyright IBM Corp. 2008
- *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-#include <asm/vdso.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-#include <asm/dwarf.h>
-#include <asm/ptrace.h>
-
-	.text
-	.align 4
-	.globl __kernel_clock_gettime
-	.type  __kernel_clock_gettime,@function
-__kernel_clock_gettime:
-	CFI_STARTPROC
-	aghi	%r15,-16
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD+16
-	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
-	larl	%r5,_vdso_data
-	cghi	%r2,__CLOCK_REALTIME_COARSE
-	je	4f
-	cghi	%r2,__CLOCK_REALTIME
-	je	5f
-	cghi	%r2,-3		/* Per-thread CPUCLOCK with PID=0, VIRT=1 */
-	je	9f
-	cghi	%r2,__CLOCK_MONOTONIC_COARSE
-	je	3f
-	cghi	%r2,__CLOCK_MONOTONIC
-	jne	12f
-
-	/* CLOCK_MONOTONIC */
-0:	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
-	tmll	%r4,0x0001			/* pending update ? loop */
-	jnz	0b
-	stcke	0(%r15)				/* Store TOD clock */
-	lgf	%r2,__VDSO_TK_SHIFT(%r5)	/* Timekeeper shift */
-	lg	%r0,__VDSO_WTOM_SEC(%r5)
-	lg	%r1,1(%r15)
-	sg	%r1,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
-	msgf	%r1,__VDSO_TK_MULT(%r5)		/*  * tk->mult */
-	alg	%r1,__VDSO_WTOM_NSEC(%r5)
-	srlg	%r1,%r1,0(%r2)			/*  >> tk->shift */
-	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
-	jne	0b
-	larl	%r5,13f
-1:	clg	%r1,0(%r5)
-	jl	2f
-	slg	%r1,0(%r5)
-	aghi	%r0,1
-	j	1b
-2:	stg	%r0,0(%r3)			/* store tp->tv_sec */
-	stg	%r1,8(%r3)			/* store tp->tv_nsec */
-	lghi	%r2,0
-	aghi	%r15,16
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
-	CFI_RESTORE 15
-	br	%r14
-
-	/* CLOCK_MONOTONIC_COARSE */
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD+16
-	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
-3:	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
-	tmll	%r4,0x0001			/* pending update ? loop */
-	jnz	3b
-	lg	%r0,__VDSO_WTOM_CRS_SEC(%r5)
-	lg	%r1,__VDSO_WTOM_CRS_NSEC(%r5)
-	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
-	jne	3b
-	j	2b
-
-	/* CLOCK_REALTIME_COARSE */
-4:	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
-	tmll	%r4,0x0001			/* pending update ? loop */
-	jnz	4b
-	lg	%r0,__VDSO_XTIME_CRS_SEC(%r5)
-	lg	%r1,__VDSO_XTIME_CRS_NSEC(%r5)
-	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
-	jne	4b
-	j	7f
-
-	/* CLOCK_REALTIME */
-5:	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
-	tmll	%r4,0x0001			/* pending update ? loop */
-	jnz	5b
-	stcke	0(%r15)				/* Store TOD clock */
-	lg	%r1,1(%r15)
-	lg	%r0,__VDSO_TS_END(%r5)		/* TOD steering end time */
-	slgr	%r0,%r1				/* now - ts_steering_end */
-	ltgr	%r0,%r0				/* past end of steering ? */
-	jm	17f
-	srlg	%r0,%r0,15			/* 1 per 2^16 */
-	tm	__VDSO_TS_DIR+3(%r5),0x01	/* steering direction? */
-	jz	18f
-	lcgr	%r0,%r0				/* negative TOD offset */
-18:	algr	%r1,%r0				/* add steering offset */
-17:	lgf	%r2,__VDSO_TK_SHIFT(%r5)	/* Timekeeper shift */
-	sg	%r1,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
-	msgf	%r1,__VDSO_TK_MULT(%r5)		/*  * tk->mult */
-	alg	%r1,__VDSO_XTIME_NSEC(%r5)	/*  + tk->xtime_nsec */
-	srlg	%r1,%r1,0(%r2)			/*  >> tk->shift */
-	lg	%r0,__VDSO_XTIME_SEC(%r5)	/* tk->xtime_sec */
-	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
-	jne	5b
-	larl	%r5,13f
-6:	clg	%r1,0(%r5)
-	jl	7f
-	slg	%r1,0(%r5)
-	aghi	%r0,1
-	j	6b
-7:	stg	%r0,0(%r3)			/* store tp->tv_sec */
-	stg	%r1,8(%r3)			/* store tp->tv_nsec */
-	lghi	%r2,0
-	aghi	%r15,16
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
-	CFI_RESTORE 15
-	br	%r14
-
-	/* CPUCLOCK_VIRT for this thread */
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD+16
-	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
-9:	lghi	%r4,0
-	icm	%r0,15,__VDSO_ECTG_OK(%r5)
-	jz	12f
-	sacf	256				/* Magic ectg instruction */
-	.insn	ssf,0xc80100000000,__VDSO_ECTG_BASE(4),__VDSO_ECTG_USER(4),4
-	sacf	0
-	algr	%r1,%r0				/* r1 = cputime as TOD value */
-	mghi	%r1,1000			/* convert to nanoseconds */
-	srlg	%r1,%r1,12			/* r1 = cputime in nanosec */
-	lgr	%r4,%r1
-	larl	%r5,13f
-	srlg	%r1,%r1,9			/* divide by 1000000000 */
-	mlg	%r0,8(%r5)
-	srlg	%r0,%r0,11			/* r0 = tv_sec */
-	stg	%r0,0(%r3)
-	msg	%r0,0(%r5)			/* calculate tv_nsec */
-	slgr	%r4,%r0				/* r4 = tv_nsec */
-	stg	%r4,8(%r3)
-	lghi	%r2,0
-	aghi	%r15,16
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
-	CFI_RESTORE 15
-	br	%r14
-
-	/* Fallback to system call */
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD+16
-	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
-12:	lghi	%r1,__NR_clock_gettime
-	svc	0
-	aghi	%r15,16
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
-	CFI_RESTORE 15
-	br	%r14
-	CFI_ENDPROC
-
-13:	.quad	1000000000
-14:	.quad	19342813113834067
-	.size	__kernel_clock_gettime,.-__kernel_clock_gettime
diff --git a/arch/s390/kernel/vdso64/gettimeofday.S b/arch/s390/kernel/vdso64/gettimeofday.S
deleted file mode 100644
index aebe10dc7c99..000000000000
--- a/arch/s390/kernel/vdso64/gettimeofday.S
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Userland implementation of gettimeofday() for 64 bits processes in a
- * s390 kernel for use in the vDSO
- *
- *  Copyright IBM Corp. 2008
- *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- */
-#include <asm/vdso.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-#include <asm/dwarf.h>
-#include <asm/ptrace.h>
-
-	.text
-	.align 4
-	.globl __kernel_gettimeofday
-	.type  __kernel_gettimeofday,@function
-__kernel_gettimeofday:
-	CFI_STARTPROC
-	aghi	%r15,-16
-	CFI_ADJUST_CFA_OFFSET 16
-	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
-	larl	%r5,_vdso_data
-0:	ltgr	%r3,%r3				/* check if tz is NULL */
-	je	1f
-	mvc	0(8,%r3),__VDSO_TIMEZONE(%r5)
-1:	ltgr	%r2,%r2				/* check if tv is NULL */
-	je	4f
-	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
-	tmll	%r4,0x0001			/* pending update ? loop */
-	jnz	0b
-	stcke	0(%r15)				/* Store TOD clock */
-	lg	%r1,1(%r15)
-	lg	%r0,__VDSO_TS_END(%r5)		/* TOD steering end time */
-	slgr	%r0,%r1				/* now - ts_steering_end */
-	ltgr	%r0,%r0				/* past end of steering ? */
-	jm	6f
-	srlg	%r0,%r0,15			/* 1 per 2^16 */
-	tm	__VDSO_TS_DIR+3(%r5),0x01	/* steering direction? */
-	jz	7f
-	lcgr	%r0,%r0				/* negative TOD offset */
-7:	algr	%r1,%r0				/* add steering offset */
-6:	sg	%r1,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
-	msgf	%r1,__VDSO_TK_MULT(%r5)		/*  * tk->mult */
-	alg	%r1,__VDSO_XTIME_NSEC(%r5)	/*  + tk->xtime_nsec */
-	lg	%r0,__VDSO_XTIME_SEC(%r5)	/* tk->xtime_sec */
-	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
-	jne	0b
-	lgf	%r5,__VDSO_TK_SHIFT(%r5)	/* Timekeeper shift */
-	srlg	%r1,%r1,0(%r5)			/*  >> tk->shift */
-	larl	%r5,5f
-2:	clg	%r1,0(%r5)
-	jl	3f
-	slg	%r1,0(%r5)
-	aghi	%r0,1
-	j	2b
-3:	stg	%r0,0(%r2)			/* store tv->tv_sec */
-	slgr	%r0,%r0				/* tv_nsec -> tv_usec */
-	ml	%r0,8(%r5)
-	srlg	%r0,%r0,6
-	stg	%r0,8(%r2)			/* store tv->tv_usec */
-4:	lghi	%r2,0
-	aghi	%r15,16
-	CFI_ADJUST_CFA_OFFSET -16
-	CFI_RESTORE 15
-	br	%r14
-	CFI_ENDPROC
-5:	.quad	1000000000
-	.long	274877907
-	.size	__kernel_gettimeofday,.-__kernel_gettimeofday
diff --git a/arch/s390/kernel/vdso64/vdso64_generic.c b/arch/s390/kernel/vdso64/vdso64_generic.c
new file mode 100644
index 000000000000..a8cef7e4d137
--- /dev/null
+++ b/arch/s390/kernel/vdso64/vdso64_generic.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../../../../lib/vdso/gettimeofday.c"
+
+int __s390_vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			     struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __s390_vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __s390_vdso_clock_getres(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_getres(clock, ts);
+}
diff --git a/arch/s390/kernel/vdso64/vdso_user_wrapper.S b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
new file mode 100644
index 000000000000..a775d7e52872
--- /dev/null
+++ b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/vdso.h>
+#include <asm/unistd.h>
+#include <asm/asm-offsets.h>
+#include <asm/dwarf.h>
+#include <asm/ptrace.h>
+
+#define WRAPPER_FRAME_SIZE (STACK_FRAME_OVERHEAD+8)
+
+/*
+ * Older glibc version called vdso without allocating a stackframe. This wrapper
+ * is just used to allocate a stackframe. See
+ * https://sourceware.org/git/?p=glibc.git;a=commit;h=478593e6374f3818da39332260dc453cb19cfa1e
+ * for details.
+ */
+.macro vdso_func func
+	.globl __kernel_\func
+	.type  __kernel_\func,@function
+	.align 8
+__kernel_\func:
+	CFI_STARTPROC
+	aghi	%r15,-WRAPPER_FRAME_SIZE
+	CFI_DEF_CFA_OFFSET (STACK_FRAME_OVERHEAD + WRAPPER_FRAME_SIZE)
+	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
+	stg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	brasl	%r14,__s390_vdso_\func
+	lg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	aghi	%r15,WRAPPER_FRAME_SIZE
+	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
+	CFI_RESTORE 15
+	br	%r14
+	CFI_ENDPROC
+	.size	__kernel_\func,.-__kernel_\func
+.endm
+
+vdso_func gettimeofday
+vdso_func clock_getres
+vdso_func clock_gettime
-- 
2.17.1
