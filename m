Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642252;
	b=ZqhPhFj3NScCoiCOT7Dw1NDwVaGAz8FxR709FpA3tt/Te9LI69CknVLpmAuwXs6QW0gQ
	 W5TOpf0+nwtqSSQWOBab18i+jX8oKCNKNrhoR3iX4eXumJloEvMMBE/rXMhDi3UaDfFed
	 bbGRhPCwhv6ZMzv4HNeuxgbwQyVV/16IIOC9TLIBLrSW9m6Ji9DqTejqQHFg8i0j+RaOY
	 uq4UbZRFcnWFLRTFiEdcb7yrWFMjpjp3SjHl1qOsXLTYqrx8zCWxMVPIzx4DTNv0qsQt4
	 v3IU7OeHayKv5LS2pG1t9xFWiFxaBfFQsNybd3iKJWyG0BA6QEPEwswtVq20A1G4YzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G7I040ofB4XjWpmjfyg+NPMbXtFY2nOQvFDXAjxGsNY=;
	b=bfTdGpM2ZlR39OBHvojEZU/8MCeLqfeRw1njmdsTEe+YyuzYkUPGjWdNAqX9DcK35C1D
	 Ca6gaSVQz+koPxcPpKdlOF7Ro4Iyu0m2YNrLk32O7EIsbvc6FvIjaC9A9ySk39OJOvZLg
	 PxUAAdm2+PWLjc06aMXix0vtr4/gPEtNj2oOGVOsWwAzE1Bj0KX2zhu5LQ4nKcaFJFF8S
	 1JS56scb5ZNw+BFgcamsvYXh4fnNn+RlWgCfIei/oFiGIVBfSaw8n6KbdKdHgF4LwDCEl
	 2RVjk584vc4zUIxgj1fbJW+oIKOIhNcAkWWUIKEZIJbOC6tCZEnzbdsZXk8eyvWQr7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCb9Y9GV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74960716E1;
	Mon,  2 Nov 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dCb9Y9GV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983391F00A21;
	Mon,  2 Nov 2026 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642252;
	bh=G7I040ofB4XjWpmjfyg+NPMbXtFY2nOQvFDXAjxGsNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCb9Y9GVa4E3rLkioXKpfvc/9XxIJbXYCwA6ngqaEwAmOmvCwf1yMXUVuVvGxWlwC
	 WWEP41S5OD7JqJAQm3D9pkrNOtEw4UJnGXVLL3g7oGD/i51l62AanBO503r/NFsEWk
	 E/MWeaj9k5P6rNz0KGi8QynIj6K9R2emtl3r61pfLasIwU8CJDmtMb6M7TbAKixNFC
	 3P11EPRVZCNLyDaL+367cyMrOZcY/8ci4tOXcQUkOK/FH7yUZWsEf+zHplXgCPZZx+
	 y4uOs/CqWgFjEgj9jBN31LSqguEv/2NpbtX1hPZewM03pauVsb97TjwRYGw6dda8nc
	 9fJ4H42ONTSjQ==
Message-ID: <sashiko-outbox-193886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/14] s390/vfio-ap: Set up for vfio-ap device
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-13-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:57:31 +0000
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
- [Critical] s390/vfio-ap: use-after-free of mig_file in vfio_ap_release_mi=
g_file()
- [High] s390/vfio-ap: fortify_panic() on chunked writes in vfio_ap_resumin=
g_write()
--

commit 8f5bd5cbf7956f3cc86d039dd21c5869a7e36482
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Set up for vfio-ap device migration

This commit plugs in the vfio_migration_ops callbacks and sets the
VFIO_MIGRATION_STOP_COPY migration flag during vfio-ap mediated device probe
when not running in an SE guest.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 7c282d396f502..57cfaafec4d97 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -217,6 +217,30 @@ static int vfio_ap_release_mig_file(struct inode *fi=
le_inode, struct file *filp)
>  	return 0;
>  }
> =20
> +static const struct vfio_migration_ops vfio_ap_migration_ops;
> +
> +/**
> + * vfio_ap_setup_vfio_device_migration:
> + *
> + * Plug the object containing the function pointers to the migration cal=
lbacks
> + * used to facilitate migration into the vfio device and set the flags
> + * indicating migration states STOP, STOP_COPY and RESUMING are supporte=
d.
> + *
> + * @matrix_mdev: pointer to object containing the vfio device (vdev)
> + */
> +void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_m=
dev)
> +{
> +	/*
> +	 * Live guest migration is not supported for SE guests, so there is no
> +	 * need to initialize the migration capabilities.
> +	 */
> +	if (ap_is_se_guest())
> +		return;
> +
> +	matrix_mdev->vdev.migration_flags =3D VFIO_MIGRATION_STOP_COPY;
> +	matrix_mdev->vdev.mig_ops =3D &vfio_ap_migration_ops;
> +}

[Severity: Critical]
As reported by Sashiko on v5 [1], now that vfio_ap_migration_ops is wired u=
p,
can closing the VFIO device file descriptor while a migration file descript=
or
remains open trigger a use-after-free of matrix_mdev->mig_data and its
embedded mig_file structs?

In drivers/s390/crypto/vfio_ap_migration.c, resuming_mig_file and
stop_copy_mig_file are embedded inside the heap-allocated struct
vfio_ap_migration_data (matrix_mdev->mig_data) rather than inside struct
ap_matrix_mdev:

struct vfio_ap_migration_data {
	enum vfio_device_mig_state	mig_state;
	bool				resuming_mig_data_complete;
	struct vfio_ap_migration_file	resuming_mig_file;
	struct vfio_ap_migration_file	stop_copy_mig_file;
};

When transitioning to VFIO_DEVICE_STATE_STOP_COPY or
VFIO_DEVICE_STATE_RESUMING, vfio_ap_open_file_stream() takes a registration
reference via vfio_device_try_get_registration(&mig_file->matrix_mdev->vdev)
and sets filp->private_data to mig_file. That registration reference keeps
struct ap_matrix_mdev alive, but it does not prevent the VFIO device FD from
being closed.

If the VFIO device FD is closed before the migration FD (for example, by
userspace or during process exit when close_files() closes a lower-numbered
VFIO device FD before a higher-numbered migration FD),
vfio_ap_mdev_close_device() -> vfio_ap_release_migration_data() destroys the
mig_file mutexes and frees matrix_mdev->mig_data:

void vfio_ap_release_migration_data(struct ap_matrix_mdev *matrix_mdev)
{
	lockdep_assert_held(&matrix_dev->mdevs_lock);

	if (!matrix_mdev->mig_data)
		return;

	vfio_ap_release_mig_files(matrix_mdev);
	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
}

Once matrix_mdev->mig_data is freed while the migration FD is still open:

1. Closing the migration FD afterwards invokes vfio_ap_release_mig_file(),
   which dereferences mig_file->matrix_mdev in freed memory:

static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *=
filp)
{
	struct vfio_ap_migration_file *mig_file =3D filp->private_data;

	vfio_device_put_registration(&mig_file->matrix_mdev->vdev);
	return 0;
}

2. Any subsequent or concurrent vfio_ap_stop_copy_read() or
   vfio_ap_resuming_write() on the open migration FD accesses
   filp->private_data (mig_file) and locks or unlocks mig_file->lock after
   mig_data has been destroyed and freed (or while vfio_ap_stop_copy_read()
   holds mig_file->lock across copy_to_user() after dropping
   matrix_dev->mdevs_lock).

[Severity: High]
With vfio_ap_migration_ops exposed to userspace, can chunked writes to the
RESUMING migration file descriptor trigger a fortify_panic() in
vfio_ap_resuming_write() under CONFIG_FORTIFY_SOURCE?

In drivers/s390/crypto/vfio_ap_migration.c, struct vfio_ap_config annotates
its flexible array member with __counted_by(num_queues):

struct vfio_ap_config {
	u32				magic;
	u32				version;
	u32				num_queues;
	u8				reserved[4];
	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
};

Although vfio_ap_resuming_init() initializes ap_config->num_queues to
MAX_AP_QUEUES when allocating the VFIO_AP_CONFIG_MAX_SIZE buffer,
vfio_ap_resuming_write() copies each incoming chunk directly into ap_config
before validating expected_sz:

	ap_config =3D mig_file->ap_config;
	memcpy((char *)ap_config + *pos, kbuf, len);
	*pos +=3D len;

	if (*pos >=3D offsetofend(struct vfio_ap_config, num_queues)) {
		size_t expected_sz;

		if (ap_config->num_queues > MAX_AP_QUEUES) {
			ret =3D -EINVAL;
			goto out_unlock;
		}

		expected_sz =3D sizeof(struct vfio_ap_config) +
			      ap_config->num_queues *
			      sizeof(struct vfio_ap_queue_info);

		if (*pos > (loff_t)expected_sz) {
			ret =3D -EINVAL;
			goto out_unlock;
		}

When CONFIG_FORTIFY_SOURCE is enabled, memcpy((char *)ap_config + *pos, kbu=
f,
len) evaluates __builtin_dynamic_object_size() using the current in-memory
value of ap_config->num_queues before copying:

1. If an earlier write chunk sets ap_config->num_queues to a smaller value N
   (where N < MAX_AP_QUEUES) and a subsequent write chunk writes past
   expected_sz (while still within VFIO_AP_CONFIG_MAX_SIZE), the fortified
   memcpy() sees the smaller object size derived from ap_config->num_queues=
 =3D=3D
   N and calls fortify_panic() before reaching the *pos > expected_sz check.

2. Because s390x is big-endian, MAX_AP_QUEUES (0x00010000) has bytes
   {0x00, 0x01, 0x00, 0x00} at offsets 8..11. For any valid migration stream
   with num_queues < 65536 (where the upper two bytes are 0x00, 0x00), if a
   chunked write splits across the num_queues field after its second or thi=
rd
   byte, ap_config->num_queues in memory temporarily becomes 0. If the next
   write chunk copies the rest of the header and any queue info entries, the
   fortified memcpy() evaluates ap_config->num_queues =3D=3D 0 before copyi=
ng the
   remaining bytes of num_queues and triggers fortify_panic().

[1] https://lore.kernel.org/r/20260724182949.EA9C51F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D12
