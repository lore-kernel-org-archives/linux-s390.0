Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD553DA7DF;
	Mon, 17 Aug 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969731; cv=none; b=DLtJ1hnzScXA/u0zXq25MYF7tIaSA86CltAZJ6cxj+ZEGAjCugdRr023LTILilG3HcgY/T9Vns2lGxi7EGA+0QNNPR8T0L61cFRTEjuue93k3QhqRYQBOZjXQr/us+nS20+jCYk0IH/jvDm76rFE7x7pXX60URx0d/MC+dk7Q7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969731; c=relaxed/simple;
	bh=Gyofv3sSO7lYqnHwkCFyoZgbVgblfnpQlRUFfS2Q5bQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkbBgl0drMgHoh4OZWmAQKX7YRx83LjV4QwabFbpS8aEKLrYBAXdCkOzDIP6VprjApyC+dYgvRDUbtdsVof8e41DQYFvBKbXZxcY3+dYLaNFBJazcYEwL6tveRCIKPM9D5EZ1IUiLITEkDyFMzmFvCbbth2mNzJnzbRPJD4wGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh1uzKKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh1uzKKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8061F00A3A;
	Mon, 17 Aug 2026 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786969730;
	bh=3YD7sKPJXuQc3fWJwZrTJUwueIKAqqSiZgtgDHA80SI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gh1uzKKyeV0EHOzHR81E4Pim/hvsThT1AiHMBWpBRPVBXv93l1NRUo+0i7bheCwYp
	 GOq/FNnhoRR1Bx7l3xLBq4GFsAfRkxtpzOOJcmwkQMk6eVGzpmfWbIofvRqesPnZk/
	 7XoP18bYTFntBmCRwVTSEkOqfBDIC3FX+/wTMD6kti6YrEkxQiu+Uu/8bkw0kCdJ9f
	 pA4vLLG9HNHqmutrSQ9vrE5GedTa891QTJkKOF4008bzl5Nu0Av0yX/ae2LFc9Wzxe
	 A6K4eBbGcpeFxXI5m4ZhK5M8SeOrcc2IUrBZfNflVMwpPsnB26jfNhFEHFpOepKxIC
	 OhimMIStHO6vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260817121631.159451-1-frankja@linux.ibm.com>
References: <20260817121631.159451-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 12:28:49 +0000
Message-Id: <20260817122849.9F8061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Use-After-Free of `inti` when injecting floating interrupts.
- [High] Missed vCPU kick causes lost or delayed floating interrupts when a=
ll vCPUs have masks closed.
--

--- Patch [1]: [PATCH v2] KVM: s390: Improve floating IRQ injection behavio=
r ---
commit e7cb031c2f46e8290e932cd848faad5eec943d11
Author: Janosch Frank <frankja@linux.ibm.com>
Subject: KVM: s390: Improve floating IRQ injection behavior

Floating IRQs can be handled by any VCPU that opened its masks. The
current design does not check if the mask is open when a floating IRQ
is injected via the FLIC. It will wakeup the last VCPU that went
sleeping hoping it's the correct one.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8f24bcd1a6d36..e67cdedb5aece 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -1915,22 +1946,48 @@ static int __inject_io(struct kvm *kvm, struct kv=
m_s390_interrupt_info *inti)

[ ... ]

>  /*
>   * Find a destination VCPU for a floating irq and kick it.
>   */
> -static void __floating_irq_kick(struct kvm *kvm, u64 type)
> +static void __floating_irq_kick(struct kvm *kvm, struct kvm_s390_interru=
pt_info *inti)
>  {
>  	struct kvm_vcpu *dst_vcpu;
>  	int sigcpu, online_vcpus, nr_tries =3D 0;
> +	u64 type =3D READ_ONCE(inti->type);
> +	u64 irq_pend_mask;
> =20
>  	online_vcpus =3D atomic_read(&kvm->online_vcpus);
>  	if (!online_vcpus)
>  		return;
> =20
> +	irq_pend_mask =3D inti_to_irq_pend_mask(inti);
>  	for (sigcpu =3D kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>  		sigcpu %=3D online_vcpus;
>  		dst_vcpu =3D kvm_get_vcpu(kvm, sigcpu);
> -		if (!is_vcpu_stopped(dst_vcpu))
> +		if (!is_vcpu_stopped(dst_vcpu) &&
> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>  			break;
>  		/* avoid endless loops if all vcpus are stopped */
>  		if (nr_tries++ >=3D online_vcpus)
>  			return;

[Severity: High]
Does this code drop the interrupt kick entirely if all vCPUs currently
have their interrupt masks closed?

If deliverable_irqs(dst_vcpu) & irq_pend_mask evaluates to 0 for all running
vCPUs, this loop will exit via the nr_tries check and return early.

Because it returns early, kvm_s390_set_cpuflags() and kvm_s390_vcpu_wakeup()
are never executed, meaning no vCPU drops out of SIE and
set_intercept_indicators() is not called.=20

If the guest later unmasks the interrupt, could it remain undelivered since
the hardware intercept was never set up?

[ ... ]

> @@ -1982,7 +2039,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_=
s390_interrupt_info *inti)
>  	if (rc)
>  		return rc;
> =20
> -	__floating_irq_kick(kvm, type);
> +	__floating_irq_kick(kvm, inti);

[Severity: Critical]
Does this cause a use-after-free when injecting GISA I/O adapter interrupts?

When __inject_io() handles a GISA I/O interrupt, it frees the interrupt inf=
o:

arch/s390/kvm/interrupt.c:__inject_io() {
    ...
    if (gi->origin && inti->type & KVM_S390_INT_IO_AI_MASK) {
        ...
        kfree(inti);
        return 0;
    }
    ...
}

Since it returns 0, __inject_vm() will proceed to call __floating_irq_kick()
with the newly freed inti pointer, which then dereferences it when calling
inti_to_irq_pend_mask(inti).

Also, for non-GISA interrupts, inti is placed on a shared list where another
vCPU might deliver and free it before __floating_irq_kick() runs.=20

Should we avoid passing inti to the kick function?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817121631.1594=
51-1-frankja@linux.ibm.com?part=3D1
