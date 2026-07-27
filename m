Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9EE42903A;
	Mon, 27 Jul 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174501; cv=none; b=IEMkTo09f0mUeHNlMRbvHc45zk+CLQpmz7g9Qfs9GYQE5eGVBTqOGQ6M92db1jXnYO0VGp2r3OX2elTJMrVAatdNUzpWjl9agORaiLVi5ywW0bc7nPHcjj2aww8J7GU1BB62K1ae7NF/cBzhCQrZcDODRtDNePhkmvzlv4F+/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174501; c=relaxed/simple;
	bh=Q2VkQ2fTXWEyqf2YJwuCiFeCvcIiJgTlG+EMVXD6VmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a15dTSk5FS8WLDE1YUjGt8q0w8/2W4vYPKsTicigoz+arrp95EulZ8wl1n43D70SXYepkf1stkXS0K8r0q0LdYEGoDmjFY6Xm1ylzk4Qqm0AXLduq1T43G/PQ6R9is4umndnMjpdoEyrBOGWQHi1+C/HSMh1nVV9x9oPbMYx8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmo3bdPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmo3bdPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A0A1F000E9;
	Mon, 27 Jul 2026 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785174489;
	bh=sXId5OA5jKIJatozsYRVjHIGndsIcrcghgNRUzTUAKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmo3bdPWdqaFvprjetwF6jBqRIgANrtpfqMYyx3EAo8TuMjwe7cSpThTNwvNCn0nx
	 jSg+oisp8gaXvRMZmVJzyG5H6VJFqyfp/5CbDsynPnMU/cQSYjyrumLbe5lrFy+vIx
	 XYe+m9AWT4JcJXDeYnwEExQXUZNQrALmlQB8+SI3ZNfLPXS/+fVwS25NDiaIVZV8H2
	 4Q0a2azgCl8vuxQYhXMmrF/VVVgJc2Fn1TLpgvsDMM+CKfqQOd6uldT2xNmpmd71Vm
	 OuoMt5w3e+156QzmeXJSdGlHvrgJPgN7QcXZlC4wYnxaqVau5H3F/fTq9PaxbIbDji
	 65TIyTVln+Dmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727173239.2420754-4-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:48:08 +0000
Message-Id: <20260727174809.30A0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The driver prematurely exposes the VFIO migration capability to us=
erspace while only providing stub implementations that silently pretend to =
succeed.

Pre-existing issues:
- [High] The eventfd contexts for `req_trigger` and `cfg_chg_trigger` are l=
eaked when the matrix mdev is removed or the device is closed.
- [Medium] In `vfio_ap_mdev_probe()`, the device is exposed to userspace be=
fore `req_trigger` and `cfg_chg_trigger` are initialized, allowing them to =
be clobbered by a concurrent ioctl.
--

--- Patch [3]: [PATCH v6 03/15] s390/vfio-ap: Functions to initialize/relea=
se vfio device migration data ---
commit faa8a565ea108d20c1807c07fbe1be6336a97435
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data
   =20
Provides the functions that initialize and release the data structures
used during live guest migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index fc3b2e154ad8b..ae0bd1f415feb 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	return NULL;
> +}

[Severity: High]
Does returning NULL unconditionally here trick the VFIO FSM into believing =
the
state transition succeeded immediately without actually transferring any da=
ta?

[ ... ]

> +void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_m=
dev)
> +{
> +	if (ap_is_se_guest())
> +		return;
> +
> +	matrix_mdev->vdev.migration_flags =3D VFIO_MIGRATION_STOP_COPY;
> +	matrix_mdev->vdev.mig_ops =3D &vfio_ap_migration_ops;
> +}

[Severity: High]
Since the state transition operations like vfio_ap_set_state() currently ju=
st
return NULL, does advertising the VFIO_MIGRATION_STOP_COPY capability here
prematurely expose an incomplete migration implementation to userspace, whi=
ch
could result in broken live migration and guest data corruption?

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 36786d70a88f5..90b0fce0123b5 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> +static void vfio_ap_mdev_release_dev(struct vfio_device *vdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	vfio_ap_release_migration_data(matrix_mdev);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does vfio_ap_mdev_release_de=
v()
fail to put the req_trigger and cfg_chg_trigger eventfd contexts?=20

If they are also not cleaned up in vfio_ap_mdev_close_device(), could this
allow a user to systematically leak kernel memory by repeatedly opening the
device, configuring IRQs, and closing it?

[ ... ]

>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>  	if (ret)
>  		goto err_put_vdev;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
>  	matrix_mdev->req_trigger =3D NULL;
>  	matrix_mdev->cfg_chg_trigger =3D NULL;

[Severity: Medium]
This isn't a bug introduced by this patch, but does assigning NULL to
req_trigger and cfg_chg_trigger here risk clobbering valid pointers?

If a concurrent ioctl configures the triggers via VFIO_DEVICE_SET_IRQS
immediately after the device is exposed via vfio_register_emulated_iommu_de=
v(),
but before we acquire mdevs_lock here, could we overwrite the initialized
triggers and leak the eventfd contexts?

>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>  	mutex_unlock(&matrix_dev->mdevs_lock);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D3
