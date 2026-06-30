Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F33F8236;
	Tue, 30 Jun 2026 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817495; cv=none; b=Kk9t1nB2XGMXePk1PQHt4O/6Am4IQMTo0ucneYjoX9lhFQf8Ua3xhBqO4mo87Os24hPwT7xoYnK1+pmnrYBa63L9lSjwzakvSxjps9Su6qlIkHuDoPerzRsQTU3x2irXxOLkJ4MmNVLQI2jqXnurtB9PP/rp3hJszOB8EjXYIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817495; c=relaxed/simple;
	bh=N9/bH/yp/PkL6WR/lUUvUIJHqDTDNEvrPZQppyFucxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=joVE9e+ovTV53/u/xIh6gszN7wJ4kRD2Lx9lein4wOuUV+6saZykcx1V1c4sm4IAj2ZLKqeytYL1e+rHiD9WG6eZFD9E6S5gj6CqRDh0oTBYNbMMdbOaKXyrNa6A3RYxzgqTAGD36cblnJAjajUSuBNQ1cHZ0akVZtoehY1A0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeowBjvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeowBjvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E121F000E9;
	Tue, 30 Jun 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817494;
	bh=gOW7gUurJ4uVHBkmFyzwUE3xZenwq/l96TeNgbtvpio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GeowBjvCqhk7zkrQUdbrRuF4Gr5rT0QCMZRjV4FU6WstnI86M4C5A4lCwfHULm0gL
	 E5XMoJY/al675x8NcXXV0cghLJTcvcKOlq646cAD4Z4xPNqx2m0UgjY7jcPDT7fzLX
	 DeLPf6wV9QQ80hixW7s0k0zPZ70AMOiOTkw/a1+QjH6VlzqC6NLd5m5iF7LOQDstaf
	 nbji3FFvQEaQDdXce1vH9ErwwIqNUMkjBMIzV/JX76f9/q0En6S+AsdwHDTkofg8Kj
	 gFgFzrVjZTlcmAHwXRJE/xf9DUhFxk0cuk4i6KkO2EJLtVjqXDw79TdXczPuKFX1NJ
	 RraUWAY8JLEtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/15] s390/vfio-ap: Initialize/release vfio device
 migration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260630104132.1598851-4-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
 <20260630104132.1598851-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:04:53 +0000
Message-Id: <20260630110453.A2E121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Self-deadlock in the error path of vfio_ap_mdev_probe() when vfio_=
register_emulated_iommu_dev() fails.
--

commit 5aa03de641783e67e8d873c30619dc8b515b536e
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Initialize/release vfio device migration data

This commit provides functions to initialize and release data structures
used during live guest migration. It also adds a release callback for the
vfio device to clean up the migration data when the mdev is released.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> +static void vfio_ap_mdev_release_dev(struct vfio_device *vdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D container_of(vdev, struct ap_matrix_mdev, vdev);
> +	vfio_ap_release_migration_data(matrix_mdev);
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +}
> +
>  static int vfio_ap_mdev_probe(struct mdev_device *mdev)
[ ... ]
> @@ -797,19 +809,30 @@ static int vfio_ap_mdev_probe(struct mdev_device *m=
dev)
>  	if (IS_ERR(matrix_mdev))
>  		return PTR_ERR(matrix_mdev);
> =20
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
[ ... ]
>  	ret =3D vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>  	if (ret)
>  		goto err_put_vdev;
[ ... ]
>  err_put_vdev:
>  	vfio_put_device(&matrix_mdev->vdev);
> +	mutex_unlock(&matrix_dev->mdevs_lock);

[Severity: High]
Does this create a self-deadlock when vfio_register_emulated_iommu_dev()
fails?

In this error path, matrix_dev->mdevs_lock is held when calling
vfio_put_device(). If this drops the last reference, it will synchronously
invoke the device's release callback, vfio_ap_mdev_release_dev().

Looking at the newly added vfio_ap_mdev_release_dev() above, it
unconditionally attempts to acquire the exact same matrix_dev->mdevs_lock.
Could this cause the thread to hang indefinitely since the non-recursive
lock is already held by vfio_ap_mdev_probe()?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630104132.1598=
851-1-akrowiak@linux.ibm.com?part=3D3
