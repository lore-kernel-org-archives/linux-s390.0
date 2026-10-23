Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779011;
	b=rVbwq/Njx2l1/4bp+IM6pnPrRA3NEtOixRDH9n2koit4KQpd8sJn1OF9xliqIOFa4UT9
	 LAm3k8u/Hp/SrrMKdrRHDRU54qtRUsw6FZ3l5w60rLWaPEYyJjeL6PB3rvTYAcSDZsn3V
	 siPV51wMk2ToIxwOmfjneu4Bmm4blI4iYpaJ0VcR9qfiIK+dIEOhFGZrHggLsaAUoved3
	 scScYANB+QESOw3Q/OLOxxmZvY7cQZCxD05Bu88EQEM66jNbYE3P2Q4VZCHb0sR4yHh6E
	 Msu6k9ELjzQb3b6cV15lPMhO8jTRWvSkdPjvVpI8O4vX/atBOOTz1Ca4FvcIAOFO8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=upL2t2CUPbfONkk9afc2TlnwOA87mZCju8ZTo5czJ08=;
	b=I1eP1ER0maJsK9WGt0zL1AR8iL0kI2cxiOhQMmKTH5l9ezp2SiUWov/DW0dwJBm+96/I
	 OzPN/ZS86BndSS/a/2ROyOZXT88rMHsYvMAzKiNE31hGDGg9Akql+FA8wc4gpUF8vpgmJ
	 pzaoiDrjglguVQBNOzGNKecOgmteLuN7BorxaAcOSXT+vKSpW0PFDYRQJd7nwRlVXQCx3
	 KlCCELigjNHHAt7gkDSsNJjMwY94VC5fD1EyLGd9MGBNEbJ3ir23rfXxEhXWvVD1eU3K8
	 MawavwowfjtkiViPaeKZE1a7jpx8aWOYDg3wXRFgUl8v7i+9axxqlItPdDvg3esw0qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxUJ7tPm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6B606A31A;
	Fri, 23 Oct 2026 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxUJ7tPm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563511F01825;
	Fri, 23 Oct 2026 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779010;
	bh=upL2t2CUPbfONkk9afc2TlnwOA87mZCju8ZTo5czJ08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxUJ7tPmrCuMQ7Kv/a1sbAeQK91c5aRxtt0h+uNbp40Zi+JFMG4W3vTIlGB3H5gr7
	 TmjRLnQIAhShTA0SPRpqiQQTm7G2Y5N7fX/24CQe9tMxOcQXcPumat636QAN24/Oop
	 JFPUjaa7qF3ibWrhJSB3FI2+YdLQ3kbrHRnkU7/japC12WPM2BilGKwIsqSPU8j333
	 4ADGj64SOgaerlqaqpWPlKPlihV8KRpWEqf9URDINWZsBSOi+jTBWc3yVlKB2hceL8
	 eJVwwBSsHbG8bOyv08yeWOCqEVSSE55T0dS/kEbCFlv6cCUImraYTXIToXfVB/+fiL
	 F02GqKKc3jQ7A==
Message-ID: <sashiko-outbox-183048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/15] s390/vfio-ap: File ops called to save the
 vfio device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-8-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:10:09 +0000
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
- [Medium] s390/vfio-ap: f_pos corruption on -EFAULT in vfio_ap_stop_copy_r=
ead()
- [Medium] s390/vfio-ap: high-order kmalloc() in vfio_ap_stop_copy_read()
--

commit 244125b3df6e4802b043acebf35691558c6264c3
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to save the vfio device migration state

This commit implements the vfio_ap_stop_copy_read() callback for the
migration file created when transitioning from stop to stop-copy state,
copying the guest's AP configuration and queue hardware information to
userspace.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index bc216c51a1a79..f9b00fb89410f 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -162,6 +155,269 @@ static int vfio_ap_release_mig_file(struct inode *f=
ile_inode, struct file *filp)

[ ... ]

> +static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_config *ap_configuration;
> +	unsigned long *apm, *aqm, apid, apqi;
> +	unsigned int num_queues;
> +	const char *mdev_name;
> +	size_t ap_config_size;
> +	int ret, qindex;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);
> +
> +	ap_configuration =3D kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
> +	if (!ap_configuration)
> +		return -ENOMEM;

[ ... ]

> +static ssize_t vfio_ap_stop_copy_read(struct file *filp, char __user *bu=
f,
> +				      size_t len, loff_t *pos)
> +{
> +	struct vfio_ap_migration_file *mig_file;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	void *bounce;
> +	ssize_t ret;

[ ... ]

> +	/*
> +	 * Don't read past the end of the AP configuration data. Limit len to
> +	 * the number of bytes remaining.
> +	 */
> +	len =3D min_t(size_t, mig_file->config_sz - *pos, len);
> +	if (len =3D=3D 0) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Copy into a bounce buffer under mdevs_lock and advance *pos, then
> +	 * perform copy_to_user() outside the lock. This avoids stalling
> +	 * all host mdev operations if userspace passes a buffer that faults.
> +	 */
> +	bounce =3D kmalloc(len, GFP_KERNEL);
> +	if (!bounce) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return -ENOMEM;
> +	}

[Severity: Medium]
In drivers/s390/crypto/vfio_ap_migration.c, vfio_ap_get_config() allocates
ap_configuration using kvzalloc() with GFP_KERNEL_ACCOUNT because a guest's
configuration can hold up to 65,536 queues, making mig_file->config_sz up to
1,048,624 bytes:

	ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);

	ap_configuration =3D kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);

In vfio_ap_stop_copy_read(), len is clamped only to mig_file->config_sz - *=
pos
and passed directly to kmalloc(). When userspace reads the full migration
blob in a single read() call for a guest with a large queue configuration,
this requests up to an order-9 (2 MiB) physically contiguous allocation
without vmalloc fallback or memcg accounting, which can fail and trigger pa=
ge
allocation warnings on fragmented hosts.

Should vfio_ap_stop_copy_read() allocate bounce with kvmalloc() using
GFP_KERNEL_ACCOUNT and free it with kvfree() instead of kmalloc() and
kfree()?

> +
> +	memcpy(bounce, (char *)mig_file->ap_config + *pos, len);
> +	*pos +=3D len;
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	if (copy_to_user(buf, bounce, len)) {
> +		kfree(bounce);
> +		return -EFAULT;
> +	}

[Severity: Medium]
What happens to filp->f_pos if copy_to_user() fails in
vfio_ap_stop_copy_read()?

In drivers/s390/crypto/vfio_ap_migration.c, vfio_ap_stop_copy_read() sets
pos =3D &filp->f_pos, advances *pos +=3D len, and drops matrix_dev->mdevs_l=
ock
before calling copy_to_user(). If copy_to_user() faults and returns non-zer=
o,
the function returns an error while leaving filp->f_pos permanently advanced
past the unread bytes.

Because vfio_ap_open_file_stream() opens the migration file with
stream_open(), seeking and pread() are rejected, so userspace cannot rewind
the stream. Any subsequent read() will silently skip those len bytes or
observe end-of-file prematurely, corrupting or truncating the saved migrati=
on
state. In addition, because stream_open() clears atomic position locking on
filp->f_mode, dropping matrix_dev->mdevs_lock after advancing *pos but befo=
re
copy_to_user() allows concurrent readers to advance *pos further, preventing
a safe rollback and allowing out-of-order stream delivery.

Can *pos be updated only after copy_to_user() succeeds (or only by the numb=
er
of bytes actually copied), while keeping concurrent reads serialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D7
