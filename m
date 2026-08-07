Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5532AABA;
	Fri,  7 Aug 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142322; cv=none; b=Qtr046PV2t3IGeEGIAXPap9BUKKNgLTSrfw9hBhYuhJsp14KvI6d/da9HbRbS9RRi8vZrvrXi+bA4XbUvNv5xCFoII8I1lQSLxWfsA8MFvZXOf+ACZy27ga7weU+Xyu6rM++uWcfXTHenDt89pT6wD4JzllRHvFtxRLf6JXC+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142322; c=relaxed/simple;
	bh=tzKkrZ8w5bOElHBipjseWunK7TBF/1OnpCrI9FfOhOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cGaioQAjHVJabdyYEoqfiZOQQP0S43tG6Gp0WjoH0YFBOSUy1oUHe5sFdm4qBkt0MKWvMdtBXJYZzY5Y3LxMDYvhEurHkP5JgYomVui6Gl/otQa31Vy/zFqj/aNCmKOhhvGSYeA4EmvAYFJjpTd/P/CNk7e3bOMGcrUU3w/hayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rldl2Bei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rldl2Bei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA41F000E9;
	Fri,  7 Aug 2026 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142320;
	bh=NQKjGYEfPZHwQpv/+G1guZcUrQZCdqg/J1anxhZARW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rldl2BeidvKXiMuctxGB853Q8NVQTiUALXonDT31R06uZaeoR9sKLORJ0j5aFqZ7U
	 8/Vs3P+JzRWqqs5xUmhdY6Jj/F9E+hjA92XFW40/Q95rqAM5umDAIL6884TEHIPxwy
	 lN3TPSXEPI9Yhgj46HMaaMBA/rqTd4IXpMXvHCcx22vx24l4Su5+QTGNvoQG5fJbo6
	 axc0EXZkNgoabQM/lP1H9yVjzSgAZS+kNUrFjClGEgIktYc0wp25MtvwgHqDH56vWU
	 XcNeRjeiWVEcaXfiSP4QkBIRBh28FaxNae5lXK/8+fPjytWE4TyjTtgiIfG2a8fTGq
	 9yZYCug6ktWSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807221834.562851-4-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:38:39 +0000
Message-Id: <20260807223840.4FCA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch exposes the VFIO_MIGRATION_STOP_COPY capability to users=
pace before the actual migration data transfer logic is implemented, causin=
g silent migration failures.
- [High] An open migration FD can access a newly allocated migration sessio=
n if the VFIO device is closed and reopened, bypassing the intended `NULL` =
check.

Pre-existing issues:
- [High] Unconditional NULL assignments to `req_trigger` and `cfg_chg_trigg=
er` in `probe` can overwrite valid eventfd contexts set by concurrent ioctl=
s, causing a memory leak and breaking interrupts.
- [High] The mediated device is exposed to userspace before it is fully ini=
tialized and added to the driver's tracking lists, allowing multiple mdevs =
to attach to the same KVM guest.
--

--- Patch [3]: [PATCH v7 03/15] s390/vfio-ap: Functions to initialize/relea=
se vfio device migration data ---
commit 04c1b466fec62cf9e53c2d6610cde9ecbf5fefad
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data

This commit provides the initialization and release functions for the data
structures used during live guest migration of vfio-ap devices. It introduc=
es
stubs for the migration operations that will be fully implemented in
subsequent patches.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 374d3a67cb214..cf303d228a0a5 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	return NULL;
> +}
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
Will advertising the VFIO_MIGRATION_STOP_COPY capability to userspace befor=
e=20
the actual migration data transfer logic is implemented cause silent failur=
es?

If vfio_ap_set_state() returns NULL for the VFIO_DEVICE_STATE_STOP_COPY
transition, won't the VFIO core interpret this as a successful transition
that does not require a data stream? This could cause QEMU to silently
succeed on the source side without transferring any device state, leaving
the AP subsystem broken for the guest on the target side.

> +/**
> + * vfio_ap_release_mig_files:
> + *
> + * Free the ap_config buffers for any open migration FDs. Although a
> + * migration FD may still be held open by userspace, it is safe to free
> + * mig_data here because:
> + *
> + *   1. matrix_mdev remains valid for the lifetime of any open migration
> + *      FD via the vfio_device registration reference taken in
> + *      vfio_ap_open_file_stream() and dropped in
> + *      vfio_ap_release_mig_file().
> + *
> + *   2. mig_data is only accessed by the migration file ops
> + *      (vfio_ap_stop_copy_read, vfio_ap_resuming_write) under
> + *      mdevs_lock. Once mig_data is set to NULL by the caller, those
> + *      paths will see NULL and return -ENODEV before dereferencing it.
> + *

[Severity: High]
Does this lifecycle design handle the case where the VFIO device is closed
and reopened while a migration FD is kept open?

If userspace keeps the migration FD open, closes the VFIO device, and then
reopens it, vfio_ap_mdev_open_device() will allocate a new mig_data. When t=
he
old migration FD subsequently performs read or write operations, won't it
bypass the NULL check and incorrectly access the mig_data belonging to the
new session?

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 36786d70a88f5..90b0fce0123b5 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -797,13 +809,28 @@ static int vfio_ap_mdev_probe(struct mdev_device *m=
dev)
>  	if (IS_ERR(matrix_mdev))
>  		return PTR_ERR(matrix_mdev);
> =20
> +	/*
> +	 * Migration capabilities must be initialized before calling
> +	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
> +	 * will see mig_ops as NULL during the registration. This could
> +	 * prevent the VFIO core from properly setting up migration
> +	 * infrastructure like debugfs entries.
> +	 *
> +	 * This must be done before acquiring mdevs_lock to avoid an ABBA
> +	 * deadlock: vfio_register_emulated_iommu_dev() acquires dev_set->lock
> +	 * internally, while vfio_ap_mdev_open_device() is called by the VFIO
> +	 * core with dev_set->lock already held and then acquires mdevs_lock.
> +	 */
> +	vfio_ap_init_migration_capabilities(matrix_mdev);
> +
>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>  	if (ret)
>  		goto err_put_vdev;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
>  	matrix_mdev->req_trigger =3D NULL;
>  	matrix_mdev->cfg_chg_trigger =3D NULL;

[Severity: High]
This is a pre-existing issue, but does exposing the device to userspace
before setting these triggers to NULL introduce a race condition?

If userspace immediately opens the device after
vfio_register_emulated_iommu_dev() and configures interrupts, it will
allocate and set valid eventfd contexts for req_trigger and cfg_chg_trigger.
When the probe thread continues and overwrites these with NULL, won't it le=
ak
the eventfd contexts and break guest interrupts?

>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);

[Severity: High]
This is also a pre-existing issue, but does calling
vfio_register_emulated_iommu_dev() before list_add() allow multiple mediated
devices to attach to the same KVM guest?

If two mdevs are probed and opened concurrently before they are added to
mdev_list, won't they bypass the conflict detection logic in
vfio_ap_mdev_set_kvm() and violate KVM uniqueness invariants?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D3
