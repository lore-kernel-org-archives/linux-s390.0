Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A3470EA2;
	Wed, 12 Aug 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552724; cv=none; b=Nm6w2EltILxfP+UfoHPs8yvGBb2+G47jmy8EbZoiPbLRbP9fW5NPgRnIPMBlwB9dxdAM+V7Usfa4a55utJshsOjVfiiV/NpeNYjTvIxwFzgWpRHdUFRSx+YVflgTM+XX54QHBqAGjBruOsL1MbvMV6k1/Yxz6JC/dHpP7cMa+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552724; c=relaxed/simple;
	bh=CBcx1FXjxgV9xrEr51C5aAI3GA0VO4xvtbdHQrcJjuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuq41tBooxSUzohGdGrinRUWh+rZuuZZrieCT+tVQ3Rz4mdtkbe6zAtLMouZiPiQDHonYBmvlaLMD+v1qnqwmNVe7O1PyoI8zRpC2hIF4zh6h0FuwMpSpavTiREYaJXnU+Rwkv8o8YS8BmbQp2zVqNgm1icjMNiWQVE5rRolWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYmxiS1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYmxiS1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C071F00A3A;
	Wed, 12 Aug 2026 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552723;
	bh=0+/9nol15K57ypPQ6svx7wYijNxYXJFNMqk5t1tn1fE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYmxiS1ultvHQC9pBXqpsmJXNzWXF0tR5H2DkyW0diEFt37oGajEwyYyzlAa4a/7b
	 bCV8ge9sI1q1ht+niej0MDpzzio9zdgSjhmo6c4fJIK6ptcA7Jb9LjZeFczQ5sv71n
	 cpRgxDrWKcdQpVsjH8Nmx/maHoRxdQ/TEXIp1lQka/FvZHoU0RrKzNI05v47a+qoJE
	 x2ac4KII/IR9I+rH9l0dR+aUjYmhuD+TEXpW+o2sbUAqujrj2OxsswN8wIiSB+j+6z
	 x6p7ZFqWoWL2Rf/g9I4kZo3USFNFP7LDvk5tcMQNAXCsYI1E1QJc49B9LjpG0CdOqx
	 MDDHKDI3a6tqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 30/33] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-31-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-31-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:38:42 +0000
Message-Id: <20260812163842.76C071F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Integer underflow in `kvm_max_guest_address()` bypassing KVM's IPA=
 limits and causing Undefined Behavior.
- [High] VM IPA size configuration is ignored for memory boundaries, and me=
m_limit suffers from an off-by-one error.
--

--- Patch [30]: [PATCH v6 30/33] KVM: s390: arm64: Implement vm/vcpu create=
 destroy. ---
commit ac331802b4f3974b686910d63a6161cfc71cfae4
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vm/vcpu create destroy.

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap and gmap plumbing.
Implement function (stubs) required by gamp.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 8e17b7eef8131..69d43066f9e1a 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
> @@ -53,6 +58,83 @@ static u64 kvm_max_guest_address(void)
>  	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;
>  }

[Severity: High]
Does this underflow if the host is booted with less than 1GB of memory?

If sclp.hamax is less than 1GB, max_addr + 1 is less than 1 << 30.
ALIGN_DOWN would result in 0, and 0 - 1 would underflow to U64_MAX.

[ ... ]

> +static int kvm_vm_type_ipa_size_shift(unsigned long type)
> +{
> +	int phys_shift;
> +
> +	phys_shift =3D KVM_VM_TYPE_ARM_IPA_SIZE(type);
> +	if (phys_shift) {
> +		if (phys_shift > get_kvm_ipa_limit() ||
> +		    phys_shift < ARM64_MIN_PARANGE_BITS)
> +			return -EINVAL;

[Severity: High]
This seems to cascade from the potential underflow in kvm_max_guest_address=
().

If get_kvm_ipa_limit() computes fls64(0) - 1, it would return -1 as 0xFFFFF=
FFF
via u32. Could a malicious userspace then bypass this IPA size check since
phys_shift > get_kvm_ipa_limit() would evaluate to false?

[ ... ]

> +int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> +{
> +	char debug_name[32];
> +	int ret;
> +
> +	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> +		return -EINVAL;
> +
> +	ret =3D kvm_vm_type_ipa_size_shift(type);
> +	if (ret < 0)
> +		return ret;
> +	kvm->arch.guest_phys_size =3D 1UL << ret;

[Severity: High]
If the check in kvm_vm_type_ipa_size_shift() is bypassed, the phys_shift va=
lue
(up to 255) would be used in this shift. Would this invoke undefined behavi=
or
since the shift amount could exceed the width of the type?

[ ... ]

> +	ret =3D kvm_gmap_init(kvm);
> +	if (ret)
> +		goto out_err;
> +	kvm->arch.mem_limit =3D kvm_max_guest_address();

[Severity: High]
Is it intended that kvm->arch.mem_limit is hardcoded to the global host
maximum instead of the VM's configured IPA size limit
(kvm->arch.guest_phys_size)?

If it uses the host's maximum, could userspace successfully map memory high=
er
than the configured VM IPA size limit?

Also, kvm_max_guest_address() appears to return an inclusive limit, but when
s390_kvm_mmu_prepare_memory_region() checks this limit:

    if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)

it treats mem_limit as an exclusive boundary. Does this off-by-one prevent
userspace from mapping the final page of the allowed memory region?

[ ... ]

> +int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sae_block *sae_block =3D &vcpu->arch.sae_block;
> +	struct kvm_sae_save_area *save_area =3D &vcpu->arch.save_area;
> +
> +	spin_lock_init(&vcpu->arch.mp_state_lock);
> +
> +	/* Force users to call KVM_ARM_VCPU_INIT */
> +	vcpu_clear_flag(vcpu, VCPU_INITIALIZED);
> +
> +	vcpu->arch.mc =3D kvm_s390_new_mmu_cache();
> +	if (!vcpu->arch.mc)
> +		return -ENOMEM;
> +
> +	sae_block->hbasce =3D vcpu->kvm->arch.gmap->asce.val;
> +	sae_block->mso =3D 0L;
> +	sae_block->msl =3D kvm_max_guest_address();

[Severity: High]
Does sae_block->msl also need to be scoped to the VM's requested size rather
than the host maximum?

Setting this to the host maximum might remove hardware emulation boundaries=
 if
the guest physical size was configured to be smaller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D30
