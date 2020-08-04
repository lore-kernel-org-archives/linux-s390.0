Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbgHDJWq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Aug 2020 05:22:46 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
References: <20200803055645.79042-1-svens@linux.ibm.com>
        <20200803055645.79042-3-svens@linux.ibm.com>
        <87ft93ncaa.fsf@nanos.tec.linutronix.de>
        <yt9dmu3b3jo3.fsf@linux.ibm.com>
        <87a6zbn29n.fsf@nanos.tec.linutronix.de>
        <20200803184428.GA3973@osiris>
        <873653mswn.fsf@nanos.tec.linutronix.de>
Date: Tue, 04 Aug 2020 11:22:20 +0200
In-Reply-To: <873653mswn.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 03 Aug 2020 21:27:36 +0200")
Message-ID: <yt9d5z9yhik3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org

Hi,

Thomas Gleixner <tglx@linutronix.de> writes:
> Heiko Carstens <hca@linux.ibm.com> writes:
>
>> On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
>>> +/**
>>> + * vdso_update_begin - Start of a VDSO update section
>>> + *
>>> + * Allows architecture code to safely update the architecture specific VDSO
>>> + * data.
>>> + */
>>> +void vdso_update_begin(void)
>>> +{
>>> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>> +
>>> +	raw_spin_lock(&timekeeper_lock);
>>> +	vdso_write_begin(vdata);
>>> +}
>>
>> I would assume that this only works if vdso_update_begin() is called
>> with irqs disabled, otherwise it could deadlock, no?
>
> Yes.
>
>> Maybe something like:
>>
>> void vdso_update_begin(unsigned long *flags)
>> {
>> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>
>> 	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
>> 	vdso_write_begin(vdata);
>
> Shudder. Why not returning flags?
>
>> }
>>
>> void vdso_update_end(unsigned long *flags)
>
> Ditto, why pointer and not value?
>
>> {
>> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>>
>> 	vdso_write_end(vdata);
>> 	__arch_sync_vdso_data(vdata);
>> 	raw_spin_unlock_irqrestore(&timekeeper_lock, *flags);
>> }
>>
>> ? Just wondering.
>
> Thought about that briefly, but then hated the flags thing and delegated
> it to the caller. Lockdep will yell if that lock is taken with
> interrupts enabled :)
>
> But aside of the pointer vs. value thing, I'm fine with doing it in the
> functions.

Thanks Thomas & Heiko. I'll incorporate the changes into my patchset and
send an updated version. Thomas, i think it's fine if i update your
patch and we take it through the s390 tree?

Regards
Sven
