Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84C3469EE;
	Wed, 12 Aug 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565834; cv=none; b=VuT6cDeJAtpWDaU9jJ0ESOnjcDLJze9C+cWJF5MyPcionp9LEJ+tZ9/dxTasxPkpk/THT6Ey4JtElYt8Trx3FyyoZPmOgDywZI1mbghJh15qZALVUUT2DQcDVYE2Og0y24eDMyoFWMaIyWDRwrZVl6A6q6yfOzgenJrpGSeppSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565834; c=relaxed/simple;
	bh=VXKH1D+suebJ5JdRhCoXfjEG9UoxwhZmALXjgcm3Zls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h062zUhHFc3TDMETWNuR2QIqfdrAtGeJP495sbo5FvAL7eNXXKMw+u1HvaE/jJUTE5UFyuh0FsIWW8BVUzxxqoIcaknux8kjtvyH2UjYExvKIy9pbfqL2s5bI7ayuihtmMKxZMPN8fvRdOzcUHVoY/9cBeqMT0ODJn3KtNzqpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHtG8m+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHtG8m+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A231F000E9;
	Wed, 12 Aug 2026 20:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565833;
	bh=1vv9pTH6uy3ZguaMQUG6E48a2XMa5FfdhvR988Vbdng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHtG8m+K+i25JOC14+etx8Eod6MhOo9X/oAYMZspRdR5J9PrUhG7TUEbDp11f61p4
	 y0l/Nsqr9z8zyYx4S/TIhm1OfiALK0mN14pyHuzZDqN5R/jFUOjbIpVkGBHxUEGiVk
	 lrhqS6o45JZ35LSSKGH8sYX75CKvr1w1F0LB4SR1yIkutdSAar/tAOTowyHMCeOaIr
	 NDCOxueQCOgc/BsTySflFLJ8DlT0W5HgJSJSNhl4ZJ5X4KdJ9dAbRJwzH7XjgeAyPX
	 X59drtZ2VFWBYe551d2GK0PIfWx0cBTW4ldDgN000fDiAsvJ2pqN+c1QigNMU4/CC9
	 hrbvpTqgWjfZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812200240.818004-3-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:17:12 +0000
Message-Id: <20260812201712.E9A231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `apm_filtered` stack array is conditionally left uninitialized=
 but unconditionally used, causing random AP queue resets.
- [High] Concurrent list additions and traversals cause unprotected data ra=
ces on `matrix_dev->mdev_list`.
--

--- Patch [2]: [PATCH v5 2/9] s390/vfio-ap: Fix dereference matrix_mdev->kv=
m without checking for NULL ---
commit da7c08a88a7102b1daed33f3e6352fe4dffb203f
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL

This patch adds checks to ensure matrix_mdev->kvm is not NULL before taking
the matrix_mdev->kvm->lock mutex during the configuration change and scan
complete callbacks. The locking order between kvm->lock and mdevs_lock is
also updated.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 845c86ba8bc30..c6bee69cc22f6 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -2821,9 +2834,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D fals=
e;
> =20
> -	mutex_lock(&matrix_mdev->kvm->lock);
> -	mutex_lock(&matrix_dev->mdevs_lock);
> -
>  	filter_adapters =3D bitmap_intersects(matrix_mdev->matrix.apm,
>  					    matrix_mdev->apm_add, AP_DEVICES);
>  	filter_domains =3D bitmap_intersects(matrix_mdev->matrix.aqm,
[ ... ]
> @@ -2841,9 +2851,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_mat=
rix_mdev *matrix_mdev)
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> =20
>  	reset_queues_for_apids(matrix_mdev, apm_filtered);

[Severity: High]
This isn't a bug introduced by this patch, but can this sequence result in
reading uninitialized stack memory?

In vfio_ap_mdev_hot_plug_cfg(), DECLARE_BITMAP() allocates apm_filtered on
the stack but does not initialize it.

If filter_adapters and filter_domains are both false (for example, if only
control domains were added), the code bypasses vfio_ap_mdev_filter_matrix(),
leaving the stack array completely uninitialized.

When reset_queues_for_apids() is then called, will it unconditionally itera=
te
over this garbage memory and potentially trigger unintended hardware queue
resets (ap_zapq) for random matching queues?

> -
> -	mutex_unlock(&matrix_dev->mdevs_lock);
> -	mutex_unlock(&matrix_mdev->kvm->lock);
>  }
> =20
>  void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> @@ -2854,15 +2861,29 @@ void vfio_ap_on_scan_complete(struct ap_config_in=
fo *new_config_info,
>  	mutex_lock(&matrix_dev->guests_lock);
> =20
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {

[Severity: High]
This is a pre-existing issue, but does this list traversal have an
unprotected data race?

The matrix_dev->mdev_list is traversed here holding only
matrix_dev->guests_lock. Because matrix_dev->mdevs_lock is acquired inside
the loop, it is dropped before the list_next_entry() macro step evaluates
the next pointer for the iteration.

Since vfio_ap_mdev_probe() adds devices to this list while holding only
matrix_dev->mdevs_lock:

vfio_ap_mdev_probe() {
    ...
    mutex_lock(&matrix_dev->mdevs_lock);
    list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
    mutex_unlock(&matrix_dev->mdevs_lock);
    ...
}

Could a concurrent bus scan and probe cause this traversal in
vfio_ap_on_scan_complete() to read a partially updated list pointer and
cause list corruption?

> +		/*
> +		 * The mdevs_lock must be held to access fields within matrix_mdev,
> +		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
> +		 * ordering requirement and prevent a lockdep splat.
> +		 */
> +		if (matrix_mdev->kvm)
> +			mutex_lock(&matrix_mdev->kvm->lock);
> +		mutex_lock(&matrix_dev->mdevs_lock);
> +
>  		if (bitmap_empty(matrix_mdev->apm_add, AP_DEVICES) &&
>  		    bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS) &&
>  		    bitmap_empty(matrix_mdev->adm_add, AP_DOMAINS))
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D2
