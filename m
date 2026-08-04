Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAA486BA9;
	Tue,  4 Aug 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863169; cv=none; b=qhYy44tnshkl9UkbUnTgMtuUNtEwA1e5YuWnfKJItG+3fRoSGeufvXkmN4CRquNcGPxiNO68n2WUcWRAb6eY+4kjJA3Rz9gvgKaxB8yR7YRaTIrL3hla+B2nLRdKfMluyBJrR+jR/TqwS58B5u18x1Mrff5lENmFghNfQxYG3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863169; c=relaxed/simple;
	bh=wb/wAEYkrs2QgKCPTAVppRiRw4gvpRo/MiLYGkC/shQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LsjRtzq+xhaDMGtkuYIvk1++9krfRvHcaGdZt0+ULgBT/bMVrcNQeGmy34FzcL35QPCBvBqvT1744oYx/ktl0+STIVxkH8HJaDnfprSfjQC89U/e3YbnDvvPxFdyfSPHntgAoQIGvGKzocUbdlaNNSZYgFCRxm7EPKiBog18rQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TErTUf1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TErTUf1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940BF1F000E9;
	Tue,  4 Aug 2026 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863155;
	bh=MxwdNewgDTYvIULAL8dVil1SaNYsl2PasaIECt8LcBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TErTUf1WdPPpKGp3RLvZUGMg0rsspy7Jh0TC46FgnrnaD9ffQb57+jI84OJpFaP2L
	 P0b9SETXgyEUrym5uftOJYDHY8HspZvHfPQ+j3lqk2hAMD7xYtDwLfSyEiG2tgfLrn
	 GNtpo8mroCJRKv4NTTSerq3GnxeGUWX7J6i08L2efDplcmBOxc9P0HtTIpYCqkREsl
	 x8RA786l9VIUgATgjyAFH+zRNRWn3FLbBJAhfsNHvZwRFWe6WQEJifHPpWpxW2xvl0
	 FaY0X2OxDtLqBBchWaSn8+dDvGNddMhTw+zOXdDSpEqDjDBmjYgTOufFYojVx0/Jxc
	 MaBZqIrL/6JsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] KVM: s390: Zero initialize data structures for
 inject_pfault_token
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260804162435.28617-3-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:05:55 +0000
Message-Id: <20260804170555.940BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling kfree() on a stack-allocated variable when reinjecting=
 floating machine checks leads to a guest-triggerable kernel panic.
- [High] Uninitialized stack memory in `struct kvm_s390_irq` is leaked to t=
he guest and userspace during machine check reinjection.
--

--- Patch [2]: [PATCH v2 2/7] KVM: s390: Zero initialize data structures fo=
r inject_pfault_token ---
commit 2b81aa54a540c9ab3f152dc0b18d8b86e716252d
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Zero initialize data structures for inject_pfault_token

This commit fixes an issue where __kvm_inject_pfault_token() leaves fields
in the on-stack struct kvm_s390_irq uninitialized. These stale stack values
are copied into the cpu local variable, allowing a host user to access them
via migration ioctls. The fix zero-initializes the irq and inti structures.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85c..611dcb5342101 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4474,8 +4474,8 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, con=
st struct kvm_s390_vm_tod_clo
>  static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_=
token,
>  				     unsigned long token)
>  {
> -	struct kvm_s390_interrupt inti;
> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_interrupt inti =3D {};
> +	struct kvm_s390_irq irq =3D {};

[Severity: Critical]
This is a pre-existing issue, but while looking at these stack variables,
I noticed a similar pattern in arch/s390/kvm/interrupt.c that might lead to=
 a
kernel panic.

In kvm_s390_reinject_machine_check(), the interrupt structure is allocated =
on
the kernel stack:

arch/s390/kvm/interrupt.c:kvm_s390_reinject_machine_check() {
    ...
    struct kvm_s390_interrupt_info inti;
    ...
}

If a malicious L1 guest crafts a nested vSIE control block with mcic set to
include the mci.ck bit, __inject_vm() delegates to __inject_float_mchk(),
which then unconditionally frees the stack pointer:

arch/s390/kvm/interrupt.c:__inject_float_mchk() {
    ...
    kfree(inti);
    ...
}

Could this allow an untrusted, unprivileged guest to trigger an immediate
kernel panic by corrupting the SLUB allocator?

[Severity: High]
This is a pre-existing issue, but there appears to be another uninitialized
stack leak in arch/s390/kvm/interrupt.c.

Also in kvm_s390_reinject_machine_check(), the irq structure is allocated on
the kernel stack without zero-initialization:

arch/s390/kvm/interrupt.c:kvm_s390_reinject_machine_check() {
    ...
    struct kvm_s390_irq irq;
    ...
}

If triggered via vSIE without the mci.ck bit, the fixed_logout field remains
uninitialized. When __inject_mchk() is called, it blindly copies this memor=
y:

arch/s390/kvm/interrupt.c:__inject_mchk() {
    ...
    memcpy(&mchk->fixed_logout, &irq->u.mchk.fixed_logout,
           sizeof(mchk->fixed_logout));
    ...
}

This uninitialized host kernel stack data is then written directly to guest
memory via __write_machine_check(), or leaked via KVM_GET_IRQ_STATE:

arch/s390/kvm/interrupt.c:__write_machine_check() {
    ...
    rc |=3D write_guest_lc(vcpu, __LC_PSW_SAVE_AREA, &mchk->fixed_logout,
                         sizeof(mchk->fixed_logout));
    ...
}

Could this allow an untrusted guest to repeatedly dump 16 bytes of
uninitialized host kernel stack memory, potentially bypassing KASLR or leak=
ing
sensitive information?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D2
