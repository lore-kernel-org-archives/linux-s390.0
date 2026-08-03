Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C73395266;
	Mon,  3 Aug 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775912; cv=none; b=VCvOelQunc5EeBjzIWswpBDbUya2xiUJQr+zAB9iSdmM2WSseHQDW6Y8+f2The3G9AoxomZTKkJO1kyXVxJIw/REOEA1DktY7uNAnzKuGIkErTi6gwG+p9UOdZBhvKtccgzGlcV1Vt+80dRUnDGpUNHfmsxCPIxh+sZQUiMNuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775912; c=relaxed/simple;
	bh=cOvy2782lrXBA+cACAXYHzyIv88J6EV/DJSqvAf5B4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hn89zOxktH20+5zoc1YisuEeF4lRCWAPc9BJTC0ilLW8YlsDUr08bPzbx2I/St9CUyp/mZHJUHjSUePusqo8xKlAE8LI2Ger07z/fsO2CZatDKvqZIk4lu/dAz+akm9fUhbsqJVzFDPn18iVWxVFPbEks/sm38FHicDI61tOQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiiTrIEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiiTrIEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2461F000E9;
	Mon,  3 Aug 2026 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775910;
	bh=5FZZhjkdxLQE0xiSbo1FR5kuHaaKn2HeuAbrlB1SOV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SiiTrIEnsGqie/vCRqdj7o+mZS6k9QemzjEDsNusfDL3+liSHGWdfMr939RUQNmlR
	 +sVIYs9+kD+lRKFGvZwUuom5o/w6l6/dx7z/TQNb9MmavovFTPJnZKu8ifZhHJUov1
	 uLObTPONUTC6iaYNtBWGQbwAemxMIBAKY4DLRQPlS1gyO9hJSWg1gPgfXkpL7By3d3
	 EshtQE+KsIVrqRrx6wYqGPi26NsKE73ROLIzmrOKUQv6Sz5flliyki6M6gGtAnhKaR
	 gJRBQH7cv88t22Msi5CBMHpINOyxnlhb9GPQAT4FbZ8jjBcfBhdgC0aJqiw05HXpWJ
	 v635lUK9l0Ofg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 10/23] s390/vfio_ccw: Implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803160924.236807-11-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:51:48 +0000
Message-Id: <20260803165150.1E2461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronization when updating eventfd triggers leads to a =
potential Use-After-Free of the `eventfd_ctx` during `eventfd_signal()`.
- [High] Concurrent execution of asynchronous CSS hardware callbacks and md=
ev removal allows a Use-After-Free of the `vfio_ccw_private` structure.
- [Medium] The `eventfd_ctx` for device triggers is leaked when the device =
file descriptor is closed without explicitly disabling the IRQs.
--

--- Patch [10]: [GIT PULL v1 10/23] s390/vfio_ccw: Implement a crw lock ---
commit e6c7aa37724a25bba44b60d5d9939f115e04276a
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 757ff5b2556e3..ab6b518cc353f 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -118,11 +118,14 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  void vfio_ccw_crw_todo(struct work_struct *work)
>  {
>  	struct vfio_ccw_private *private;
> +	unsigned long flags;
> =20
>  	private =3D container_of(work, struct vfio_ccw_private, crw_work);
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	if (!list_empty(&private->crw) && private->crw_trigger)
>  		eventfd_signal(private->crw_trigger);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  }

[Severity: High]
This is a pre-existing issue, but does this adequately protect against
concurrent modification of the eventfd context?

While this patch adds crw_lock around the read and signal path here in
vfio_ccw_crw_todo(), is the writer side in vfio_ccw_mdev_set_irqs()
also protected?

If vfio_ccw_mdev_set_irqs() replaces or unsets the eventfd without locks:

vfio_ccw_mdev_set_irqs()
    if (*ctx)
        eventfd_ctx_put(*ctx);
    *ctx =3D efdctx;
   =20
Could a concurrent execution of vfio_ccw_crw_todo() read the pointer,
have the context freed by vfio_ccw_mdev_set_irqs(), and then use it in
eventfd_signal(), resulting in a use-after-free?

[ ... ]

> @@ -286,6 +289,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
>  			       unsigned int rsid)
>  {
>  	struct vfio_ccw_crw *crw;
> +	unsigned long flags;
> =20
>  	/*
>  	 * If unable to allocate a CRW, just drop the event and
>  	 * carry on.  The guest will either see a later one or
>  	 * learn when it issues its own store subchannel.
>  	 */
>  	crw =3D kzalloc_obj(*crw, GFP_ATOMIC);
>  	if (!crw)
>  		return;
> =20
>  	/*
>  	 * Build the CRW based on the inputs given to us.
>  	 */
>  	crw->crw.rsc =3D rsc;
>  	crw->crw.erc =3D erc;
>  	crw->crw.rsid =3D rsid;
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_add_tail(&crw->next, &private->crw);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  	queue_work(vfio_ccw_work_q, &private->crw_work);
>  }

[Severity: High]
This is a pre-existing issue, but could vfio_ccw_queue_crw() dereference
a freed private pointer during device removal?

If an asynchronous CSS hardware callback like vfio_ccw_chp_event() fetches
the private struct locklessly, and concurrently the mdev is removed via
sysfs:

vfio_ccw_mdev_remove()
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
   =20
Since there is no synchronization stopping the CSS callback, could the
private structure be freed before vfio_ccw_chp_event() calls
vfio_ccw_queue_crw(), leading to a use-after-free when acquiring the
crw_lock here?

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 1df6d649565b8..5ce91285c7d52 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -131,6 +132,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
>  	struct vfio_ccw_private *private =3D
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
> +	unsigned long flags;
> =20
>  	/*
>  	 * Ensure these work items are fully drained, so none can
> @@ -146,10 +148,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
evice *vdev)
>  	cancel_work_sync(&private->crw_work);
>  	flush_work(&private->notoper_work);
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {
>  		list_del(&crw->next);
>  		kfree(crw);
>  	}
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
> =20
>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);

[Severity: Medium]
This isn't a bug introduced by this patch, but does closing the device leak
the eventfd contexts allocated for device triggers?

When userspace configures IRQs via VFIO_DEVICE_SET_IRQS, eventfd_ctx_fdget()
increments the reference count of the eventfd context.

If userspace closes the device without explicitly disabling the IRQs first,
vfio_ccw_mdev_release_dev() is invoked. Is it necessary to call
eventfd_ctx_put() here to release the references to private->io_trigger,
private->crw_trigger, and private->req_trigger?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D10
