Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6D30674B;
	Fri, 24 Jul 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917574; cv=none; b=sj1eTrz+p6DeOBUG4CPtza3LvanNnib5j5hS8PWelH7IQHvH2eRTG6ciFZ0Xx180lxjvpSKfums7TEzdLYPmIS59xntdRtMbGZpDGRPSZOxq7vrmsPT5+G8wHbjPpvOBdYzNscKNxdGLd/Tvblfi4WOBwP89lRE0bzidQc30fKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917574; c=relaxed/simple;
	bh=X2P1ekneIlD9ihVjTz4lHANBznJNOoyFjz2tt/EO/rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tVOmIZgvjEMozEIs0BjazdPXlw4RAILHaInVTggD/6FYL3lT7swyBxO7E8o35kAd6u3lIxmp+nkIYjB8YquMxiDDRSuqs23QpvSRd9XuYT+Gcd8nKMpoy7wf3VJquWPS8l/PYCN7fh+HFpQriIae3sYniTtdY1KQA/yRDSoqbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m799F+Cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m799F+Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6479E1F000E9;
	Fri, 24 Jul 2026 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917572;
	bh=LJcCt1hGGpWcxxoe06Dx+uOlq09BQn53GaGVAJls7fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m799F+CsgjTjsUBeD4eppIbXQ2tNfkN8c0RBOpZXXtzKHbmo/jqw5qrD7RDz2aVNX
	 zfmdb/clgdmTRY32bSWecXBl2Cb7lyWVxEpo9zH4cFCC4tUA00xcIP2KZvhAbP8vDu
	 5wzJoU8H1/y1GLWSSg75GsozWY5J+8Pfn1hjugzpAtdNP0UY0gMybFT9SZrLOmA7dz
	 TRQnRFgWDOZ/p8HI2yHOGaxdWu7ge/W4Oik6yG3m+PnRO9FNqSusaQ8n1g7j2l3ncW
	 G4Derxj502EL+Eb8MP5DKgzHqok6GyN122PcH8Qe62wE8NGngl7wxlimDuawIG3rkh
	 z6A49HN9cevPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/15] s390/vfio-ap: Transition device migration
 state to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-12-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:26:11 +0000
Message-Id: <20260724182612.6479E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Transitioning out of data transfer states (STOP_COPY -> STOP or RE=
SUMING -> STOP) returns NULL without cleaning up the active migration file =
state, causing stale data reuse and memory leaks.

Pre-existing issues:
- [Critical] Migration file descriptors lack a reference count to `matrix_m=
dev`, allowing a Use-After-Free if the device is unbound while the file is =
open.
- [Critical] Calling `fput()` on a migration file stream without holding an=
 additional reference causes a structural Use-After-Free of the file object.
- [Critical] Writing fewer than `sizeof(struct vfio_ap_config)` bytes to th=
e resuming FD bypasses validation and causes an Out-Of-Bounds Read kernel p=
anic.
--

--- Patch [11]: [PATCH v5 11/15] s390/vfio-ap: Transition device migration =
state to STOP ---
commit 6eb426fca5901497387e866972eaf6e2157cc2bb
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Transition device migration state to STOP

This commit modifies the vfio-ap driver to support transitioning to the STOP
state during migration. It updates the state machine to return NULL instead
of -EOPNOTSUPP when transitioning out of the STOP_COPY or RESUMING states.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 7a9a8f63a76d3..21cd9810a18c4 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1304,12 +1304,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev=
 *matrix_mdev,
>  		return filp;
>  	}
> =20
> +	/*
> +	 * Terminates the data transfer session of the vfio-ap device state
> +	 * between the source and target hosts. Since the vfio-ap device does
> +	 * not virtualize a DMA device, there is no internal device state to
> +	 * incorporate into the vfio-ap device on the target.
> +	 */
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_RESUMING &&
>  	     new_state =3D=3D VFIO_DEVICE_STATE_STOP) ||
>  	    (cur_state =3D=3D VFIO_DEVICE_STATE_STOP_COPY &&
>  	     new_state =3D=3D VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return NULL;

[Severity: High]
Does returning NULL here without calling vfio_ap_release_mig_files() leak t=
he
active migration file state?

If the migration is aborted and a new one starts before userspace closes the
old file descriptor, the new session overwrites the filp pointer but does n=
ot
free ap_config. Will the new read operation then see a non-NULL ap_config a=
nd
silently reuse the stale configuration snapshot from the aborted migration?

>  	}
> =20
>  	if ((cur_state =3D=3D VFIO_DEVICE_STATE_STOP &&

[Severity: Critical]
This is a pre-existing issue, but does creating the migration file descript=
or
without incrementing the VFIO device's reference count allow a use-after-fr=
ee?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_open_file_stream() {
    ...
	filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flags);
    ...
}

If a user holds the migration file descriptor open and unbinds the device v=
ia
sysfs, vfio_unregister_group_dev() can complete because the migration file
descriptor holds no reference to the device. Any future read, write, or clo=
se
on the file descriptor will dereference the freed matrix_mdev:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_mig_file() {
    ...
	matrix_mdev =3D filp->private_data;
	if (!matrix_mdev || !matrix_mdev->mig_data) {
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does calling fput() here cause a structur=
al
use-after-free of the file object?

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_release_mig_files() {
    ...
	if (mig_data->stop_copy_mig_file.filp) {
		fput(mig_data->stop_copy_mig_file.filp);
		mig_data->stop_copy_mig_file.filp =3D NULL;
	}
    ...
}

Since vfio_ap_open_file_stream() allocates the file using anon_inode_getfil=
e()
with a refcount of 1, and this single reference is consumed by the VFIO core
when it installs the file into the userspace file descriptor table, the dri=
ver
does not own a reference to the file.

If the device state is reset and fput() is called, it artificially drops the
refcount to 0, freeing the struct file while userspace still holds the file
descriptor open.

[Severity: Critical]
This is a pre-existing issue, but can writing fewer than
sizeof(struct vfio_ap_config) bytes to the resuming file descriptor bypass
validation and cause an out-of-bounds read?

If userspace writes a small payload (e.g., 4 bytes), allocate_ap_config()
allocates those 4 bytes directly:

drivers/s390/crypto/vfio_ap_migration.c:allocate_ap_config() {
    ...
	} else {
		config_size =3D len;
	}

	*ap_config =3D kzalloc(config_size, GFP_KERNEL_ACCOUNT);
    ...
}

This allows the write handler's completion check to instantly pass:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_resuming_write() {
    ...
	/* Check if we've completed writing the entire configuration */
	if (*pos + len =3D=3D cfg_sz) {
		/* Acquire locks required to update the guest's AP config */
		...
		ret =3D do_post_copy_validation(mdev_name, ap_config);
    ...
}

The validation will then read a user-controlled num_queues value from the
undersized buffer and loop over the qinfo array, reading heap memory
drastically out of bounds:

drivers/s390/crypto/vfio_ap_migration.c:queues_available() {
    ...
	for (int i =3D 0; i < source_config->num_queues; i++) {
		apqn =3D source_config->qinfo[i].apqn;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D11
