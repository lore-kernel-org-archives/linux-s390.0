Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1B3DE431;
	Fri,  7 Aug 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142520; cv=none; b=omulSBPZF4mC5FqBh967Y5knX+NGicUL0UDLlWZHiEpPAfovug3Kcf+5AjAwH4GDR/g+cfbYXZBvrtnN+QQynFGeAtcilWE5RLVDK1jC2IqIR2tgcYlsYKy9QRAheRodB+0thuFO3y6suuxrU6cUwUtMtipb68DlN7GLTuzhmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142520; c=relaxed/simple;
	bh=Ob/Q42VjsjzVlLtQcAYSjqnGMbGGPhHf9bPmZLGqLMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cg94iFxfqmtq/HHtzvWTQscVDQbVSrOkhlc44mPkTLnnVkCV/vAyA3JFQMeRL93Gdx3wlxJkcWK2JM9ndhNk3prdFcGG7BYX2EHW4+Ee9ZKysNU27WXaHxLrhREP0G/ATGmnf3ImQQHk25K3BOmwGxqVF2TPyqjpv23QkWFSlbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKurvQn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKurvQn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FFE1F000E9;
	Fri,  7 Aug 2026 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142518;
	bh=VtS7ZPVXRuEeKdUEub6tXmmZArefMa+gt4zRmJMG8M8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKurvQn2+91/gAreqhcoS/lHMMTY8CJDa32Gq7GNJ/dML8AyepYFX6x+sE9GjuFzM
	 ruapFwuzLsZ38VZGNU5Vpd+9PsPIk4UJOXyTGi1KS5bwb2IxN3nO89HVf803iEgfo6
	 ec/Y3fnGXLpFSaKWD+h9X8WFzprKCkaXO2ilm1xHCVn74hs5YA1cq006kOWhx4G42l
	 A5rPFR++Q89o4ir36GGLAJ/gopSI0vNhA88/9HEXoSmuhtEAjDs5V8f5PLIWTRnAgu
	 nKvARLbwhbbyGGo/QW3wMD6k1UVJ8L3FTEZqLGM/abSSO5oZkFe/Pf5QIonaMyjJzo
	 jQ7eVCsYygQJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807221834.562851-9-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:41:57 +0000
Message-Id: <20260807224158.85FFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Dangling pointer dereference and Use-After-Free (UAF) in `vfio=
_ap_stop_copy_read` due to dropped lock.
--

--- Patch [8]: [PATCH v7 08/15] s390/vfio-ap: Transition device migration s=
tate from STOP to RESUMING ---
commit d54f2e0efd43f553196ad099672d0319fbd7c8d9
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
> index 50781b61f7f18..e2e7ae8515e55 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -451,6 +451,26 @@ static struct file *vfio_ap_open_file_stream(struct =
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
Can a concurrent device close or reset cause a use-after-free when reading =
the
migration state?

While looking at the migration file operations, I noticed a potential regre=
ssion
in vfio_ap_stop_copy_read() where mdevs_lock is acquired but explicitly dro=
pped
before copy_to_user():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_to_user(buf, (char *)mig_file->ap_config + read_pos, len))
        return -EFAULT;
}

If userspace concurrently issues a VFIO_DEVICE_RESET ioctl or closes the de=
vice
FD while the read thread has dropped mdevs_lock, vfio_ap_release_mig_files()
will acquire mdevs_lock and call kvfree() on
mig_data->stop_copy_mig_file.ap_config.

When the read thread resumes, copy_to_user() will read from the freed buffe=
r,
which could leak kernel memory contents to userspace.

Additionally, mdevs_lock is also dropped in vfio_ap_get_config() for a
potentially long-running operation:

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_get_config() {
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);
    ret =3D vfio_ap_store_queue_info(mdev_name, ap_configuration);
    mutex_lock(&matrix_dev->mdevs_lock);
    ...
}

If the device is closed and re-opened during this window, mig_data itself c=
an
be freed and reallocated.

However, vfio_ap_stop_copy_read() caches a local pointer before calling
vfio_ap_get_config():

drivers/s390/crypto/vfio_ap_migration.c:vfio_ap_stop_copy_read() {
    ...
    mig_file =3D &matrix_mdev->mig_data->stop_copy_mig_file;

    if (!mig_file->ap_config) {
        ret =3D vfio_ap_get_config(matrix_mdev);
    ...
}

This leaves mig_file dangling when vfio_ap_get_config() returns. This could
lead to a use-after-free when subsequently accessing mig_file->config_sz or
mig_file->ap_config.

Are there protections against mig_data or ap_config being freed while
mdevs_lock is dropped during these operations?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D8
