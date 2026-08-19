Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5344078FA;
	Wed, 19 Aug 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166800; cv=none; b=otVLaQPDv5j36AhxRAg8BuY8kkFHTWVkco5tszDg5Obz2KjnqqpChvBDiSlkIid0ZFlmQR/+dmGKICa9SRF0Mql76+E+LmscJNC3aPQSMxlTKpV8mP2Uclrv6H7bJYPvLbwM0VES2cJCDjs/qpumxeKIkpZaUMy94T5xthQ6brA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166800; c=relaxed/simple;
	bh=OdBSEYUC+FUZI8qb5QevWK6WTRr/A3pjpm3l3kYHGkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dogi7BTuRt0fqBpzrFHYunTlz3opdu/XTTSbpK3qpdpiRrX0kSXK3cmDOF45LZsV3rP5IcsyZpxxXZiqRv1A+mH+q+Mo5YSVQqctRqlXBwqRkwmyiSOYSpXbxsdhXH51n3g+Uaie4qlf5P25ZWy1vXTBOfebRrlGsYF7CIP51xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMxdYb1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMxdYb1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7961F00A3A;
	Wed, 19 Aug 2026 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166797;
	bh=Axvqw+Mf4s8FyfXDo2D8ogBG8oLV9kQvsBtV7dLkq7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMxdYb1ZWb+3DbcYIfCTIrt4kY5qt7ez1nSBOFWzAkP8LTmuST2oWtuXHLy6odHEe
	 ol6W4TW0yKcD0jz8zwpOB9JE3uftyeW8VLnCJ+6swSxSFaa1JC6U7b3q6rWQyJ3RRa
	 qXuRLBEIpfv5sStnoVnXLu4LD4uHrlR9cjkg63ev4T/6blAgafrqB7pK8QhU/I0PTW
	 uNBsGVGg7Quyyn6IrWm/loB3S1dt6rZN5qq2UHleTRgayVPSlmnVhC5B4jI1emo3zP
	 StP+/yEG/oJvpWuQZQ1RsVC/mWJVDC7WruYUcAi4dYRwOuoFO4bANwyi6sPMyMXZE1
	 tOuI1uQvEt0pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] KVM: s390: Improve floating IRQ injection
 behavior
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819190408.247843-2-frankja@linux.ibm.com>
References: <20260819190408.247843-1-frankja@linux.ibm.com>
 <20260819190408.247843-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:13:16 +0000
Message-Id: <20260819191317.2C7961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect bitmask computation for floating I/O interrupts causes t=
hundering herd performance regressions or lost wakeups.
--

--- Patch [1]: [PATCH v3 1/3] KVM: s390: Improve floating IRQ injection beh=
avior ---
commit 8a0b82ce7a926dc2db73a2448ac2bcc105213707
Author: Janosch Frank <frankja@linux.ibm.com>

KVM: s390: Improve floating IRQ injection behavior

This commit improves floating IRQ injection by checking if a VCPU has pendi=
ng
IRQs instead of blindly waking up the last VCPU that went to sleep. This ai=
ms
to prevent deadlocks when a VCPU is sleeping without an open mask.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8f24bcd1a6d36..3af060ec5be8e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -1915,49 +1915,93 @@ static int __inject_io(struct kvm *kvm, struct kv=
m_s390_interrupt_info *inti)
>  	return 0;
>  }
> =20
> +static u64 inti_to_irq_pend_mask(u64 type, int isc)
> +{
> +	switch (type) {
> +	case KVM_S390_MCHK:
> +		/* Only repressible machine checks are floating */
> +		return BIT(IRQ_PEND_MCHK_REP);
> +	case KVM_S390_INT_VIRTIO:
> +		return BIT(IRQ_PEND_VIRTIO);
> +	case KVM_S390_INT_SERVICE:
> +		return BIT(IRQ_PEND_EXT_SERVICE) |
> +		       BIT(IRQ_PEND_EXT_SERVICE_EV);
> +	case KVM_S390_INT_PFAULT_DONE:
> +		return BIT(IRQ_PEND_PFAULT_DONE);
> +	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> +		return isc_to_irq_type(isc);

[Severity: High]
Does this correctly return a bitmask? The other cases return BIT() masks, b=
ut
this returns a raw integer resulting from isc_to_irq_type().

Could this cause `deliverable_irqs(dst_vcpu) & irq_pend_mask` to check the
wrong bits or evaluate to 0 later in __floating_irq_kick(), leading to skip=
ped
eligible VCPUs and a thundering herd where all VCPUs are woken up?

[ ... ]
> @@ -1974,6 +2018,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_=
s390_interrupt_info *inti)
>  		rc =3D __inject_pfault_done(kvm, inti);
>  		break;
>  	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> +		/* Grab isc here since __inject_io() might free inti */
> +		isc =3D isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));

[Severity: High]
Are we applying isc_to_irq_type() twice for I/O interrupts?

This converts the ISC to an IRQ bit index before assigning it to `isc`. Lat=
er,
__floating_irq_kick() passes it to inti_to_irq_pend_mask(), which calls
isc_to_irq_type() a second time on the same value.

Since isc_to_irq_type() is implemented as `IRQ_PEND_IO_ISC_0 - isc`, callin=
g it
twice will reverse the calculation and yield the original ISC value instead
of the expected IRQ bit index.

>  		rc =3D __inject_io(kvm, inti);
>  		break;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819190408.2478=
43-1-frankja@linux.ibm.com?part=3D1
