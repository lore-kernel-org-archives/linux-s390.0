Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0C31618C;
	Fri, 24 Jul 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915418; cv=none; b=HOOziSQvL0kcdn471CakyP/bFSo5tlIXemX0XAUL6pE7KjTZc9OQZUUSePOgHv6vFb+swLUEpc1aonvnhnrk7EIjagiA7oSs+51zDgzJf3+vrV/el1Ny0jfA3I/ZzkjeJN1jMUJZFnWbtGLsF1YTBFBFJm0VVJfZVoLFHNl7deE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915418; c=relaxed/simple;
	bh=HaYUtvd5WBEGS2M1K0pn2EOF2RDKPgMWS8cpHso+gec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SCvkbwhH7WXrUEi43appbyWbBQFzYdu8vRbzXwCcIx6fdoNSMoMkRx2UdumHS1k/kymC+KJqZCc+YkZmftB9RcaLqpLggvxI7xhuRgIr9H87aAODYYoVPVQOgIsnAL3jlWGH2XfME5WLPfOewLw3B9FSDwouAXbHytZR9/g8GiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MARoNKL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MARoNKL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4A31F000E9;
	Fri, 24 Jul 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784915416;
	bh=W54w3Dc8P67h0cyjkXHko6VNm2p5GFYuSjKptI3uKgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MARoNKL9pc82cqWPbfwgwUonWD/XNYH4Fx+MOJWdXfxs8gX4bievGLBtjHpsNMUoX
	 Tcd7JJutuRuN+1VIaX7eLchGr8qg1bHrINHcbEAA2OzvCnDSh5TzMRrkPtR88Rhah4
	 jPgmj4EsAZmC/LkO0rXCIJVaCgTqLoGM1hBgIjK5LPLTeu3lQnVJi6V/+Nwcr3uG2a
	 DI4p9jIsVCK/W/4RgNsn1sYycU/NTiWsnWcyt6/1eLFMjDUdPPZBHZbGtVtNbs6D9o
	 x/iDe6DEo734ObMYS01toZTEX2dp9x8DRQhHtZi2r57NbK21tzXQ4XaqKDugSu3aLn
	 aA3Jqxn9iBcqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260724161351.1802644-7-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:50:15 +0000
Message-Id: <20260724175016.6F4A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The migration file descriptor holds a raw pointer to `ap_matrix_md=
ev` without acquiring a reference to the VFIO device, causing a Use-After-F=
ree when the file is closed if the device was removed.
- [High] Missing `get_file()` when saving the migration file pointer to the=
 internal state, leading to premature file destruction and Use-After-Free.
--

--- Patch [6]: [PATCH v5 06/15] s390/vfio-ap: Transition guest migration st=
ate from STOP to STOP_COPY ---
commit d0aca043e8f77cdca50116119638c000987fae0d
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
   =20
This commit begins the process of saving the vfio device state by transitio=
ning
from STOP to STOP_COPY. It introduces a stub implementation of the read
operation for migration state files.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 17cabd7541e75..e566250a88ea3 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -72,6 +73,67 @@ struct vfio_ap_config {
>  	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>  };
> =20
[ ... ]
> +static int vfio_ap_release_mig_file(struct inode *file_inode, struct fil=
e *filp)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	int ret =3D 0;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	matrix_mdev =3D filp->private_data;
> +	if (!matrix_mdev || !matrix_mdev->mig_data) {
> +		ret =3D -ENODEV;
> +		goto done;
> +	}
[ ... ]
> +static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matr=
ix_mdev,
> +					     const struct file_operations *fops,
> +					     int flags)
> +{
> +	struct file *filp;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	filp =3D anon_inode_getfile("vfio_ap_mig_file", fops, matrix_mdev, flag=
s);

[Severity: High]
Does this code need to take a reference to the underlying VFIO device?

If the mediated device is unbound or removed, matrix_mdev could be freed.
When the migration file descriptor is subsequently closed,
vfio_ap_release_mig_file() dereferences filp->private_data, which might
result in a use-after-free on the freed matrix_mdev.

> +	if (!IS_ERR(filp))
> +		stream_open(filp->f_inode, filp);
> +
> +	return filp;
> +}
[ ... ]
> @@ -85,10 +147,22 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *m=
atrix_mdev,
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
> +		struct file *filp =3D vfio_ap_open_file_stream(matrix_mdev,
> +							     &vfio_ap_stop_copy_fops,
> +							     O_RDONLY);
> +		if (IS_ERR(filp))
> +			return ERR_CAST(filp);
> +
> +		mig_data->stop_copy_mig_file.filp =3D filp;
> +
> +		return filp;
>  	}

[Severity: High]
Should get_file() be called before saving the file pointer to the internal
state?

The VFIO core installs the returned file pointer into the user's FD table,
which consumes the only reference to the file. If the driver later drops its
saved reference during a device reset (e.g., via a call to fput() in
vfio_ap_release_mig_files()), the file could be prematurely destroyed while=
 the
userspace FD table still points to it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D6
