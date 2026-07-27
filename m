Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325E373BE0;
	Mon, 27 Jul 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165897; cv=none; b=L2f7M+hCUIXNkQ7PpgqGj0IlhRbX8aLCy9WgM6VN67+O1nCBP9vLcnc4a/NlpxIoMNr7IzjOTLm90kfvbFiqYI+B33u3VmrpgrzcDcCOeXvSii00JfBlxHDcGadZuvXUUM+dR5S7+L7avKXV9ZrDaO2li8u6eQ9CL6vcy4qgbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165897; c=relaxed/simple;
	bh=PSp+TmAnM8T06oj2ua6xucA0mLR7kJaewsQLee692SE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TPY2rRVbAopY62Q1lSEAv9dJgCkcUit26Pf2VRLL42AuLwRmDMrgciQocYI4etDhJrmk6VX+xlFmEzCYyDgik1wplpaiLQgaoy5Q+MTyHfoIMwl9p5ZVSkIy1T2hq5cT6Jj7IFPQatpOQ7CgQnGlu2lMsUg7liIQZ8tqq12cX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKOTxB2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKOTxB2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB331F000E9;
	Mon, 27 Jul 2026 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785165896;
	bh=5rqb6KCAKK0iTSapYubgDA2Qe/LdfhEAPWAMk2EUHUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKOTxB2wYC0ny85jsAZKHFAyVz34ptBXwoyiFafhKRptLdMsi0QRRSulm3CRmzJFE
	 2EphEvEPo1AYrZwFqx+dhi+WUQGDLkt99KegXnbBDOdhQ6xaCXuQ4Z6a6G9YTiKlfj
	 iEOSZtYhHfOcLyArSS4LACwXiZ9V82PpV7abDQOPiQPI137uH33dkKjGfTYa2tVura
	 Lm67EbpoMSopj3lZsuHSEbNdO+CtHEvFjnkJJC8pSfi4a/iS/7SFazGHuMG8A3hp4+
	 Y7Jyymhr3njxMPrBVyp0Ug4yqloVmcN/DvT4H/T1w+FyFv9t2r9d5jfcy/UirJCl29
	 Ga/62f25msT4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727150254.236021-2-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:24:55 +0000
Message-Id: <20260727152455.DCB331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing compiler barrier in vCPU initialization publication allows=
 compiler reordering, potentially defeating the NULL pointer dereference fi=
x.
--

--- Patch [1]: [PATCH v3 01/10] KVM: s390: Fix unlikely NULL gmap dereferen=
ce ---
commit 5328cd0469f8706fce5babcef6c93d98cfcef985
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix unlikely NULL gmap dereference

This commit fixes a potential NULL pointer dereference if a malicious
userspace program guesses a newly created vCPU file descriptor and
starts it before kvm_arch_vcpu_postcreate() finishes. It adds an
initialized flag that is checked before allowing vCPU ioctls to run.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 23c817595e28d..eff0644b8517d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3611,6 +3611,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
>  	    vcpu->kvm->arch.user_operexec)
>  		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
> +
> +	WRITE_ONCE(vcpu->arch.initialized, true);

[Severity: High]
Could the compiler reorder the gmap assignment after this WRITE_ONCE()?

Since WRITE_ONCE() only guarantees volatile access but does not provide a
general compiler barrier, it might be possible for the compiler to legally
reorder the preceding non-volatile store (vcpu->arch.gmap =3D ...) to occur
after the initialized flag is set.

If this happens, a concurrent thread could read initialized as true but
still observe a NULL gmap in __vcpu_run(), triggering the exact crash this
patch intends to fix.=20

Would it be safer to use smp_store_release() here to ensure the gmap
initialization is safely published?

>  }
> =20
>  static bool kvm_has_pckmo_subfunc(struct kvm *kvm, unsigned long nr)

[ ... ]

> @@ -5037,6 +5039,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
>  		return -EINVAL;
> =20
> +	if (!READ_ONCE(vcpu->arch.initialized))
> +		return -EINVAL;

[Severity: High]
If smp_store_release() is used in kvm_arch_vcpu_postcreate(), would it make
sense to use smp_load_acquire() here to properly pair with it and guarantee
we observe the fully initialized vCPU state?

> +
>  	vcpu_load(vcpu);
> =20
>  	if (guestdbg_exit_pending(vcpu)) {

[ ... ]

> @@ -5521,6 +5526,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	long r;
>  	u16 rc, rrc;
> =20
> +	if (!READ_ONCE(vcpu->arch.initialized))
> +		return -EINVAL;

[Severity: High]
Similarly, should this be smp_load_acquire() to ensure memory visibility
guarantees match across all the vCPU ioctl paths?

> +
>  	vcpu_load(vcpu);
> =20
>  	switch (ioctl) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D1
