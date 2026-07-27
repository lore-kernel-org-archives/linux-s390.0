Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16641F34A;
	Mon, 27 Jul 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168900; cv=none; b=s9n9C9PoV1y+NYU3PthGwuAwZJBnzmHXILBfZ+hGm/Yy8JYNkwYfwp2ocyq9ap4akVUufj35dZQ/WhaAL1o9+7AyiGq+MoYXFMHDGxmoTs+tvUjUYyXpMal/8ieAtOgZ73p9G2Xp9480kzAJk3C+88WvMJHBHdHFze1k6QurV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168900; c=relaxed/simple;
	bh=Z8l3HVqSD6DiU40DHhc0cr063GI3YZJGRxTmhH5QPvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2+BzbMfCptFES4eC1sab3ki17i/Ey+i1UYcqm6qIvmDfvuNtf54p5GADLUqZS0TDdO7pLXAZ4l2blrGe9rYuMO/p+JE3FPRBON2SANaKGzAvOOn5hSgsV1n5wKkKfbSRWQ3gWH4FchtP1Uo8vVvQ1WyyYvVPdGrURRe8YVtSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+RLUevU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+RLUevU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7AC1F000E9;
	Mon, 27 Jul 2026 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785168894;
	bh=OlO7HjhyjpcAHirr3npQRaVvfWRMQEMQUzsUvRSkifs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a+RLUevU9qQGbwZRUFpgXqRZRgU8be3atxhesGuGYphfN3iclm3qq1pPOLzjCSMvx
	 7gWJ8vWaW9hz+8dQy0zdi095n/voeST/dAFq+kQNWhTRtZ1t8VM1h6XG4vpFC/bOJw
	 wTqofEUeienUWAmbeLAanHiKXxE68Sk/axHtyp7Pnuyrta8dF+h6ZLiRHvVfeY/2qP
	 PmGMxeQAj34j/51O3yfH3ZY1kY9lA20ZIgov2uo1hqveAZYTJyrh5CDJ5kIfRcg4t2
	 VSYWQv0S3VeBtsvMRMBGZYzk0XfP4nVsX41LTvfzO7P9Uw1pWbTc1Rt6Rmc7OzKsWR
	 hepLVCn6g8Gzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727150254.236021-6-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:14:53 +0000
Message-Id: <20260727161453.AF7AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional free of physical page 0 on error path in kvm_s39=
0_vcpu_setup() when CMMA is disabled.
--

--- Patch [5]: [PATCH v3 05/10] KVM: s390: ucontrol: Add missing locking ar=
ound gmap_remove_child() ---
commit 23ca669df08a6ebee3b62a02dbada5159020162e
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 0a44351722702..e2a15799b9ac3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3867,7 +3867,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  out_ucontrol_uninit:

[Severity: Critical]
This is a pre-existing issue, but is it possible for the error handling path
in kvm_s390_vcpu_setup() to accidentally free physical page 0?

In kvm_s390_vcpu_setup(), if use_cmma is 0, kvm_s390_vcpu_setup_cmma() is
skipped and vcpu->arch.sie_block->cbrlo is left at its initialized value
of 0.

If a subsequent step like kvm_s390_pv_create_cpu() fails, the error path
unconditionally triggers the CMMA cleanup:

arch/s390/kvm/kvm-s390.c:kvm_s390_vcpu_setup() {
    ...
    if (rc)
        goto out_free_cpu;
    ...
out_free_cpu:
    kvm_s390_vcpu_unsetup_cmma(vcpu);
    ...
}

Inside kvm_s390_vcpu_unsetup_cmma(), the page is freed without checking if
CMMA was actually initialized:

arch/s390/kvm/kvm-s390.c:kvm_s390_vcpu_unsetup_cmma() {
    ...
    free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
    ...
}

On s390, phys_to_virt(0) evaluates to __identity_base. When KASLR is enable=
d,
this is a non-zero virtual address that maps exactly to physical page 0.

Because the resulting virtual address is non-zero, it bypasses the addr !=
=3D 0
safeguard in free_pages(), which could cause physical page 0 (containing
s390 lowcore data) to be freed into the buddy allocator.

Would it make sense to verify use_cmma is enabled or that cbrlo is non-zero
before freeing this page?

>  	if (kvm_is_ucontrol(vcpu->kvm)) {
> +		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
>  		gmap_remove_child(vcpu->arch.gmap);
> +		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
>  		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
>  	}
>  out_free_sie_block:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D5
