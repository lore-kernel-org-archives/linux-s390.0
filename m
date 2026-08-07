Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550531327A;
	Fri,  7 Aug 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115892; cv=none; b=DzgslnkkFTmWqa7kcaDNjefF8y97k38syrtbQ8eQA4y31sZ9hiYFXQdheo9KG6e6x+KU/AjcqBF6Q/GMof9mbNDbq1prYFnqSfqntF9YtRFPoI6sMyWuxd5A2GlwJ9ZubodW9fP/UGp/kwgP38WZs1yujVo+QKheV0KzZz7wSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115892; c=relaxed/simple;
	bh=fIhZ+ruL7tmlfaF/BxwJY4Dsn5x5XRHZh5O3Rle0xfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PjSFzm7EYelt1Gml404eXclrXUwi4C55V/f/qtiDrDoWb7xQlxc27wvTzl/PRjQ7pTGB6/gfNezrPhJwPkO319UcgAeSY2sbhQD2HtOw8PSKft9D5rzCIugbaLZC2LxbVp7xjps7eP0xB5hkzV0HhXzWden5w8Ck8s/OvgCcn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyBfzXol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyBfzXol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF971F00A3A;
	Fri,  7 Aug 2026 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115890;
	bh=kUuF4k1q1+EGhgsAmElAs4gyEvKA2f7IW84oC4fNSCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyBfzXol8nk1i5PaBkpg/qhN3QxBvknNkkTAYRzFBxE8m71GFXZthPnuMk90/scPo
	 bXzz3RyJs0JfTW1R+/kq7MbFoMQTgwo/g55628GKBVaZfF7ug1BKJeCZECPfPkJ58j
	 pwMmJM6+82DG5esXMf+EcxSA6CLSrmaEn9+wlRgr9Krcaw4bqvBlWfcwyik2fS3Kai
	 W1wfatUHTKauHG/MIfbmFTBQVNs05zJD4D0WS9Omt/Gj1e8937mZl9jCtl23UNdkGK
	 oALF0dUyajev0g0afiwdikYRckrNF2OBd2hVwqpLpO1uNoiT37WDbpxzY0zqqBIVRQ
	 Q67zuU61CePEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Fix dereference matrix_mdev->kvm without
 checking for NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807145416.322916-1-akrowiak@linux.ibm.com>
References: <20260807145416.322916-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:18:09 +0000
Message-Id: <20260807151809.CEF971F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect bitwise operation `bitmap_andnot` used instead of `bitma=
p_and` for control domains in `vfio_ap_mdev_cfg_remove`, preventing removal=
 of unplugged domains.
--

--- Patch [1]: [PATCH] s390/vfio-ap: Fix dereference matrix_mdev->kvm witho=
ut checking for NULL ---
commit 7ae73def648a068715a8cdb4bf574ac5755f8e77
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL

This commit adds NULL pointer checks for matrix_mdev->kvm prior to taking
the kvm->lock mutex in the configuration change and scan complete callbacks.
This prevents a NULL pointer dereference when the matrix mdev has no
associated KVM instance.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..a0b7c37fee281 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2606,7 +2606,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long =
*ap_remove,
>  	int do_remove =3D 0;
> =20
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> -		mutex_lock(&matrix_mdev->kvm->lock);
> +		/*
> +		 * If the mdev is attached to a KVM guest, we will need to
> +		 * hold the KVM lock in order to update the guest's AP
> +		 * configuration if any adapters, domains or control domains
> +		 * have been removed.
> +		 */
> +		if (matrix_mdev->kvm)
> +			mutex_lock(&matrix_mdev->kvm->lock);
> +
>  		mutex_lock(&matrix_dev->mdevs_lock);
> =20
>  		do_remove |=3D bitmap_and(aprem, ap_remove,

[Severity: High]
This is a pre-existing issue, but I noticed a potential logic flaw just
below this context in vfio_ap_mdev_cfg_remove() within
drivers/s390/crypto/vfio_ap_ops.c.

Does the control domain removal incorrectly use bitmap_andnot() instead of
bitmap_and()?

When a host administrator or hypervisor unplugs a control domain, the code
evaluates the removed domains using:

	do_remove |=3D bitmap_andnot(cdrem, cd_remove,
				   matrix_mdev->matrix.adm,
				   AP_DOMAINS);

Since this evaluates to cd_remove & ~matrix_mdev->matrix.adm, doesn't this
mean assigned domains that were removed from the host will resolve to 0?

Could this prevent explicitly unplugged control domains from being removed
from the KVM guest, allowing it to retain access to hardware it shouldn't
have?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145416.3229=
16-1-akrowiak@linux.ibm.com?part=3D1
