Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824234751E;
	Tue, 30 Jun 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818766; cv=none; b=QY76fwQtrBxw5iFnnUQ5fog9W7PXrTdckehMsaKJu7HQ0GtRX7KBAFeejTLr1G9ORMOSOcKlArWfurwH7Ttk/xG1DvTN4411YwUMtSK8RI2quS9rS3y4iTR4RKZMFkkWuXf0lvel4vYJt3cHUxpp494zmIz3SQtkhqf2pvCT0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818766; c=relaxed/simple;
	bh=ArpKKHnE24HOuP/clBs9n/6w2eSnAXYwzvOR7OQNrO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D+gAeqeJ84gmieluxTAXjPp3O8Mc5bfUeTcuViQazd7SVjjvUIKN26e/NrAILR1JRWrrcQwflYTGleY8aCq07r/1cBA/qE0jqY9DAMDrryaeX1ISICnMpTLDuTx60A7gBVsJKxtNT17BlOKQ2E4vNpVQ/RsmtpHGrWWYMtuUNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOS8pyHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOS8pyHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF051F000E9;
	Tue, 30 Jun 2026 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818764;
	bh=pGyiTAIkD/kvJk2FJ2xWcivZWiK3tdgjr2GpKT3uBk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOS8pyHpfVIPu+cG1JWVwQ2cAJhVKCj9cebujDzVd+6KEA1hICqd6wDXH4louNfpt
	 8bw8nFaK/HNgn7x7zLEhOBMl/VG4OhhfRxLIhwOJBzRLuvqQTRAQKMbA6gmp+pEk/G
	 RGQY4c/+8RG9CwrVPAa4yoVPAdbWLhyGcZCaum3E2FoVWxsizVdrY88/B7whgv++Ml
	 UZqzFLGlCbMEBKDtEi951m6lE8M6vD+RQ4qAb6l6pbCEjAuXSDlx9p6YL82CAaQ/Kr
	 Kio/L8zIzBzuwVknxZ3lBOdk5Yyoz8AqTpjtUibsTv+9RE8EdZ6FfqEzN7iSGC0Y2k
	 OLhqr9DGiCHOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-8-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:26:02 +0000
Message-Id: <20260630112603.8BF051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Uninitialized config_sz in vfio_ap_config breaks migration dat=
a restoration on target
- [Critical] Concurrent read() calls race on lockless f_pos updates causing=
 Out-of-Bounds kernel read
- [High] Dynamic state re-generation on chunked read() causes data stream c=
orruption
- [High] Lockless release of migration file causes Use-After-Free of mig_da=
ta
- [Medium] Inverted logic for handling async hardware errors in get_hardwar=
e_info_for_queue
--

commit 41fe322bf22b6ffa832bc302520c59909d8f5cca
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This commit implements the read callback for the vfio-ap device's stop-copy
migration file. It reads hardware queue states and exposes them to userspace
for transfer to the destination host during migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 76e06abe5a9e9..5ef7127b697a5 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -65,13 +65,6 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migratio=
n_data *mig_data)
>  		mig_data->stop_copy_mig_file =3D NULL;
>  }
> =20
> -static ssize_t
> -vfio_ap_stop_copy_read(struct file *, char __user *, size_t, loff_t *)
> -{
> -	/* TODO */
> -	return -EOPNOTSUPP;
> -}
> -
>  static int vfio_ap_release_mig_file(struct inode *file_inode, struct fil=
e *filp)
>  {
>  	struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;

[Severity: High]
Can this lockless release cause a use-after-free of mig_data?

In vfio_ap_release_mig_file(), matrix_mdev->mig_data is checked and then
dereferenced locklessly. Concurrently, if the device fd is closed,
vfio_ap_release_migration_data() frees matrix_mdev->mig_data and sets it to
NULL.

If a user closes the device fd while simultaneously closing the migration f=
d,
could this read a non-NULL pointer that is subsequently freed before being
dereferenced?

> @@ -87,6 +80,215 @@ static int vfio_ap_release_mig_file(struct inode *fil=
e_inode, struct file *filp)
>  	return 0;
>  }
> =20

[ ... ]

> +static int get_hardware_info_for_queue(struct ap_matrix_mdev *matrix_mde=
v,
> +				       struct ap_tapq_hwinfo *hwinfo,
> +				       unsigned long apqn)
> +{
> +	struct ap_queue_status status;
> +
> +	status =3D ap_tapq(apqn, hwinfo);
> +
> +	switch (status.response_code) {
> +	case AP_RESPONSE_NORMAL:
> +	case AP_RESPONSE_RESET_IN_PROGRESS:
> +	case AP_RESPONSE_DECONFIGURED:
> +	case AP_RESPONSE_CHECKSTOPPED:
> +	case AP_RESPONSE_BUSY:
> +		/* For all these RCs the tapq info should be available */
> +		return 0;
> +	case AP_RESPONSE_Q_NOT_AVAIL:
> +		dev_err(matrix_mdev->vdev.dev,
> +			"migration failed: Failed to get hwinfo for queue %02lx.%04lx on targ=
et host: TAPQ rc=3D%d",
> +			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
> +		return -ENODEV;
> +	default:
> +		/* On a pending async error the tapq info should be available */
> +		if (!status.async)
> +			return 0;

[Severity: Medium]
Is this logic inverted?

If there is no pending async error (!status.async), this returns 0 for an
unknown response code. However, it returns -EIO if there is an async error.=
=20

The comment suggests the info should be available on a pending async error.

Should this check be if (status.async) instead?

> +
> +		dev_err(matrix_mdev->vdev.dev,
> +			"Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=3D%d",
> +			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
> +		return -EIO;
> +	}
> +
> +	return -EINVAL;
> +}

[ ... ]

> +static int
> +vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev,
> +		   struct vfio_ap_config **ap_config, size_t *ap_config_size)
> +{
> +	struct vfio_ap_config *ap_configuration;
> +	int num_queues, ret;
> +
> +	*ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);
> +
> +	ap_configuration =3D kzalloc(*ap_config_size, GFP_KERNEL_ACCOUNT);
> +	if (!ap_configuration)
> +		return -ENOMEM;
> +
> +	ap_configuration->num_queues =3D num_queues;

[Severity: Critical]
Does this code fail to initialize ap_configuration->config_sz?

The target host receives this structure and relies on config_sz during
reallocate_ap_config(). If config_sz is 0, the check:

    if (cur_cfg_sz >=3D sizeof(struct vfio_ap_config))

falls through to:

    new_cfg_sz =3D cur_cfg_sz + len; // evaluates to (0 + len)

This might cause the configuration buffer to be incorrectly reallocated to
just len bytes, stripping the previously allocated space.

Will this lead to memory corruption when writing subsequent queue data?

> +
> +	ret =3D vfio_ap_store_queue_info(matrix_mdev, ap_configuration);
> +	if (ret) {
> +		kfree(ap_configuration);
> +		return ret;
> +	}
> +
> +	*ap_config =3D ap_configuration;
> +
> +	return 0;
> +}
> +
> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	size_t ret =3D 0, ap_config_size;
> +	struct vfio_ap_config *ap_config;
> +
> +	/*
> +	 * When userspace calls read() with an explicit offset (pread), pos is
> +	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
> +	 * normal read() calls, pos is NULL, so we'll use the file's internal
> +	 * position filp->f_pos
> +	 */
> +	if (pos)
> +		return -ESPIPE;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	pos =3D &filp->f_pos;
> +
> +	ret =3D validate_stop_copy_read_parms(filp, pos, len);
> +	if (ret) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ret;
> +	}
> +
> +	matrix_mdev =3D filp->private_data;
> +
> +	ret =3D vfio_ap_get_config(matrix_mdev, &ap_config, &ap_config_size);

[Severity: High]
Does this dynamically regenerate the entire device state on every read() ca=
ll?

If userspace reads the data in smaller chunks (e.g., 4KB at a time), the
hardware state is re-fetched and re-allocated from scratch for every chunk.

If a queue's state or the number of queues changes on the host between
chunk reads, the generated size and data will shift.=20

Could this result in torn structures, truncated streams, or duplicated data?

> +	if (ret) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If the position exceeds the size of the AP configuration data,
> +	 * then indicate EOF; otherwise calculate the length of the data to
> +	 * read such that a buffer overrun is prevented.
> +	 */
> +	if (*pos >=3D ap_config_size)
> +		len =3D 0;
> +	else
> +		len =3D min_t(size_t, ap_config_size - *pos, len);
> +
> +	/* If we've reached an EOF condition, let the caller know */
> +	if (len =3D=3D 0) {
> +		kfree(ap_config);
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return 0;
> +	}
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, (char *)ap_config + *pos, len)) {

[Severity: Critical]
Can concurrent read() calls race here and cause an out-of-bounds kernel
memory read?

Since this file descriptor uses FMODE_STREAM, vfs_read() bypasses f_pos_loc=
k.
The mutex is dropped just before copy_to_user(), which directly dereferences
*pos.

If Thread A and Thread B read concurrently:

Thread A evaluates len and drops the lock.
Thread B evaluates len and drops the lock.
Thread A completes copy_to_user() and updates *pos +=3D len.

Thread B would then evaluate (char *)ap_config + *pos using Thread A's
updated *pos.=20

Could Thread B end up reading len bytes from beyond the end of the
ap_config kernel buffer?

> +		kfree(ap_config);
> +		return -EFAULT;
> +	}
> +
> +	kfree(ap_config);
> +	*pos +=3D len;
> +	return len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D7
