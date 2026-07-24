Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD32E7F2C;
	Fri, 24 Jul 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916263; cv=none; b=j8YEXnUpRuUstsKms/JhVveHdrr3g9kr/D3BdU6RK2DC55hTDldS25p2dgOT3OPoG4WcY/nI8shl3p8UJ0Ycxk0c7bxLYT5pkUtoZesCSWN2DjC8w3oMqv8Kxmx68l4yWQNl3naQ/Bu+5IWp8wQc9KYGSMLNtofx0J6zT98emSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916263; c=relaxed/simple;
	bh=tNKy034eXrfjMAxDoUvqmiAVt+qchZfcHJT9FEWKMHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2dFIep2KYPvzNnAQrMP7fk/t1+izHNRze50PcD5h3J5DTbnRyMJ12/AfBj69wKqkfrjPP++/RAhNSTSYODZi+Y3zl9RpZBwPQZEP7XtoGVS3CUvIv4USMfzZ4hLxgrqpLpbiod/ufOV0zglHjUlYhoS2G63C4GM0Q0qfXkLMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsXr2JvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsXr2JvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE871F000E9;
	Fri, 24 Jul 2026 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916261;
	bh=Gf4HjSkEaAllJVwuMguuWlWa847XAxfB918FF91mHmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsXr2JvCgScqhXkzbG1zOC2EoGBUxafRsMhnaLDI1my0vQSVh99+8RjV23ZjmSmMP
	 UZ861lN7e3qhhNiyMO7QwgMu8x7s6o78dLIdPRHboaMZbV+IomZu0CQ8EiZxaeqr66
	 7QSUZZub6yGw0O9jDXQ3Le8YkEqI+KZTiiBr4zJvugOg10Xbr+7LxZrzfRAHIHVGwL
	 16Zjf82wwTQgjpuP5gQx6bZhRwrwTFT+m0pwg6pS4hMjQjHarxDolyDx8zzok14J8I
	 qRj/Es5/u/UHF19UDL+yi0LQfb4MQlhNhFIt0CYY43ZSy4jyOzYpLuWIqWTnFJsVh3
	 PYM0a99XzkSzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/15] s390/vfio-ap: File ops called to save the vfio
 device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-8-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:04:20 +0000
Message-Id: <20260724180421.2EE871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Concurrent `read()` calls trigger a TOCTOU race condition on unpro=
tected `filp->f_pos`, leading to data corruption and a heap out-of-bounds r=
ead.
- [High] A TOCTOU race condition in `vfio_ap_get_config()` permanently leak=
s the `ap_configuration` buffer during concurrent reads.
- [High] `__counted_by` bounds violation panic due to accessing a flexible =
array before initializing its count.
- [High] Use-After-Free of `matrix_mdev` because the migration file descrip=
tor does not hold a reference to the VFIO device.
- [Medium] Resource exhaustion and high allocation failure probability due =
to order-8 memory allocation on every read chunk.
--

--- Patch [7]: [PATCH v5 07/15] s390/vfio-ap: File ops called to save the v=
fio device migration state ---
commit ea39a12de8ce91ab4c204140075df7f484f9c8f8
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: File ops called to save the vfio device migration st=
ate

This commit implements the read callback for the migration stop-copy state
to transfer the guest's AP configuration and queue information to userspace.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index e566250a88ea3..0d949ec205de6 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static int validate_stop_copy_read_parms(struct file *filp, loff_t *pos,
> +					 size_t len)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	loff_t total_len;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	if (check_add_overflow((loff_t)len, *pos, &total_len))
> +		return -EIO;
> +
> +	matrix_mdev =3D filp->private_data;
> +
> +	if (!matrix_mdev || !matrix_mdev->mig_data)
> +		return -ENODEV;

[Severity: High]
Does the migration file descriptor hold a reference to the VFIO device?

If userspace closes the main VFIO device file descriptor but keeps the
migration file descriptor open, the VFIO core could unregister and free the
vfio_device and the embedding matrix_mdev. A subsequent read() on the
migration file would then dereference the freed matrix_mdev here.

[ ... ]

> +static int
> +vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	unsigned long *apm, *aqm, apid, apqi, num_queues;
> +	struct vfio_ap_config *ap_configuration;
> +	const char *mdev_name;
> +	size_t ap_config_size;
> +	int ret;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	ap_config_size =3D vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
> +
> +	ap_configuration =3D kzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
> +	if (!ap_configuration)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Snapshot the APQN list from shadow_apcb under the lock so that
> +	 * ap_tapq() calls in vfio_ap_store_queue_info() can happen without it.
> +	 */
> +	apm =3D matrix_mdev->shadow_apcb.apm;
> +	aqm =3D matrix_mdev->shadow_apcb.aqm;
> +	num_queues =3D 0;
> +	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
> +		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
> +			ap_configuration->qinfo[num_queues].apqn =3D
> +				AP_MKQID(apid, apqi);
> +			num_queues +=3D 1;
> +		}
> +	}
> +	ap_configuration->num_queues =3D num_queues;

[Severity: High]
Will this trigger a __counted_by bounds check panic?

The struct vfio_ap_config uses __counted_by(num_queues) for the qinfo
flexible array. Since kzalloc() initializes num_queues to 0, writing to
qinfo[num_queues] before assigning ap_configuration->num_queues =3D num_que=
ues
causes compiler-inserted bounds checks to evaluate the access against a
count of 0.

> +	memcpy(ap_configuration->adm, matrix_mdev->shadow_apcb.adm,
> +	       sizeof(ap_configuration->adm));
> +	mdev_name =3D dev_name(matrix_mdev->vdev.dev);
> +
> +	/**
> +	 * Release the global mdevs_lock which guards access to all mdevs.
> +	 * Storing the queue information could take a while if there are a
> +	 * large number of queues.
> +	 */
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	ret =3D vfio_ap_store_queue_info(mdev_name, ap_configuration);
> +	if (ret) {
> +		kfree(ap_configuration);
> +		mutex_lock(&matrix_dev->mdevs_lock);
> +		return ret;
> +	}
> +
> +	/* Retake the mdevs lock so we can safely make updates to the mdev */
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	/*
> +	 * Verify mig_data is still valid - mdevs_lock was dropped, so the
> +	 * device could have been closed concurrently.
> +	 */
> +	if (!matrix_mdev->mig_data) {
> +		kfree(ap_configuration);
> +		return -ENODEV;
> +	}
> +
> +	matrix_mdev->mig_data->stop_copy_mig_file.ap_config =3D ap_configuratio=
n;

[Severity: High]
Does dropping mdevs_lock allow concurrent readers to leak ap_configuration?

In vfio_ap_stop_copy_read(), if stop_copy_mig_file.ap_config is NULL,
it calls this function. Because mdevs_lock is temporarily dropped here for
the hardware query, a concurrent read() could also observe that ap_config is
NULL, enter this function, and allocate a second buffer.

When the lock is reacquired, both threads will sequentially overwrite
stop_copy_mig_file.ap_config, permanently leaking the previous buffer.

[ ... ]

> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_config *ap_config;
> +	ssize_t ret =3D 0;
> +	size_t ap_config_size;

[ ... ]

> +	/*
> +	 * Allocate ap_config and copy the content of the object caching the
> +	 * AP configuration data between calls to it so we can give up the
> +	 * global mdevs_lock while copying the data to userspace.
> +	 */
> +	ap_config =3D kzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);

[Severity: Medium]
Is it safe to allocate up to 1MB using kzalloc() on every read syscall?

ap_config_size can exceed 1MB, requiring a contiguous order-8 allocation.
Requesting this on every read() regardless of the requested chunk length
is likely to fail with -ENOMEM on fragmented systems, breaking migration.
It may also allow userspace to cause memory allocator thrashing by issuing
small, repetitive reads.

> +	if (!ap_config) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(ap_config, matrix_mdev->mig_data->stop_copy_mig_file.ap_config,
> +	       ap_config_size);

[Severity: High]
Will this memcpy() also trigger a __counted_by panic?

Since ap_config was just allocated with kzalloc(), its num_queues field is =
0.
The memcpy() relies on __struct_size(), which will evaluate only to the base
structure size without the flexible array elements, causing a buffer
overflow panic during the copy.

> +
> +	/*
> +	 * Give up the global mdevs_lock while copying data to the user; it
> +	 * might be a long running operation and we don't want to prevent access
> +	 * to other mdevs for an inordinate amount of time.
> +	 */
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
> +		kfree(ap_config);
> +		return -EFAULT;
> +	}
> +
> +	kfree(ap_config);
> +	*pos +=3D len;

[Severity: High]
Can concurrent read() calls cause an out-of-bounds heap read here?

Because the file is opened with FMODE_STREAM, VFS does not serialize reads
with f_pos_lock. The read length is calculated based on *pos under
mdevs_lock, but the lock is dropped before copy_to_user() and the offset
increment (*pos +=3D len).

A concurrent read() can calculate its length based on an outdated *pos,
wait for the lock, and then read from ap_config + *pos after the first
thread has advanced *pos. This would allow reading past the end of the
ap_config buffer, leaking adjacent kernel memory to userspace.

> +
> +	return len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D7
