Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50B31E85E;
	Tue,  4 Aug 2026 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846718; cv=none; b=T+pvQMCdsCMlxRzEYr+PVPZdCfsjdo9Kx+TOM2eiBTzasKrc8F848U5j6SxxftNRJcnVQl13FJrFgZoiX3FLiJMPAlbkK7MK05QDgZpHATN8O/kk6AZ9yvOpWDId96xkZQm0dC3DKO2OJ2Ck6Y94P/iPIgvlbZB2kR6TRphU7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846718; c=relaxed/simple;
	bh=2eMCZj3wMRY2FtHiV9IYph6UHiqs2UPzP/kv7BEJTmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkXugiRCn57Nv715CMpoj7affG1NJcOQvgQu/Dnrdw9JHSj6j0vL9VG1w+Mc9SlpyGfByoy8ShR54SksEhV8FsLGbzsz30LB5Q9cS9EGR5Tmt6sQbU+4m8T+SoHkjOMXNsL9wg3OuNX/0qPAAqao4TCbNG3SMY3wTPt7fCUv54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX71/vsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX71/vsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E01F00A3A;
	Tue,  4 Aug 2026 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846716;
	bh=3Rdr1MiG9gdlT4/0z8dZX9Xgl1tJzo3jF2h2RIkg/o0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lX71/vsV6c57CzX/Ll5kGMtJimg09mwgyQJouZAvFraJon/DW+UHZyu47S58cIj5Z
	 oNYe5CePvZRMVuKd6Wka+ZqJGimTk0XZPy+hWreU3GmPVIBP8fr1urbrB6fJbkdV7L
	 TcN+otWYoiNbRk4NtUnU6N0xIYssE6XPtMSTqk6ie/+YhFg4/BuSpjIKBI8uIPR37a
	 YQjfbAc4IjCsgjNTL8BloHEReY6jYrJdSBja+wnlR1L52DiNen5FPs82yoSNLIsbIu
	 iUG9DXITRyG1jaPCMBOcB7/d8NfBwf26u1PNQ4zIhihtmEnGEQzqxnMjiq//oQys+1
	 w1jazjJUcbiOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: s390: zero initialize irq for
 inject_pfault_token
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260804120631.736919-3-borntraeger@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
 <20260804120631.736919-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:31:55 +0000
Message-Id: <20260804123156.601E01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling kfree() on a stack-allocated pointer during floating m=
achine check reinjection.
- [High] Uninitialized kernel stack memory in the `fixed_logout` array is l=
eaked to host userspace via the KVM_GET_IRQ_STATE ioctl.
--

--- Patch [2]: [PATCH 2/3] KVM: s390: zero initialize irq for inject_pfault=
_token ---
commit f6de66eb1335bc1e8dc54d73ed3ad8d7b39ac810
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: zero initialize irq for inject_pfault_token

This commit fixes a potential stack information leak to userspace via
migration ioctls. It zero-initializes the irq structure in
__kvm_inject_pfault_token() to ensure stale stack values are not copied.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85c..4f4ac6a8d1ad3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4475,7 +4475,7 @@ static void __kvm_inject_pfault_token(struct kvm_vc=
pu *vcpu, bool start_token,
>  				     unsigned long token)
>  {
>  	struct kvm_s390_interrupt inti;
> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_irq irq =3D {};

[Severity: High]
This isn't a bug introduced by this patch, but while looking at stack memor=
y=20
leaks, does a similar uninitialized stack leak happen in=20
kvm_s390_reinject_machine_check() in arch/s390/kvm/interrupt.c?

arch/s390/kvm/interrupt.c:kvm_s390_reinject_machine_check() {
    ...
    struct kvm_s390_irq irq;
    ...
}

If the machine check is injected into the vCPU (mci.ck is false), several
fields are populated, but the fixed_logout array might be left
uninitialized.=20

When passed to kvm_s390_inject_vcpu() -> __inject_mchk(), the uninitialized
fixed_logout array is copied into the vCPU's pending interrupt state:

arch/s390/kvm/interrupt.c:__inject_mchk() {
    ...
    memcpy(&mchk->fixed_logout, &irq->u.mchk.fixed_logout,
           sizeof(mchk->fixed_logout));
    ...
}

Later, if a host user calls the KVM_S390_GET_IRQ_STATE ioctl, this state
could be copied to userspace:

arch/s390/kvm/interrupt.c:kvm_s390_get_irq_state() {
    ...
    if (copy_to_user(&buf[n], &irq, sizeof(irq)))
    ...
}

Could this leak kernel stack memory in the fixed_logout array to userspace?


[Severity: Critical]
This is another pre-existing issue, but while looking at=20
kvm_s390_reinject_machine_check(), can a stack pointer be incorrectly freed?

It allocates struct kvm_s390_interrupt_info inti on the kernel stack:

arch/s390/kvm/interrupt.c:kvm_s390_reinject_machine_check() {
    ...
    struct kvm_s390_interrupt_info inti;
    ...
}

If mci.ck is true, it attempts to inject a floating machine check by passing
the stack-allocated struct by reference:

arch/s390/kvm/interrupt.c:kvm_s390_reinject_machine_check() {
    ...
    rc =3D __inject_vm(vcpu->kvm, &inti);
    ...
}

The injection routes KVM_S390_MCHK to __inject_float_mchk(), which
unconditionally calls kfree() on the passed pointer:

arch/s390/kvm/interrupt.c:__inject_float_mchk() {
    ...
    kfree(inti);
    ...
}

Would calling kfree() on this stack pointer cause a kernel panic?

>  	struct kvm_s390_interrupt_info *inti_mem =3D NULL;
>  	int ret =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120631.7369=
19-1-borntraeger@linux.ibm.com?part=3D2
