Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7D52F268;
	Tue, 13 Oct 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906425; cv=none; b=R3NGOTTSjr6yoPWhvXLJRN8VSfFvIwuc05fjs67aEF9gjdrt5OflwKyco41vuerOIrlIxW98OuQCLtuPf+AKDRxYDJR60eTLZmmgKeqHX+oqlekOOEhzGTXMwp9ohsPUWstMbHBg1sPI46fryT77byP4KeUmVueq3i7HsJkN3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906425; c=relaxed/simple;
	bh=8lmlYocTtrtVRxHJwjZJSw67ReGEHbGEgG8J8p6mM+g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TVjxWak+QG7IsJshqIeR6VrmS94Az6IaFUFbR/f+eZvp1XkpUxIfCdnd3jw8PiDRD4y6i3W3+rW9NqPEO00uB+tP6Y9fRO4hu6C3ozj0vmBLMKRfdf7uKu+M5eBOewfYcwqgok1INWbBYZmRWktuCTgQps8x1nGyCdTp/bDLn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+qLsnJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+qLsnJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D3B1F000FF;
	Tue, 13 Oct 2026 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906424;
	bh=hUluWN38/2QuS4IqfJWpMGAB+8f+2Udu41ReBaUeN4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+qLsnJboH+gBIZhK1qrNevsuZU9TUYiCZkWvK1GG0gH/04abv+y2Zd8c75VNpxXb
	 hh8UTkbgx+7IO+gOfxj9W6y8R5FZ+ZYTxlZK4U+rEl9rPZGQ/W+o7OBqWsxBZsMU0z
	 9aM396+xlBN61Z8MQVuN31zfCjAkfhf1jMP0ncd0/ozuzBqMXe+56qDF8XKUEGMdrz
	 gTwz9GVj5IN8iV0SXyGQW6Hfj1A6wYUUYmRYRrtIkHgRr89eYH7SDVd5sJo2Girvre
	 hDIVJDc7QQNFmbYQse1TKK1Jdo2fsiVt0bRt0ZFoJdNZFyO7dxh615gCVZyxLlq7Te
	 Sj5SlvlCLF1OA==
Message-ID: <sashiko-outbox-170040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-4-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:47:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/vfio-ap: Data race on matrix_dev->info during mdev init
--

commit 61bb5cee71d03ac3e82343abe74a853a264da523
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Functions to initialize/release vfio device migration data

Provides the functions that initialize and release the data structures
used during live guest migration.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 01439f0ca42ab..6829e423b5a46 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -782,18 +782,30 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_ma=
trix_mdev *matrix_mdev,
> =20
>  static int vfio_ap_mdev_init_dev(struct vfio_device *vdev)
>  {
> -	struct ap_matrix_mdev *matrix_mdev =3D
> -		container_of(vdev, struct ap_matrix_mdev, vdev);
> +	struct ap_matrix_mdev *matrix_mdev;
> =20
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
>  	matrix_mdev->mdev =3D to_mdev_device(vdev->dev);
>  	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);

[Severity: Medium]
Could this result in a data race on matrix_dev->info?=20

The modified vfio_ap_mdev_init_dev() reads matrix_dev->info via=20
vfio_ap_matrix_init() while holding only matrix_dev->mdevs_lock.

However, vfio_ap_on_cfg_changed() updates matrix_dev->info via memcpy()=20
while holding only matrix_dev->guests_lock:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_on_cfg_changed() {
    ...
    memcpy(&matrix_dev->info, cur_cfg_info, sizeof(*cur_cfg_info));
    ...
}

Since memcpy() is not atomic and the two functions acquire different locks,
can a concurrent AP configuration change cause vfio_ap_mdev_init_dev()
to read a torn or partially updated ap_config_info struct, potentially
leading to incorrect apm_max, aqm_max, or adm_max values?

Note that follow-up patches in the series do not resolve this lock mismatch.

>  	matrix_mdev->pqap_hook =3D handle_pqap;
>  	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
>  	hash_init(matrix_mdev->qtable.queues);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D3
