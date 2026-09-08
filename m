Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EF36F433;
	Tue,  8 Sep 2026 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846613; cv=none; b=KZgrStDW9DUrw+OFxC6AMhBmkSG8Q1QJ0GqUCiizuvoTvwOQbv0CLt5+CvO/Tn5l1T0t7ySalLmwFvfy1mIxxnxpyQWmSkSwSzuNh7f9TGLzLTNYosl1C2uB21tP1WpTXANaDt4bRASK3zDjP9mm7f5VVigx4+KYPB57rCmiz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846613; c=relaxed/simple;
	bh=WlHKWn4yfvUJ319cAxDoU013Ad86POKd21udtY7ib28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bIQ6jfYoqoFaAEF6Ex4NWnBMXPi0I0+WCyse89Fcf8zNg3FbVJiaQGbXsV2ctJKlarOgeS7ZqAzcWiv2vE4k18e3kBtsR+oXACmlrvrOsXBP6xirVIkABt4kDrJbTKQqoq4JK/wXeBhDHBEOTFF+JbYDOSAgl+zTA9kt4Ywf+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLcAmM95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLcAmM95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FB01F00A3A;
	Tue,  8 Sep 2026 05:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846611;
	bh=7PPDiMy/NLx4yhSVt9UYMgdlaaoloT+zt8azCTyczJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLcAmM95FVrix5OnTTH7AvHA0ADawEQqrw50ACnm9/GQheqOlU+X0cXhKmo08ynrj
	 B903vgWnQ387vRJQJYfhIEdhMI3Dg0Qltz8FYlLb+XuCB8swhPqIQjiu+v0nfRLVWe
	 UVA2d+y18SxAA2g93ytEa/g1GT87uGT3gP18jlhfFIgmxtvWcvNwmySZ75qbWOGuGI
	 w+je40TOdZT76WIzSY8YmnqtOWUK6Z5NE3xM9Hsh+Y6g+Mt5DXt83WKf4cCWffJI0j
	 Vl++qLUw3F8NsygT+clfDClPRXRoo6SfTu6JLI76vnI2x6vL4CsG3aiqQ3cPZcheMW
	 kmDrVdYpdMvIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] virtio_ccw: fix synchronize_cbs() after
 interrupt fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, dmitry.torokhov@gmail.com, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-input@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260908053817.26065-2-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:50:11 +0000
Message-Id: <20260908055011.87FB01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] virtio_ccw_reset() silently fails to reset the device if ccw a=
llocation fails, risking use-after-free and DMA corruption.
- [High] virtio_ccw_del_vqs silently aborts on memory allocation failure, p=
ermanently leaking all virtqueues and their DMA memory.
- [High] Silent allocation failure in virtio_ccw_drop_indicator leaves stal=
e virtqueue pointers in global routing tables, leading to UAF when adapter =
interrupts fire.
--

commit bd43fb4d1f3ef8003538155a318dcf69a27e4625
Author: Karl Mehltretter <kmehltretter@gmail.com>

virtio_ccw: fix synchronize_cbs() after interrupt fallback

virtio_ccw_synchronize_cbs() assumes the device uses adapter interrupts
when vcdev->airq_info is not NULL. If registering adapter indicators
fails, virtio_ccw_find_vqs() falls back to classic interrupts but can
leave airq_info set. This patch uses vcdev->is_thinint to properly
select the lock.

> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virti=
o_ccw.c
> index bab6cad3fd5ce..b90299205698b 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virti=
o_device *vdev)
>  	struct virtio_ccw_device *vcdev =3D to_vc_device(vdev);
>  	struct airq_info *info =3D vcdev->airq_info;
> =20
> -	if (info) {
> +	if (vcdev->is_thinint && info) {
>  		/*
>  		 * This device uses adapter interrupts: synchronize with
>  		 * vring_interrupt() called by virtio_airq_handler()

[ ... ]

> static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
> 				      struct ccw1 *ccw)
> {
> 	int ret;
> 	struct virtio_thinint_area *thinint_area =3D NULL;
> 	struct airq_info *airq_info =3D vcdev->airq_info;
> 	dma64_t *indicatorp =3D NULL;
>=20
> 	if (vcdev->is_thinint) {
> 		thinint_area =3D ccw_device_dma_zalloc(vcdev->cdev,
> 						     sizeof(*thinint_area),
> 						     &ccw->cda);
> 		if (!thinint_area)
> 			return;

[Severity: High]
This is a pre-existing issue, but returning early here on allocation failure
skips deregistering indicators and removing stale pointers from the global
airq_areas array.

If ccw_device_dma_zalloc() fails, the caller virtio_ccw_del_vqs() continues
and frees all virtqueues, while the global airq_areas array retains pointers
to them.

A subsequent adapter interrupt in virtio_airq_handler() could then fetch the
stale pointer:

	vring_interrupt(0, (void *)airq_iv_get_ptr(info->aiv, ai));

and trigger a use-after-free on the freed virtqueue memory.

Does this early return need to gracefully handle indicator deregistration
when allocation fails?

[ ... ]

> static void virtio_ccw_del_vqs(struct virtio_device *vdev)
> {
> 	struct virtqueue *vq, *n;
> 	struct ccw1 *ccw;
> 	struct virtio_ccw_device *vcdev =3D to_vc_device(vdev);
>=20
> 	ccw =3D ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw), NULL);
> 	if (!ccw)
> 		return;

[Severity: High]
This isn't a bug introduced by this patch, but returning early on allocation
failure skips the teardown loop entirely.

This leaks all virtqueues and their DMA memory. Since the virtqueues are not
deregistered from the host or removed from the global airq_areas routing
array, the virtio core will subsequently free the parent virtio_ccw_device.

A later adapter interrupt could invoke vring_interrupt() on the leaked
virtqueue, holding a stale pointer to the freed device and potentially
causing a use-after-free.

Should this fallback to a safe teardown path if ccw allocation fails?

[ ... ]

> static void virtio_ccw_reset(struct virtio_device *vdev)
> {
> 	struct virtio_ccw_device *vcdev =3D to_vc_device(vdev);
> 	struct ccw1 *ccw;
>=20
> 	ccw =3D ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw), NULL);
> 	if (!ccw)
> 		return;

[Severity: Critical]
This is a pre-existing issue, but this silent return bypasses sending the
CCW_CMD_VDEV_RESET command to the host if allocation fails.

The virtio core assumes the device is fully quiesced after virtio_ccw_reset=
()
returns and proceeds to free virtqueues and data buffers. Since the device =
on
the host was never actually reset, the hardware state machine remains active
and may continue to execute pending DMA operations into the now-freed memor=
y,
causing critical data corruption.

How should we ensure the device is safely quiesced if ccw allocation fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908053817.2606=
5-1-kmehltretter@gmail.com?part=3D1
