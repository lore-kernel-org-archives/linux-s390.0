Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AC3F825F;
	Wed, 12 Aug 2026 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525945; cv=none; b=Pvxyw1/tESke90wkTnHbIWyj8xFes1UaI43YTz1GxoTq405fqY/HEXK0Zh2yOhOLREfJw0/5/+nShx0g8s0tfiyfoojxw4DGhIYoCIZVHsUqyhKtdsWeo3prPi83Zi78qownvxD9fVzxkC9GD7klUCkdsqauaYwXVY+O0MrdV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525945; c=relaxed/simple;
	bh=gAE/wdGycgqb3yC6uPNYg9+Ty7V14V/cwIZue3f3epg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6wTleKD+UmlDv/okpc6QZfHYMLyY/3XdsmdcTzkSemUnBc2cGnhgtyjcg7vKXMobvjnhGITjzvgp3MS6vpiLim/Db7O1tBzjV3UjEkMPZVAc4i2LxgbGytZAH4ITP5cksB+53wCFVc0pgsBKFDEyJT5o+UO/nYMIHjnJE9+oAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ayaH9N9B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ayaH9N9B"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62tDU809081;
	Wed, 12 Aug 2026 09:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZhH8nw
	Pti03YGDOCY5+SVZXoNFYBa0fblAMxu8gVeGc=; b=ayaH9N9B5gkkYMhSfT3L3M
	rPtGI/DAE649AjFxT0qPj+iWyof5+pb1AGA4muf6xKx4j7uHWDVTdn7SULk3E1C3
	unVFrhMkni6N7Iy2rpM5u9IYfD9W6odNCCvRRPhUCDeOjejyCPJ2PpNd2vkYu+1q
	gL1MYSXr13WYwpS6J51WJ51fcOB+xNpsG72wtm66oXJ3XfTrXcQMh0YsDRUdxy5J
	4Yqr+R9de/QzhKlRApWaBSY9OIhgwpfOvrjVPmXyT57An7KRJp58NgRXWDzbKUI2
	M6sOgGEbFW2IhoGblTvrfYzSdaEGOC4XAlobU5U2HP2KFhdLF7TNfJyrTrAfOyaw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk01nqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:12:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C9BWKg026779;
	Wed, 12 Aug 2026 09:12:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy54dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:12:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C9CFAt17301940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 09:12:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DE4120043;
	Wed, 12 Aug 2026 09:12:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FAEA20040;
	Wed, 12 Aug 2026 09:12:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 09:12:15 +0000 (GMT)
Date: Wed, 12 Aug 2026 11:12:13 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v1 03/11] KVM: s390: Fix get_all_floating_irqs()
Message-ID: <20260812111213.7e8aa048@p-imbrenda>
In-Reply-To: <6cc80fa3-f506-4fff-970a-2cbd66d9ce49@de.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
	<20260811155641.219777-4-imbrenda@linux.ibm.com>
	<6cc80fa3-f506-4fff-970a-2cbd66d9ce49@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MiBTYWx0ZWRfX3FguEIzd9xBy
 wbCNWdvLwwHKHAf/hfcXzkbamvIA60uh/wUYtY1Di5Kklit1mrRr1KVF625FpvcAJ5lOqgHwwq+
 rV33BLFy3sELKRBOGBhM6YtP0RYrxx25QrnXbsXjpdwpkHgBIxjhOi0WdRMwMgIdYvjHjdnZcJ2
 BSV3b9NFDBow7bmkN0LLwkedn2zQMA+HrM/opxga7Xeo4DOAXEPO88TQwYhQgqho2tqtlXHYcSg
 zwwDhjCpn9bSzIq26WgQKhR2EEyzgaVLpzCS7+ojGtTeBXynPSk5Uuo1ibNeOZYZogauX6nN0TD
 lNaWgjvYaOKxipoLHEblCBzQ+PbEX62agKE0EFnT10N7MvX8Ex8tWcFflKLSSVUQeQJXCIexzeg
 4AsjvZbKJVctP42D2RBTT0CXeJ91Jt21ElIQjhbRX1+wTBaRqS/d+QNKeFby7cXwmmjg/lL8DeC
 IYDwETU27PHFgWVbOGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MiBTYWx0ZWRfXx0J2oM2Uik1V
 gQ2fmGynDM+S/7y6dHPDTfnyPIGXw3ZjDnJF4hE54zRED0AEiUmpK9WAMjCrAetqNCPLbHJt8EI
 +5BVG7j2Z9n+OR05GRI0TYtuXJxRi2U=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c38f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=gEnNJA3cCCmfQvNCwZEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Pqbv2DFx8kOhJO672FtU4JUkrv14nDMm
X-Proofpoint-ORIG-GUID: Pqbv2DFx8kOhJO672FtU4JUkrv14nDMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120072

On Wed, 12 Aug 2026 09:11:11 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> > When attempting to report all pending floating interrupt to userspace,
> > the GISA IPM bits are atomically tested and cleared, and the
> > corresponding interrupt description is written in the output buffer. If
> > the output buffer is too small, an error is returned to userspace, but
> > the GISA IPM bits are now lost.
> > 
> > Fix by moving the GISA test at the end of the function, and keeping
> > track of which bits have been cleared. In case of error, set the bits
> > again, so they are not lost.
> > 
> > Fixes: 24160af6cb28 ("KVM: s390: add GISA interrupts to FLIC ioctl interface")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>  
> 
> this looks too complicated for a fix. Now what is the semantic of this?
> This is used for migration purposes, and the doc says:

that's exactly what I did after I read the documentation more carefully

> 
> Documentation/virt/kvm/devices/s390_flic.rst
> 
>    KVM_DEV_FLIC_GET_ALL_IRQS
>      Copies all floating interrupts into a buffer provided by userspace.
> [...]
>      All interrupts remain pending, i.e. are not deleted from the list of
>      currently pending interrupts.
> [...]
> 
> So even the success case is wrong. Why not simply add a new helper that
> reads the GISA without clearing the bits?
> 
> static inline int gisa_test_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> {
>        return test_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> }
> 
> 
> 
> 
> > ---
> >   arch/s390/kvm/interrupt.c | 93 ++++++++++++++++++---------------------
> >   1 file changed, 44 insertions(+), 49 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> > index 6b3f97a7513b..30963e05e0e6 100644
> > --- a/arch/s390/kvm/interrupt.c
> > +++ b/arch/s390/kvm/interrupt.c
> > @@ -2211,15 +2211,14 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
> >   static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
> >   {
> >   	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> > +	struct kvm_s390_irq *buf __free(kvfree) = NULL;
> >   	struct kvm_s390_interrupt_info *inti;
> >   	struct kvm_s390_float_interrupt *fi;
> > -	struct kvm_s390_irq *buf;
> >   	struct kvm_s390_irq *irq;
> > +	unsigned int tmp = 0;
> >   	int max_irqs;
> > -	int ret = 0;
> >   	int n = 0;
> >   	int i;
> > -	unsigned long flags;
> >   
> >   	if (len > KVM_S390_FLIC_MAX_BUFFER || len == 0)
> >   		return -EINVAL;
> > @@ -2235,14 +2234,48 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
> >   
> >   	max_irqs = len / sizeof(struct kvm_s390_irq);
> >   
> > +	fi = &kvm->arch.float_int;
> > +	scoped_guard(spinlock_irqsave, &fi->lock) {
> > +		for (i = 0; i < FIRQ_LIST_COUNT; i++) {
> > +			list_for_each_entry(inti, &fi->lists[i], list) {
> > +				/* signal userspace to try again */
> > +				if (n == max_irqs)
> > +					return -ENOMEM;
> > +				inti_to_irq(inti, &buf[n]);
> > +				n++;
> > +			}
> > +		}
> > +		if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs) ||
> > +		    test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs)) {
> > +			/* signal userspace to try again */
> > +			if (n == max_irqs)
> > +				return -ENOMEM;
> > +			irq = (struct kvm_s390_irq *)&buf[n];
> > +			irq->type = KVM_S390_INT_SERVICE;
> > +			irq->u.ext = fi->srv_signal;
> > +			n++;
> > +		}
> > +		if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
> > +			/* signal userspace to try again */
> > +			if (n == max_irqs)
> > +				return -ENOMEM;
> > +			irq = (struct kvm_s390_irq *)&buf[n];
> > +			irq->type = KVM_S390_MCHK;
> > +			irq->u.mchk = fi->mchk;
> > +			n++;
> > +		}
> > +	}
> >   	if (gi->origin && gisa_get_ipm(gi->origin)) {
> >   		for (i = 0; i <= MAX_ISC; i++) {
> >   			if (n == max_irqs) {
> > +				/* restore removed bits if returning failure */
> > +				__atomic_or(tmp, (void *)&gi->origin->ipm);
> >   				/* signal userspace to try again */
> > -				ret = -ENOMEM;
> > -				goto out_nolock;
> > +				return -ENOMEM;
> >   			}
> >   			if (gisa_tac_ipm_gisc(gi->origin, i)) {
> > +				/* set aside the bits we cleared */
> > +				tmp |= 1 << (31 - i);
> >   				irq = (struct kvm_s390_irq *) &buf[n];
> >   				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
> >   				irq->u.io.io_int_word = isc_to_int_word(i);
> > @@ -2250,53 +2283,15 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
> >   			}
> >   		}
> >   	}
> > -	fi = &kvm->arch.float_int;
> > -	spin_lock_irqsave(&fi->lock, flags);
> > -	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
> > -		list_for_each_entry(inti, &fi->lists[i], list) {
> > -			if (n == max_irqs) {
> > -				/* signal userspace to try again */
> > -				ret = -ENOMEM;
> > -				goto out;
> > -			}
> > -			inti_to_irq(inti, &buf[n]);
> > -			n++;
> > -		}
> > -	}
> > -	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs) ||
> > -	    test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs)) {
> > -		if (n == max_irqs) {
> > -			/* signal userspace to try again */
> > -			ret = -ENOMEM;
> > -			goto out;
> > -		}
> > -		irq = (struct kvm_s390_irq *) &buf[n];
> > -		irq->type = KVM_S390_INT_SERVICE;
> > -		irq->u.ext = fi->srv_signal;
> > -		n++;
> > -	}
> > -	if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
> > -		if (n == max_irqs) {
> > -				/* signal userspace to try again */
> > -				ret = -ENOMEM;
> > -				goto out;
> > -		}
> > -		irq = (struct kvm_s390_irq *) &buf[n];
> > -		irq->type = KVM_S390_MCHK;
> > -		irq->u.mchk = fi->mchk;
> > -		n++;
> > -}
> >   
> > -out:
> > -	spin_unlock_irqrestore(&fi->lock, flags);
> > -out_nolock:
> > -	if (!ret && n > 0) {
> > -		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
> > -			ret = -EFAULT;
> > +	if (n > 0 && copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n)) {
> > +		/* restore removed bits if returning failure */
> > +		if (tmp)
> > +			__atomic_or(tmp, (void *)&gi->origin->ipm);
> > +		return -EFAULT;
> >   	}
> > -	vfree(buf);
> >   
> > -	return ret < 0 ? ret : n;
> > +	return n;
> >   }
> >   
> >   static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)  
> 

