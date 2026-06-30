Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B03367B84;
	Tue, 30 Jun 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818621; cv=none; b=Jmd+hcDs3uQ5Q9V9mc3oSbabMBoQH8ECn7rTmdPsUIsiDEFIEA3MF+ZzpA/FBsvazb8HPoQWDAYp3uVGV1AsGxgV3JVGZq6W3jO6VTmpy1AcBmVuu7i5QB5XBjrZoY5Vu6FLArfqYedXydirUm+E1qZ7KVfUru/hj7f2b37tIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818621; c=relaxed/simple;
	bh=BmYQlyg6DPo5W20GbYFNTHyYCjZbTimUzZODM+rPPH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KA70C9KS2zPXQGr5Vepj0wBj2hGVLPjI5BeUE+Q70a/4/PP3AZo1hAsePCaNpnYN/MpDkr0qjBX2vTm9Xlg9isEMgqxGSQNpga/6pR1N+w6RI/nv3cbM0Iz0l3H4OQb/Rh3VzvTDTFZiA2JThZ1SzT4EOJVdqSBUm49vj+5JXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYywgAMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYywgAMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E09D1F000E9;
	Tue, 30 Jun 2026 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818620;
	bh=Y54KlgvkpmlsfsNNcAQh4EUQ3Fj/F0JMr3x/DzBJXOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYywgAMjZpz3twqqKSubeal2hOB8n/vkpaGJIh+Luf+kL3leI+66qOVbOXUgxFfKB
	 x370xUvHy+QXQrSRZpEecMrM8IVm1SdP5ESQE84oOZp9DFgHjRi9S4kfvdSos2a2vN
	 1LzFYWLLbPiuA2Z0DcehoJT5WQ9ZaxnW3kvheYv/5ij1M5Ty3ZEHWens3kS338en3+
	 677h9rbfWYRvgB7wxnVw7P6bCxpg2JeXWURtnvjBCG2eBYwKEbKWkSRIJn1JrzwpvJ
	 NoxpLs6Azcf5e/VFKD5/mcL0cwX6ceG3xN5nH2XR7i7L/9wAL/cYKxKKb9vo43ElIh
	 xaJp5CNzJmiwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260630104132.1598851-7-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:23:39 +0000
Message-Id: <20260630112340.1E09D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The migration file descriptor does not hold a reference to `matrix=
_mdev` nor uses an independent context structure, leading to a Use-After-Fr=
ee when the migration file is closed after the device is removed.
- [High] `vfio_ap_release_mig_file()` accesses and modifies `matrix_mdev->m=
ig_data` without holding `matrix_dev->mdevs_lock`, leading to a TOCTOU race=
 and Use-After-Free.
--

commit 24121dd0a897a029f9bc2979eb21b1bf31847440
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY

This patch implements the transition to the STOP_COPY migration state for
vfio-ap devices. It sets up the migration infrastructure by creating a file
stream used to read the guest's AP configuration. The file operations are
introduced with a stub read implementation.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 8274e7b65eea4..76e06abe5a9e9 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> @@ -57,6 +58,57 @@ struct vfio_ap_config {
>  	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
>  };
> =20
[ ... ]
> +static int vfio_ap_release_mig_file(struct inode *file_inode, struct fil=
e *filp)
> +{
> +	struct ap_matrix_mdev *matrix_mdev =3D filp->private_data;
> +

[Severity: High]
Does this code race with device closure?

If userspace concurrently closes the main VFIO device FD and the migration
FD, one thread could process the main FD closure, acquire the mdevs_lock,
and free matrix_mdev->mig_data.

If vfio_ap_release_mig_file() is called by the other thread and accesses
matrix_mdev->mig_data without acquiring matrix_dev->mdevs_lock, could it
dereference a freed mig_data pointer?

> +	if (!matrix_mdev || !matrix_mdev->mig_data)
> +		return -ENODEV;
> +
> +	if (filp =3D=3D matrix_mdev->mig_data->stop_copy_mig_file)
> +		vfio_ap_release_stop_copy_file(matrix_mdev->mig_data);
> +	else
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations vfio_ap_stop_copy_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.read =3D vfio_ap_stop_copy_read,
> +	.compat_ioctl =3D compat_ptr_ioctl,
> +	.release =3D vfio_ap_release_mig_file,
> +};
> +
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
Can this lead to a use-after-free of matrix_mdev?

Because the migration file descriptor does not hold a reference to
matrix_mdev, what happens if userspace closes the main VFIO device FD
while keeping the migration FD open, and the administrator removes the
mediated device?

The VFIO core might wait for the main device FD to close and then free the
matrix_mdev object. When userspace eventually closes the migration FD,
vfio_ap_release_mig_file() will dereference filp->private_data which
points to the freed matrix_mdev memory.

> +	if (!IS_ERR(filp))
> +		stream_open(filp->f_inode, filp);
> +
> +	return filp;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D6
