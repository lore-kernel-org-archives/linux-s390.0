Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643569;
	b=mhSGZXwXSDjepFljZSSAFxXSTMs/OABjwr71S9TpzTEkQVhz6QGKgv9hSlgMKdL/r6DV
	 ywH1kzHfYwrU+aSEQUfQjqcIcLbYYjq4hzPIN+euOXMcfJkaB4Mnpjg36sF8wHV+xgrlF
	 SF8qZFy/+EcrzsnU+H6nSvUMbm2zqaqoJ/z3iPLwlF4+NV1wjBHpdgE86nwaYQhzbWK3k
	 WVKyf7tvNXLyWL2erCvFiWbbdDvg7AlKk+dg2pMXZ4epNuxgYIovdSli2JbJp2gg7Nele
	 1AeEZhF8t/dHM6hONkCsJpPYIErpp8nZDXLTYGvdgBJozxNctrvKgRL16KF2FoAjlpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZ/0QkKqbQDrL6gDZD1igN44tGnGYCJvCg5zZ6xZA1s=;
	b=dSmOSUBPnNcYePjFvcd+L1ifk+sHM2CNNewhZO5kIXnbXqEIqvTqoCo1QVffL5s1vo96
	 SzXW95LvO4cVvjOih6mkFKme4Hyq2sRTNNB9N+J/B3F7cldd5Q28/SiN5DqOu28qev81y
	 XI6aOwQzVSBlJ+ziJfrxh1y8amaoqWxPz0Thre3WyrThlsa/w4sov7BajwV4kT8YSNRqB
	 zslQHNzafRRcqc3Ami9fuVm23q8K9xexI0KEVquMGI8kSvctn1PSp/AvwFEHSehlhet59
	 DoWdno22ZAV2nBfAp2LrZpohwT0bAIAAwGOILlIEeoe56+owoHXnFG3mYSBTxcaZLCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K35/EQNs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C956606D804;
	Mon,  2 Nov 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K35/EQNs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492921F00A18;
	Mon,  2 Nov 2026 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643568;
	bh=ZZ/0QkKqbQDrL6gDZD1igN44tGnGYCJvCg5zZ6xZA1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K35/EQNseL3QXNnJVA2m5fsdywTG8ROKkraLR0FBxyKsWICbEFLxx1Z9LfCAc2RXx
	 1w8RfHysO9C/bPSMyzUSGh2sdqRFJmP7feOKt2vzZV+7jIG2QEf0nhN+ikETJacWNu
	 rzRZ6KAzsIeUkjGXYAMw/lyWA81f7GLGeB35wSwG9aH8ma5RpF3g5JEracrxBupWfL
	 P0Ig8re1hZhDZAEDE0aQ2wH77oTGZaO6MF+nCIJkJBruSB2ZRlA9TXULlzf4bzQZE0
	 lCW/lHpHx3gClEE5vCGhgRzvVMDqMnkUcvQ/m2fWomO/56MsoEnhL3q+96Ok+IuD3Z
	 YzwR8BOW2S+yA==
Message-ID: <sashiko-outbox-193924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/14] s390/vfio-ap: Add live guest migration
 chapter to vfio-ap.rst
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-15-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:19:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] s390/vfio-ap: use-after-free of mig_file when device FD closes=
 before migration FD
- [Low] s390/vfio-ap: pointer signedness mismatch in vfio_ap_get_data_size()
- [Low] s390/vfio-ap: stray comment fix in vfio_ap_mdev_probe() in document=
ation commit
--

commit 678cd90abd6549f06a0dbfc0140b0ae844762cfe
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add live guest migration chapter to vfio-ap.rst

This series implements VFIO live guest migration support for the s390
vfio-ap mediated device driver and documents the migration requirements and
setup in Documentation/arch/s390/vfio-ap.rst.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> index 0000000000000..57cfaafec4d97
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +static size_t vfio_ap_config_size(struct ap_matrix_mdev *matrix_mdev,
> +				  unsigned int *num_queues)
> +{
> +	size_t qinfo_size;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	*num_queues =3D vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
> +	qinfo_size =3D *num_queues * sizeof(struct vfio_ap_queue_info);
> +
> +	return qinfo_size + sizeof(struct vfio_ap_config);
> +}

[ ... ]

> +static int vfio_ap_get_data_size(struct vfio_device *vdev,
> +				 unsigned long *stop_copy_length)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	int num_queues;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	*stop_copy_length =3D vfio_ap_config_size(matrix_mdev, &num_queues);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return 0;
> +}

[Severity: Low]
Does passing &num_queues here trigger a -Wpointer-sign compiler warning?

In vfio_ap_get_data_size(), num_queues is declared as int, whereas
vfio_ap_config_size() takes unsigned int *num_queues. Should num_queues in
vfio_ap_get_data_size() be declared as unsigned int to match
vfio_ap_get_config()?

[ ... ]

> +static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	mig_data =3D matrix_mdev->mig_data;
> +	vfio_ap_release_stop_copy_file(mig_data);
> +	vfio_ap_release_resuming_file(mig_data);
> +}
> +
> +/**
> + * vfio_ap_release_migration_data: reclaim private migration data
> + *
> + * @matrix_mdev: pointer to the object containing the state of the mdev
> + */
> +void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	if (!matrix_mdev->mig_data)
> +		return;
> +
> +	vfio_ap_release_mig_files(matrix_mdev);
> +	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
> +	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
> +	kfree(matrix_mdev->mig_data);
> +	matrix_mdev->mig_data =3D NULL;
> +}

[Severity: Critical]
Can closing the VFIO device file descriptor before an open migration file
descriptor cause a use-after-free on mig_file?

When vfio_ap_open_file_stream() creates a migration file descriptor, it pins
matrix_mdev->vdev via vfio_device_try_get_registration() and sets
filp->private_data to &mig_data->stop_copy_mig_file or
&mig_data->resuming_mig_file, which are embedded directly inside
struct vfio_ap_migration_data:

struct vfio_ap_migration_data {
	enum vfio_device_mig_state	mig_state;
	bool				resuming_mig_data_complete;
	struct vfio_ap_migration_file	resuming_mig_file;
	struct vfio_ap_migration_file	stop_copy_mig_file;
};

However, when the VFIO device file descriptor is closed,
vfio_ap_mdev_close_device() calls vfio_ap_release_migration_data(), which
destroys stop_copy_mig_file.lock and resuming_mig_file.lock and frees
matrix_mdev->mig_data with kfree() even if the migration file descriptor is
still open in userspace.

Although the vfio_device registration reference keeps matrix_mdev alive,
filp->private_data (mig_file) points into the freed matrix_mdev->mig_data
allocation:

1. When the migration file descriptor is later closed,
   vfio_ap_release_mig_file() dereferences mig_file->matrix_mdev from freed
   memory:

   static int vfio_ap_release_mig_file(struct inode *file_inode,
                                       struct file *filp)
   {
           struct vfio_ap_migration_file *mig_file =3D filp->private_data;
           ...
           vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
           return 0;
   }

2. If userspace calls read() or write() on the migration file descriptor
   after or concurrently with vfio_ap_mdev_close_device(),
   vfio_ap_stop_copy_read() and vfio_ap_resuming_write() call
   mutex_lock(&mig_file->lock) on a destroyed mutex in freed memory and
   dereference mig_file->filp and mig_file->matrix_mdev in
   validate_stop_copy_read_parms() and validate_resuming_write_parms().

3. If vfio_ap_stop_copy_read() drops matrix_dev->mdevs_lock while copying to
   userspace (or if read()/write() is waiting on ap_attr_mutex or
   matrix_dev->mdevs_lock after acquiring mig_file->lock), a concurrent
   vfio_ap_mdev_close_device() will destroy mig_file->lock while it is held
   and free mig_data before the reader or writer unlocks mig_file->lock.

Would embedding or lifetime-tying the migration state to struct ap_matrix_m=
dev
(freed in vfio_ap_mdev_release_dev() after all registration references drop)
avoid freeing mig_file while a migration file descriptor is still open?

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 969e7c6dacc18..94c524e952f79 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -816,7 +816,7 @@ static int vfio_ap_mdev_probe(struct mdev_device *mde=
v)
>  		return PTR_ERR(matrix_mdev);
> =20
>  	/*
> -	 * Wet up vfio-ap device migration before calling
> +	 * Setting up for vfio device migration must be done before calling
>  	 * vfio_register_emulated_iommu_dev; otherwise, the VFIO core
>  	 * will see mig_ops as NULL during the registration. This could
>  	 * prevent the VFIO core from properly setting up migration

[Severity: Low]
This isn't a bug, but should this comment fix in vfio_ap_mdev_probe() be
squashed into earlier commit 8f5bd5cbf795 ("s390/vfio-ap: Set up for vfio-ap
device migration") where the comment was introduced, rather than included in
the documentation commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D14
