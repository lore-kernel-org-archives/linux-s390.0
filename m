Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8781DE4F1;
	Mon, 27 Jul 2026 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182527; cv=none; b=l/MxkM2TGt9uYNP8Lm/olT1byNol2CJi/60RAmzNgqMj7uUm7xmrotI8SU7OMO9DlWv/OelRmQ9VMLJ55H+vmgQwDfoI8eG07z0HHioI+dXgoxzB/UlTVQb2t8L3oVdEBNL5AtjNmYCA5TBqoH7dYqIMx/QTGG8xeNx44a3kxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182527; c=relaxed/simple;
	bh=T/0KMVRUVjAsuI8ms8R/D25LukG8GTsCYQQdDARUHrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F0mH4ekiBR1c28UEoOCArSG+JeKKACuN2eOSZwRUD4dDid89+/zRsfCyNTJUkBqRa8683mRXxNZ1wU8QkcLZUOZKQ7jCSkLH38jY+0KJrRF+kRGvmDScLMTu1Fe7v8qWsEZU6zzvkN4TR0keX3XHymp8su/c40C78Mfjl5WkZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBnxF4z2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBnxF4z2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57AB1F000E9;
	Mon, 27 Jul 2026 20:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182526;
	bh=kKeZzh/EQk2aMwB6RRE6A8JNgAFatMmAUBGuIKTgvXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MBnxF4z2O9QUuFuUB5fZCGRK58QDXTCbLf2LCJmeEMwCT69EKYSxAKC+LW/YWB7nw
	 OFbX9/hVeE79PJKOYquTQayit34Ahrw2mDvZtBZWw61l1ToF+/t8gjvuqympwQDJ31
	 aNy/OJih2C7MPo12z9FKRtbDEFS2eWNet6sywblz2pilAe4/5EAghfB3S42EY0R/kk
	 xe78pjPCGw777PA+updID2XO+QHwg3zo4jQ7/v9KPtg5nIt52DhGYVRIapPB/KIqgT
	 y0jLFjwAbscytTH2MUOTUZ+5xHIB9y8rWu7aeJsQRx8rvgwvXc2T0ng3ZFiz8WnZ67
	 YNPby9IVba3WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] s390/vfio_ccw: cancel existing workqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727192230.2715207-8-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:02:05 +0000
Message-Id: <20260727200205.D57AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Suboptimal ordering of `cancel_work_sync()` and `private->crw` lis=
t teardown introduces a memory leak.

Pre-existing issues:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) race condition leads to =
Use-After-Free during device removal.
- [High] Lockless modification and traversal of the shared `private->crw` l=
ist leads to data races and list corruption.
- [High] Eventfd contexts for device triggers are leaked when the device is=
 closed or released.
--

--- Patch [7]: [PATCH v7 07/10] s390/vfio_ccw: cancel existing workqueues -=
--
commit e5fd510ce3193c957c167ef6f613d80a32133fe5
Author: Eric Farman <farman@linux.ibm.com>
s390/vfio_ccw: cancel existing workqueues

The patch adds cleanup tags to un-initialize the io_work and crw_work
workqueues in the release and close paths. This ensures work isn't dispatch=
ed
after the private structure is freed.

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 032a1cdf4df70..bd488e40e1531 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -136,6 +136,10 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
>  		kfree(crw);
>  	}
> =20
> +	/* Should be empty, but just in case */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);

[Severity: High]
Does this order of operations leave room for a memory leak?

If a concurrent channel path event triggers vfio_ccw_queue_crw() and adds a
new crw element to private->crw right after the teardown loop finishes drai=
ning
the list, but before cancel_work_sync() executes, those newly added elements
will be left on the list permanently.

Would reversing the order, so cancel_work_sync() happens first, guarantee
that no concurrently queued background processing remains before the list
drain is final?

[Severity: High]
This is a pre-existing issue, but is there a data race when modifying
the private->crw list?

It looks like elements are added locklessly in vfio_ccw_queue_crw():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
    ...
    list_add_tail(&crw->next, &private->crw);
    ...
}

And unlinked concurrently in vfio_ccw_crw_region_read():

drivers/s390/cio/vfio_ccw_chp.c:vfio_ccw_crw_region_read() {
    ...
    list_del(&crw->next);
    ...
}

Could this concurrent access without a lock lead to list corruption if a
userspace process reads the CRW region while a concurrent channel path hard=
ware
event occurs?

[Severity: Critical]
This is a pre-existing issue, but could a use-after-free occur during
device removal?

In vfio_ccw_chp_event(), private is read while handling an event:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    ...
    private =3D dev_get_drvdata(&parent->dev);
    ...
    vfio_ccw_queue_crw(private, ...);
    ...
}

Concurrently, vfio_ccw_mdev_remove() unregisters the device and clears drvd=
ata
locklessly:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    ...
}

If the event handler resumes after vfio_ccw_mdev_release_dev() frees the
private structure, will it blindly use the freed pointer to queue work?

> +
>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
[ ... ]
> @@ -202,6 +206,10 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> =20
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
> +
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);

[Severity: High]
This is a pre-existing issue, but are eventfd contexts being leaked here?

If userspace sets the eventfd IRQs but closes the device descriptor without
unregistering them, they appear to be left behind.

Unlike other VFIO drivers, vfio_ccw_mdev_close_device() and
vfio_ccw_mdev_release_dev() do not seem to call eventfd_ctx_put() on
io_trigger, crw_trigger, or req_trigger.

Will these contexts leak and pin inodes in memory over time?

> +
>  	vfio_ccw_unregister_dev_regions(private);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D7
