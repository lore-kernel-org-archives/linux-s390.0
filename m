Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6D31A572;
	Mon, 13 Jul 2026 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956678; cv=none; b=ZyD/VOYXKphMjeNZw0vWftSYRM9LgcG6YHKp9L7OP5Fh+0A3s7ek8f5J2W61zupBBomFR7HMr0SzLiyQ8v2gXdgoy8i1SIDMyEIjV48sD4qVXTHbL6CQl2/mJPCAY8GybX2Mrvc2pIEuZBNcelwLw3clWzRppPrG/2iNVRaewgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956678; c=relaxed/simple;
	bh=GdBxMgWt84R9Uqgu+mqBEcC2JWYIEUjbGoZCfUOzhJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JrzGhLrJ9SCRWqXmm0zA0Kew8YZasEJXj8s45Gn+YryW/3nYqNGhMR7p9tEg/5A4woTPiNHdPsOCgvTnp6RYa8xRkPIluIUYpG6m+3P/qo9+zNR3bmrGIQr3l5uNDfxOvIcbMFS7H8zA3FRNTdBN6s0jjIBOyYAfM/gkV4uMTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckiV8l+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckiV8l+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB71F00A3A;
	Mon, 13 Jul 2026 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956675;
	bh=xAhNPS2m2V+kPBOlSmOgKgLVvM8cJVXPrPHkQV7xLrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckiV8l+fDTiquAHY86MFNjrUjI9Vy3qlOh1u6SiSCTOqw4rPDof9C+RLURxL9X5WC
	 pIQS2UExDpVqqHoJS9WP2c7qEPJRwctAFCs+tsNtntLTNFBoNdkPA6vcy7j+dk2ir2
	 H9U9gr1BB1PwirvM8Bo9fodP7hifoCA3/jNOlKK1JzZSc/KPDGDoQ7qPuUXq4KwIx6
	 YuhDer3f0GV+wqBDNqmtmQEzFPFYNNcYSnyc9isszWNb9J+OI2wkaMx4aLdopi9vTg
	 GBYFX3vW8g0QwP18ymKnesUzHEt3b5OC/GKXzDPYR6d+0y214ETSHyYxTmNKqhcj2s
	 oi3BvnKOEvZtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] KVM: s390: Fix overclearing ESCA in case of
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260713150857.269954-7-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:31:13 +0000
Message-Id: <20260713153114.46BB71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The condition `!vcpu->arch.sie_block->scaol` incorrectly assumes `=
scaol` is always non-zero for a valid SCA physical address, which can lead =
to silently skipping ESCA cleanup for valid vCPUs.

Pre-existing issues:
- [Critical] In `sca_add_vcpu()`, the hardware-visible ESCA `mcn` validity =
bit is set before the `sda` (State Description Address) pointer is written,=
 exposing an uninitialized (zero) `sda` to concurrent hardware SIGP operati=
ons.
- [High] The patch fixes the clearing of the ESCA entry in `sca_del_vcpu()`=
 during duplicate vCPU destruction, but misses an identical issue in `sca_c=
lear_ext_call()` which also corrupts the original vCPU's ESCA state.
- [High] Memory leak of `vcpu->arch.mc` on the error path of `kvm_arch_vcpu=
_create()`.
--

--- Patch [6]: [PATCH v2 6/7] KVM: s390: Fix overclearing ESCA in case of e=
rror ---
commit 2c6e0529648df791186dd5602fe55245586d90d7
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix overclearing ESCA in case of error
   =20
If an attempt is made to create a vCPU with an already existing ID,
the duplicated vCPU will be destroyed. When destroying a vCPU, its
ESCA entry will be cleared. This patch fixes a regression where the
original vCPU ESCA entry was erroneously cleared by checking if the
pointer to the ESCA is set.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fc0a884d7f549..6339a327a7be2 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3458,7 +3458,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct esca_block *sca =3D vcpu->kvm->arch.sca;
> =20
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.sie_block->scaol)

[Severity: High]
Is it possible for scaol to legitimately be zero here?

Since scaol stores the lower 32 bits of the ESCA block physical address, if
the block allocated via alloc_pages_exact() happens to be 4GB aligned
(e.g., 0x100000000), scaol would evaluate to zero.

Would this cause the cleanup to be skipped for a fully initialized vCPU,
leaving the mcn bit set and sda pointing to a freed sie_block? Can this
cause a use-after-free if hardware receives a SIGP for the freed vCPU ID?

>  		return;
> =20
>  	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);

[Severity: High]
This is a pre-existing issue, but it looks like a similar regression exists
in sca_clear_ext_call().

When a duplicate vCPU is destroyed, kvm_arch_vcpu_destroy() calls
kvm_s390_clear_local_irqs(), which invokes sca_clear_ext_call(). Without a
similar initialization check, this unconditionally zeroes the sigp_ctrl:

arch/s390/kvm/interrupt.c:sca_clear_ext_call() {
    ...
    WRITE_ONCE(sigp_ctrl->value, 0);
    ...
}

Will this silently drop pending external calls or emergency signals for the
original, legitimate vCPU?


[Severity: High]
This is a pre-existing issue, but I noticed a potential memory leak on the
error path of kvm_arch_vcpu_create().

If an initialization step fails after vcpu->arch.mc is allocated via
kvm_s390_new_mmu_cache(), the error path frees vcpu->arch.sie_block but
appears to omit freeing vcpu->arch.mc:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
    ...
out_free_sie_block:
    free_page((unsigned long)(vcpu->arch.sie_block));
    return rc;
}

Does this code leak the memory allocated for the mmu_cache?


[Severity: Critical]
This is a pre-existing issue, but the initialization order in sca_add_vcpu()
seems risky.

The mcn validity bitmask is set before the sda pointer is written:

arch/s390/kvm/kvm-s390.c:sca_add_vcpu() {
    ...
    set_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);
    sca->cpu[vcpu->vcpu_id].sda =3D virt_to_phys(vcpu->arch.sie_block);
    ...
}

Can a concurrent hardware SIGP instruction from another vCPU observe the
valid mcn bit and read an uninitialized sda pointer before the host software
writes the SIE block address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D6
