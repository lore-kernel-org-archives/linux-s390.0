Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727039AbgHCOKB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 10:10:01 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
References: <20200803055645.79042-1-svens@linux.ibm.com>
        <20200803055645.79042-3-svens@linux.ibm.com>
        <87ft93ncaa.fsf@nanos.tec.linutronix.de>
Date: Mon, 03 Aug 2020 16:09:48 +0200
In-Reply-To: <87ft93ncaa.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 03 Aug 2020 14:29:01 +0200")
Message-ID: <yt9dmu3b3jo3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, hca@linux.ibm.com

Thomas Gleixner <tglx@linutronix.de> writes:

> Sven Schnelle <svens@linux.ibm.com> writes:
>
>> - CPUCLOCK_VIRT is now handled with a syscall fallback, which might
>>   be slower/less accurate than the old implementation.
>
> I can understand the slower, but why does it become less accurate?

Because we saved the system/user times as almost the last instruction
when leaving the kernel to userspace. Now it's a bit earlier, because
it is done in the C code. So it's not really related to the syscall
fallback, but the switch from assembly to C.

>> Performance number from my system do 100 mio gettimeofday() calls:
>>
>> Plain syscall: 8.6s
>> Generic VDSO:  1.3s
>> old ASM VDSO:  1s
>>
>> So it's a bit slower but still much faster than syscalls.
>
> Where is the overhead coming from?

It's because we have to allocate a stackframe which we didn't do before,
and the compiler generated code is less optimized than the hand-crafted
assembly code we had before.

>> +static inline u64 __arch_get_hw_counter(s32 clock_mode)
>> +{
>> +	const struct vdso_data *vdso = __arch_get_vdso_data();
>> +	u64 adj, now;
>> +	int cnt;
>> +
>> +	do {
>> +		do {
>> +			cnt = READ_ONCE(vdso->arch.tb_update_cnt);
>> +		} while (cnt & 1);
>
>                 smp_rmb() ?

>> +		now = get_tod_clock();
>> +		adj = vdso->arch.tod_steering_end - now;
>> +		if (unlikely((s64) adj > 0))
>> +			now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);
>
>                 smp_rmb() ?
>
>> +	} while (cnt != READ_ONCE(vdso->arch.tb_update_cnt));
>> +	return now;
>>  	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
>>  		lpar_offset = qto.tod_epoch_difference;
>> @@ -599,6 +550,13 @@ static int stp_sync_clock(void *data)
>>  		if (stp_info.todoff[0] || stp_info.todoff[1] ||
>>  		    stp_info.todoff[2] || stp_info.todoff[3] ||
>>  		    stp_info.tmd != 2) {
>> +			vdso_data->arch.tb_update_cnt++;
>> +			/*
>> +			 * This barrier isn't really needed as we're called
>> +			 * from stop_machine_cpuslocked(). However it doesn't
>> +			 * hurt in case the code gets changed.
>> +			 */
>> +			smp_wmb();
>
> WMB without a corresponding RMB and an explanation what's ordered
> against what is voodoo at best.
>
>>  			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
>>  					&clock_delta);
>>  			if (rc == 0) {
>> @@ -609,6 +567,8 @@ static int stp_sync_clock(void *data)
>>  				if (rc == 0 && stp_info.tmd != 2)
>>  					rc = -EAGAIN;
>>  			}
>> +			smp_wmb(); /* see comment above */
>
> See my comments above :)

:-)

What do you think about my question on using vdso_write_begin/end()?
__arch_get_hw_counter() is called inside a vdso_read_retry() loop, so i
would think that just enclosing this update with vdso_write_begin/end()
should sufficient. But i'm not sure whether arch/ should call these
functions.

Thanks
Sven
