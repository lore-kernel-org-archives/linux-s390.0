Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D242379A;
	Wed, 12 Aug 2026 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537004; cv=none; b=EvT4YML+X6enEe8CIucxagPUnZuqgzSC323jtYRJL/FN1e1rAbBA5fzn5i4cQTYUZ+6/E48+Sc1ORcFLrCANEbw+CKMvXRTPPzSYlntpEfYqLBw8FjJRM8fYgDEbpssoG6NRYjwnbrm5qiybzB0hddxd73W8ZN6Icbqy4chGwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537004; c=relaxed/simple;
	bh=Y5pNa2ZPZ7QOHTj6Z58dqlvKaeRh8BMGM3eywtqMoJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CFw7jWy9a8VdG5efRUZDoLZe1gd+LN/DfoeXVRw6+OuWEWPldPehbzTuthCH2pc2SsNP9RKUhMaYzFtRNdDaUD2hs+KqUi5EIPxZnIzsWyzDcLnWECD0WhsKz/59BLEkvUlPUKizpBqTF58xAtA4hTTg+2ccpq44gQCRRumLE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9U25A74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9U25A74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CB51F000E9;
	Wed, 12 Aug 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786537000;
	bh=4BnkytiivFlkjj/n+bqyy+yetlhSRKDyFGU72RBw26M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9U25A74ggnD1S0OLRn4/U5HnKAcWZyG3IeRtW597VepRK2L3o41dUU27APKbjnIG
	 zAaIYNhb16vVlTQlBrQEKTTH/xR4m6NXGfhGS/BjhI5SrZ+VPLUX+6x3By9vb6EuwE
	 AewW4hsnA/U8ON9AhuJKBDu2if2llQT0HbwmGHw4gMqtnEw6tL7W8U+slQmqF47QhV
	 mZgkKK4AYqf69AkAH3BvoSdxNRrjZjwQd7qAqWl7e2qoZapLAZtf92P9DYGenUVQDs
	 /+XFzSQW//4vlTrx4629vuCK563pGcYvGzecWI1KU5palwMtwWii5qfdZ+82uT3bZV
	 0q0wmqhT9YiAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812115139.576303-9-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:16:39 +0000
Message-Id: <20260812121639.90CB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ABBA deadlock in the probe error path between kernfs active refere=
nce and guests_lock.
--

--- Patch [8]: [PATCH v3 8/9] s390/vfio-ap: Fix NULL deref in status_show()=
 during queue probe ---
commit dd5ddcd73e238630c53e21354f9251a158e8bee2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix NULL deref in status_show() during queue probe

This commit fixes a NULL pointer dereference in status_show() during queue
probe by acquiring update locks before creating the sysfs attribute group.
This ensures any concurrent read blocks until driver data is set and locks
are released.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index cb1e5db69d8a7..3652ba792be73 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2419,14 +2419,17 @@ void vfio_ap_mdev_unregister(void)
> =20
>  int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>  {
> -	int ret;
> +	int ret, apqn;
>  	struct vfio_ap_queue *q;
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	struct ap_matrix_mdev *matrix_mdev;
> =20
> +	apqn =3D to_ap_queue(&apdev->device)->qid;
> +	matrix_mdev =3D get_update_locks_by_apqn(apqn);
> +
>  	ret =3D sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
>  	if (ret)
> -		return ret;
> +		goto err_release_locks;
> =20
>  	q =3D kzalloc_obj(*q);
>  	if (!q) {
> @@ -2434,11 +2437,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *ap=
dev)
>  		goto err_remove_group;
>  	}
[ ... ]
> @@ -2468,6 +2470,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apde=
v)
> =20
>  err_remove_group:
>  	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);

[Severity: High]
Does this create an ABBA deadlock on the error path?

If kzalloc_obj() fails, we jump to err_remove_group and call
sysfs_remove_group() while still holding matrix_dev->guests_lock (acquired
via get_update_locks_by_apqn()).

If a concurrent reader opens the 'status' sysfs file before we hit the error
path, it acquires a kernfs active reference and blocks on:

status_show()
    mutex_lock(&matrix_dev->guests_lock);

Then sysfs_remove_group() blocks in kernfs_drain() waiting for the reader to
release its active reference, resulting in a deadlock.

> +err_release_locks:
> +	release_update_locks_for_mdev(matrix_mdev);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D8
