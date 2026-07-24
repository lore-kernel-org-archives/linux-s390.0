Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01119302149;
	Fri, 24 Jul 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916369; cv=none; b=YBXS+Lz6INdWgsyqH4vBN8xdAvqNTgmzN+OTkNYDYz1OuIWmn3ZCM+hRGv3tkrC+NzPKNWK3GXac2k8CVtbM0Z80CeKAiTMy9UnFlZQzdOAlirzqHzRLmcuy2pZghMz1f1KwIFnvhMCQwDb030WZBJhKrrVgEZKqI6Q0OdTOPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916369; c=relaxed/simple;
	bh=kzrfFfV81YqiYHFsxeXrn/8M4OCrXxgr7azxfQsCrpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Atc+G38YBh5+UHLUc7gGoOGBM5E26iFfFcqfD+WvfC3GKogZ7HtlXMdIKP4ZjVw+tUukXWfNVCQC8HU2ya7WtcG9flRqYk1rLZUS5dYooNt3HomrrRBJw9Ywe/X/nWIGXWF3HitHb/S+0f3IM9CrZrs9Jc1431ssTVWSKNhg3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfZoAqxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfZoAqxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A4A1F000E9;
	Fri, 24 Jul 2026 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916366;
	bh=ch+orQB8HtBE3ZZHfOBEMiWbMjA0deP2GATjul91HXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfZoAqxbE6bWnbDIn9HP37CJXjXNePcEnaJWPPMhkl4RAjwpxZzUPem8wk/tp+qHw
	 SfKdqziG2qMUCZLd2ciNhtSGJHfBOeYqvEH5dWAqTUz9U6bc3hyY7rG6HQ8ETzCooK
	 uAnuEkSwTbD6nwdbeUN6nnlaO743raS9oxKhsYO6ThlIkMHX/HwAXwry4mo33N9KzA
	 MQO1PoqNo92IjqY8dn4QEcSYYmz78fxU0jS5Be7crbktqkoUNLuXNIYRO46DJRoOJE
	 0jND5cQd9fZb+xATC17omnEv6nd5bfqjTu0xtrvUsjtbf0jfj2fjZRWlNLS4Lvr/t2
	 9VYV3BArKfodA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260724161351.1802644-9-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:06:05 +0000
Message-Id: <20260724180605.92A4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Use-After-Free of `matrix_mdev` in the migration file release =
handler if the migration file descriptor outlives the VFIO device.
- [Critical] Missing file reference acquisition (`get_file`) leads to unbal=
anced `fput()` and Use-After-Free of `struct file`.
- [Low] Unused variable `mig_data` in `vfio_ap_resuming_init`.
--

--- Patch [8]: [PATCH v5 08/15] s390/vfio-ap: Transition device migration s=
tate from STOP to RESUMING ---
commit 94d16087e429b1f41655bfa5ac0aacdda266732c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RESUMING
   =20
Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
starts a process of restoring the device state of the vfio device on the
target system. To prepare for restoring the device state, open a file
stream to receive the guest's AP configuration saved when the device state
on the source system transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 0d949ec205de6..4a489a7a05ff1 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -398,6 +409,32 @@ static struct file *vfio_ap_open_file_stream(struct =
ap_matrix_mdev *matrix_mdev,
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

[Severity: Critical]
If the migration file descriptor outlives the VFIO device, could this cause=
 a
use-after-free?

When a process closes the main device file descriptor, the VFIO device
reference count drops to 0, which triggers device release and frees the
matrix_mdev structure.

If the process retains the migration file descriptor and subsequently closes
it, the VFS invokes this .release callback (vfio_ap_release_mig_file()).
This extracts the freed matrix_mdev from filp->private_data and dereferences
it:

vfio_ap_release_mig_file() {
    ...
    matrix_mdev =3D filp->private_data;
    if (!matrix_mdev || !matrix_mdev->mig_data) {
    ...
}

Does vfio_ap_open_file_stream() need to take a reference on the VFIO device
when creating the file descriptor to prevent this?

> +static struct file *vfio_ap_resuming_init(struct ap_matrix_mdev *matrix_=
mdev)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +	struct file *filp;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	mig_data =3D matrix_mdev->mig_data;

[Severity: Low]
This isn't a bug, but the mig_data variable is assigned here and never
used. Can it be removed?

> +	filp =3D vfio_ap_open_file_stream(matrix_mdev, &vfio_ap_resume_fops, O_=
WRONLY);
> +
> +	return filp;
> +}

[ ... ]

> @@ -429,10 +466,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *=
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
> +		struct file *filp =3D vfio_ap_resuming_init(matrix_mdev);
> +
> +		if (IS_ERR(filp))
> +			return ERR_CAST(filp);
> +
> +		mig_data->resuming_mig_file.filp =3D filp;
> +		return filp;
>  	}

[Severity: Critical]
Does caching this file pointer without acquiring an additional reference
create a risk of a use-after-free on the struct file?

When the VFIO core installs the file into the userspace file descriptor
table via fd_install(), ownership of the single existing file reference
transfers to userspace.

If userspace issues a VFIO_DEVICE_RESET ioctl on the main device,
vfio_ap_reset_migration_state() calls vfio_ap_release_mig_files(), which
appears to execute fput() on the cached file pointer:

vfio_ap_release_mig_files() {
    ...
    if (mig_data->resuming_mig_file.filp) {
        fput(mig_data->resuming_mig_file.filp);
        mig_data->resuming_mig_file.filp =3D NULL;
    }
    ...
}

This would incorrectly drop the file's reference count to 0 and destroy the
struct file object while it remains in the userspace fdtable. Any subsequent
read, write, or close syscall by userspace on the migration fd would then
dereference the freed struct file.

Should this call get_file(filp) before caching the pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D8
