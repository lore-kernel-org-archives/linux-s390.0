Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779327;
	b=mfTcuitsf9F8hDLesi5W218SM9WzA/r9SjMKouFCLC25XM5e/mJZe0GoF9n+jeyFksIN
	 ANKpa4lnBiySusevBo2bmI9yJ5Cbk29hFzztVxWzPsXgZ0s0AleVX7IAB+1wx00UGIwTZ
	 SIF8GNy3TMowvRhQ7uFsCTLN3SibHqtiDC/QGHeXhJSFvdBXsCCQx0BQ5eTgXi9Z1pYGp
	 QL/6rloty+ab7mo/lvl1n1mboMkBfiC64dhNrjFVe1SaOddfaMudkYS3aEzDiLzIvWLtR
	 hJLVebeh/95DxGw9Y3vaYqMYlRSV5XgLskVboLqxnICeXXhIYpQWraeWXtMJZvm5yJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gBypaeOx2UVfhXTPFYYB/sKuC2VbBKZzpJ3QAeJ4meI=;
	b=hGkQMFOWYjhuVgC3KoDUCaSyBvfchIPcV1QkBFrAYgBRTbqjWy31E5c8oq/q15h3NEjY
	 QIOjSpMVjOklSf92P5MlgHmJC12O+A3SOYsYoaT0Tm1UkyHOA10FQtUzRLdF4qeXxQUxT
	 ss3V7FGINcWwLkjF3l5t4P3bMSik0BwxQvZmdDXEuLK6wFaS4ZL5fKDPmrl4HJyes/Iw9
	 1wm+p6X/KV9/A5LJqdqII/qpdVCT9jNgh0H8xlaXxdl88BgIOqLTIJI9UpXl3OpIB4EEF
	 4gCx37MAEH000f6yrwJsv9SxKp+7Eg9qId8bhRb3XXwwCppDc9aqE+pjle9kTaQoDWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdehSyiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61036606A326;
	Fri, 23 Oct 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdehSyiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379641F031E1;
	Fri, 23 Oct 2026 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779327;
	bh=gBypaeOx2UVfhXTPFYYB/sKuC2VbBKZzpJ3QAeJ4meI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VdehSyiNpw76RTZweyxGXWfrq2+lGW+hiEiCoDNdgMsjYFV1CECUH7ntGhF6iN1Rc
	 lpAzPbPx9ATsuPsZrZwEbVm5Fu5mjkEK3suQHmwB0FoIDyZ3eEKQPnDPR3z59Qegj9
	 4ezebeHj3akTernW77AKJi/BFHg8M7gB1rTb9fgEclljNL4vVlyo5nZ55Vjy2mNAFy
	 E/mvlf9I+Xo5ig2cesuL4bRqWu98EPQk37d2xvpQBL6znkXUeYU1CjYnpmc8m52Vw0
	 HcKGvOveBOvFDw6sFfoKzli0IAJHcvVl9OkTEwMRz0CtH2twJeFonHzSnql3iojyg2
	 gp6Xd84bCXoSA==
Message-ID: <sashiko-outbox-183055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-11-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:15:25 +0000
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
- [High] s390/vfio-ap: fortify panic in vfio_ap_resuming_write() due to __c=
ounted_by
- [Medium] s390/vfio-ap: corrupt f_pos and completion state in vfio_ap_resu=
ming_write()
--

commit 1a397bedb442875a3f4830b60abce45f72b37dfd
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback for the resuming migration file
stream in drivers/s390/crypto/vfio_ap_migration.c, accumulating the source
guest's AP configuration into a pre-allocated vfio_ap_config buffer and
validating compatibility against the destination mdev's shadow_apcb and
hardware capabilities.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 9ed657c7302e9..469fa09ec9087 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -451,11 +506,562 @@ static struct file *vfio_ap_open_file_stream(struc=
t ap_matrix_mdev *matrix_mdev,
>  	return filp;
>  }
> =20

[ ... ]

>  static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
>  				      size_t len, loff_t *pos)
>  {
> -	/* TODO */
> -	return -EOPNOTSUPP;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_config *ap_config;
> +	ssize_t ret;
> +	void *kbuf;

[ ... ]

> +	matrix_mdev =3D filp->private_data;
> +	mutex_lock(&ap_attr_mutex);
> +	get_update_locks_for_mdev(matrix_mdev);
> +	pos =3D &filp->f_pos;
> +
> +	ret =3D validate_resuming_write_parms(filp, len);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ap_config =3D matrix_mdev->mig_data->resuming_mig_file.ap_config;
> +
> +	memcpy((char *)ap_config + *pos, kbuf, len);

[Severity: High]
Will this memcpy() in vfio_ap_resuming_write() trigger a fortify_panic() wh=
en
built with CONFIG_FORTIFY_SOURCE=3Dy and CONFIG_CC_HAS_COUNTED_BY=3Dy?

In drivers/s390/crypto/vfio_ap_migration.c, struct vfio_ap_config declares =
its
flexible array member with __counted_by(num_queues):

struct vfio_ap_config {
	u32				magic;
	u32				version;
	u32				num_queues;
	u8				reserved[4];
	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
};

When vfio_ap_resuming_init() allocates ap_config via kvzalloc(),
ap_config->num_queues is zero-initialized. In vfio_ap_resuming_write(),
fortified memcpy() evaluates __builtin_dynamic_object_size() on
(char *)ap_config + *pos before copying the bytes from kbuf. Because
qinfo[] is annotated with __counted_by(num_queues), the compiler computes t=
he
remaining object size from the current value of ap_config->num_queues:

  sizeof(struct vfio_ap_config) +
  ap_config->num_queues * sizeof(struct vfio_ap_queue_info) - *pos

When userspace writes a configuration containing one or more queues in a
single write() call (or a chunk spanning across num_queues into qinfo[]),
ap_config->num_queues is still 0 when the bounds check runs, so p_size is
at most sizeof(struct vfio_ap_config) while len is larger, causing
fortify_memcpy_chk() to call fortify_panic().

Similarly, even if an earlier chunk already populated ap_config->num_queues,
memcpy() runs before the *pos > (loff_t)expected_sz check below, so a write
that exceeds expected_sz will also trigger fortify_panic() instead of
returning -EINVAL.

> +	*pos +=3D len;
> +
> +	/*
> +	 * Check whether we have received all the data.  We know the total
> +	 * expected size once num_queues has arrived, i.e. once *pos is past
> +	 * the fixed header.  Until then keep accumulating.
> +	 */
> +	if (*pos >=3D offsetofend(struct vfio_ap_config, num_queues)) {
> +		size_t expected_sz;
> +
> +		if (ap_config->num_queues > MAX_AP_QUEUES) {
> +			ret =3D -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		expected_sz =3D sizeof(struct vfio_ap_config) +
> +			      ap_config->num_queues *
> +			      sizeof(struct vfio_ap_queue_info);
> +
> +		if (*pos > (loff_t)expected_sz) {
> +			ret =3D -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		if (*pos =3D=3D (loff_t)expected_sz) {
> +			ret =3D do_post_copy_processing(matrix_mdev, ap_config);
> +			matrix_mdev->mig_data->resuming_mig_data_complete =3D !ret;
> +		}
> +	}

[Severity: Medium]
Can advancing *pos and writing into ap_config before validating num_queues
and expected_sz leave filp->f_pos, ap_config, and resuming_mig_data_complete
in an inconsistent state on error?

In vfio_ap_resuming_write(), memcpy() and *pos +=3D len execute uncondition=
ally
before checking ap_config->num_queues > MAX_AP_QUEUES and
*pos > (loff_t)expected_sz. If either check fails, or if
do_post_copy_processing() fails, vfio_ap_resuming_write() returns a negative
errno while leaving filp->f_pos advanced and the invalid data in ap_config.

In addition, if a valid configuration is written completely such that
*pos =3D=3D (loff_t)expected_sz and do_post_copy_processing() succeeds,
matrix_mdev->mig_data->resuming_mig_data_complete is set to true. If a
subsequent write arrives with extra trailing bytes before the device
transitions out of VFIO_DEVICE_STATE_RESUMING, vfio_ap_resuming_write()
returns -EINVAL (or -EIO in validate_resuming_write_parms()) without cleari=
ng
resuming_mig_data_complete, leaving the stream marked complete after a fail=
ed
write.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D10
