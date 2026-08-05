Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7593E49E3;
	Wed,  5 Aug 2026 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929366; cv=none; b=lX6Avm4qc3XobwDmrqJEuYC/k0H5jUZVC2A9X0d+YiQLSOPBRXJOg8hSUvIYeVnkjOslqW7YIdI5IN36H1CV84qytv/DdvlPPLy2S4NrLwQfEDe2o0tDh7M9uDcr4db94OHU5H30FtgaSq8p6lQHpxe8rOxi46rjj1OSR1fTSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929366; c=relaxed/simple;
	bh=REt/SSR6JvYOfk+KVHBxnWN/iJUR4bHno4E71vzijCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTzKP9M2ixQjxl568+iy8QdULpBvDfHP54JPZ31F8OFIWTWzEmc3EEaW3OXHyIKwFCpG+R43Hudx9DeskCtkSCfgzdstk6CUwapmHijj8xNEXXNy+bQTqwkQuP7jiZi3gtC/PDRrEZvNMdvlrRPTIBR00ioOyAeiM6GMEEiPE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj6Rj8JG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj6Rj8JG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E51F00A3A;
	Wed,  5 Aug 2026 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929365;
	bh=5QBEbMs8T3djWX2Gu12cZRyOlgBm5PCaIgyclHDO53s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fj6Rj8JG+1nG9Jp3tjHMVXA3310mg5P2b+CRLEASfPfrWa4cUs+Zw7K4VVblD5uzr
	 GWQKkJv/1AMvzjG0J2fmVqgG8wTkUXJcapa75GehTmO7w7lKZpBM71lL/CPm4+aY0r
	 EdQsANxiU5f1WHIiIfAzD+I9wiVZS+wIAA+JXC5GSyWpJv8KcrCABA7SJMuYHInOFI
	 xlWerEUThUSmPy82IhABSOZyZUex6/U00C7sc5eqbfFGy2Bps9Jgkd2oa0Pn1+l4tu
	 ZALoVaHfIzAPq+/TCecAUQc8xspvDRQIJxaazgB27VbQho7Tjr0jd1JnkVh7Jsagik
	 tlrTni6Ha2YQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] KVM: s390: Zero initialize irq in
 reinject_machine_check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805110455.7200-4-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:29:24 +0000
Message-Id: <20260805112925.174E51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling kfree() on a stack-allocated variable `inti` when injectin=
g a floating machine check leads to a kernel panic.
--

--- Patch [3]: [PATCH v3 3/8] KVM: s390: Zero initialize irq in reinject_ma=
chine_check ---
commit 318473328452694fe22802ec70c8f2cf0f840578
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Zero initialize irq in reinject_machine_check

This commit zero-initializes the on-stack struct kvm_s390_irq in
kvm_s390_reinject_machine_check(). This prevents uninitialized memory from
being copied into the vcpu local interrupt state and reaching the guest or
userspace.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 23f0e0821474a..009d6a845d598 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3109,7 +3109,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcp=
u *vcpu,
>  				     struct mcck_volatile_info *mcck_info)
>  {
>  	struct kvm_s390_interrupt_info inti;

[Severity: High]
This is a pre-existing issue, but does this stack-allocated variable lead to
a kernel panic during floating machine check injection?

If mci.ck is set, this function passes the stack-allocated inti pointer to
__inject_vm():

	if (mci.ck) {
		/* Inject the floating machine check */
		inti.type =3D KVM_S390_MCHK;
		rc =3D __inject_vm(vcpu->kvm, &inti);
	}

__inject_vm() then calls __inject_float_mchk(), which unconditionally calls
kfree() on the provided pointer:

arch/s390/kvm/interrupt.c:__inject_float_mchk() {
    ...
    kfree(inti);
    ...
}

Will this cause a panic when kfree() attempts to free the local stack
pointer?

> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_irq irq =3D {};
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D3
