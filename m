Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3102A15E5BB;
	Mon, 27 Jul 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176050; cv=none; b=esSQwLbB6CKqYHotrtGMo+Hj0Gs960L9MqfQZiA1QzLwlEDXIwTD8wB9gEhdS2u58S+FsqWbVG7SwzWJdU0mIDZ9u7Wsh0yBG0lTm4eG6kbGlUxv7pFQF44Rgu22wGRUt+NYi1W6Xo0UrzO8Cxd0MF5FOpFsKNyk3+zqPIbGHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176050; c=relaxed/simple;
	bh=88R2X2nnHiZCWBLFRGE4iEi8N5wvFLhLO9Xg9Wef+OI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q46sQdLBTS3mCeZx7MlSilzCOf3LVxBCof3hrp7LReanm1TabKo9EcetHp/ocsYipn7dZYDwQJMY+x+od7iqwx6TUMGJMaXGnlLupCRSQ+RfBLZPClDwbvvBfzWA2jGGqH5nf9ltiGWjkXKEzJlJ6m2QbJfncn0Bl/UUUEWUSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhqCDHiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhqCDHiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805861F000E9;
	Mon, 27 Jul 2026 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176048;
	bh=0PMSG7YijW0rFFLwORd9Tm1c8LgtgzuXAUw/pFqwEnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhqCDHiRrfRZ3Drd2OiaKaIJ4KkhmE7XuVoE+hw7OwJWeSet/Va1d4dmKf7u+mwoB
	 5AqW6cty10FYrmflcn8ri5aNgjuHuN52quZb2LLzXhzud1Bil+5JRLRyrL3PVU0t5V
	 6p0MlyI7TZVmUMLHkdX/f6ISroTQorkWQQFesaGdpJ81c6lF4KeMGB8A73HKuYmJuC
	 1c1i8WPD+rvbyz/qdaxmQ0uiRuiArSanGAwann0iMTTqEbkzV9X/MRNnX5Egy5ehJ2
	 y2oF3mHWhUk5NvJHXNlxLE79+Flw7G/DieKBJ2YG3djvqUPfWKzBCpIceTuzp6qMYn
	 vZu5Ip36ELylg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727173239.2420754-9-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
 <20260727173239.2420754-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:14:07 +0000
Message-Id: <20260727181408.805861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Use-After-Free in `vfio_ap_stop_copy_read` leading to kernel m=
emory leak to userspace.
- [Low] The `.release` callback logic for cleaning up the resuming and stop=
-copy file states is completely unreachable dead code.
--

--- Patch [8]: [PATCH v6 08/15] s390/vfio-ap: Transition device migration s=
tate from STOP to RESUMING ---
commit 798f82863e85b4d37fd3594dc855fe7caaaaf7f5
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition device migration state from STOP to RESUMING

Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
starts a process of restoring the device state of the vfio device on the
target system. To prepare for restoring the device state, open a file
stream to receive the guest's AP configuration saved when the device state
on the source system transitioned from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index e4bc67b1eb842..c7fecad0b6769 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -99,6 +108,8 @@ static int vfio_ap_release_mig_file(struct inode *file=
_inode, struct file *filp)
> =20
>  	if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file.filp)
>  		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
> +	else if (filp =3D=3D matrix_mdev->mig_data->resuming_mig_file.filp)
> +		vfio_ap_release_resuming_file(matrix_mdev->mig_data);

[Severity: Low]
Is this conditional branch actually reachable?

During vfio_ap_open_file_stream(), the driver takes an internal reference to
the file via get_file(). This means the VFS .release callback is only invok=
ed
after the driver explicitly drops its reference by calling fput().

If fput() is called in vfio_ap_release_mig_files(), which first sets
mig_data->resuming_mig_file.filp =3D NULL, won't filp inside mig_data always
be NULL by the time this .release callback executes?

Consequently, will this check always evaluate to false, leaving
vfio_ap_release_resuming_file() as unused dead code?

[ ... ]

> @@ -400,6 +411,26 @@ static struct file *vfio_ap_open_file_stream(struct =
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
Could the migration file stream logic be vulnerable to a use-after-free when
the device file descriptor is concurrently closed?

Looking at the related vfio_ap_stop_copy_read() stream implementation, it
drops mdevs_lock before calling copy_to_user():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
        return -EFAULT;
    ...
}

If the device file descriptor is concurrently closed, vfio_ap_mdev_release()
could invoke vfio_ap_release_migration_data(), which acquires mdevs_lock and
frees the mig_data structure.=20

When vfio_ap_stop_copy_read() resumes, will it dereference the freed mig_da=
ta
structure via mig_file->ap_config and leak kernel memory to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173239.2420=
754-1-akrowiak@linux.ibm.com?part=3D8
