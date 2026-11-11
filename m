Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429418;
	b=d7bm8t8sXtz161Jb9iDv5fmjiiTPJ/tZkF5Jora1zDJAHChO/FZ8Tv5//WuhBbqykZpA
	 vg7NKX1qRrRMmqjFpnRnGQc8N1irQNmsnj42n5JSNrU86c8I27qg9CZ5f37qhvdxn/HFg
	 P8nfaZmVHJn08LwWsZ6TRjbH/zTdT0MvF+M6atvRyaSW4A3WNOpZB6QPe0Rwa9s6cMg3g
	 7rghu9azMQsSJaZw52s+zzdIhpAfHdxBevekVRIDVCwiDbHE8usWrQsnc8kRlXpeXk5M4
	 AZUm7yst1oYEdovFNXtcvJaxEjVHinHyMUK+MTsClaPTAxNR2Rv+uBpmxahPCHHVRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3gbwYkOrYZ7ASQ3Qu8BJDhzDVxflBv+hXo9YLwtWMKM=;
	b=Vr/12yDqDuSAaoUxu+ETzY1J5qctvCBuwHqtbSr8XDB3wZzo9vX+BfXTR498amUlD8LX
	 cpX2DnpP6hEBhB8qeloswDHxisD7WSvsiF/u1ZY6SvNarZHh6YJt58xraoKVAt5MLurrm
	 heybzombNVbU2v5Msnnt2zKzzEmbXBbkhoyBUBVcP891EaOM1sQ/cUttM2UEzsqZX8I0x
	 JInuDW7cszmrHjtP2psjGRvrP/uGC5J4iNiygEJ40IdL3vDIMwSpYo80iF2qPDgVL3A00
	 lrRZyiFqa94+HYxZoqOePiL0VW1Nj+1ZE+1d8ud26DospeJRDodQhS1mT1/VnxYS3vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPDbCNSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE660A6F79;
	Wed, 11 Nov 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPDbCNSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE301F0283D;
	Wed, 11 Nov 2026 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429417;
	bh=3gbwYkOrYZ7ASQ3Qu8BJDhzDVxflBv+hXo9YLwtWMKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPDbCNSRj4jtOparufalL5WdcuQ8jRDCHaBJtPak9LDGxVxHbv0xJDcEl/2sV/bLj
	 gRC+6g+TSvr2vgPNzEZ2YLtTw2enLy8DcnJpKcseC/OAwJaQQPypfWIpf4i1fqfevQ
	 Y4LWQh3cNoeRHwIcE6aLQLhpwIEO5jL0ptUW2ra8doy5yXMh9d7k/UAyDv8QqacjAT
	 DAa1gkIJe/pSEIDsebONSz9VVTaygTx5AenGTEzcWb6fYf6O18ozjZbha6F5FFQLvV
	 BnNeVqn7fKoQZDZRuCelHbonnzy3o1qvJnKHvNIrJjXllRV+pH85NDfqb7svmTgbUO
	 cvNJMXN4SCBkA==
Message-ID: <sashiko-outbox-209669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/14] s390/vfio-ap: Set up for vfio-ap device
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-13-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:36:56 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] s390/vfio-ap: incomplete kernel-doc on
  vfio_ap_setup_vfio_device_migration()
--

commit 4bbee35693e7530ca98001e694624b10c95b87d4
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Set up for vfio-ap device migration

This commit adds vfio_ap_setup_vfio_device_migration() to populate
vdev.mig_ops and vdev.migration_flags for non-SE guests and calls it from
vfio_ap_mdev_probe() before registering the device.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 4af734aeee17e..28370b1b3833e 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1316,6 +1316,28 @@ static const struct vfio_migration_ops vfio_ap_mig=
ration_ops =3D {
>  	.migration_get_data_size =3D vfio_ap_get_data_size,
>  };
> =20
> +/**
> + * vfio_ap_setup_vfio_device_migration:
> + *
> + * Plug the object containing the function pointers to the migration cal=
lbacks
> + * used to facilitate migration into the vfio device and set the flags
> + * indicating migration states STOP, STOP_COPY and RESUMING are supporte=
d.
> + *
> + * @matrix_mdev: pointer to object containing the vfio device (vdev)
> + */

[Severity: Low]
Does this kernel-doc block need a short description on the identifier line
and @matrix_mdev placed before the body description?  Without a short
description after the colon, running kernel-doc with -Wall (make W=3D2)
warns about a missing initial short description.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D12
