Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50F8440627;
	Wed, 19 Aug 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787167172; cv=none; b=bwDCIwVSQWJnLnnkQxttIm8TCObvNBwU2MErZoJfY6u5ERyd14gDp2qllv2AA88vae+sl+URb+V5Vr2IYgTIp8HRrO3omfeP7dDqfOtso5ndWPieCRh/mpkN2kQDdWHtylr4hin1XK77H2X7Tx6MsqqoLKyy5wsDIG/xbu5OhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787167172; c=relaxed/simple;
	bh=Rjs9CI3raqkOJy3xif1kNygJqcpZjwBZXmRd0EMZ9Xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QxbgYcU4wiBv+c03wI/fPdpqiDKy9Od/uz41guz/HEgQPeXFTFThJvEocNufNsbfD/CLm/lvEHwDSsckHjmVb9+ID5mfj0KkAt+DfMFSBE9CZ1/Mivgh40nRuQGGY9dvkpY8GD99Dvva3QwR85TasVTBJTbWYZBOEDuHlEf55oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKbsu2Rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKbsu2Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2BA1F000E9;
	Wed, 19 Aug 2026 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787167170;
	bh=KSb5d8UM4n7K+FzxGUKoTN33UqORrvstH7YcpY5Ea0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKbsu2RpoduczHdme0NAdYcOZ1IyX8ci0iYoEvwagMoVlyeweFExQWXYmEyE0ogfV
	 skCYhOoXJrCptwglUvQeAf9vCQH9KRxMPjh4x5wfzazvQ4gfTG339NAJQMCLxrMADC
	 L5eMiiqHGl5NlViQ7o5EH+50ELGdBR/gDkzh7kxY2JbIEWb8QLkLvMrN12GtmSq9QS
	 0L1niAR8HaVZFQWwbLkAxe2AoEtg8BV9Wi6QtfU2syuPSTvfOb0N8+Qrfg/mLOGnPL
	 MmZDBUOo71GvgymMPHthB1iL5xS6lIiQm+E5pYB+75Hut7MU4/e7j/ehiaKYtAHxq4
	 dC01KavLuOpEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] KVM: s390: Kick PV cpus at the right time for
 service irqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819190408.247843-3-frankja@linux.ibm.com>
References: <20260819190408.247843-1-frankja@linux.ibm.com>
 <20260819190408.247843-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:19:29 +0000
Message-Id: <20260819191930.1A2BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Unconditional acquisition of a sleeping lock (`mutex_lock(&kvm=
->lock)`) in the floating interrupt injection hot-path causes a system BUG =
when called from atomic context.
- [Critical] Acquiring `kvm->lock` inside `__floating_irq_kick()` violates =
the KVM locking hierarchy, creating ABBA deadlocks with `vcpu->mutex` and `=
kvm->srcu`.
- [High] In `kvm_s390_pv_sclp_kick()`, `IRQ_PEND_EXT_SERVICE` is incorrectl=
y used as a bitmask instead of a bit index, causing the kick condition to e=
valuate incorrectly.
- [High] `inti_to_irq_pend_mask()` returns an unshifted bit index instead o=
f a bitmask for I/O interrupts and double-converts the ISC value, breaking =
IO floating IRQ routing.
- [Medium] The local variable `parm` is passed by value uninitialized to `_=
_floating_irq_kick()` for several interrupt types, triggering Undefined Beh=
avior and KMSAN warnings.
--

--- Patch [2]: [PATCH v3 2/3] KVM: s390: Kick PV cpus at the right time for=
 service irqs ---
commit a45baf236c563050e29f20187e5498732692fe4c
Author: Janosch Frank <frankja@linux.ibm.com>

KVM: s390: Kick PV cpus at the right time for service irqs

Service call handling is a two stage process for PV vms. First we
receive the secure instruction intercept and then the secure
instruction notification intercept.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 3af060ec5be8e..53ba74a749e8a 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -1998,10 +1995,49 @@ static void __floating_irq_kick(struct kvm *kvm, =
u64 type, int isc)
>  	vcpu_intervention_kick(dst_vcpu, type);
>  }
> =20
> +void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * The cpu that called sclp likely will also take the IRQ, no
> +	 * need to kick anyone.
> +	 */
> +	if (likely(deliverable_irqs(vcpu) & IRQ_PEND_EXT_SERVICE))
> +		return;

[Severity: High]
Is IRQ_PEND_EXT_SERVICE missing a BIT() macro here?

The deliverable_irqs() function returns a bitmask, but IRQ_PEND_EXT_SERVICE
is an enum value (15). Doesn't this evaluate the bitwise AND against 15
(0b1111) rather than checking bit 15? This could result in false negatives
and lost wakeups for target vCPUs waiting for service interrupts.

> +
> +	/*
> +	 * For the other cases we might have sleeping cpus with open
> +	 * masks. Time to find and kick them.
> +	 */
> +	kick_cpu_irq(vcpu->kvm, KVM_S390_INT_SERVICE, -1);
> +}
> +
> +/*
> + * Find a destination VCPU for a floating irq and kick it.
> + */
> +static void __floating_irq_kick(struct kvm *kvm, u64 type, u64 parm)
> +{
> +	int prot;
> +
> +	mutex_lock(&kvm->lock);
> +	prot =3D kvm_s390_pv_is_protected(kvm);
> +	mutex_unlock(&kvm->lock);

[Severity: Critical]
Can acquiring this sleeping lock cause a 'scheduling while atomic' bug?

When called via the interrupt injection path, this can execute in an atomic
context:

kvm_arch_set_irq_inatomic()
   spin_lock(&fi->ais_lock);
   kvm_s390_inject_vm()
      __inject_vm()
         __floating_irq_kick()
            mutex_lock(&kvm->lock);

[Severity: Critical]
Does taking kvm->lock here also create an ABBA deadlock?

During standard I/O interrupt reinjection:

vcpu_run()
   handle_tpi()
      kvm_s390_reinject_io_int()
         __inject_vm()
            __floating_irq_kick()

In this path, vcpu->mutex is already held by KVM_RUN, and the vCPU is inside
an SRCU read-side critical section. Acquiring kvm->lock while holding these
violates the KVM locking hierarchy.

> +	/*
> +	 * No need to kick on non-ev service IRQs for PV VMs, we're
> +	 * not allowed to inject anyway. We need to wait for the sclp
> +	 * instruction notification AFTER re-entry of the vcpu that
> +	 * handled the instruction intercept.
> +	 */
> +	if (prot && type =3D=3D KVM_S390_INT_SERVICE &&
> +	    !(parm & SCCB_EVENT_PENDING))
> +		return;
> +
> +	kick_cpu_irq(kvm, type, parm);
> +}
> +
>  static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *=
inti)
>  {
>  	u64 type =3D READ_ONCE(inti->type);
> -	int isc =3D -1;
> +	u64 parm;
>  	int rc;
> =20
>  	switch (type) {

[ ... ]

>  	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
>  		/* Grab isc here since __inject_io() might free inti */
> -		isc =3D isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));
> +		parm =3D isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));

[Severity: High]
Does this result in a double-conversion of the ISC value?

Down in inti_to_irq_pend_mask(), the switch case for I/O interrupts does:

    case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
        return isc_to_irq_type(isc);

Since parm is already converted here and passed into inti_to_irq_pend_mask()
as the isc parameter, it looks like it gets processed through
isc_to_irq_type() a second time. It also appears to lack a BIT() macro
wrapper, returning a raw integer (0-7) instead of a bitmask.

>  		rc =3D __inject_io(kvm, inti);
>  		break;
>  	default:
> @@ -2028,7 +2065,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_=
s390_interrupt_info *inti)
>  	if (rc)
>  		return rc;
> =20
> -	__floating_irq_kick(kvm, type, isc);
> +	__floating_irq_kick(kvm, type, parm);

[Severity: Medium]
Does parm get passed uninitialized here for certain interrupt types?

For cases like KVM_S390_MCHK, KVM_S390_INT_VIRTIO, and
KVM_S390_INT_PFAULT_DONE, parm is never assigned a value in the switch
statement above. Passing it by value to __floating_irq_kick() causes an
uninitialized read that triggers KMSAN warnings.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819190408.2478=
43-1-frankja@linux.ibm.com?part=3D2
