Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637138;
	b=tq5KCjtd4BDJHxd4rYR9AzapYiubBgPUBIxMnNIAu+IE0Xm+Yrq4Qi/ThfeJaOzI09tq
	 XqYXo3HFXoRJ2uIjkgQaMsLws4ylVgrelHCI2ZuedIJdmSM6rj1z+ZTCBDOWpqq4V+jmH
	 x2VKyt3A5I2gWU3tnmN5KV+Un4EIL8owcodi8hUjr2UBYkTaEMF9zWHd4QpyUlpId2xAW
	 zlNvG19DgkfLeohbft9IZrzezPbLon2hYKgE+4hWYUEybd87y/IbD5wV/SDbwJB8R3ikF
	 FGWjNZFi3N4SsNcpRTfUG9BJCEzrj9KQrwlqqZBt6CmGzlNGiSBsO7OdREA3z3cGJjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637138;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BHtTtcYi04zl9O9bzQ6Ir6M454wMIOiUEHs4hDmq31Q=;
	b=jGSfYPpx/AgFIkAtDs6UHnJgY3+Q/VLu6cwGA1C2RcHidpDk05HspO8G9wii4wXBmq86
	 YPVO5i6Q7Nl4/ZE6zXSEu/Vl0WRiUi+R5sYQUCADDSgmBTRjNphQVfeq6reGIIOwaVicl
	 wS8XhUTotX38LYffMrWR2EB6p1O9y5e5D5+npbxqnzikgNlDEFnqCdTXDAYp5flr4kbau
	 DParjwrg9/V+RWpDylZDb5e6XHsVE2cwng9dU6CW4yB2O0yio2R0sqcOEdFYETZDPwklq
	 pwrIffE00qYBVGJ948fBeQSycvp5PpSO1Ti1KdX2bY2EkV8+n9dWDr308Fkt7wLcTDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKJr2l4P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB36606A931;
	Mon,  2 Nov 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKJr2l4P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC11F00A17;
	Mon,  2 Nov 2026 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637137;
	bh=BHtTtcYi04zl9O9bzQ6Ir6M454wMIOiUEHs4hDmq31Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKJr2l4PA81b2Y85JkPHb/1cQONsqqb+wWp9X1zK8VEdjeWhVHJuE/l2fW1e/5JSm
	 EEifwfj0LvfA6OULLPzkiW7CfNHylYIlMXyJlDCEg7oYY/8henabr1bxbTFFrdvQUp
	 zPMN5KyBqHiR/XqVrTrQGYT5Cd5Ros+5k2YTFEl+9Vqnooy2ft/PWx0t86dTyZjcon
	 s9x3W48SxqcgnyH81mTR7qM83BNXhfKyaCx0IvSkOCyAJ0Uqv3Qgqd3B79RbtpSdyf
	 q1ZMTR9b/6AMYRmUPb5isoAp4x4DymNyvc+ENCwV9VIyj1f4F3mzjqZqZiT+KFtMRj
	 cy7RYx2iWxiiA==
Message-ID: <sashiko-outbox-193752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/14] s390/vfio-ap: File ops called to save the
 vfio device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-8-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:32:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_stop_copy_=
read()
--

commit 6f641fc7194e9bced026956cec2ed8bc278c6d77
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This commit implements the vfio_ap_stop_copy_read() callback for the migrat=
ion
file created when transitioning from STOP to STOP_COPY, snapshotting and
copying the guest's AP configuration and queue hardware information to
userspace.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 48028b12b26f9..b64ce092a41b1 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -167,6 +160,269 @@ static int vfio_ap_release_mig_file(struct inode *f=
ile_inode, struct file *filp)
>  	return 0;
>  }
> =20
> +/**
> + * validate_stop_copy_read_parms: Validate the input parameters to the
> + *                                vfio_ap_stop_copy_read function
> + *
> + * @mig_file:	Pointer to the object used for storing the vfio-ap device =
state
> + * @filp:	File stream to which to write source guest's AP configuration
> + * @len:	The length of the data to be read
> + *
> + * Verify the following:
> + * - @filp is the instance opened when state transitioned from STOP to S=
TOP_COPY
> + * - @filp->f_pos + @len does not cause integer overflow
> + * - @mig_file->matrix_mdev is not NULL
> + * - @mig_file->matrix_mdev->mig_data is not NULL
> + *
> + * Returns: 0 if the parameters pass validation; otherwise returns an er=
ror
> + */
> +static int validate_stop_copy_read_parms(struct vfio_ap_migration_file *=
mig_file,
> +					 struct file *filp,
> +					 size_t len)
> +{
> +	loff_t total_len;
> +
> +	lockdep_assert_held(&mig_file->lock);
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	if (filp !=3D mig_file->filp)
> +		return -EINVAL;
> +
> +	if (check_add_overflow((loff_t)len, filp->f_pos, &total_len))
> +		return -EIO;
> +
> +	if (!mig_file->matrix_mdev || !mig_file->matrix_mdev->mig_data)
> +		return -ENODEV;
> +
> +	return 0;
> +}

[ ... ]

> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
> +	struct vfio_ap_migration_file *mig_file;
> +	void *bounce;
> +	ssize_t ret;
> +
> +	/*
> +	 * This file was opened with stream_open(), so pos should be NULL for
> +	 * sequential read() calls; a non-NULL pointer will be passed only
> +	 * for positional pread() calls in which case we return an error
> +	 * indicating broken pipe/illegal seek on a non-seekable file
> +	 */
> +	if (pos)
> +		return -ESPIPE;
> +
> +	/*
> +	 * mig_file is guaranteed live here: vfio_ap_open_file_stream() took
> +	 * a vfio_device registration reference that is held until
> +	 * vfio_ap_release_mig_file() runs, so the embedding mig_file cannot
> +	 * be freed while this file descriptor is open.
> +	 */
> +	mig_file =3D filp->private_data;
> +	mutex_lock(&mig_file->lock);
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	ret =3D validate_stop_copy_read_parms(mig_file, filp, len);
> +	if (ret) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		mutex_unlock(&mig_file->lock);
> +		return ret;
> +	}

[ ... ]

> +	memcpy(bounce, (char *)mig_file->ap_config + *pos, len);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, bounce, len)) {
> +		kfree(bounce);
> +		mutex_unlock(&mig_file->lock);
> +		return -EFAULT;
> +	}
> +
> +	*pos +=3D len;
> +	mutex_unlock(&mig_file->lock);
> +	kfree(bounce);
> +	return len;
> +}

[Severity: Critical]
As reported by Sashiko on v6 [1], can closing the vfio device file descript=
or
while the migration file descriptor remains open cause a use-after-free of
mig_file in vfio_ap_stop_copy_read() and vfio_ap_release_mig_file()?

The comment in vfio_ap_stop_copy_read() notes that vfio_ap_open_file_stream=
()
takes a vfio_device registration reference via
vfio_device_try_get_registration() until vfio_ap_release_mig_file() runs.
However, that reference only keeps matrix_mdev alive; stop_copy_mig_file is
embedded inside struct vfio_ap_migration_data (matrix_mdev->mig_data), which
is allocated separately in vfio_ap_init_migration_data().

When userspace closes the vfio device file descriptor,
vfio_ap_mdev_close_device() -> vfio_ap_release_migration_data() runs under
matrix_dev->mdevs_lock:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_migration_data() {
	if (!matrix_mdev->mig_data)
		return;

	vfio_ap_release_mig_files(matrix_mdev);
	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
}

Because filp->private_data on the still-open migration file descriptor poin=
ts
to &mig_data->stop_copy_mig_file, freeing matrix_mdev->mig_data frees
mig_file itself:

1. If vfio_ap_stop_copy_read() runs after vfio_ap_mdev_close_device(),
   mig_file =3D filp->private_data points into freed memory.
   mutex_lock(&mig_file->lock) operates on a destroyed mutex in freed slab
   memory, and validate_stop_copy_read_parms() dereferences mig_file->filp =
and
   mig_file->matrix_mdev from freed memory before checking
   !mig_file->matrix_mdev->mig_data.

2. If vfio_ap_stop_copy_read() is already in progress and drops
   matrix_dev->mdevs_lock before copy_to_user() while holding mig_file->lock
   (or is waiting to acquire matrix_dev->mdevs_lock after locking
   mig_file->lock), a concurrent vfio_ap_mdev_close_device() ->
   vfio_ap_release_migration_data() will destroy mig_file->lock while it is
   locked and kfree(matrix_mdev->mig_data), causing the subsequent
   mutex_unlock(&mig_file->lock) in vfio_ap_stop_copy_read() to write to fr=
eed
   memory.

3. When the migration file descriptor is later closed,
   vfio_ap_release_mig_file() dereferences mig_file->matrix_mdev from the
   freed mig_data structure.

[1] https://lore.kernel.org/r/20260727180224.027021F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D7
