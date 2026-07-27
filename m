Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5B31F983;
	Mon, 27 Jul 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182843; cv=none; b=W/OyqWUU0Q1fBlKCo7gDtNLXJ8egCgMHdu6sxZ5IkMlLiKj1aBYCKx+Z1t/G4rC93yFDW0tiDEGhkQqPP+h1GfYlkDV/Zhh8PWAdJMws0U19k0cixvTUd733T9jEaSrJhRSwjf1c1vu3pNK2oh8RQKLSLB/EnwzyvuPXaAM3WLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182843; c=relaxed/simple;
	bh=mSG3SDntozht81XjkgqwZvI3rcXb8fqJ06OH0lJQuJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JqxJ48RiOREWFwsLTUz+SV2DC/yXpX+Ey0O/krZK6Gn4vl7j1mxP9pfeQn4E0dtbSiHwRVfZNeDN2zEYO+m6QevXMECg+xg8+XrXwsmXyrZbkRIqO6f3uSI8tq5cZTFeQLDs5Zbpmbb676Xcl7/fwY6WJQyGO414/frBEhiF1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYXMpylw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYXMpylw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D818D1F000E9;
	Mon, 27 Jul 2026 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182842;
	bh=HoD5ERXRS8RqPGbrs8ek5LrTYxklvfJtLV+Jdnw4zYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYXMpylwi2igYz8WoJDYqpa1p1H+AB+6PUqgE8J5n7xogXu94so52aJjwJ3p0cTk9
	 Hsw29I/fR/Ee6udRAjuqYkoPTvRzxiLGe8lqlHu0JjycMd38Uc8+7l/4/rcV3q8H/p
	 dNXxL4mL5+iE1lZyI53gG+L9U4TCU/lbVdDSzNw5dcN2IYqskpO8UOfSCqZhhWUc8t
	 GNboRcU1UHtNwAIliJDgf8Wkc3jkzBVcMy3Ra1nI5kAGyNZ2F6NXTEuByOjcGzlEzQ
	 p2SDFF2G2vQeoTtkI4z+K3ZTvGFCUnbypkGGUdb2anT15eHzStZJmL/NgwDdBd+cqM
	 1HGZtYB1VVsJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727192230.2715207-11-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-11-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:07:21 +0000
Message-Id: <20260727200721.D818D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent VFIO_DEVICE_SET_IRQS ioctl can cause a Use-After-Free o=
f eventfd_ctx in vfio_ccw_crw_region_read() and vfio_ccw_crw_todo().
- [High] Race condition between asynchronous channel path events and device=
 removal leads to Use-After-Free of the `private` struct.
- [High] The `crw` list is emptied before `cancel_work_sync()` is called, w=
hich can lead to memory leaks of dynamically allocated `crw` objects.
--

--- Patch [10]: [PATCH v7 10/10] s390/vfio_ccw: implement a crw lock ---
commit 32947477038816f52fb49c7c2eb829ec1255cb5d
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>

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
This isn't a bug introduced by this patch, but can a concurrent
VFIO_DEVICE_SET_IRQS ioctl cause a use-after-free of the eventfd_ctx?

If an unprivileged userspace process calls the VFIO_DEVICE_SET_IRQS ioctl,
vfio_ccw_mdev_set_irqs() releases the eventfd_ctx without acquiring crw_lock
or other serializing locks:

	if (*ctx)
		eventfd_ctx_put(*ctx);
	*ctx =3D efdctx;

Since private->crw_trigger is read under crw_lock here, but not held by
the writer, could the context be freed before or during eventfd_signal()?

> @@ -286,6 +289,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
>  			       unsigned int rsid)
>  {
>  	struct vfio_ccw_crw *crw;
> +	unsigned long flags;
> =20
>  	/*
>  	 * If unable to allocate a CRW, just drop the event and
> @@ -303,7 +307,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
>  	crw->crw.erc =3D erc;
>  	crw->crw.rsid =3D rsid;
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_add_tail(&crw->next, &private->crw);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  	queue_work(vfio_ccw_work_q, &private->crw_work);
>  }

[Severity: High]
This is a pre-existing issue, but is there a race condition between asynchr=
onous
channel path events and device removal that could lead to a use-after-free =
of
the private struct?

A hardware event can trigger vfio_ccw_chp_event() which fetches the private
pointer locklessly:

	struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
	...
	vfio_ccw_queue_crw(private, CRW_RSC_CPATH, ...);

Concurrently, if userspace writes to the mdev 'remove' sysfs attribute,
vfio_ccw_mdev_remove() clears the driver data and releases the device refer=
ence:

	dev_set_drvdata(&parent->dev, NULL);
	vfio_put_device(&private->vdev);

Could the private structure be freed while we are still executing here or in
queue_work()?

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 8ec6b175d9914..9cbb277b83fb2 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -131,11 +132,14 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
evice *vdev)
>  	struct vfio_ccw_private *private =3D
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {
>  		list_del(&crw->next);
>  		kfree(crw);
>  	}
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
> =20
>  	/* Should be empty, but just in case */
>  	cancel_work_sync(&private->io_work);

[Severity: High]
This isn't a bug introduced by this patch, but does emptying the crw list b=
efore
calling cancel_work_sync() violate the subsystem rule that background tasks=
 must
be explicitly stopped before the queues they operate on are destroyed?

If a concurrent hardware event (like vfio_ccw_chp_event) allocates a crw and
calls queue_work() before or during the cancellation, could the newly alloc=
ated
crw be left on the list and leaked?

Additionally, if queue_work() executes after cancel_work_sync() finishes, c=
ould
the work execute on a freed private pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D10
