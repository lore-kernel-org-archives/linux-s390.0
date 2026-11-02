Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634362;
	b=WDApMpY0L1EGKqFScTErs4/PUarIxAx/4IRgpnB+0Dh5b5tgZBlp0ULPnFs7tZ+8jXOJ
	 f7ADrPjTtbdQQqxEzR6fkZGQ88IlWNYBg9BJP1TygZ4Zhu37UdR7ONU9bMYgyu85bW6L9
	 6ljDTKci0L//yq5V60eNjNi30p5nyaVW5DOeLsqYfnjl821RWyNosqxriZnN3fIDtJta8
	 ivXUQSeqAhVd3PJok4UKf4rfvUz/Nj0C3vnfU/pvbeF9PF2NjgTd+Pl6yWjk0zbeEV0ps
	 F/SX0FPbnb+kXiD4juWmSMYizxz1BdGln+17uD87MYBvYCwllt8j080F2S2lsF9yvxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XcnciT3D7d65PtFeUoZXa7fxLTNaJkc6pdnB1BKXFZQ=;
	b=qGtZdyXp3bsd3+iD//x5bYimsOLC/3DQRWL8x09gZgAoANqjnrWa5RF5W6ztF6Mexbjo
	 t2o268GlwX7frpwEoh0eia7E0W8zoi4HoSjFjSpcgQEJdXn6mO57211+j/bahmCbo5+2M
	 4zXuRBmbBCx053eyZke29LEeSZDBI9Jbj6vhsn/hQmceydiIdzG19VY2Hj2otLWVVlQ1T
	 oMRK7SHmCrNVgZk+8u8hWEVcNwqPqX/uMBAdGwTJUg5n1GdgbtpP7qxIQONIuSbOENZ0M
	 WErpcLDU3rKYdrvRUKCNSvIjd6D+kimH4mxRzrWOS0EWSOx8e5R22E8NRQBaPhOkhUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XjF/poUB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F176076736;
	Mon,  2 Nov 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjF/poUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B41F00A18;
	Mon,  2 Nov 2026 15:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634361;
	bh=XcnciT3D7d65PtFeUoZXa7fxLTNaJkc6pdnB1BKXFZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjF/poUBLyluFrKR0FBgvI/0pOBsrmI9ruOzol6/iX3R+oOz0ECqZ4KEoNO4JwzHr
	 ycSPqlrFos314M/wZ2pwiTdMZbdlpzMoxuYJKyW1L91K3Wm5AZthEd67/uahlxfgTe
	 FYCnoXMCGBVXIeQ72Gkl64nH99R4aR8jCyXqlzImrlUIolnAMzrCd5w4bGMRCtw1m9
	 34T3B4o/hhvQLarRCIT43GSQeObho3hzwM4VBgg/aadrjCoESAp1PLAH16qlDB/ec6
	 sV0xSJmGduAIt2cNhr8WhKIo3hCOd2rCkNKCoJuO5pZXnSMWNouHUx0OqA713YV8ky
	 A1lGnCTMYaZfw==
Message-ID: <sashiko-outbox-193701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/14] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-4-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:46:00 +0000
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
- [Critical] s390/vfio-ap: use-after-free of mig_data when migration FD out=
lives device FD
- [Medium] s390/vfio-ap: commit message does not match code in vfio_ap_migr=
ation.c
- [Low] s390/vfio-ap: malformed kernel-doc comment on vfio_ap_release_mig_f=
iles()
--

commit 2bff67e6f9b81966cd8ed45a78897f37868b65ad
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data

This commit adds functions to allocate, initialize, and release the data
structures used to maintain live guest migration state for vfio_ap mediated
devices when the VFIO device is opened, closed, or released.

>     s390/vfio-ap: Functions to initialize/release vfio device migration d=
ata
>    =20
>     Provides the functions that initialize and release the data structures
>     used during live guest migration:
>    =20
>     * vfio_ap_init_migration_data
>    =20
>       Allocates and initializes the object used to maintain the state of =
the
>       VFIO migration. It is called when the VFIO device is opened.
>    =20
>     * vfio_ap_release_migration_data
>    =20
>       Frees the memory of the object used to maintain the VFIO migration
>       state. It is called when the VFIO device release callback is invoked
>       and when the VFIO device is closed.
>    =20
>     * vfio_ap_release_mig_files
>    =20
>       This function is called from the vfio_ap_release_migration_data
>       function (above) and releases the vfio_ap_migration_file objects
>       contained within the vfio_ap_migation_data object used to maintain
>       the state of the VFIO migration process.
>    =20
>     * vfio_ap_release_stop_copy_file
>    =20
>       This function is called from the vfio_ap_release_mig_files function
>       (above) to release the vfio_ap_migration_file used during the
>       STOP_COPY phase of migration. For now, this is a stub function that
>       will be fully implemented in a subsequent patch after the
>       vfio_ap_config object referenced within is allocated, as it will
>       need to be freed according to how it is allocated.
>    =20
>     * vfio_ap_release_resuming_file
>    =20
>       This function is called from the vfio_ap_release_mig_files function
>       (above) to release the vfio_ap_migration_file used during the
>       RESUMING phase of migration. For now, this is a stub function that
>       will be fully implemented in a subsequent patch after the
>       vfio_ap_config object referenced within is allocated, as it will
>       need to be freed according to how it is allocated.
>    =20
>     * vfio_ap_set_state, vfio_ap_get_state and vfio_ap_get_data_size
>    =20
>       These three functions are callback functions assigned to the
>       vfio_ap_migration_ops (.migration_set_state, .migration_get_state
>       and .migration_get_data_size function pointers).
>    =20
>     Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>=20
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 2a0a8c76f820e..d525dec782a18 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright IBM Corp. 2025
>   */
> +#include <linux/file.h>
>  #include "vfio_ap_private.h"
> =20
>  /* Magic number and version for the vfio_ap_config migration blob */
> @@ -123,3 +124,105 @@ struct vfio_ap_config {
>  	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
>  	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>  };
> +
> +static void
> +vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
> +{
> +	kvfree(mig_data->stop_copy_mig_file.ap_config);
> +	mig_data->stop_copy_mig_file.ap_config =3D NULL;
> +	mig_data->stop_copy_mig_file.config_sz =3D 0;
> +	mig_data->stop_copy_mig_file.filp =3D NULL;
> +}
> +
> +static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data =
*mig_data)
> +{
> +	kvfree(mig_data->resuming_mig_file.ap_config);
> +	mig_data->resuming_mig_file.ap_config =3D NULL;
> +	mig_data->resuming_mig_file.config_sz =3D 0;
> +	mig_data->resuming_mig_file.filp =3D NULL;
> +	mig_data->resuming_mig_data_complete =3D false;
> +}

[Severity: Medium]
Is the commit message out of sync with the changes in
drivers/s390/crypto/vfio_ap_migration.c?

The changelog describes vfio_ap_release_stop_copy_file() and
vfio_ap_release_resuming_file() as stubs to be implemented in a subsequent
patch, but both functions are already fully implemented here to call
kvfree() on ap_config and reset the fields on stop_copy_mig_file and
resuming_mig_file.

The changelog also states that this commit provides vfio_ap_set_state(),
vfio_ap_get_state(), and vfio_ap_get_data_size() assigned to
vfio_ap_migration_ops, which are not present in this patch and instead get
introduced in later patches in the series, along with the usage of the newly
added linux/file.h include.

> +
> +/**
> + * vfio_ap_init_migration_data - initialize migration data and functions
> + *
> + * @matrix_mdev: pointer to object containing the mdev state
> + *
> + * Return: zero if initialization is successful; otherwise, returns a er=
ror.
> + */
> +int vfio_ap_init_migration_data(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	/*
> +	 * Live guest migration is not supported for SE guests, so there is no
> +	 * need to initialize the migration data.
> +	 */
> +	if (ap_is_se_guest())
> +		return 0;
> +
> +	mig_data =3D kzalloc_obj(struct vfio_ap_migration_data, GFP_KERNEL);
> +	if (!mig_data)
> +		return -ENOMEM;
> +
> +	mig_data->mig_state =3D VFIO_DEVICE_STATE_RUNNING;
> +	mig_data->resuming_mig_data_complete =3D false;
> +	mig_data->resuming_mig_file.matrix_mdev =3D matrix_mdev;
> +	mutex_init(&mig_data->resuming_mig_file.lock);
> +	mig_data->stop_copy_mig_file.matrix_mdev =3D matrix_mdev;
> +	mutex_init(&mig_data->stop_copy_mig_file.lock);
> +	matrix_mdev->mig_data =3D mig_data;
> +
> +	return 0;
> +}
> +
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
> + * @matrix_mdev: The object used to maintain the state for a mediated de=
vice
> + */
> +static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)

[Severity: Low]
This isn't a bug, but the kernel-doc comment on vfio_ap_release_mig_files()
in drivers/s390/crypto/vfio_ap_migration.c omits the short description on t=
he
identifier line and places the @matrix_mdev parameter description after the
body text, which triggers a scripts/kernel-doc warning about a missing
initial short description. Should the short description and @matrix_mdev
parameter be moved to the top of the kernel-doc block?

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
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 01439f0ca42ab..1aada3068df5f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2052,19 +2062,39 @@ static int vfio_ap_mdev_reset_qlist(struct list_h=
ead *qlist)

[ ... ]

>  static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
>  {
> -	struct ap_matrix_mdev *matrix_mdev =3D
> -		container_of(vdev, struct ap_matrix_mdev, vdev);
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	vfio_ap_release_migration_data(matrix_mdev);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> =20
>  	vfio_ap_mdev_unset_kvm(matrix_mdev);
>  }

[Severity: Critical]
As reported by Sashiko on v3 [1], can closing the VFIO device file descript=
or
while a migration file descriptor remains open trigger a use-after-free of
matrix_mdev->mig_data?

In drivers/s390/crypto/vfio_ap_migration.c, struct vfio_ap_migration_data
embeds resuming_mig_file and stop_copy_mig_file by value:

struct vfio_ap_migration_data {
	enum vfio_device_mig_state	mig_state;
	bool				resuming_mig_data_complete;
	struct vfio_ap_migration_file	resuming_mig_file;
	struct vfio_ap_migration_file	stop_copy_mig_file;
};

When a migration stream file descriptor is opened in
vfio_ap_open_file_stream() (added in later patches in this series),
anon_inode_getfile() sets filp->private_data to &mig_data->stop_copy_mig_fi=
le
or &mig_data->resuming_mig_file, and takes a registration reference on
vdev via vfio_device_try_get_registration().

That registration reference keeps struct ap_matrix_mdev alive until
vfio_ap_mdev_release_dev(), but it does not prevent the last close of the
VFIO device file descriptor from calling
vfio_ap_mdev_close_device()->vfio_ap_release_migration_data(), which destro=
ys
stop_copy_mig_file.lock and resuming_mig_file.lock and frees
matrix_mdev->mig_data with kfree().

When userspace subsequently reads, writes, or closes the open migration file
descriptor (including during process exit when close_files() closes the
lower-numbered VFIO device FD before the migration FD),
vfio_ap_stop_copy_read(), vfio_ap_resuming_write(), and
vfio_ap_release_mig_file() dereference filp->private_data (mig_file->lock,
mig_file->filp, and mig_file->matrix_mdev) inside the freed mig_data object.

[1] https://lore.kernel.org/r/20260630111142.08F0A1F00A3A@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D3
