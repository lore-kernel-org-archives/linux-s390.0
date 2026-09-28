Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164A302163;
	Mon, 28 Sep 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599807; cv=none; b=IH5ToDqTbM/hHbEMolWWlj4zC+q5FLz1tXl6IFgd1tDspQr5UcZkHmYoOfluC75qus5oaGS90xmIWx6+5oDBZVKL7uKPut2JO3mvSNChOzJCmNXl2EFYRMPcZr0wc1jjmhXIuR1sk6oP9DHTgYOuhHgh1qgMdP3vaJT0wcO74gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599807; c=relaxed/simple;
	bh=EK0h5dzbLyppDZc3qKtcCuScNRc0X3t3i8glM0gvc9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tn7XVUOKvRRp+hkGRLbdeHXNY+aZTOO2MX9WuLzWxy8pZUBOFOQeeIcdMHtRnDVmVy6XaId3AtnR4fZ53+3FbpirsBT2u2c/ga25HzOa7y5qsC6wXcpxZQ1UFM1/L8MmGlKwvaxsRhlcjrVbPw9XNiTcvwprVHlq+zSIi1Y//DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anjIezer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anjIezer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F21F000FF;
	Mon, 28 Sep 2026 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599806;
	bh=HsNhJQVL8rPL77OUq6VVztYrwr20+G0z05AQGEa4EXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anjIezerCm6k0rjzS0vKYhS8WuS0W45JyK77ozEeUJXPXyok5cSJk4uQw99Rva/tR
	 qpAwcpP08feYDz+4hgj41tFGiwe9XRxwWidPcnNr5IfFXME/d6L/Ej+tYl2odjmOCx
	 0OJj3pISu/Id6ZRv9WTMvc72AegO0EDkVAE0lpY0TpMMWRSbiNP0aT8wQRhbESS/KA
	 Y7b85xVaYffScu/ro7lDZ+kfyhnQIGUu7+PJdXyQfu3dAThXpr8/PCv5LJkdXMJxh/
	 ysxbYBe/JodZvDrFJz6XXrAXVeNS+uGNQCtcqLd7rdxMVipOPbzeiiSrsG67jBJLKG
	 fiwo0pJy/wq4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] KVM: s390: Add opportunistic floating IRQ
 delivery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janosch Frank" <frankja@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260928123639.34226-4-frankja@linux.ibm.com>
References: <20260928123639.34226-1-frankja@linux.ibm.com>
 <20260928123639.34226-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:50:05 +0000
Message-Id: <20260928125005.DD2F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: s390: timer-less wait bypasses floating IRQ distribution
--

commit f14594a6a744fbc4a4f3602b18d73cbd397d4076
Author: Janosch Frank <frankja@linux.ibm.com>

KVM: s390: Add opportunistic floating IRQ delivery

This commit attempts to distribute floating IRQs which haven't been taken by
a vCPU yet to sleeping vCPUs. This lowers the risk of floating IRQs not bei=
ng
delivered.

> diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrup=
t.c
> index 3c0e6216eee3b..1b06775e581bf 100644
> --- a/arch/s390/kvm/s390/interrupt.c
> +++ b/arch/s390/kvm/s390/interrupt.c
[ ... ]
> @@ -1294,6 +1326,8 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
>  	if (!sltime)
>  		return 0;
> =20
> +	distribute_float_irqs(vcpu->kvm);
> +
>  	__set_cpu_idle(vcpu);
>  	hrtimer_start(&vcpu->arch.ckc_timer, sltime, HRTIMER_MODE_REL);
>  	VCPU_EVENT(vcpu, 4, "enabled wait: %llu ns", sltime);

[Severity: High]
Does this bypass distribute_float_irqs() when a guest enters an enabled wait
state with clock comparator and CPU timer interrupts disabled?

If a guest disables timer interrupts and enters a wait state, it appears
kvm_s390_handle_wait() jumps directly to the no_timer label:

arch/s390/kvm/s390/interrupt.c:kvm_s390_handle_wait() {
    ...
	if (!ckc_interrupts_enabled(vcpu) &&
	    !cpu_timer_interrupts_enabled(vcpu)) {
		VCPU_EVENT(vcpu, 3, "%s", "enabled wait w/o timer");
		__set_cpu_idle(vcpu);
		goto no_timer;
	}

	sltime =3D __calculate_sltime(vcpu);
	if (!sltime)
		return 0;

	distribute_float_irqs(vcpu->kvm);

	__set_cpu_idle(vcpu);
	hrtimer_start(&vcpu->arch.ckc_timer, sltime, HRTIMER_MODE_REL);
	VCPU_EVENT(vcpu, 4, "enabled wait: %llu ns", sltime);
no_timer:
    ...
}

Because the goto completely bypasses the newly added distribute_float_irqs()
call, any pending floating IRQs that this vCPU cannot deliver might remain
undelivered when the current vCPU goes to sleep. Could this lead to guest
stalls or deadlocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928123639.3422=
6-1-frankja@linux.ibm.com?part=3D3
