Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A780384CEA;
	Mon,  3 Aug 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763198; cv=none; b=l5zuR/JK+I2yK0WCj5KGSHiW3VLQ0Yr4lGfhsaL5lsc1AF14QQDiskXbyGodOp5W4nTqPpHYsh5kLAD0tAuF8ymTyRM9LTZGha+inhL92hn7hv3Cqpeb7JvtiXcShcvyKMu2U4P+4pCeXBBt84C0+/y34yHBFAxrIzIehPBTgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763198; c=relaxed/simple;
	bh=oqyBayK5GTWWCNMV/15hYP/xoXbYcViI/e77FCL5e0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O15RBBFL5ghfgduQqgWFbnpeoaKAb7dGRxD21ffZfKeCOoGnEKOXFJTFfw5OlV4/mm6VPjlscuGtI2yhEf3pKsk/m1Jh8uL8ukFtYKt4/Pyxm529ThwB44zSbgReWvotwXQHjFVaDte8FbRjaapVUQJ7of9efgnT+lZLnXMUN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaILd7vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaILd7vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B41F000E9;
	Mon,  3 Aug 2026 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763185;
	bh=aah5d4GXlFPb/9QM6mnGQNooVYDYPyIFVJTVKGSjSmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaILd7vhKGvzFQ/5uTm3a7ayQT4hPBk7neo1yrNL/sdFAT/LRj2lhMJtzkETu2vlR
	 MNCxnsuh+KTyI6TACNu9mtUpDga+G1Xh9JU3K6kjHssexM+LmXeZYFMWYDP48Dh/KT
	 Jm6yfs0bzUg3ROrvFV++At6KNRWWqPyyhACTOa0I5JUI1x9AlKqldhHdXShK3e8rei
	 +9U+FTByV3psOYFluZh17UqHIFUaFx0Husd5cB2mCZEQmU5xficF1TfJtBZ/6ATifu
	 9fGLEmyilY0dB4nZ6cF9QAaCrzgq5+4+JAYNFgHBRe8Qhunm+fVIAsKTubggJm0kHr
	 HO0xek3AjdduQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260803124040.126471-4-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:19:45 +0000
Message-Id: <20260803131945.888B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The MMU cache (`vcpu->arch.mc`) is permanently leaked when `kvm_ar=
ch_vcpu_create()` fails during vCPU initialization.
- [High] Protected vCPU creation failure leaks `pv.stor_base` and `sidad` p=
ages.
--

--- Patch [3]: [PATCH v8 03/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()=
 ---
commit 17f441be24aaabde7dd38b196f4dba98cf6e898d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()

In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
cbrlo; in such cases, if running with V !=3D R, free_page() will attempt
to free physical page 0.

Fix by freeing cbrlo only if it's non-zero.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1b3290a5ad1ae..9be27db0a21e6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3678,7 +3678,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_v=
cpu *vcpu)
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>  {
> -	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> +	if (vcpu->arch.sie_block->cbrlo)
> +		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
>  	vcpu->arch.sie_block->cbrlo =3D 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the MMU cache
(vcpu->arch.mc) might be permanently leaked when kvm_arch_vcpu_create() fai=
ls
during vCPU initialization.

kvm_arch_vcpu_create() allocates memory for vcpu->arch.mc via
kvm_s390_new_mmu_cache(). If a subsequent initialization step fails, the er=
ror
paths free vcpu->arch.gmap and vcpu->arch.sie_block, but appear to omit
calling kvm_s390_free_mmu_cache(vcpu->arch.mc):

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create() {
    ...
out_ucontrol_uninit:
	if (kvm_is_ucontrol(vcpu->kvm)) {
		gmap_remove_child(vcpu->arch.gmap);
		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
	}
out_free_sie_block:
	free_page((unsigned long)(vcpu->arch.sie_block));
	return rc;
}

Since the KVM core does not call kvm_arch_vcpu_destroy() when
kvm_arch_vcpu_create() returns an error, could this leak the MMU cache pages
and allow a local user to exhaust kernel memory?


[Severity: High]
This is a pre-existing issue, but I noticed another potential leak in
kvm_s390_pv_create_cpu().

When creating a protected vCPU, pages are allocated for
vcpu->arch.pv.stor_base and the sida_addr. If the ultravisor call uv_call()
fails, the code attempts cleanup using kvm_s390_pv_destroy_cpu():

arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu() {
    ...
	if (cc) {
		u16 dummy;

		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
		return -EIO;
	}

	/* Output */
	vcpu->arch.pv.handle =3D uvcb.cpu_handle;
    ...
}

However, kvm_s390_pv_destroy_cpu() begins with a check for the handle:

    if (!kvm_s390_pv_cpu_get_handle(vcpu))
        return 0;

Since vcpu->arch.pv.handle is strictly populated after a successful uv_call=
(),
doesn't it evaluate to 0 during a failure?

Does this mean kvm_s390_pv_destroy_cpu() will return immediately without
freeing the stor_base and sidad pages, allowing a local user to repeatedly
fail protected vCPU creation and exhaust kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D3
