Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636312;
	b=gSo2bYWh0xTGKL2afVS+7DZgKCNEwvHnL8czu5qZPc3EqI+XrXGLz0lcZtlSNsoLLrzl
	 afzaX5IfGZqhGq83pN9+V+cp/X6tgXri7WWnUZPRrJNK9cpP90AJoV3AruLpm9D0j77DQ
	 WGfVizer5Se88xC86W1cvS8n6AbMtLcAe226MZvxS9V9TqEKPJgjrrHrmm1NyY2X5TwkC
	 wcISaIDcrFCUWsDASwDJ2FPkezz+4NsBHJjJmvW2g+Eo3TLsIaocS60jtRoP4cq3AbpGx
	 9Pgxq6L9f95pW05EbsZx3l6Eve0pv9f0QLPdcmPDgFv9jz1dCbiPgvnlThLrSQoiPZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P2LNDzn0MJNW6K7sLutgY5lEnudmvSdx/LGIN+Bsfzg=;
	b=uOBip273w72uB7zqgMaZCyaN9m/DOuC93RgZbPYlkcHqduJaaghsmlaTN800WJ09Ob+v
	 zvMAvOCbdZ2J3OIX45PBgHzKT5aZX4zn9fGZ46UPFSiDoZ6PYfbQRjWTmZ2l7wLW60Zw+
	 v8E24LzZJ9q5BWcc9duWU9sdtg8/ufrnDt1E9QKCsoNfaFrvYHoBsWAgPqIftRN1ktX41
	 VzrOybJsY3T9zbTJR5Gw0fIDSfmToSOEFn5q4ix8r3ScYt+MdI8Zs2sVc5s/tUfwaRY7F
	 xZtAfF3P0Y9SFfsXcdY6/7xk8rnCfxMEoECmzDeNZsSMjjIhfd3sj6ZVLqc0Q1vOUdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD6+fTE9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0336083616;
	Mon,  2 Nov 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD6+fTE9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03A61F00A16;
	Mon,  2 Nov 2026 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636311;
	bh=P2LNDzn0MJNW6K7sLutgY5lEnudmvSdx/LGIN+Bsfzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KD6+fTE93CAzykm41UKobnXoMv8Rs5pVqpqdzj0cjzwUrF6fqTBSGlSA6aHKqovJU
	 uUHR3wrPp18rssQiZv3M7bZairhBykbyaek+/u6U2dk5D7WDx8FuKJ1+ITNFnHBBP+
	 Xd2f4Uuz5KRgFTXcVwAeZ2+0StEhNR7GCBFy37K/WpDwQqCYCroKS2XMOz5Jz3wqoc
	 gql1q18wzkVVMIruIVVFAnu0wVt6mkAhMHQv7UwCiS2Bidp1EreTETvm27YP2Rskbd
	 qDnpNalqt6lBamC+BbR/+BVVoJrHYrhAHjaxH7CuDGIJKoJqQUkWC6pKfrZ6j7IoYm
	 73p/QK4ZElTwg==
Message-ID: <sashiko-outbox-193746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/14] s390/vfio-ap: Transition guest migration
 state from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-7-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:18:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] s390/vfio-ap: use-after-free in vfio_ap_release_mig_file() aft=
er device close
- [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_release_mi=
g_file()
--

commit d4f19cfbfd83130bd2529cc5a305e86f834b23bb
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY

This commit implements the migration state transition from
VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_STOP_COPY by opening an
anonymous file stream for reading the guest's AP configuration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 8e4e04e039658..48028b12b26f9 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -143,6 +144,62 @@ static void vfio_ap_release_resuming_file(struct vfi=
o_ap_migration_data *mig_dat
>  	mig_data->resuming_mig_data_complete =3D false;
>  }
> =20
> +static ssize_t
> +vfio_ap_stop_copy_read(struct file *filp, char __user *buf, size_t len,
> +		       loff_t *pos)
> +{
> +	/* TODO */
> +	return -EOPNOTSUPP;
> +}
> +
> +static int vfio_ap_release_mig_file(struct inode *file_inode, struct fil=
e *filp)
> +{
> +	struct vfio_ap_migration_file *mig_file =3D filp->private_data;
> +
> +	/*
> +	 * The mig_file (and by extension mig_file->matrix_mdev) is tied to
> +	 * migration FD lifetime (see vfio_ap_open_file_stream() function) to
> +	 * guarantee that the matrix_mdev remains valid for every read/write
> +	 * operation. Let's drop it here since the migration FD is being
> +	 * released.
> +	 */
> +	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
> +	return 0;
> +}
> +
> +static const struct file_operations vfio_ap_stop_copy_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.read =3D vfio_ap_stop_copy_read,
> +	.release =3D vfio_ap_release_mig_file,
> +};
> +
> +static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_fi=
le *mig_file,
> +					     const struct file_operations *fops,
> +					     int flags)
> +{
> +	struct file *filp;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	/*
> +	 * Pin the vfio_device registration so that matrix_mdev cannot be freed
> +	 * while the migration FD is still open. The matching put is in
> +	 * vfio_ap_release_mig_file().
> +	 */
> +	if (!vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev))
> +		return ERR_PTR(-ENODEV);
> +
> +	filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, mig_file, flags);
> +	if (IS_ERR(filp)) {
> +		vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
> +		return filp;
> +	}
> +
> +	stream_open(filp->f_inode, filp);
> +
> +	return filp;
> +}
> +
>  static struct file *
>  vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>  			    enum vfio_device_mig_state new_state)
> @@ -156,10 +213,23 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *=
matrix_mdev,
>  	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
>  		new_state);
> =20
> +	/*
> +	 * Begins the process of saving the vfio device state by creating and
> +	 * returning a streaming data_fd to be used to read out the internal
> +	 * state of the vfio-ap device on the source host.
> +	 */
>  	if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
>  	    new_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		struct vfio_ap_migration_file *mig_file =3D &mig_data->stop_copy_mig_f=
ile;
> +		struct file *filp =3D vfio_ap_open_file_stream(mig_file,
> +							     &vfio_ap_stop_copy_fops,
> +							     O_RDONLY);
> +		if (IS_ERR(filp))
> +			return ERR_CAST(filp);
> +
> +		mig_file->filp =3D filp;
> +
> +		return filp;
>  	}

[Severity: Critical]
Can this trigger a use-after-free of mig_file in vfio_ap_release_mig_file()
(and in vfio_ap_stop_copy_read() in the subsequent patch) if the VFIO device
file descriptor is closed while the migration stream file descriptor remains
open?

In vfio_ap_transition_to_state(), mig_file points to
&mig_data->stop_copy_mig_file, which is embedded inside struct
vfio_ap_migration_data:

struct vfio_ap_migration_data {
	enum vfio_device_mig_state	mig_state;
	bool				resuming_mig_data_complete;
	struct vfio_ap_migration_file	resuming_mig_file;
	struct vfio_ap_migration_file	stop_copy_mig_file;
};

vfio_ap_open_file_stream() stores mig_file in filp->private_data and calls
vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev). However,
vfio_device_try_get_registration() only pins struct vfio_device (and thus
matrix_mdev) against unregistration; it does not prevent vfio_df_close()
from invoking vfio_ap_mdev_close_device() when the VFIO device FD is closed
(which also happens during normal process exit when close_files() closes the
lower-numbered VFIO device FD before the higher-numbered migration data FD).

When the VFIO device FD is closed, vfio_ap_mdev_close_device() calls
vfio_ap_release_migration_data(), which destroys stop_copy_mig_file.lock and
frees matrix_mdev->mig_data:

void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
{
	...
	vfio_ap_release_mig_files(matrix_mdev);
	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
}

When the migration stream FD is subsequently closed (or read),
vfio_ap_release_mig_file() retrieves mig_file from filp->private_data and
dereferences mig_file->matrix_mdev from the freed mig_data allocation (and
if the VFIO device was reopened in the meantime, a new mig_data is allocated
while the old migration FD still points to the freed mig_data instance).

Should filp->private_data point to matrix_mdev (or should mig_file/mig_data
lifetime be tied to the open migration FDs) so that releasing or reading the
migration FD does not dereference freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D6
