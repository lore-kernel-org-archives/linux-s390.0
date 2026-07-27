Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62771431A3C;
	Mon, 27 Jul 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172014; cv=none; b=UAQll9vGkspgXiYy/diKDEiUQFTp1E1eZLdymunoEDEN67PyJprRj9yLDegx4zTPhx3dYOdwaRUiXSdg8ivhrJKhDouJ/CdilJqz0meIU7FqEr6U9Ym6aRKPC469+11tCsD/+aexwbyWJkqp5RBoJpxpkYH0CEidi/RpfFxm/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172014; c=relaxed/simple;
	bh=0abLyJ/sXTsk+U6Ogh5/7WWHQXQTffHcvb/EteXDmTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+zco34fa+shcW0ziDJuDAC3ndWMlAlcD3ulRhCbLxENAmmdvBF+8Jxu4SaiwjWMvsEGWv+0wn79xeVTPeoDJ8X6yixEbS5ZG4hC8ulfAjBv2ScC4YRODpKT3w39+1DBZQ41Pb7qFFYeuRbnoimcw2rU8j8Q637f8Zh4Rg6CpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px2ts0gL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px2ts0gL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69FB1F000E9;
	Mon, 27 Jul 2026 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172013;
	bh=XioYB+5PINUrUQ03SpMY/e6bhHF4Bg8BvhN4moUpdLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Px2ts0gL2a7onBRUJTYe5x+TJirwD7q8w3EF4PQR7dSMotZE4YhlchLUTEL4Et2F2
	 k7LRQTDGkPkZzbRzGAw/c7xVQUA6U5PSKbJWLg2jFRy12geecwf2GQvHYi30DZE1ws
	 gCtwzuSAGM3v29dtLklLNNJTBd0pn9EoAVzbRj5r0FY4XBlRLGXErI00YrKShtayui
	 dBqHJCllpqfNvQnj02yJxQC1VixqQ4jtjn4aBpWDQyhZI5H377qnZ7hR+FFlzYI7bA
	 Tyga+r4msZ3RwhPbS0MdFpvhNVxJjtDruq/OoFOKdzyFe9rgbKRy4xxs7aGtFowSHv
	 i+A+u5GmQUhag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727150254.236021-9-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:06:52 +0000
Message-Id: <20260727170652.A69FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based error handling with scope-based cleanup (__free) =
in the same function.
--

--- Patch [8]: [PATCH v3 08/10] KVM: s390: Free the mmu cache when kvm_arch=
_vcpu_create() fails ---
commit f957b5e2634eaa5f53bf929349c916ffa15d9f2c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Free the mmu cache when kvm_arch_vcpu_create() fails

This commit switches kvm_arch_vcpu_create() to use the __free()=20
scope-based cleanup helper for the mmu cache to prevent memory leaks=20
during initialization failures.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3794,19 +3794,17 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsi=
gned int id)
> =20
>  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) =3D NULL;
>  	struct sie_page *sie_page;
>  	int rc;

[ ... ]

> @@ -3862,6 +3860,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	if (rc)
>  		goto out_ucontrol_uninit;
> =20

[Severity: Low]
Are we permitted to mix scope-based cleanup and goto-based error handling=20
in the same function?

The cleanup guidelines indicate that for a given routine, we should general=
ly=20
convert all resources that need a goto cleanup to scope-based cleanup, or=20
convert none of them. Mixing __free() with existing goto paths can create=20
confusing ownership semantics during future refactoring.

Could we either convert out_ucontrol_uninit and out_free_sie_block to use
scope-based cleanup as well, or stick to traditional goto labels for freein=
g=20
the mmu cache?

> +	vcpu->arch.mc =3D mc;
> +	mc =3D NULL;
>  	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
>  	return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D8
