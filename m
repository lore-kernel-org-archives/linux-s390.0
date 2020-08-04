Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:47510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHDUlF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Aug 2020 16:41:05 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/3] s390: convert to GENERIC_VDSO
In-Reply-To: <20200804150124.41692-4-svens@linux.ibm.com>
References: <20200804150124.41692-1-svens@linux.ibm.com> <20200804150124.41692-4-svens@linux.ibm.com>
Date: Tue, 04 Aug 2020 22:41:00 +0200
Message-ID: <87tuxikuub.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com

Sven,

Sven Schnelle <svens@linux.ibm.com> writes:
> --- /dev/null
> +++ b/arch/s390/include/asm/vdso/data.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __S390_ASM_VDSO_DATA_H
> +#define __S390_ASM_VDSO_DATA_H
> +
> +#include <linux/types.h>
> +#include <vdso/datapage.h>

I don't think this header needs vdso/datapage.h

> +struct arch_vdso_data {
> +	__u64 tod_steering_delta;
> +	__u64 tod_steering_end;
> +};
> +
> +#endif /* __S390_ASM_VDSO_DATA_H */

> --- /dev/null
> +++ b/arch/s390/include/asm/vdso/gettimeofday.h

> +static inline u64 __arch_get_hw_counter(s32 clock_mode)
> +{
> +	const struct vdso_data *vdso = __arch_get_vdso_data();

If you go and implement time namespace support for VDSO then this
becomes a problem. See do_hres_timens().

As we did not expect that this function needs vdso_data we should just
add a vdso_data pointer argument to __arch_get_hw_counter(). And while
looking at it you're not the first one. MIPS already uses it and because
it does not support time namespaces so far nobody noticed yet.

That's fine for all others because the compiler will optimize it
out when it's unused. If the compiler fails to do so, then this is the
least of our worries :)

As there is no new VDSO conversion pending in next, I can just queue
that (see below) along with #1 and #2 of this series and send it to
Linus by end of the week.

> +	u64 adj, now;
> +
> +	now = get_tod_clock();
> +	adj = vdso->arch.tod_steering_end - now;
> +	if (unlikely((s64) adj > 0))
> +		now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);
> +	return now;
> +}


> --- /dev/null
> +++ b/arch/s390/include/asm/vdso/processor.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_VDSO_PROCESSOR_H
> +#define __ASM_VDSO_PROCESSOR_H
> +
> +#endif /* __ASM_VDSO_PROCESSOR_H */

The idea of this file was to provide cpu_relax() self contained without
pulling in tons of other things from asm/processor.h.

> diff --git a/arch/s390/include/asm/vdso/vdso.h b/arch/s390/include/asm/vdso/vdso.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
> new file mode 100644
> index 000000000000..6c67c08cefdd
> --- /dev/null
> +++ b/arch/s390/include/asm/vdso/vsyscall.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_VDSO_VSYSCALL_H
> +#define __ASM_VDSO_VSYSCALL_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/hrtimer.h>
> +#include <linux/timekeeper_internal.h>

I know you copied that from x86 or some other architecture, but thinking
about the above these two includes are not required for building VDSO
itself. Only the kernel update side needs them and they are included
already there. I'm going to remove them from x86 as well.

> @@ -443,9 +396,8 @@ static void clock_sync_global(unsigned long long delta)
>  		panic("TOD clock sync offset %lli is too large to drift\n",
>  		      tod_steering_delta);
>  	tod_steering_end = now + (abs(tod_steering_delta) << 15);
> -	vdso_data->ts_dir = (tod_steering_delta < 0) ? 0 : 1;
> -	vdso_data->ts_end = tod_steering_end;
> -	vdso_data->tb_update_count++;
> +	vdso_data->arch.tod_steering_end = tod_steering_end;

Leftover from the previous version. Should be arch_data.tod....

Heiko, do you consider this 5.9 material or am I right to assume that
this targets 5.10?

Thanks,

        tglx
-----
Subject: vdso/treewide: Add vdso_data pointer argument to __arch_get_hw_counter()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 04 Aug 2020 22:17:44 +0200

MIPS already uses and S390 will need the vdso data pointer in
__arch_get_hw_counter().

This works nicely as long as the architecture does not support time
namespaces in the VDSO. With time namespaces enabled the regular
accessor to the vdso data pointer __arch_get_vdso_data() will return the
namespace specific VDSO data page for tasks which are part of a
non-root time namespace. This would cause the architectures which need
the vdso data pointer in __arch_get_hw_counter() to access the wrong
vdso data page.

Add a vdso_data pointer argument to __arch_get_hw_counter() and hand it
in from the call sites in the core code. For architectures which do not
need the data pointer in their counter accessor inline function the
compiler will just optimize it out.

Fix up all existing architecture implementations and make MIPS utilize the
pointer instead of invoking the accessor function.

No functional change and no change in the resulting object code (except
MIPS).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/include/asm/vdso/gettimeofday.h          |    3 ++-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |    3 ++-
 arch/arm64/include/asm/vdso/gettimeofday.h        |    3 ++-
 arch/mips/include/asm/vdso/gettimeofday.h         |    5 +++--
 arch/riscv/include/asm/vdso/gettimeofday.h        |    3 ++-
 arch/x86/include/asm/vdso/gettimeofday.h          |    3 ++-
 lib/vdso/gettimeofday.c                           |    4 ++--
 7 files changed, 15 insertions(+), 9 deletions(-)

--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -112,7 +112,8 @@ static inline bool arm_vdso_hres_capable
 }
 #define __arch_vdso_hres_capable arm_vdso_hres_capable
 
-static __always_inline u64 __arch_get_hw_counter(int clock_mode)
+static __always_inline u64 __arch_get_hw_counter(int clock_mode,
+						 const struct vdso_data *vd)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
 	u64 cycle_now;
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -102,7 +102,8 @@ int clock_getres32_fallback(clockid_t _c
 	return ret;
 }
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 	u64 res;
 
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -63,7 +63,8 @@ int clock_getres_fallback(clockid_t _clk
 	return ret;
 }
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 	u64 res;
 
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -167,7 +167,8 @@ static __always_inline u64 read_gic_coun
 
 #endif
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 #ifdef CONFIG_CSRC_R4K
 	if (clock_mode == VDSO_CLOCKMODE_R4K)
@@ -175,7 +176,7 @@ static __always_inline u64 __arch_get_hw
 #endif
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 	if (clock_mode == VDSO_CLOCKMODE_GIC)
-		return read_gic_count(get_vdso_data());
+		return read_gic_count(vd);
 #endif
 	/*
 	 * Core checks mode already. So this raced against a concurrent
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -59,7 +59,8 @@ int clock_getres_fallback(clockid_t _clk
 	return ret;
 }
 
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
 {
 	/*
 	 * The purpose of csr_read(CSR_TIME) is to trap the system into
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -241,7 +241,8 @@ static u64 vread_hvclock(void)
 }
 #endif
 
-static inline u64 __arch_get_hw_counter(s32 clock_mode)
+static inline u64 __arch_get_hw_counter(s32 clock_mode,
+					const struct vdso_data *vd)
 {
 	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
 		return (u64)rdtsc_ordered();
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -68,7 +68,7 @@ static int do_hres_timens(const struct v
 		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
-		cycles = __arch_get_hw_counter(vd->clock_mode);
+		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
 		ns = vdso_ts->nsec;
@@ -138,7 +138,7 @@ static __always_inline int do_hres(const
 		if (unlikely(!vdso_clocksource_ok(vd)))
 			return -1;
 
-		cycles = __arch_get_hw_counter(vd->clock_mode);
+		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
 		ns = vdso_ts->nsec;
