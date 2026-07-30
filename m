Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D0382395;
	Thu, 30 Jul 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430106; cv=none; b=s3xtSKXtdzjdPy4uiB/SljLceR/Xnqaq+aybbF7LDZ+CybACZlmqiBokjV3fOL9xop1fiascAALDDIfPa3VLwILH7depcGojqFtY7Z+QaGnBxbE0bNcidTYb9EkDWIm1QhQkJyD/YCIDiwHApkzbZiGy0GgA5cpDxmVL/dtG+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430106; c=relaxed/simple;
	bh=6KOP1NgXIbC1chRi+KtgbMy/0DN0N/Wvx0YY6taHUP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mt2izkqMzZOGrJFNg9pOa3DwmAerEGCy7DvKsTuB2kGwhRooY5NT/9uxnU2u5pY6/njCiLgAfBjZ8eEZB3PhmXuDJF0mrBTA3FRzPFsjplidBl/SUwCrwnsquNmQ5tb1URJpiGVGg0zDh5m1vfN1aAqP4I+2G25hz3X2GMETBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk8ZBvQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk8ZBvQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A4C1F000E9;
	Thu, 30 Jul 2026 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430105;
	bh=1dI6Tn6LPRYpfKzHSOOBlti5q6efuhZEMHkvbi1NosA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nk8ZBvQa5jsYM5eXsM3wUobI/CSsC8l1DAPUyum5An55Zpgjs+p5r+kKmoTn41bLC
	 baNFc7UcKQcnOQzYYnRDcyuUUYqwRAiODxLj9ylKrH4vL+9/Yp+Y5nBJLOj2rpFb34
	 S/F6/BafRpxHTyVW9BgZvQQ1w1nzZkGOyhLl9BGHYQAVCdaDySfLC+B+PGIFN/eqMX
	 rsNhB5B/TUst9rF+MrraJCFxFOpM5mdl47c1LnbodTNJqm7ytN78RUUqBYIXEpldDe
	 GDD06q2IUyc+L4Jb1dKcCqZ6MksOTHBtPjTXVNwmNs8LmQIChAseg9n+xYk0reEc7C
	 MIOuUgYauj4gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/14] KVM: s390: ucontrol: Add missing locking
 around gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730162714.133327-9-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:48:24 +0000
Message-Id: <20260730164824.F3A4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The s390 MMU cache (`vcpu->arch.mc`) and its internally topped-up =
pages are permanently leaked on the error paths of `kvm_arch_vcpu_create()`.
--

--- Patch [8]: [PATCH v6 08/14] KVM: s390: ucontrol: Add missing locking ar=
ound gmap_remove_child() ---
commit 84329d883b130f6a53d6ec86765dba1245a95998
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
   =20
gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c1984fe2f9a40..a234c2ab5fed5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3874,7 +3874,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  out_ucontrol_uninit:
>  	if (kvm_is_ucontrol(vcpu->kvm)) {
> +		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
>  		gmap_remove_child(vcpu->arch.gmap);
> +		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
>  		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
>  	}
>  out_free_sie_block:

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak the
s390 MMU cache and its internally topped-up pages?

When an error occurs during kvm_arch_vcpu_create(), such as a failure in
gmap_new_child() or kvm_s390_vcpu_setup(), the error path jumps to
out_free_sie_block.  This frees the sie_page but fails to call
kvm_s390_free_mmu_cache() for vcpu->arch.mc.

Since userspace can repeatedly invoke the KVM_CREATE_VCPU ioctl and force it
to fail (for example, by exhausting cgroup memory limits to trigger an
-ENOMEM), could this result in a permanent kernel memory leak triggerable
from userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D8
