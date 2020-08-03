Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:39108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgHCT1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 15:27:39 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
In-Reply-To: <20200803184428.GA3973@osiris>
References: <20200803055645.79042-1-svens@linux.ibm.com> <20200803055645.79042-3-svens@linux.ibm.com> <87ft93ncaa.fsf@nanos.tec.linutronix.de> <yt9dmu3b3jo3.fsf@linux.ibm.com> <87a6zbn29n.fsf@nanos.tec.linutronix.de> <20200803184428.GA3973@osiris>
Date: Mon, 03 Aug 2020 21:27:36 +0200
Message-ID: <873653mswn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org

Heiko Carstens <hca@linux.ibm.com> writes:

> On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
>> +/**
>> + * vdso_update_begin - Start of a VDSO update section
>> + *
>> + * Allows architecture code to safely update the architecture specific VDSO
>> + * data.
>> + */
>> +void vdso_update_begin(void)
>> +{
>> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
>> +
>> +	raw_spin_lock(&timekeeper_lock);
>> +	vdso_write_begin(vdata);
>> +}
>
> I would assume that this only works if vdso_update_begin() is called
> with irqs disabled, otherwise it could deadlock, no?

Yes.

> Maybe something like:
>
> void vdso_update_begin(unsigned long *flags)
> {
> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>
> 	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
> 	vdso_write_begin(vdata);

Shudder. Why not returning flags?

> }
>
> void vdso_update_end(unsigned long *flags)

Ditto, why pointer and not value?

> {
> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>
> 	vdso_write_end(vdata);
> 	__arch_sync_vdso_data(vdata);
> 	raw_spin_unlock_irqrestore(&timekeeper_lock, *flags);
> }
>
> ? Just wondering.

Thought about that briefly, but then hated the flags thing and delegated
it to the caller. Lockdep will yell if that lock is taken with
interrupts enabled :)

But aside of the pointer vs. value thing, I'm fine with doing it in the
functions.

Thanks,

        tglx
