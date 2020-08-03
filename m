Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728515AbgHCSoo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 14:44:44 -0400
Date: Mon, 3 Aug 2020 20:44:28 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
Message-ID: <20200803184428.GA3973@osiris>
References: <20200803055645.79042-1-svens@linux.ibm.com>
 <20200803055645.79042-3-svens@linux.ibm.com>
 <87ft93ncaa.fsf@nanos.tec.linutronix.de>
 <yt9dmu3b3jo3.fsf@linux.ibm.com>
 <87a6zbn29n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6zbn29n.fsf@nanos.tec.linutronix.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org

On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
> +/**
> + * vdso_update_begin - Start of a VDSO update section
> + *
> + * Allows architecture code to safely update the architecture specific VDSO
> + * data.
> + */
> +void vdso_update_begin(void)
> +{
> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
> +
> +	raw_spin_lock(&timekeeper_lock);
> +	vdso_write_begin(vdata);
> +}

I would assume that this only works if vdso_update_begin() is called
with irqs disabled, otherwise it could deadlock, no?

Maybe something like:

void vdso_update_begin(unsigned long *flags)
{
	struct vdso_data *vdata = __arch_get_k_vdso_data();

	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
	vdso_write_begin(vdata);
}

void vdso_update_end(unsigned long *flags)
{
	struct vdso_data *vdata = __arch_get_k_vdso_data();

	vdso_write_end(vdata);
	__arch_sync_vdso_data(vdata);
	raw_spin_unlock_irqrestore(&timekeeper_lock, *flags);
}

? Just wondering.
