Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76035C180;
	Thu, 30 Jul 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431085; cv=none; b=nHoHu97jpM5/ZM7NCBNLMxQchz8PzGBQIuARMmkWyhOHhniT38YmpN/go4ifHkgeiQRDKoyc9hkSxYrXA/1b4B6cpHsiLOcXmXViuIX/Yhu/U03HzU5GqUmFKl1CqwL/TfwCI1AbiQ5T/MsSvGhWO9r+/8h+Dl0i1Nr5zVC7Uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431085; c=relaxed/simple;
	bh=vDuvDHLHJ+0AZ41ug75orRGPYaz8ZMCR448uzbUP7qM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mZ/6E5zIOjdh++Kam83nqutA2AnRVOxHUpZCaOiXqQyoP05oux58FMz9apicLQlzYscCGBwBs2K/NlvsBB+R+T51jK3mQiWErdpRBFyAb87y6o1F5JTfxaBZJj6R91RdhJUDDAnmFCdG+Cu8O7asXcPaCQPNlbDrlAJM6zaRw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWHzmFL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWHzmFL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7441F000E9;
	Thu, 30 Jul 2026 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785431084;
	bh=9J0QRCWAkroDOML7M6Pu99OroGdhTBe5DYMDcE6OMyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWHzmFL0+xM1OQnobx51vQNlmNiFtMLJoVR5Op4DYvMBxl9mx2MMbmHYOuTPtMeuY
	 FsGdbHHrMNWJDEQW47V5um6BIoJzXuWtIeYgFTLLRHvhTnU89GmRXvo/550v6c/XJo
	 u55oKIvW0WKDG8zj9xlMaFLGNgdYlf1ZqNPOW8oFeu+duyqmn128TI4GzF6GjuB8bs
	 k/jI0E6FcfLETeoCeoqjA9ahCus0SSbYN9guc83kCGZ0/XWOk+rvUCkCMfKD9Futjr
	 Z7s/URHSWeUSHTPPU1EGwTXe9j0Pf0SobTFvynbPEu7zndcy5Rroyvd6LrGepBnnls
	 ly3oTUefP70fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/14] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730162714.133327-4-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 17:04:42 +0000
Message-Id: <20260730170443.0E7441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing ucontrol checks in ESCA handling lead to out-of-bounds mem=
ory accesses for KVM_VM_UCONTROL VMs.
- [High] Memory leak of `vcpu->arch.mc` on error paths in `kvm_arch_vcpu_cr=
eate()`.
--

--- Patch [3]: [PATCH v6 03/14] KVM: s390: Fix overclearing ESCA in case of=
 error ---
commit 0972b46b8d10201faec4d5ded093d7c4cc013c9b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error
   =20
If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. In the above scenario, the spurious
duplicate vCPU is destroyed, but the ESCA entry corresponding to the
original vCPU is cleared.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..2acdff130fa6c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -86,7 +86,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
>  	union esca_sigp_ctrl *sigp_ctrl =3D &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)

[Severity: High]
This is a pre-existing issue, but missing ucontrol checks in ESCA handling
can lead to out-of-bounds memory accesses for KVM_VM_UCONTROL VMs.

If a user creates a KVM_VM_S390_UCONTROL VM (requires CAP_SYS_ADMIN), skips
sca_can_add_vcpu() limit checks during vCPU creation, and successfully
initializes vCPU IDs up to 254 (above the ESCA array limit of 248), does th=
is
allow out-of-bounds reads and writes?

For example, when injecting KVM_S390_INT_EXTERNAL_CALL or resetting the vCP=
U,
sca_clear_ext_call() unconditionally writes 0:

arch/s390/kvm/interrupt.c:sca_clear_ext_call() {
    ...
    WRITE_ONCE(sigp_ctrl->value, 0);
}

Similarly, sca_inject_ext_call() performs an out-of-bounds cmpxchg write:

arch/s390/kvm/interrupt.c:sca_inject_ext_call() {
    ...
    rc =3D cmpxchg(&sigp_ctrl->value, old_val.value, new_val.value);
}

Could this corrupt the kernel memory adjacent to the esca_block pages for
vCPU IDs >=3D 248?

>  		return;
>  	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);

[ ... ]

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 9ec5833a09732..58cec3703c2d5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does kvm_arch_vcpu_create() in
arch/s390/kvm/kvm-s390.c leak the MMU cache allocation on error paths?

If a subsequent allocation fails after kvm_s390_new_mmu_cache() assigns the
cache to vcpu->arch.mc, the function jumps to out_free_sie_block and returns
an error without freeing the MMU cache:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
    ...
out_free_sie_block:
    free_page((unsigned long)(vcpu->arch.sie_block));
    return rc;
}

Since kvm_vm_ioctl_create_vcpu() decrements kvm->created_vcpus and frees the
vCPU struct but does not call kvm_arch_vcpu_destroy() on this error path,
would vcpu->arch.mc be permanently leaked?

Can an unprivileged user repeatedly attempt to create a vCPU and force memo=
ry
allocation failures to cause an unbounded memory leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D3
