Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639389;
	b=CbVvaA3ai0RmNbXT4Ywprae947EtWgciEyMkUzDCGfwLdXvPmfYdqJ8W2wd41QE8CSMI
	 7oGcoRpX9FifRMiw4bLAIdrMGYPaqmr2sxEMBff/aETEae++BsyLhroRyjpA5BNSKJ85/
	 uLz9zCVDqgu1qAl1jNV9eh8njXX7usi9z82+uKqc3Sh/tFqfMYrSkheaJLDnB/V4w6CtW
	 f2tHKPMX9tJSqrSwuPxvNzKSeIO3skm5P3CGjTo7Qa6WZSttD7rfmrWgxaNgHGTHgntWI
	 rI5s1lfRLkwk0dvPWKpLGuLhMOi0opHnxjQS0qHaAZ1z3k5f/01GHVWi5b5BkSUy1Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639389;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2DZ1zvFiyUdPiMpjcPyT89GsGFeQ1qQf0z+hcbf5ZUQ=;
	b=KsfdVe8OgaxNH8uuleReRWhNWYErqZUcjsw2h7H/BKsMTZbnaM8wdJOn8quMVsH6DOX0
	 fAxYS+0XTyPMsrZTPK3ebRN/O6zGGBZU5N1LEzudOvbtP6YyBBCmZHxDe5Pny1WG0a6vb
	 qiZaI65bCNpOzH5TrhOzsAxszfrwwmgrnkTtAPQ0TEj8ryPbJhMmxQWp3koQXBAcMLgVL
	 A5i4N8IPS5sdvAJu+PAeMPz8PRp6jmiJBgf4bOMEwNQVOOvNEc3aA6E50lzf+zfXpRdDu
	 O4lNDuvZdRy/zknWQIxSLf+jHUsn7c/SS0iJ38fF3+aXIGbwjdPSJ5Sb+o+hk14swxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA2q0AkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F4606A90F;
	Mon,  2 Nov 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kA2q0AkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F741F00A16;
	Mon,  2 Nov 2026 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793639388;
	bh=2DZ1zvFiyUdPiMpjcPyT89GsGFeQ1qQf0z+hcbf5ZUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kA2q0AkELlrkhlssQ/Of2B5L1LykJYz4FkHBNYh4h+n3cAT7esH9kg5zMekGInDlv
	 tR+dX0tJWHi49tCEdh+7ee0IrrwOAU9i8stVW4G3UTWmIRqnACSCGzkiJ6hlaH1dUI
	 M+X0AdGUsyy9Ahpzs2uDbJ19iksDz9QvbvrHEhIYzhgb+Mabn80Z+1RszC65n53SaW
	 EetXtOrE7IgQpLcUrsD7UyyDqyfWat1j7Xdx+3cd8zx7w2FOFl976LfGhJoFGTLGAI
	 rvFAYF813ivZqJZicUvv/yNDhgFiziEL8r1uMOpKkG/jUlbDCRjX0B/DcZn3POXQWm
	 7NocSTflAmZQA==
Message-ID: <sashiko-outbox-193805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/14] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-10-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:09:48 +0000
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
- [High] s390/vfio-ap: use-after-free of mig_file in vfio_ap_resuming_write=
()
- [High] s390/vfio-ap: fortify panic in vfio_ap_resuming_write() on chunked=
 writes
--

commit 05b49746b964ad1916518e2c783de5c6220f1f14
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback for the migration file stream used
during the RESUMING phase to receive and validate the source guest's AP
configuration on the destination host.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 526d83e8590d9..47f05e43b9e0e 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -466,11 +511,562 @@ static struct file *vfio_ap_open_file_stream(struc=
t vfio_ap_migration_file *mig_
>  	return filp;
>  }
> =20
> +static int validate_resuming_write_parms(struct vfio_ap_migration_file *=
mig_file,
> +					 struct file *filp, size_t len)
> +{
> +	loff_t total_len;
> +
> +	lockdep_assert_held(&mig_file->lock);
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	if (!len || filp->f_pos < 0)
> +		return -EINVAL;
> +
> +	if (!mig_file->matrix_mdev->mig_data)
> +		return -ENODEV;

[ ... ]

>  static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
>  				      size_t len, loff_t *pos)
>  {
> -	/* TODO */
> -	return -EOPNOTSUPP;
> +	struct vfio_ap_migration_file *mig_file;
> +	struct vfio_ap_config *ap_config;
> +	ssize_t ret;
> +	void *kbuf;

[ ... ]

> +	mig_file =3D filp->private_data;
> +	mutex_lock(&mig_file->lock);
> +	mutex_lock(&ap_attr_mutex);
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	pos =3D &filp->f_pos;
> +
> +	ret =3D validate_resuming_write_parms(mig_file, filp, len);
> +	if (ret)
> +		goto out_unlock;

[Severity: High]
Can this trigger a use-after-free on mig_file if the VFIO device file
descriptor is closed while the migration file descriptor remains open?

In vfio_ap_resuming_init() -> vfio_ap_open_file_stream(), filp->private_data
is set to &mig_data->resuming_mig_file, which is embedded inside
matrix_mdev->mig_data:

drivers/s390/crypto/vfio_ap_migration.c:
struct vfio_ap_migration_data {
	enum vfio_device_mig_state	mig_state;
	bool				resuming_mig_data_complete;
	struct vfio_ap_migration_file	resuming_mig_file;
	struct vfio_ap_migration_file	stop_copy_mig_file;
};

While vfio_ap_open_file_stream() calls vfio_device_try_get_registration() to
keep matrix_mdev alive until vfio_ap_release_mig_file() runs, closing the
VFIO device file descriptor invokes:

vfio_ap_mdev_close_device()
  vfio_ap_release_migration_data() {
	...
	vfio_ap_release_mig_files(matrix_mdev);
	mutex_destroy(&matrix_mdev->mig_data->stop_copy_mig_file.lock);
	mutex_destroy(&matrix_mdev->mig_data->resuming_mig_file.lock);
	kfree(matrix_mdev->mig_data);
	matrix_mdev->mig_data =3D NULL;
  }

Although validate_resuming_write_parms() checks
!mig_file->matrix_mdev->mig_data under matrix_dev->mdevs_lock, mig_file
itself lives inside the freed matrix_mdev->mig_data object. Calling
vfio_ap_resuming_write() after or concurrently with
vfio_ap_mdev_close_device() will lock and unlock the destroyed
mig_file->lock and dereference mig_file->matrix_mdev in freed memory.

> +
> +	ap_config =3D mig_file->ap_config;
> +	memcpy((char *)ap_config + *pos, kbuf, len);
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

[Severity: High]
As reported by Sashiko on v9 [1], can the memcpy() in
vfio_ap_resuming_write() trigger a fortify_panic() on chunked writes when
CONFIG_FORTIFY_SOURCE and CONFIG_CC_HAS_COUNTED_BY are enabled?

In struct vfio_ap_config, qinfo[] is annotated with
__counted_by(num_queues):

struct vfio_ap_config {
	u32				magic;
	u32				version;
	u32				num_queues;
	u8				reserved[4];
	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
};

Although vfio_ap_resuming_init() initializes ap_config->num_queues to
MAX_AP_QUEUES, fortified memcpy((char *)ap_config + *pos, kbuf, len)
evaluates __struct_size((char *)ap_config + *pos) using the current value of
ap_config->num_queues in memory before the expected_sz check runs:

1. Once an earlier chunk writes the header with num_queues < MAX_AP_QUEUES,
   the dynamic object size of *ap_config shrinks to expected_sz. If a
   subsequent write() supplies more bytes than expected_sz - *pos (while
   staying within VFIO_AP_CONFIG_MAX_SIZE), memcpy() executes before the
   *pos > (loff_t)expected_sz check and calls fortify_panic() instead of
   returning -EINVAL.

2. On big-endian s390, MAX_AP_QUEUES (0x00010000) has bytes 0x00, 0x01,
   0x00, 0x00 at offsets 8..11. If an initial chunk of 10 or 11 bytes writes
   the upper two bytes of a valid num_queues < 65536 (0x00, 0x00),
   ap_config->num_queues in memory becomes 0. If the next chunk writes past
   the header into qinfo[], fortified memcpy() evaluates __struct_size()
   with ap_config->num_queues =3D=3D 0 before copying the remaining bytes of
   num_queues, triggering fortify_panic() on valid migration data.

[1] https://lore.kernel.org/r/sashiko-outbox-170099@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D9
