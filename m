Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B14471415;
	Tue,  4 Aug 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864064; cv=none; b=MNqoMJE0dsC0soBoVSt4n5ClyR8hYQiPksCt2srZlZwxoqNskEfkfojhmYii5d8Wtzal4aA5OidvLhqnR8fPRCcxBATQ1e02a2dcft55u55eF4VlfdV0dMolP50XkiJLFnm+Boya9SmsCbqCykX1HLO0v963kr+2dhREtviyRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864064; c=relaxed/simple;
	bh=3b3yDqBZQcNiEb2AXDbGrNNHOAZ/E03QCQZBgH4zW1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOGPohf9sh7W7mpX+zCWvN28P8e+XQhDHOl7hHZsXP2+WxIdKoJdJyIvXB8aD72ZeVstq0FKaeWhKhoER6tibOCHRMHblqmdF5A4pkf4lj48oxjC38Ej0poYmbit+h22jiOHHPMesQDeMxGZSbyoYMis2cym93ayq0cwE4dJbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHN0Ml0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHN0Ml0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7626C1F000E9;
	Tue,  4 Aug 2026 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785864052;
	bh=1Z99V4heVn1LEU7F88hh7Nnoh3G4uH3no1vU/vJzqAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nHN0Ml0/aXN81VVNOfQWLEMs/HDlmAxtfL72kG/IE2svqLkq4pLPVvcSDSQPitLQ+
	 xZ7kqeJgxhOc/aT+EFGVTTS+uxkzPYj0JIHeHyIXsYUKsnifkMLa+7NhcUkTnaZQbh
	 EButuu/gAo55udlJVuptr6NmdI5+Axf+qGe1mCp4ZQRdXD982IFd09XzhCVenCES8a
	 kdPvFBjgJ5o4BZbLypdkiaf/C21uSwAZRUpLUUmHnH1HgMIZE194KykEjEcvjX+8cp
	 aMSEdOZhjlG6tji/zFdNIlwhr//ZImn3KO7BBeRTXv8zaUmSjYs5kcfqnTK1qSsxDH
	 psrQqn/Gpf2CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] KVM: s390: Zero initialize irq in
 reinject_machine_check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804162435.28617-4-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:20:51 +0000
Message-Id: <20260804172052.7626C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Injecting a floating machine check causes a host kernel panic =
because kfree() is unconditionally called on a stack-allocated variable.
- [High] Memory leak in kvm_s390_get_io_int() when I/O interrupt reinjectio=
n fails.
--

--- Patch [3]: [PATCH v2 3/7] KVM: s390: Zero initialize irq in reinject_ma=
chine_check ---
commit c87188fae3993586a5800e7440b273a7c1c85398
Author: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: KVM: s390: Zero initialize irq in reinject_machine_check

This commit zeroes out the stack-allocated kvm_s390_irq structure in
kvm_s390_reinject_machine_check() to prevent leaking uninitialized stack
data via the fixed_logout array.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 23f0e0821474a..009d6a845d598 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3109,7 +3109,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcp=
u *vcpu,
>  				     struct mcck_volatile_info *mcck_info)
>  {
>  	struct kvm_s390_interrupt_info inti;

[Severity: Critical]
This is a pre-existing issue, but does this lead to a kernel panic when
injecting a floating machine check?

If a hardware machine check occurs while the CPU is in SIE and it is a
floating machine check, we pass the address of this stack-allocated inti
variable into __inject_vm():

kvm_s390_reinject_machine_check() {
    ...
    if (mci.ck) {
        inti.type =3D KVM_S390_MCHK;
        rc =3D __inject_vm(vcpu->kvm, &inti);
    ...
}

Inside __inject_vm(), the call chain reaches __inject_float_mchk(), which
unconditionally frees the pointer:

__inject_float_mchk() {
    ...
    kfree(inti);
}

Could this result in a host crash due to freeing a stack address?

> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_irq irq =3D {};
>  	struct kvm_s390_mchk_info *mchk;
>  	union mci mci;
>  	__u64 cr14 =3D 0;         /* upper bits are not used */


While reviewing the interrupt code, I noticed another pre-existing issue in
a different path.

[Severity: High]
This isn't a bug introduced by this patch, but does kvm_s390_get_io_int()
leak memory when I/O interrupt reinjection fails?

When kvm_s390_get_io_int() dequeues a classical I/O interrupt, it takes
ownership of a dynamically allocated struct kvm_s390_interrupt_info object.
If it detects a higher-priority GISA interrupt concurrently, it attempts to
reinject it:

kvm_s390_get_io_int() {
    ...
    kvm_s390_reinject_io_int(kvm, inti);
    ...
}

If the floating interrupt queue is full, __inject_io() returns -EBUSY:

__inject_io() {
    ...
    if (fi->counters[FIRQ_CNTR_IO] >=3D KVM_S390_MAX_FLOAT_IRQS)
        return -EBUSY;
    ...
}

The return value of the reinjection is ignored in kvm_s390_get_io_int(), and
the original pointer is overwritten immediately after without freeing it on
error, which appears to leak the object.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D3
