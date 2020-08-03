Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
In-Reply-To: <20200803055645.79042-3-svens@linux.ibm.com>
References: <20200803055645.79042-1-svens@linux.ibm.com> <20200803055645.79042-3-svens@linux.ibm.com>
Date: Mon, 03 Aug 2020 14:29:01 +0200
Message-ID: <87ft93ncaa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>

Sven Schnelle <svens@linux.ibm.com> writes:

> - CPUCLOCK_VIRT is now handled with a syscall fallback, which might
>   be slower/less accurate than the old implementation.

I can understand the slower, but why does it become less accurate?

> Performance number from my system do 100 mio gettimeofday() calls:
>
> Plain syscall: 8.6s
> Generic VDSO:  1.3s
> old ASM VDSO:  1s
>
> So it's a bit slower but still much faster than syscalls.

Where is the overhead coming from?

> +static inline u64 __arch_get_hw_counter(s32 clock_mode)
> +{
> +	const struct vdso_data *vdso = __arch_get_vdso_data();
> +	u64 adj, now;
> +	int cnt;
> +
> +	do {
> +		do {
> +			cnt = READ_ONCE(vdso->arch.tb_update_cnt);
> +		} while (cnt & 1);

                smp_rmb() ?

> +		now = get_tod_clock();
> +		adj = vdso->arch.tod_steering_end - now;
> +		if (unlikely((s64) adj > 0))
> +			now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);

                smp_rmb() ?

> +	} while (cnt != READ_ONCE(vdso->arch.tb_update_cnt));
> +	return now;
>  	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
>  		lpar_offset = qto.tod_epoch_difference;
> @@ -599,6 +550,13 @@ static int stp_sync_clock(void *data)
>  		if (stp_info.todoff[0] || stp_info.todoff[1] ||
>  		    stp_info.todoff[2] || stp_info.todoff[3] ||
>  		    stp_info.tmd != 2) {
> +			vdso_data->arch.tb_update_cnt++;
> +			/*
> +			 * This barrier isn't really needed as we're called
> +			 * from stop_machine_cpuslocked(). However it doesn't
> +			 * hurt in case the code gets changed.
> +			 */
> +			smp_wmb();

WMB without a corresponding RMB and an explanation what's ordered
against what is voodoo at best.

>  			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
>  					&clock_delta);
>  			if (rc == 0) {
> @@ -609,6 +567,8 @@ static int stp_sync_clock(void *data)
>  				if (rc == 0 && stp_info.tmd != 2)
>  					rc = -EAGAIN;
>  			}
> +			smp_wmb(); /* see comment above */

See my comments above :)

Thanks,

        tglx
