Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981129;
	b=u3MRKpnbI7tBGnXiJTAQPqRH6kLAxoA06F78c6m6nNynqmHd19uM8uzoHnfANRf1gBCn
	 1RGgJ6eWS8IpxG+qwIPa9fYCvarV7P+/YUFI/wCAOoYJk9uDO0exLIH11eKQIoY+/Rbvu
	 fYixC5GedptMzrnkzjVMVMTp609eu7FthiUgGRgqxgkvssA0RFLu5UH36uWwX/4tAf+Tb
	 1LvQH3R/3B0zz3nIG1xFLFZ10bSBWhtU3u95AB2nJr8N5sCeUj3m+Cvdk588rpkud/Fqu
	 CuN5noJGQ6ICsRZ0IBug8PUSTd36YEDXKTK/V3EZ2ovxuqSqJlQRFcCKWDDXGM0QYdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dU3SYWCiqLG33S6US1OY8J+eNIT6PIRRE4xw0m5wqIo=;
	b=GNec3iYvs9wQPBxTT4MNO4GEodnXSoNuet4G6F8/k4VKAhdwFcg8OwDNnVD21X+09RLY
	 OA0FfUjrHdX+8s8AWE6xFReCpBj+jRtu/I07vL008IwQPhLEzeHUQcKlRtJi5DBen1zwu
	 dFE/+j+SfU+MqAUuDMX7NoMe2OU9nR6HtAbJ3Azwg6FkS8R0Z9s+bWWDB2xrsBYdT8CvC
	 QozDIy+P3iJGGX9XSjNv0EEhv5LMNA6oNXOIkT09ERP3fJjKZRWV3zjmOaXwUkfqZnO3t
	 /bZtsaMpGaJ7rxCcpbrP8B19r21vZkZkSYhXKZhZc0HJ8yLtnFLtfBrFvHuIq3YUKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shvb7u89;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9698606A329;
	Fri,  6 Nov 2026 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shvb7u89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC06E1F0089F;
	Fri,  6 Nov 2026 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981128;
	bh=dU3SYWCiqLG33S6US1OY8J+eNIT6PIRRE4xw0m5wqIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Shvb7u892p5jNCeG1PKqumw7NVDodSOyK7cfqYRhjtpLSK3r1wRJr7umGdzCDjQVF
	 T6aDfE4WLR2Ecr2+MM0E9jirKtfvFOK/IIfrrwqmrd4JiMaKYeNIIP9DJsexXhv8vc
	 cRkSAu7W22rdB4ZkEQL8zGTi+ZUrPN5wjRxkhZC73hjTJV+CAfhb/q0qImlH1qywol
	 BbpBssBSG2Tq99mpMKfH10dYrtDJmnpxts3WXeTHsShLWBmj9Br88/1zoDdwnc1BQf
	 gYhXfAW9EAnrFAnSz2NS25LAh/GEXIliHp5D32vedUGgZ3Wt/nepyfX1/C8cGuXkx0
	 guwbbL9Oxxjdg==
Message-ID: <sashiko-outbox-201766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/14] s390/vfio-ap: Set up for vfio-ap device
 migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-13-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:05:27 +0000
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
- [Low] s390/vfio-ap: stale commit message in
  vfio_ap_setup_vfio_device_migration()
--

commit 91bb5c1f210ed8cb015ed15a312ace69b31f9fa7
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Set up for vfio-ap device migration

This commit adds vfio_ap_setup_vfio_device_migration() to configure
migration flags and callbacks on the vfio_device for non-SE guests and
calls it from vfio_ap_mdev_probe() prior to device registration.

> * The initial migration state of the vfio-ap device is set to RUNNING
>
> * The boolean flag indicating that all data sent from userspace during the
>   RESUMINMG phase has been received is initialized to false.

[ ... ]

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> index 4af734aeee17e..924c25585987c 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -217,6 +217,30 @@ static int vfio_ap_release_mig_file(struct inode *fi=
le_inode, struct file *filp)
>  	return 0;
>  }
> =20
> +static const struct vfio_migration_ops vfio_ap_migration_ops;
> +
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
> +void vfio_ap_setup_vfio_device_migration(struct ap_matrix_mdev *matrix_m=
dev)
> +{
> +	/*
> +	 * Live guest migration is not supported for SE guests, so there is no
> +	 * need to initialize the migration capabilities.
> +	 */
> +	if (ap_is_se_guest())
> +		return;
> +
> +	matrix_mdev->vdev.migration_flags =3D VFIO_MIGRATION_STOP_COPY;
> +	matrix_mdev->vdev.mig_ops =3D &vfio_ap_migration_ops;
> +}

[Severity: Low]
This isn't a bug, but the last two bullet points of the commit message
describe initializing mig_state to VFIO_DEVICE_STATE_RUNNING and
resuming_mig_data_complete to false, which was already done in
vfio_ap_init_migration_data() in commit "s390/vfio-ap: Functions to
initialize/release vfio device migration data" rather than in this patch.

Also, placing vfio_ap_setup_vfio_device_migration() after the definition
of vfio_ap_migration_ops alongside vfio_ap_init_migration_data() would
avoid the forward declaration of vfio_ap_migration_ops.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D12
