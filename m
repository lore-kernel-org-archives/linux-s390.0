Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37860332918;
	Tue,  7 Jul 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416237; cv=none; b=DWbVmacw3BgqHY6F41z/fMyHuG0FmTJBlfOHom+f0EichzcJF+I/7Wu5i2C2l2Wm9t9pWj9uJrBDVXGYXdMrreHWfXLmQVnz1zKBW/9lUCW5OTwiLnRKY2EH6pLG1D8vp389vlUPCea/uDEgL1EWRmlS0lwkqT50Nn5pkqijKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416237; c=relaxed/simple;
	bh=UmBnk8U8znlTO49or3cWhV2tudU4PUQL/Y2FzFFZahk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B/LBgkzV+3AgwHW9jfF3UF32iQcScCx0J/q4V14XPJ2fXgNNs6seGgfeKA3wXD81lVGOP78AhvoMLU5pYCWmEjGAYLZdZwY4E8HIakTSbaGTnki+Dm6LAIGevpu9y8BaLpZXtFZOHl8LCk6glrULJvAqOH6iQVQK/iOYj9XWytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNC63Y8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNC63Y8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE91F000E9;
	Tue,  7 Jul 2026 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416235;
	bh=wQvFf2/KH651D2il3Zy4y7Vw0VZsMmf8QSAuE4SKXbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fNC63Y8/387eMNbe1QAtwXx1EnFQeLfDMxiWFG5I3KtiCGq7gNrRRe6UuxlVfiHKW
	 elwZL75nJ7CnSIXxfmfDGocwHUSFntTI8GvyDij66xnvIhX0zLsobeAXHV1rdcjlzk
	 QDbLQSeTjEHV2azD9tT2unrdq1rx7b7BVg2J88eEstMAuxgs16+z9NP5A4/KYu5UkB
	 /P8hyvwPscqRhtBcukskBnrMEkDgQsh/JTcetjlphefMvXDeiPR3nF/6cj9eoxyWCg
	 QzdpffiVlj/84TJdfFCF3KnL+M9SHlmCrU/X5K6EZUkrlXMZaxCYNQwr7vG0AC5/hQ
	 62r+7xBnZ7BBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260707090226.3206695-9-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:23:55 +0000
Message-Id: <20260707092355.7DDE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Migration file streams do not decouple their lifecycle from the vf=
io_device, allowing `matrix_mdev` to be accessed after being freed.
- [Medium] Concurrent reads on the migration state file cause a data race o=
n `filp->f_pos`.
--

--- Patch [8]: [PATCH v4 08/15] s390/vfio-ap: Transition device migration s=
tate from STOP to RESUMING ---
commit df7f5fdcda2503aec3804ab2b04e4b736cd6f0a1
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
> index 5ef7127b697a5..e917cc995d352 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -74,6 +85,8 @@ static int vfio_ap_release_mig_file(struct inode *file_=
inode, struct file *filp)
> =20
>  	if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)
>  		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
> +	else if (filp =3D=3D matrix_mdev->mig_data->resuming_mig_state.filp)
> +		vfio_ap_release_resuming_file(matrix_mdev->mig_data);
>  	else
>  		return -ENOENT;

[Severity: High]
Does this expose the matrix_mdev lifecycle to the file descriptor?

Migration file streams do not seem to decouple their lifecycle from the
vfio_device. The migration state file descriptor is created using
anon_inode_getfile() with matrix_mdev set as its private_data.

If a user closes the main device file descriptor but keeps the migration
file descriptor open, and the administrator unbinds the mdev device, the co=
re
VFIO layer unregisters and frees matrix_mdev.=20

When the user later closes the migration file descriptor,
vfio_ap_release_mig_file() dereferences filp->private_data to access the
already freed matrix_mdev:

static int vfio_ap_release_mig_file(...)
{
    struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;
    ...
    mutex_lock(&matrix_dev->mdevs_lock);
    if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)

Could this lead to a use-after-free of matrix_mdev when attempting to clean
up the migration state?

[ ... ]

> @@ -311,6 +324,32 @@ static struct file *vfio_ap_open_file_stream(struct =
ap_matrix_mdev *matrix_mdev,
>  	return filp;
>  }

[Severity: Medium]
Is it possible for concurrent operations on these migration state files to
cause a data race on filp->f_pos?

vfio_ap_open_file_stream() initializes the file with stream_open(), which s=
ets
FMODE_STREAM and clears FMODE_ATOMIC_POS. In the VFS layer, this skips
acquiring f_pos_lock for stream files.

Looking at vfio_ap_stop_copy_read() which uses these stream files:

    pos =3D &filp->f_pos;
    ...
    mutex_unlock(&matrix_dev->mdevs_lock);

    if (copy_to_user(buf, (char *)ap_config + *pos, len)) {
        kfree(ap_config);
        return -EFAULT;
    }

    kfree(ap_config);
    *pos +=3D len;

Since matrix_dev->mdevs_lock is released before copy_to_user() and before
*pos +=3D len is executed, wouldn't concurrent read() calls read from the s=
ame
*pos offset, perform copy_to_user() with duplicate data, and concurrently
update *pos?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D8
