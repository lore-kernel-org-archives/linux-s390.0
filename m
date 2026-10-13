Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BC4F7CA5;
	Tue, 13 Oct 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908043; cv=none; b=jq5ArdxttOtMmW/oGQM3T68ZQPjx25WFRBsXgC2fC8lfLqR5tG7Hfqtu86WBGLceRJiFhd7lB9idlP3RxAS7qPXLT0+SRhwpWpqTy+fogpzWeWA6bd9vTl80WzU+AsU8w79FeDNsSQKCaO0twTiTOOkv7/EtuFopK4h9hInOLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908043; c=relaxed/simple;
	bh=Te0JuFUGiR3YFM2NiTmT8CoF777bF8HGFLxMcv7KUhc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Wt0VJchORZd4GsMXEUNBsizFD6m+hX0g3AGxfT2ackaJ5/2ZLaaQXIQbFL9zBgfqWRL28u8ItLgzLNfRxBfwNM8VjkTQLRtjy/408cSlu5JQ9vubko61z9lGyrMF/B5fK2iiIxhjtgOm2uQFdii4dIVLVsemFkAMNThH1nZtrd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrZZ1VGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrZZ1VGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E031F000FF;
	Tue, 13 Oct 2026 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908041;
	bh=gpUjPc8OfT4N4hzuLGdVqasz3+4fGzOZrTqKV6VCJ/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrZZ1VGNsE7C9zSK7OWU251hdZrTDJ4af8JLpZ6kxFmPGJXxjZHbEWvjjqdRiZ6sA
	 pbv1YN9KN3r5pwQ5xyi4WVPTJqVVanwIp2ZXyiD/tjgPqvr4MVxHyF1REvdOOrtKwM
	 D/0t50WteKqYSZqApPlru+rk2i2Eqyeq6hyB966Et8qK/IiKpbYcpKjEKTroYAL4wJ
	 wsgCDRulqxOt4caH+VXzRv1j9PQoWxjWhdFQ24trMXCuLH1cCRZmGcPECFFBYnZ7ur
	 Kj+CGVHwUfrmmuIpsY4DKYHwfQ2s08z/pVewSrMz4qxavvfHu5HbYKEyfSpWzeJn2Q
	 2n99nkbvhmGnA==
Message-ID: <sashiko-outbox-170099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/15] s390/vfio-ap: File ops called to resume the
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-12-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:14:01 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] fortify: __counted_by() traps on memcpy() of ap_config causing ker=
nel panic
- [Low] build: incompatible pointer type warning for num_queues in vfio_ap_=
get_config()
--

commit 1f3606fec30cc37e82a55e4d85b768771f43fc2f
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: File ops called to resume the vfio device migration

This commit implements the write callback function for the file stream
created to restore the state of the vfio-ap device on the destination syste=
m.
Userspace reads the source guest's saved vfio-ap device state and writes it
to this file stream. The write callback copies each chunk into a pre-alloca=
ted
vfio_ap_config structure and validates it against the destination host's
configuration.

> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> @@ -284,7 +340,7 @@ static int vfio_ap_get_config(struct ap_matrix_mdev *=
matrix_mdev)
> =20
>  	lockdep_assert_held(&matrix_dev->mdevs_lock);
> =20
> -	ap_config_size =3D vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
> +	ap_config_size =3D vfio_ap_config_size(matrix_mdev, &num_queues);

[Severity: Low]
Is it possible this causes a build failure? vfio_ap_config_size() expects
an int pointer for its second argument, but num_queues is declared as an
unsigned int. Passing an unsigned int pointer here introduces an
incompatible pointer type warning which breaks the build under
CONFIG_WERROR.

[ ... ]

> +static ssize_t vfio_ap_resuming_write(struct file *filp, const char __us=
er *buf,
> +				      size_t len, loff_t *pos)
> +{

[ ... ]

> +	ret =3D validate_resuming_write_parms(filp, len);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ap_config =3D matrix_mdev->mig_data->resuming_mig_file.ap_config;
> +
> +	memcpy((char *)ap_config + *pos, kbuf, len);

[Severity: High]
Does this memcpy() trigger a fortify panic? The struct vfio_ap_config
utilizes the __counted_by(num_queues) annotation for its flexible array.
During the resuming phase, ap_config is allocated with num_queues initializ=
ed
to 0.

Because memcpy() is fortified, it evaluates the maximum size of the
destination object using __builtin_dynamic_object_size(). At the time of
this memcpy(), ap_config->num_queues is still 0, so the compiler evaluates
the destination capacity strictly as the struct header size.

If userspace writes the migration data in a chunk larger than the header
size, the bounds check will fail before num_queues can be overwritten,
triggering a panic and crashing the system.

> +	*pos +=3D len;
> +
> +	/*
> +	 * Check whether we have received all the data.  We know the total
> +	 * expected size once num_queues has arrived, i.e. once *pos is past
> +	 * the fixed header.  Until then keep accumulating.
> +	 */
> +	if (*pos >=3D offsetofend(struct vfio_ap_config, num_queues)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D11
