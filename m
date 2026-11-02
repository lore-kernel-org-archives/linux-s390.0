Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637747;
	b=QwcJEoC6LlsdhSorlmQD9Z9Q7ljuGko4BohOrrriHIseWqx7tqfRPj1YQi/EiPDUlXi0
	 er6850Yf/sa/BFtBz/sToqPAS4S+s0oxuRZbD+/Goh2LY0rs2YkZ2RZREKEikBe9p7FoB
	 dY735lNoDRjpWVltKw7vWcc9xlDXm4dJOgn+1EkajM2glKTa9BoJxe9RrtUvoHhN7bPNC
	 3pu0o3yCczbmTk8FdB4BtViTfjDQ8m/F9R1AI+gRA2jhVuP6pCWHcHPtBuhNCKtS6msT9
	 4B3MaG+e97gF0/Kb877NjX6VZXiKzfhY72Oum7yeV2GL50uK26O+Lh3xlEtEu0Oi23A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dckK3H+RIDJQcqGJtt0qcxDRO5LIQCgLJ8L7OAGIdhY=;
	b=xvuGSfl/DHG5EIYy2CE1qT6skKXzlhKk1TJLvaXvyu3E1tslvyUwAPMoIhrO7XvJSCX3
	 +tB80FVX3uG2A3ZzhARSVY9hcVmq1hCMQe5YhGXHsciijETPMtvMbhEhfyJAgq4xfrXay
	 GtK93a0kL4G+Rr+jIga9Vkst4fLxjKS25JPwL/0mMarNk4D2Z37wSgFpp58F/hb2Sqlpd
	 IWlpW4EbY6+A1L5Q/4Psm+xD6kwrigA56sY0eDrK5y9O9yF+RUroEl2kXSXAyEsLcHJWR
	 fp+UIvwFeDjbiDv6M6GKMoqc9jzJnhrO9ReoHu4/lzZVtWtPkHHIb9pIP6WiPYNtK2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpiEA1Qn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB560A1DAA;
	Mon,  2 Nov 2026 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpiEA1Qn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A001F00A1D;
	Mon,  2 Nov 2026 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637746;
	bh=dckK3H+RIDJQcqGJtt0qcxDRO5LIQCgLJ8L7OAGIdhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpiEA1QnuLsFEakcXzd9i58CLNZldQO9FS2xOLPCiA6afb7pJ6bZVDcelvYTFLGA0
	 AFtvQWeLxiQDDR11Z8nO8nHHNtSZXhUqBO1MZv7vUN2mN1VCxdLapTrjkZmvQM6t7x
	 9E0UHwPSqLC4z6+ajRyAyqzPx6UaEnQggRGU23I3CD0+z1q+yB1VzcmID9GArYh4Fn
	 OItqkB3OaTXWwoGMeuLDfPl/b9xvfH30qqFNd2qBGWIRyV0QrTAeDQc5DU7gglK2XI
	 6TqedufojRhN7NAZcNf3SuwILkeuI49SxljZFIH2scZwyVbIwYB6btaV+HDcNj45Zy
	 20gQGGqyKiRQw==
Message-ID: <sashiko-outbox-193762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-9-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:42:25 +0000
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
- [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_release_mi=
g_file()
--

commit 8958f5c47ab29cef8a0a38994bae03335dbb5b69
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RESUMING

This commit implements the transition from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_RESUMING in vfio_ap_transition_to_state() by pre-allocati=
ng
the receive buffer for the guest's AP configuration and opening a write-only
anonymous inode file stream for the resuming migration data.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index b64ce092a41b1..526d83e8590d9 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -456,6 +466,67 @@ static struct file *vfio_ap_open_file_stream(struct =
vfio_ap_migration_file *mig_
>  	return filp;
>  }
> =20
> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{
> +	/* TODO */
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct file_operations vfio_ap_resume_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.write =3D vfio_ap_resuming_write,
> +	.release =3D vfio_ap_release_mig_file,
> +};

[ ... ]

> +static struct file *vfio_ap_resuming_init(struct vfio_ap_migration_file =
*mig_file)
> +{
> +	struct vfio_ap_config *ap_config;
> +	struct file *filp;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	ap_config =3D kvzalloc(VFIO_AP_CONFIG_MAX_SIZE, GFP_KERNEL_ACCOUNT);
> +	if (!ap_config)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ap_config->num_queues =3D MAX_AP_QUEUES;
> +
> +	filp =3D vfio_ap_open_file_stream(mig_file, &vfio_ap_resume_fops, O_WRO=
NLY);
> +
> +	if (IS_ERR(filp)) {
> +		kvfree(ap_config);
> +		return filp;
> +	}
> +
> +	mig_file->ap_config =3D ap_config;
> +	mig_file->config_sz =3D VFIO_AP_CONFIG_MAX_SIZE;
> +	mig_file->filp =3D filp;
> +
> +	return filp;
> +}
> +
>  static struct file *
>  vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>  			    enum vfio_device_mig_state new_state)
> @@ -488,10 +559,19 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *=
matrix_mdev,
>  		return filp;
>  	}
> =20
> +	/*
> +	 * Begins the process of restoring the vfio device state by creating and
> +	 * returning a streaming data_fd to be used to read in the internal
> +	 * state of the vfio-ap device on the destination host.
> +	 */
>  	if (cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&
>  	    new_state =3D=3D VFIO_DEVICE_STATE_RESUMING) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		struct file *filp =3D vfio_ap_resuming_init(&mig_data->resuming_mig_fi=
le);
> +
> +		if (IS_ERR(filp))
> +			return ERR_CAST(filp);
> +
> +		return filp;
>  	}

[Severity: Critical]
Can closing the VFIO device file descriptor before the migration stream file
descriptor trigger a use-after-free in vfio_ap_release_mig_file()?

In vfio_ap_transition_to_state(), vfio_ap_resuming_init() passes
&mig_data->resuming_mig_file (and the STOP_COPY path similarly passes
&mig_data->stop_copy_mig_file) to vfio_ap_open_file_stream(), which stores
mig_file in filp->private_data and pins the vfio_device registration:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_open_file_stream() {
	if (!vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev))
		return ERR_PTR(-ENODEV);

	filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, mig_file, flags);
}

Pinning the registration keeps matrix_mdev alive, but resuming_mig_file and
stop_copy_mig_file are embedded in struct vfio_ap_migration_data
(matrix_mdev->mig_data), which is dynamically allocated when the VFIO device
file descriptor is opened and freed when it is closed via
vfio_ap_mdev_close_device() -> vfio_ap_release_migration_data():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_migration_data() {
	if (!matrix_mdev->mig_data)
		return;

	vfio_ap_release_mig_files(matrix_mdev);
	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
}

If the VFIO device file descriptor is closed while the migration stream file
descriptor is still open (for example, if a userspace VMM exits or crashes
during migration and close_files() closes descriptors in ascending order),
matrix_mdev->mig_data is freed while filp->private_data still points into i=
t.

When the migration stream file descriptor is subsequently accessed or close=
d,
vfio_ap_release_mig_file() dereferences mig_file->matrix_mdev from the freed
mig_data allocation:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_mig_file() {
	struct vfio_ap_migration_file *mig_file =3D filp->private_data;
	...
	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
	return 0;
}

And any concurrent or subsequent read/write on that migration file descript=
or
will also lock the destroyed and freed mig_file->lock.

Should mig_data (or the vfio_ap_migration_file structures) be embedded in
struct ap_matrix_mdev or otherwise tied to the lifetime of the open migrati=
on
file descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D8
