Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22B4B048D;
	Sat,  5 Sep 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622443; cv=none; b=RhAlopsnYqC1Tb7k4zZd3l0qv6FeP1whirUCVE0iXduIXKqgVhocVVl/6Mpe81vERQBjibcDsycj4YiIkpk3ejfJmxcGOTaPqtIEDYWSbuM0B1tus1t/Ov3R7tPAbNMBKlyx+y5mpuwGB/XZkGAOa/4ucRCncQ+qAERC3AmT9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622443; c=relaxed/simple;
	bh=8i33O11FOJVHhfhYVzpI9JhAjcGMHikLFOWynTzx+tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a1aLMux9mIPiPSGQik2HyEWhLsD8WvXH1rGYI4CVaMgQZINo8I0Wm88UNGG+4HF1isSoUb3m91bTY0YyzzL2UgiovZdPUZ9WYFH8En9644dLJpww9Zobw+6wPWq7kBo2hwEDIa6DfE0TkazxRR6tyja4jV2zFnzWNxJ69MqH0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGM8LUYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGM8LUYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE5E1F00A3A;
	Sat,  5 Sep 2026 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788622438;
	bh=NiAGBPcr3P+16GwhJ4Wx+8stKz4FlNOzwQ8HlHCvwKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dGM8LUYr/7zVYfrRUSuFKag1Ybt8c0N+YnGLdyoOiz+xvYHwUrSWeHnJkUR5ObU4R
	 MoOxp+dZvmR6Ic7wSnqb4n2ImYLx87TrX547PCfVuIJfyRkCKB4S9lKtiMW97f96Ys
	 0EIFFj40jLOJ2aeRZ2lHtcrFK2CbXXv2ReOLYEZz53J/q7hErAmBTH/y/Yo0+/6HAP
	 D0Bt9qXoLns0OYbn14QEu1CEszSn4T0EgnDFpFnur7PHzRA4CB4qXR7Gu9Qk/O87cG
	 54poCz5HxJ8Bs1MLXyUEwrvtq6bKWrfJNvgA8PIox3xaTrbT9Ho2iBq94tHa1YEgsj
	 17Eym9Lvo27Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before
 unregistering input device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260905152059.89560-3-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 15:33:57 +0000
Message-Id: <20260905153357.7FE5E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `virtio_reset_device()` in the error path of `virtinput_pr=
obe()` before deleting virtqueues, potentially leading to use-after-free or=
 memory corruption by the active hardware/hypervisor.
- [High] The driver leaks DMA mappings for unconsumed buffers in the event =
virtqueue (`vi->evt`) upon device removal or suspend/freeze.
--

commit 71bbbcca0b03e3c67fa905a8357e9d3ad23e7fe4
Author: Karl Mehltretter <kmehltretter@gmail.com>

virtio_input: stop callbacks before unregistering input device

virtinput_remove() unregisters the input device before resetting the
virtio device. virtinput_recv_events() drops vi->lock around input_event(),
so clearing vi->ready does not stop a callback that passed the entry check.
It can still use vi->idev, requeue buffers and kick the queue.

> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e6828..7b654af0a42cb 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
[ ... ]
> @@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vd=
ev)
>  	vi->ready =3D false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
> =20
> -	input_unregister_device(vi->idev);
> +	/* Callbacks use vi->idev. */
>  	virtio_reset_device(vdev);
> +	input_unregister_device(vi->idev);
>  	while ((buf =3D virtqueue_detach_unused_buf(vi->sts)) !=3D NULL)
>  		kfree(buf);
>  	vdev->config->del_vqs(vdev);

[Severity: High]
This is a pre-existing issue, but does this cleanup leak DMA mappings for
the event virtqueue (vi->evt)?

The cleanup loop correctly detaches and unmaps vi->sts using
virtqueue_detach_unused_buf(), but it ignores vi->evt. Since
virtinput_fill_evt() populates vi->evt with buffers using
virtqueue_add_inbuf_cache_clean(), which establishes DMA mappings under
the hood, omitting the detachment step leaves these mappings active.

Does this result in a persistent DMA mapping leak every time the device is
unbound? Furthermore, since the memory for these buffers (vi->evts) is free=
d,
does this leave active DMA mappings pointing to freed memory, posing a memo=
ry
corruption risk if delayed DMA occurs?

Does this exact same DMA mapping leak also occur during the power management
suspend cycle in virtinput_freeze() which performs the same cleanup?

[Severity: High]
This is also a pre-existing issue, but is there a missing
virtio_reset_device() in the error path of virtinput_probe()?

Looking at virtinput_probe(), the device is marked as ready:

drivers/virtio/virtio_input.c:virtinput_probe() {
    ...
	virtio_device_ready(vdev);
	vi->ready =3D true;
	err =3D input_register_device(vi->idev);
	if (err)
		goto err_input_register;
    ...
}

If input_register_device() fails, the error path deletes the virtqueues:

drivers/virtio/virtio_input.c:virtinput_probe() {
    ...
err_input_alloc:
	vdev->config->del_vqs(vdev);
    ...
}

Since virtio_device_ready() sets the device status to DRIVER_OK and enables
the host/hardware to start processing virtqueues, does deleting the active
virtqueue structures without first calling virtio_reset_device() to halt
the device risk a use-after-free or memory corruption by the host backend
if it continues to access the freed vring memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905152059.8956=
0-1-kmehltretter@gmail.com?part=3D2
