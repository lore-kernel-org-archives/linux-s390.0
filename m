Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4913B9956;
	Tue, 28 Jul 2026 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259667; cv=none; b=UZoM3WJ5xnYQ/RvLPLFlW+/Wz95w5KaHvmdLp8Nj9YquZ/7mkqlwS68v+EpjYnCqG1Ijv5Jcopf9uy6mMj7rv1jgQdDjuM6K5IH0ijk8U8on8XZN89A+pOwHWYD5ydh4mF26dwm+dg+2Nyq8mYwGVoJ8H882DZkSRqRu7miWVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259667; c=relaxed/simple;
	bh=1CW0i6xuSzPqZEj3XrOuJYAP9q1r0kgU6W+1TQQ9q3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bNtC5xhVEY88cbp4q90/Wfegd5raY/r2Wm3k5WeVlJYzokwzARbWaGhBr3f0akmLI4KpzmQCBWsrjbpzZqbolLGsK0GXkiPwnzGyQRL6wqI4MrRIyRcNuvRaApPLRu+J2fkvf7nyArG/mfT/YuR2jBm7VF/STcP6hPctCJm6eDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enypZVX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enypZVX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB67B1F000E9;
	Tue, 28 Jul 2026 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259666;
	bh=JHP2q78gQEAdhfyxlB+gjURLcSjhh5FYfyutSXjtza0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enypZVX8sQBZDgt9lyLe/bZIXzPWon3/IXbAHYJvdc4Wv3kxNc9rbhe6W7mYLItrA
	 gzkakiUCGedA3xPee9ydCcKRk1paaIUSnOuPLN9sNmrkrxOH0xUN13Tky+/K88OHjV
	 OSWKZKz7BjYzH6DoUwEiqvVqf25+G73w2+QTZdO9298a2FeY0L5ERn8kohUdoDyW9F
	 ZD2J1m9l4kEQSS3d2odGc9bLAa6AzAn7s1pBtSwrZndmUyT6zpgZ5r2LU9g49jEUmt
	 Zm9ecOu/GpPeh2fZGeSygwukPQRZV7z9ZnPsWpLu7Jmlq1jf3fuReloNKgdsJupe1N
	 XFkTv2uREczSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/13] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728170708.294400-9-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:27:45 +0000
Message-Id: <20260728172745.CB67B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional call to `kvm_s390_vcpu_unsetup_cmma()` when PV V=
CPU creation fails causes freeing of physical page 0 if CMMA is disabled, l=
eading to a host panic.
--

--- Patch [8]: [PATCH v4 08/13] KVM: s390: Free the mmu cache when kvm_arch=
_vcpu_create() fails ---
commit 30d38fd7067b631b7997fead40df5a9ae47fcfb8
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails

This commit fixes a memory leak where the mmu cache is not freed if
vcpu creation fails. It also refactors kvm_arch_vcpu_create() to use
scope-based cleanup instead of goto-based error handling.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -3849,10 +3849,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
>  		 vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
>  	trace_kvm_s390_create_vcpu(vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
> =20
>  	rc =3D kvm_s390_vcpu_setup(vcpu);

[Severity: Critical]
This is a pre-existing issue, but could this lead to a host panic if a
Protected VM fails to create a VCPU and CMMA is disabled?

If kvm_s390_pv_create_cpu() fails (e.g., hitting a cgroup memory limit)
inside kvm_s390_vcpu_setup(), it unconditionally unsets CMMA:

kvm_s390_vcpu_setup() {
    ...
	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
		rc =3D kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);
		if (rc)
			kvm_s390_vcpu_unsetup_cmma(vcpu);
	}
    ...
}

If use_cmma is false, vcpu->arch.sie_block->cbrlo is 0.=20
kvm_s390_vcpu_unsetup_cmma() then executes:

kvm_s390_vcpu_unsetup_cmma() {
    ...
	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
    ...
}

With KASLR enabled, phys_to_virt(0) evaluates to __identity_base=20
(a non-zero address), which bypasses the safety check in free_pages().=20
Does this erroneously free physical page 0 (the lowcore page), leading=20
to memory corruption or a fatal VM_BUG_ON_PAGE panic on the host?

> -	if (rc)
> -		goto out_ucontrol_uninit;
> +	if (rc) {
> +		if (kvm_is_ucontrol(vcpu->kvm)) {
> +			scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
> +				gmap_remove_child(vcpu->arch.gmap);
> +			vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
> +		}
> +		return rc;
> +	}
> =20
> +	vcpu->arch.mc =3D no_free_ptr(mc);
> +	sie_page =3D NULL;
>  	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D8
