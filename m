Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065775;
	b=IIv7vPBU3EEpE8/UlZ3ntjot4/IVVOQzPXe5CS57Hp5uWEHLJKnRLCuh7OXOHaqRJYCD
	 Bv2e8XRR1wIrPZ3tnyjkU8ENT/KbJjZd54CEUcCzAW6OfQmsP8eg7TB+jvqNuiFh7526v
	 wP3M8DGOwqYFKqAxn4vZaZI9IjTYCnzZlCt8fYPVM6cH/hOf9N+scBCy/Tb5fuTgTkW2J
	 JhOX+u68dAE4jmS0JvjjYPWrJpAzCpg+SM73kRMrrMKN27txh3V5z7zI0T42sySsCt8cr
	 xJkjp2w6Ys5mUAmuT5y95DhK7ZNBTKIYgNz454LReM/wIcuq0LbsR+jHxIhjmC1T6hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065775;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pe74ZXYn2WDsw3Ol33eh4++aTps2Da/80GDrdZC3gDk=;
	b=U5x+CBhoVYAY0fsnB/2vGpOydN+zIEND9KOMX9zTEfAdPHKGpLK4JgD2N82KyGeZqjqi
	 ywcyDl/VXeG3sa47amfOgCGNloDPQIZlORFLBHtCIW4EgIzEWgkEUvUg4Ju0MM5h1RBWF
	 IKhMIQtJWpyJ/9+ospquxPQ2Fc6S4wO9wpfN11Ypy7dWwG8AERcj38kigD45V5RW10b4X
	 BMzVwvoNeB5K7HTjMfJ1+hrWceNKbAR+bLoeU2FT0yGj2io58Sw+LUcSULqUQzt23SRT5
	 15F0gKH1vWxfv/qqBK3ZNv/Jrta8pPqgw6F72EnklizduDLnujxzjzTOLPfslAUs4ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUU17zE8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202A606A320;
	Thu, 19 Nov 2026 05:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUU17zE8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16461F000C4;
	Thu, 19 Nov 2026 05:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065775;
	bh=pe74ZXYn2WDsw3Ol33eh4++aTps2Da/80GDrdZC3gDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUU17zE8VpihVtbndd7sY+fXqYy6N3WSv0yJc7A5PDv4B/3tUtdtoqZGPLDr8vlUn
	 j7AD1Gc/hXQKbGBmXmg6Vh5bwZV9Ivkpg6wNnxgXitHoGQiEPFfewqwwoLiA2rKFLq
	 hg97ESfJscX9f3SUZAAuoTZ8j/4f4+kmMVvJ4h9ATRJcObNUBYru4yJKOBHzJ7cW6V
	 jQWnOMKZu0B85eoOxFtOC2f7J3lzHtCRnyu3X79C3aH8Xaj2QWGgfaWsg0dN0jpZHe
	 n8tJKFbKCsS7KmElKp9NTS+e2ox/6mtZZynHCzU/cnduplZ/OHRQooOAbQPpKWUcsU
	 /UKC0GS0N5z5A==
Message-ID: <sashiko-outbox-222474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/vfio: Allow untainted use of driver_override
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex@shazbot.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119051507.3306075-1-alex@shazbot.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261119051507.3306075-1-alex@shazbot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 05:22:54 +0000
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
- [High] s390/vfio: unknown field support_driver_override in struct
  device_driver
--

commit a91edca560e83afe4c0101413f2c0a4218259662
Author: Alex Williamson <alex@shazbot.org>

s390/vfio: Allow untainted use of driver_override

This commit sets the support_driver_override flag on the vfio_ccw_sch_driver
and vfio_ap_drv driver structs.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 7546bd137e4e1..77765cde87f78 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver =3D {
>  	.drv =3D {
>  		.name =3D "vfio_ccw",
>  		.owner =3D THIS_MODULE,
> +		.support_driver_override =3D true,
>  	},
>  	.subchannel_type =3D vfio_ccw_sch_ids,
>  	.irq =3D vfio_ccw_sch_irq,
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio=
_ap_drv.c
> index 8e69ed286bb9c..2d47dc6432698 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv =3D {
>  	.on_config_changed =3D vfio_ap_on_cfg_changed,
>  	.on_scan_complete =3D vfio_ap_on_scan_complete,
>  	.ids =3D ap_queue_ids,
> +	.driver.support_driver_override =3D true,
>  };

[Severity: High]
Does struct device_driver have a support_driver_override member in this
tree?  Without the driver-core prerequisite adding that field to struct
device_driver in include/linux/device/driver.h, building vfio_ccw_drv.c or
vfio_ap_drv.c fails with an unknown field error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119051507.3306=
075-1-alex@shazbot.org?part=3D1
