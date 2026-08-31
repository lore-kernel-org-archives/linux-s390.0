Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD3383C7B;
	Mon, 31 Aug 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214617; cv=none; b=Lp6KFf9NbI838nQHjZ+rHZWb66OSkIExhUyqyMyCXQk5L08q5kNaT6Fk02UYEjeNHirMKN6EBYpQu4d7v2IlarYWK7hTE2Zss2SIFzJDjgvGg02tHHOeYBb/NAVfhbGLR61UI1AM1Gm+Or9+RIBHg+lucy7XP3ZE/2Pz3XZAGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214617; c=relaxed/simple;
	bh=AXxjAlPWQ9UegK/NocD8fKrG4IHjHBwDVAiAxCIHrPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TDPcC2t7sxFZHYelvJ+r+lFdpzudXetLleFYiyfoOniRv8MXUUUvFd7L0TFkerbaPJ/su5y7W0K6a/Gypj2M7BoCXyh9Laj6nbQS0k6hu9iZILuvqvt5xsvaw8g2F6WjuGdBu/9DklBxW27yxy/86lAQ0pUgCNtNsyegwX0SM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3iJ3XPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3iJ3XPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8478D1F000E9;
	Mon, 31 Aug 2026 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214616;
	bh=UU/HdvNLgLpmqLkCo+G00MQ5XF8rpaHoqHROap+THEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3iJ3XPk/IUT6X6d8V5v5jZVfzSHLVS9kgtIE7b+qmx7AmjRVosDxqVFJhwx4a01g
	 /V8D0oTilKd+XE8Ln00eKkEPYrL8DJoCKj16dGEHY9y51bMWxQoxiFdugmoG5QgHj4
	 nhaSOim+XwqY6BEOUe4Jq8w3XNweb772z1Ns7fD7PYdmnJVwXSMGRwm2LcC6CUrETL
	 GdvcpOrqyRM4AThA7CWY6ortu9PxHIvanXpaUJD3A8nbNlduo5qC/gZk2SRXp/6lta
	 V30AeIEs8Q78mvDbZ/h9MjZb/KtUieRFi61Ac4johH+t2U6XZpIqKpk1zUuFrQZrrE
	 514NrvwhnUj2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/20] KVM: s390: arm64: Implement SVE for arm guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260831145536.913567-19-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-19-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:16:54 +0000
Message-Id: <20260831221655.8478D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] SVE register accessors copy fewer bytes than the KVM ABI specifi=
es, failing to zero-pad the remainder of the userspace buffer.
- [Medium] SVE ioctls and vCPU finalization bypass feature gating checks.
- [Low] Unrecognized or invalid SVE register IDs result in a -EFAULT return=
 code instead of -ENOENT or -EINVAL.
--

commit 7e278493890194c05cc617a90bf08952cf400bea
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement SVE for arm guests
   =20
Add support for Scalable Vector Extension (SVE) in ARM64 guests running
on s390 hardware, providing 128-bit vector operations backed by s390's
Vector Extension (VX).

> diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
> index 0474609759360..63fc4a64ab48f 100644
> --- a/arch/s390/kvm/arm64/guest.c
> +++ b/arch/s390/kvm/arm64/guest.c
[ ... ]
> +static inline int get_sve_ffr_reg(struct kvm_vcpu *vcpu, unsigned int re=
gnum,
> +				  u16 __user *uptr)
> +{
> +	/* ffr is pregmax + 1 */
> +	if (regnum !=3D KVM_ARM64_SVE_NUM_PREGS)
> +		return -EINVAL;
> +
> +	if (put_user(vcpu->arch.sae_block.sve_ffr, uptr))

[Severity: Medium]
The ARM64 KVM ABI defines FFR and PREG registers as 32 bytes
(KVM_REG_SIZE_U256), but this only writes 2 bytes via the u16 pointer. Will
this leave 30 bytes of the userspace buffer uninitialized, potentially
leaking memory contents into the migration stream when QEMU reads it?

> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static inline int get_sve_preg(struct kvm_vcpu *vcpu, unsigned int regnu=
m,
> +			       u16 __user *uptr)
> +{
> +	if (regnum < 0 || regnum >=3D KVM_ARM64_SVE_NUM_PREGS)
> +		return -EINVAL;
> +
> +	if (put_user(vcpu->arch.sae_block.sve_pregs[regnum], uptr))

[Severity: Medium]
Similar to get_sve_ffr_reg(), this only copies 2 bytes for a register size
defined as 32 bytes. Should this zero-pad the rest of the buffer according =
to
the ABI?

> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static inline int get_sve_zreg(struct kvm_vcpu *vcpu, unsigned int regnu=
m,
> +			       __vector128 __user *uptr)
> +{
> +	if (regnum < 0 || regnum >=3D KVM_ARM64_SVE_NUM_ZREGS)
> +		return -EINVAL;
> +
> +	/* vreg and svreg overlap and zreg is also just 128 bit so we reuse the=
 vreg space */
> +	if (copy_to_user(uptr, &vcpu->arch.ctxt.vregs[regnum],
> +			 sizeof(vcpu->arch.ctxt.vregs[regnum])))

[Severity: Medium]
The ZREG size is defined as 256 bytes (KVM_REG_SIZE_U2048) by the ABI, but
this only copies 16 bytes. Does this leave the remaining 240 bytes of the
userspace buffer untouched, breaking ABI expectations?

> +		return -EFAULT;
> +	return 0;
> +}
[ ... ]
> +static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *=
reg)
> +{
> +	void __user *uptr =3D (void __user *)reg->addr;
> +	unsigned int regnum;
> +	int ret =3D -EFAULT;
> +
> +	if (reg->id =3D=3D KVM_REG_ARM64_SVE_VLS)
> +		ret =3D get_sve_vls(vcpu, uptr);
> +	else if (sve_ffr_index(reg->id, &regnum) >=3D 0)
> +		ret =3D get_sve_ffr_reg(vcpu, regnum, uptr);
> +	else if (sve_preg_index(reg->id, &regnum) >=3D 0)
> +		ret =3D get_sve_preg(vcpu, regnum, uptr);
> +	else if (sve_zreg_index(reg->id, &regnum) >=3D 0)
> +		ret =3D get_sve_zreg(vcpu, regnum, uptr);

[Severity: Medium]
Does this function need to enforce the vcpu_has_sve() and
kvm_arm_vcpu_sve_finalized() constraints before delegating to the register
accessors, as required by the ABI?

[Severity: Low]
If an unrecognized or invalid SVE register ID is passed, the index validato=
rs
(e.g. sve_zreg_index()) return negative error codes like -ENOENT or -EINVAL,
but this function ignores them and falls through to returning the default
initialized ret =3D -EFAULT. Is it intentional to return -EFAULT instead of
propagating the specific error codes, which userspace like QEMU might rely
on to detect the end of slices?

> +
> +	return ret;
> +}
> +
> +static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *=
reg)
> +{
> +	const void __user *uptr =3D (const void __user *)reg->addr;
> +	int ret =3D -EFAULT;
> +	unsigned int regnum;
> +
> +	if (reg->id =3D=3D KVM_REG_ARM64_SVE_VLS)
> +		ret =3D set_sve_vls(vcpu, uptr);
> +	else if (sve_ffr_index(reg->id, &regnum) >=3D 0)
> +		ret =3D set_sve_ffr_reg(vcpu, regnum, uptr);
> +	else if (sve_preg_index(reg->id, &regnum) >=3D 0)
> +		ret =3D set_sve_preg(vcpu, regnum, uptr);
> +	else if (sve_zreg_index(reg->id, &regnum) >=3D 0)
> +		ret =3D set_sve_zreg(vcpu, regnum, uptr);

[Severity: Medium]
Like get_sve_reg(), should this also check if the vCPU has the SVE feature
enabled and finalized before allowing state modifications to vector registe=
rs?

> +
> +	return ret;
> +}
> +
> diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
> index bc7bcee75779e..754c4d4a70b6b 100644
> --- a/arch/s390/kvm/arm64/reset.c
> +++ b/arch/s390/kvm/arm64/reset.c
[ ... ]
>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
>  {
> -	return 0;
> +	switch (feature) {
> +	case KVM_ARM_VCPU_SVE:
> +		if (!cpu_has_vx())
> +			return -EINVAL;
> +		if (vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED))
> +			return -EPERM;

[Severity: Medium]
Should this function verify that the KVM_ARM_VCPU_SVE feature is actually
enabled for this vCPU (e.g. via vcpu_has_feature()) before allowing
finalization? Without this check, userspace could potentially finalize SVE
on non-SVE vCPUs.

> +		vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D18
