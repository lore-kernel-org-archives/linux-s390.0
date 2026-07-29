Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FC45C70B;
	Wed, 29 Jul 2026 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341204; cv=none; b=EvFMB0hC36+NSgUhipnJ2YWXrMb/5k/6XmnxUluCz5pv1onKXmBQ/0SSQvS9sPtmXit7P8bU4zT3wKCeLRtz7mqyUztPI4w3ammOch3t9cBLmlWd2M9sUKGrHOHsEXW7JxzZYA34C92Ak1g6z+fiGJwXP897g/7WBS+8BxwEBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341204; c=relaxed/simple;
	bh=imHAnHOASMszjFWAAI6pzhns/ootIV7dQYseIplO2k4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCOwq4Gge9pTAOGZfUW1dFCs5IwKesPbu0fVYetxkNr3Qb2Oerlp+XBbxPg4UxbNiMhmal8IuAwUks8OQbE6V8WXOUZIB/eU390zdGTYlqqwIdJa+lG+/W9enbTsfeWk+RIOmk6VIUD76RHSSHickmbNtrsbnSut7cYXnzsiHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScBiVHwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScBiVHwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C11F000E9;
	Wed, 29 Jul 2026 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785341202;
	bh=AewAhwS41Pk4oMbqWPkVLHWxwzQQ0Kl5/+DIZm+/H9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScBiVHwzzJ6vOwoi2avjW9PsEY5Ni/7Uuzmv/p3nVmCm8QF55hqw+/S0kYl7xhQrw
	 P4MblHikTjUXh8Pv9u2k2wqQLXbEg0KuYXkndtKXDa7XPlVoTNp+C6i3dAEscUZ8oG
	 MsKSIqx+eIRo5IdneAwjk6v1QJ+7lc+Ak2zFp77b6jOJ4xcIjbFCNbP4pOWlSYMug+
	 bW3cujRV/N7MRlVDPAS23inILFzvXSFcd3ya9d/hhXp0FFIwjAlek0ckEbnU9I8qY2
	 qKIC2lI3V3SD1PL0OjJjwYSpvtXcD9BDfjJI1Fi7RwKhRF9/nwqTqZ0ORxUN5j2G/h
	 XPHICYKbkpjww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729152938.782383-3-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:06:42 +0000
Message-Id: <20260729160642.B18C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The struct kvm_s390_mmu_cache allocated in kvm_arch_vcpu_create() =
is leaked on error paths.
--

--- Patch [2]: [PATCH v5 02/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()=
 ---
commit 0d3b94e982f008ae0ede697fd75113aea3b668c3
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()

In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0 cbrlo.
This commit fixes an issue where running with V !=3D R causes free_page() to
attempt freeing physical page 0 by ensuring cbrlo is only freed if it is
non-zero.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2fe2e46b7ac39..096b426c1281b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3675,7 +3675,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_v=
cpu *vcpu)
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>  {
> -	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> +	if (vcpu->arch.sie_block->cbrlo)
> +		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
>  	vcpu->arch.sie_block->cbrlo =3D 0;
>  }

This is a pre-existing issue, but while reviewing this file I noticed a
memory leak in kvm_arch_vcpu_create().

When a subsequent initialization step inside kvm_arch_vcpu_create() fails,
the function jumps to the out_free_sie_block label:

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
    ...
	vcpu->arch.mc =3D kvm_s390_new_mmu_cache();
	if (!vcpu->arch.mc)
		return -ENOMEM;
    ...
out_free_sie_block:
	free_page((unsigned long)(vcpu->arch.sie_block));
	return rc;
}

[Severity: High]
Does this error path permanently leak the struct kvm_s390_mmu_cache
allocated earlier in the function, since vcpu->arch.mc is not freed here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D2
