Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81F3469EE;
	Wed, 12 Aug 2026 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566210; cv=none; b=PovT8HWsGrGd59GNhOJcz2rJc8MUgPLLnv2YrZ73U7uBzxL3ZedrI2itj9kFYu3Ia1tSX+xyC78V3BpAH67Ntf28CIlMwyixIHCGKYZqdE2fZjIywg4dJ0+X0MvBRMgvOTqV1JCU8hIx5jwrGc8RUXnKJ7nznsgXCswFDlmgC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566210; c=relaxed/simple;
	bh=g6oouuaiookZNCHaLLX0FsOdXQjpkqCRIaHfiUVVN3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7s3cIIWIGDKyoeN7xpwuT/fX4qnDcrIrHYlt42B3eteoETazgAb/p91rNyR5AoxIipz/PVjwuVvkJZemOSyzAUqCrveyGob6o5bPvUabNqLj13z/Fr/XN1AptqSuX4f0Va5f5a39K0bNHifzvaEyRKZgpXGBU4mYsZPo0UDDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaihUdBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaihUdBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E901C1F000E9;
	Wed, 12 Aug 2026 20:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566209;
	bh=u8G5VrGlZJFlMkHIhmUSQiuxvbdI1KqBg5Wyz2z+JIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaihUdBFj2ZJRgJepfczbzwSSYvEinZ8zA3pAlSkcWNrda0ND/wlzjUHeDZw+mdNa
	 fW9FYGQqbnQk2Se7+Rdz+MSVv9nKzIOHwnTTvWMqAoBZvdPSm0R0ORskPSE6bypm+m
	 0rX+WdgWkDkhflb6KzZdnaiRmNG3JoyajkGwITXbqkn3ekg63KHUYA3H4c3a5GS24Q
	 tNnkbmJsRXzjchqc1NCKpk3ndgMNISiEONS/teKBt5RwnmpVytlVXlIZpxKz/GuYVc
	 5r/3uwD+ClVZ3OiKyLVGAKhkfHBHF5vdxuiGBs5fhHDuExvKwmC7ANitB7z7mMMw80
	 vOwH+jffxmo7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] s390/vfio-ap: Fix missing lock required to
 access list of ap_matrix_mdev objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812200240.818004-4-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:23:28 +0000
Message-Id: <20260812202328.E901C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Registering the emulated IOMMU device before adding it to the =
mdev list allows a race condition where multiple mdevs can be attached to t=
he same KVM instance, bypassing the strict 1-to-1 isolation check.
- [High] Eventfd context references (`req_trigger` and `cfg_chg_trigger`) a=
re leaked if the VFIO device is closed or removed without explicitly unregi=
stering the IRQs.
--

--- Patch [3]: [PATCH v5 3/9] s390/vfio-ap: Fix missing lock required to ac=
cess list of ap_matrix_mdev objects ---
commit 225a264b9dad5df5a833e518a4dd594cafd35d03
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev ob=
jects

This commit fixes a locking issue where the mdev_list was accessed without
holding the matrix_dev->guests_lock mutex. It ensures the lock is properly
acquired during device probe and status show operations. Unnecessary NULL
initializations for triggers are also removed.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index c6bee69cc22f6..f2d662e388bdc 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -800,12 +800,17 @@ static int vfio_ap_mdev_probe(struct mdev_device *m=
dev)
>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>  	if (ret)
>  		goto err_put_vdev;

[Severity: Critical]
This is a pre-existing issue, but does registering the emulated IOMMU
device here expose it to userspace before it is added to the mdev list?

If userspace concurrently opens the device and calls vfio_ap_mdev_set_kvm(),
that function traverses the mdev list to check for duplicate KVM references.
Since the device is not in the list yet, this check can succeed. Could this
allow multiple mdevs to attach to the same KVM instance and bypass the
isolation check?

> -	matrix_mdev->req_trigger =3D NULL;
> -	matrix_mdev->cfg_chg_trigger =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this code leak the eventfd contexts
if userspace sets them and then closes the device without explicitly
unregistering the IRQs?

When userspace sets triggers via VFIO_DEVICE_SET_IRQS, eventfd_ctx_fdget()
takes a reference. If the device fd is later closed, the cleanup sequence
happens:

vfio_ap_mdev_close_device()
vfio_ap_mdev_remove()
   vfio_put_device(&matrix_mdev->vdev);

Neither function appears to release the req_trigger or cfg_chg_trigger
references. Can this lead to an indefinite leak of the eventfd_ctx memory
since there is no release callback to clean them up when the matrix_mdev
is freed?

> +
> +	/*
> +	 * Take the matrix_dev->guests_lock mutex before adding the matrix_mdev
> +	 * to the mdev_list. All functions that traverse the list must also hold
> +	 * this lock to guard against additions to or removals from the list
> +	 * while it is being traversed.
> +	 */
> +	mutex_lock(&matrix_dev->guests_lock);
>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> -	mutex_unlock(&matrix_dev->mdevs_lock);
> +	mutex_unlock(&matrix_dev->guests_lock);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D3
