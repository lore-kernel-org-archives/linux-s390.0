Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0451D63E4;
	Tue,  7 Jul 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415883; cv=none; b=bzvaWgVrtYuOJeqFYzdbJcEL9GH/wNEQ/vYd7nmp4+obvLBvlYncE10WHpRsJs88N5jFPg1u8jwZGDUK6jLBSMQiUoCEx2MurD2GbJHt/XL5aCXFkHLWy2ycYzLaUKbKRXWo6PxB26+rjzlv/EMoCY366dy5mPv7TAKdLjOM5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415883; c=relaxed/simple;
	bh=lCJLZlMPLT9IFiD/Q3kLH3BFZe8c5wF1kIVNaVogL0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T8iuG6fYz75y0b4sszrjmXNgGVk39E9Z3Z8nnpPNtQ3QziZeNWZMja+NdZFmJURg+guqVVz+dlZhSJ2b+3X7t3eEaY6QnKqeNYmOpqukjlK8AU6+hspeZxY78Njvg6lgi6c7LOjqA/S14pJYqDrjsM+GqxvrfCWL6X24Ztszl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da+5HOfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da+5HOfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F91F00A3A;
	Tue,  7 Jul 2026 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783415882;
	bh=GWvAyCtU0bq+Dwe8XWiitwjZuoNDBGr6aX8+eM329ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=da+5HOfMxerzjl2aOhd1s91PvEbCgGAUHak3xgdJky3gEh0WDR4D3ag+xW2GTdhT7
	 ALw5/tBNjwzSv8QqywUQp1GZzAMgs5PAbJYy72iLmyeJ2Wmu6bZHNEAjMLT/ptapsQ
	 +EzL2rL6VPlfQswiRjQs4UkyTwPRsY+Ek+58XG4/CEhP7+NqJR+lxhgcT9ukH76mCu
	 DICNh9tfTq+652m20qmJWz8vWmjNlXRwI+gbydU6IpbhVxbNntfnUCW10rRcvBKSpS
	 rKPrHcBex6l30ta04z7mcfAeVTbNFjI1W60BF8r5/QJuqXEMSwpbY0ewbMTmOmkKdS
	 B3znXTiLfQRjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260707090226.3206695-4-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:18:01 +0000
Message-Id: <20260707091801.DC7F91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Self-deadlock in the error path of `vfio_ap_mdev_probe()` due to h=
olding `matrix_dev->mdevs_lock` while calling `vfio_put_device()`.
- [High] AB-BA lock inversion between `matrix_dev->mdevs_lock` and the VFIO=
 core's `dev_set->lock`.
- [Medium] Advertising `VFIO_MIGRATION_STOP_COPY` with stub callbacks that =
return `-EOPNOTSUPP` breaks userspace expectations.

Pre-existing issues:
- [Critical] If `vfio_ap_mdev_set_kvm` returns `-EPERM`, it leaves a dangli=
ng pointer in `kvm->arch.crypto.pqap_hook`, leading to a Use-After-Free.
--

--- Patch [3]: [PATCH v4 03/15] s390/vfio-ap: Functions to initialize/relea=
se vfio device migration data ---
commit fd0c4839e5d26823861a00cf7c060331ae1fd632
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data

Provides the functions that initialize and release the data structures
used during live guest migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 239168c4b7fff..5b6d48ccf332c 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -54,3 +55,77 @@ struct vfio_ap_config {
>  	size_t				config_sz;
>  	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>  };
> +
> +static struct file *vfio_ap_set_state(struct vfio_device *vdev,
> +				      enum vfio_device_mig_state  new_state)
> +{
> +	return NULL;
> +}
> +
> +static int vfio_ap_get_state(struct vfio_device *vdev,
> +			     enum vfio_device_mig_state  *current_state)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int vfio_ap_get_data_size(struct vfio_device *vdev,
> +				 unsigned long *stop_copy_length)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct vfio_migration_ops vfio_ap_migration_ops =3D {
> +	.migration_set_state =3D vfio_ap_set_state,
> +	.migration_get_state =3D vfio_ap_get_state,
> +	.migration_get_data_size =3D vfio_ap_get_data_size,
> +};
> +
> +/**
> + * vfio_ap_init_migrations_capabilities - initialize migration capabilit=
ies
> + *
> + * @matrix_mdev: pointer to object containing the mdev state
> + */
> +void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_m=
dev)
> +{
> +	matrix_mdev->vdev.migration_flags =3D VFIO_MIGRATION_STOP_COPY;
> +	matrix_mdev->vdev.mig_ops =3D &vfio_ap_migration_ops;
> +}

[Severity: Medium]
Does advertising VFIO_MIGRATION_STOP_COPY here break userspace expectations
when the callbacks like vfio_ap_get_state() unconditionally return -EOPNOTS=
UPP?

If userspace queries the device state via=20
VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE, wouldn't the -EOPNOTSUPP response
cause the setup or migration to unexpectedly abort?

[ ... ]
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 71d3e2c2e07c6..8132902148669 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -797,19 +809,30 @@ static int vfio_ap_mdev_probe(struct mdev_device *m=
dev)
>  	if (IS_ERR(matrix_mdev))
>  		return PTR_ERR(matrix_mdev);
> =20
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	/*
> +	 * Migration capabilities must be initialized before calling
> +	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
> +	 * will see mig_ops as NULL during the registration. This could
> +	 * prevent the VFIO core from properly setting up migration
> +	 * infrastructure like debugfs entries.
> +	 */
> +	vfio_ap_init_migration_capabilities(matrix_mdev);
> +
>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);

[Severity: High]
Does acquiring matrix_dev->mdevs_lock before calling
vfio_register_emulated_iommu_dev() create a lock inversion?

Since vfio_register_emulated_iommu_dev() acquires dev_set->lock, this sets
the lock order to mdevs_lock -> dev_set->lock.

Later, when userspace opens the device, the core holds dev_set->lock before
invoking the open_device callback (vfio_ap_mdev_open_device). The callback
then attempts to acquire mdevs_lock, which reverses the order to
dev_set->lock -> mdevs_lock, potentially leading to a deadlock.

>  	if (ret)
>  		goto err_put_vdev;
>  	matrix_mdev->req_trigger =3D NULL;
>  	matrix_mdev->cfg_chg_trigger =3D NULL;
>  	dev_set_drvdata(&mdev->dev, matrix_mdev);
> -	mutex_lock(&matrix_dev->mdevs_lock);
>  	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>  	mutex_unlock(&matrix_dev->mdevs_lock);
>  	return 0;
> =20
>  err_put_vdev:
>  	vfio_put_device(&matrix_mdev->vdev);

[Severity: High]
Is there a self-deadlock risk here in the error path?

If vfio_register_emulated_iommu_dev() fails, we jump to err_put_vdev while
matrix_dev->mdevs_lock is still held. Calling vfio_put_device() here will
synchronously trigger the release callback (vfio_ap_mdev_release_dev), which
attempts to acquire the same non-recursive mdevs_lock again.

> +	mutex_unlock(&matrix_dev->mdevs_lock);
>  	return ret;
>  }
> =20
> @@ -2052,19 +2075,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_h=
ead *qlist)
> =20
>  static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
>  {
> -	struct ap_matrix_mdev *matrix_mdev =3D
> -		container_of(vdev, struct ap_matrix_mdev, vdev);
> +	struct ap_matrix_mdev *matrix_mdev;
> +	int ret;
> =20
>  	if (!vdev->kvm)
>  		return -EINVAL;
> =20
> -	return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	ret =3D vfio_ap_init_migration_data(matrix_mdev);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret =3D vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);

[Severity: Critical]
This isn't a bug introduced by this patch, but does a failure in
vfio_ap_mdev_set_kvm() leave a dangling pointer that leads to a
use-after-free?

In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is immediately
overwritten with &matrix_mdev->pqap_hook:

    down_write(&kvm->arch.crypto.pqap_hook_rwsem);
    kvm->arch.crypto.pqap_hook =3D &matrix_mdev->pqap_hook;
    up_write(&kvm->arch.crypto.pqap_hook_rwsem);

If it then detects that another mdev is already assigned to this KVM,
it returns -EPERM but skips resetting the hook. Since matrix_mdev->kvm
remains NULL, vfio_ap_mdev_unset_kvm() won't clean this up on teardown.

If the second mdev is freed, wouldn't the active KVM guest trigger a
use-after-free if it executes a PQAP instruction using the stale hook?

> +	if (ret) {
> +		/* Clean up migration data on failure */
> +		mutex_lock(&matrix_dev->mdevs_lock);
> +		vfio_ap_release_migration_data(matrix_mdev);
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +	}
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D3
