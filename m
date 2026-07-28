Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A841C6A;
	Tue, 28 Jul 2026 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211365; cv=none; b=rXFAx4Fj4m4inex+p+XmgcDdMLJ0pPgNvEbG7Sq+eLjskyzlTblkmhCCaxuPGGszC0Eurf84JGUsl9cAJzhlLHcb9U8diVVLNwws7GPFqlIwhFbU4nR0PnPOTUbY2SBEr4TU5g7Udismk7uP3GB5a9YantJ2KmTXFnwxf4nJ1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211365; c=relaxed/simple;
	bh=BCvFoGA7WHf5EMWIItYy4eVRigNrZgbYcJyeXRoOAPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAgHwqkYx6yz/ucW4qFp8pEOannUqI/g6z+5/pTO3rg421mKWJMc8ZhYgBsJU9FItLW0HdlgHR3hzuGBcxniQMP52K0NQkaJwSyd2P+iBY5f7lemUi2c8YFIWPI3U2re87iltpl2r+LIYkgqMZZ1ltwFeHqNQbUSdWwFBMJu/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWNcOCFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWNcOCFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84E31F000E9;
	Tue, 28 Jul 2026 04:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211364;
	bh=mDeMIyx0GoGy12pMhXKRI5kGJ0PbLXmfBWV/Spy9ap4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kWNcOCFzP1zS2zreyu6vPqzODNnIqfAi102O8JXCTph9iWoVWwn9xQWBt6AVx9k9y
	 C6UN7RLvdx8ROg6pDvc42uAInHxNJ+DvDhm7Z5ZN7z5Qxw6GR0ARZB1uY9CdPu7G+a
	 N+J/rPgAcwgvTlUYdTgRABTaPG8858Vr3XUG8eUyOsqnSTLzPi42+WLLXJuGPrenpO
	 8fAWEwE52TKuU6+P38+362JWhUhM7cmIe41PFbXlFKSpePJ9at2qQ+VqSzgAeLGVWA
	 tc2Zkf8Ug6/PVdHoWASbHOQdBJYV2Z6nrB9SVvEY0vYjhlvc+I17XN3SfBLlVV411F
	 h8yWLNiofpYSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/10] s390/vfio_ccw: cancel existing workqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728033022.2658232-8-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:02:43 +0000
Message-Id: <20260728040243.A84E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Placing `cancel_work_sync(&private->io_work)` after the FSM CLOSE =
event in `vfio_ccw_mdev_close_device` fails to prevent `io_work` from execu=
ting concurrently with `cp_free`, leading to a use-after-free on `ccwchain`=
 objects.
- [High] Missing synchronization against mdev removal in asynchronous CSS c=
allbacks (`vfio_ccw_chp_event`, `vfio_ccw_sch_irq`) allows them to queue wo=
rk on the `private` structure after it has been cancelled and freed.
- [High] The `private->crw` linked list is modified and accessed concurrent=
ly without any locking mechanism, leading to list corruption.
- [High] Lockless updates to eventfd contexts (`io_trigger`, `crw_trigger`)=
 can lead to Use-After-Free.
--

--- Patch [7]: [PATCH v9 07/10] s390/vfio_ccw: cancel existing workqueues -=
--
commit 88059af216b0143cb97da41abcd9c5570bf7637f
Author: Eric Farman <farman@linux.ibm.com>
Subject: s390/vfio_ccw: cancel existing workqueues

This commit adds cleanup tags in _release_dev and _close_device to cancel
the io_work and crw_work workqueues. This ensures work items are not
dispatched after the private struct is freed or when the device is closed.

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 032a1cdf4df70..d361d1fde3a0d 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -131,6 +131,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
> =20
> +	/*
> +	 * Ensure these work items are fully drained, so none can
> +	 * fire after being released.
> +	 */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +

[Severity: High]
This is a pre-existing issue, but missing synchronization against mdev remo=
val
in asynchronous CSS callbacks allows them to queue work on the private
structure after it has been freed.

vfio_ccw_mdev_remove() clears the device pointer without holding sch->lock:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
}

Concurrently, an incoming asynchronous channel path event retrieves the
private structure without synchronization:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
}

If the interrupt handler thread is preempted, the removal process can
complete, freeing the private struct. When the handler resumes, it blindly
accesses private, resulting in a use-after-free.

Is there a way to serialize mdev removal with the hardware callbacks?

>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {

[Severity: High]
This is a pre-existing issue, but the private->crw linked list is modified
and accessed concurrently without any locking mechanism, which can lead to
list corruption.

vfio_ccw_queue_crw() appends elements to the list from interrupt context:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
    ...
    list_add_tail(&crw->next, &private->crw);
    queue_work(vfio_ccw_work_q, &private->crw_work);
}

Concurrently, vfio_ccw_crw_region_read() retrieves and deletes elements
from the list in process context without acquiring any locks:

drivers/s390/cio/vfio_ccw_chp.c:vfio_ccw_crw_region_read() {
    ...
    crw =3D list_first_entry_or_null(&private->crw, struct vfio_ccw_crw, ne=
xt);
    if (crw)
        list_del(&crw->next);
}

Could this concurrent access cause list corruption or double frees when an
unprivileged user reads the CRW region while hardware events occur?

>  		list_del(&crw->next);
>  		kfree(crw);
>  	}

[ ... ]

> @@ -202,6 +209,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> =20
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
> +
> +	/*
> +	 * Ensure these work items are drained, in the event the
> +	 * device is re-opened instead of released.
> +	 */
> +	cancel_work_sync(&private->io_work);

[Severity: High]
This isn't a bug introduced by this patch, but placing the cancellation
after the FSM CLOSE event leaves a race window open.

When a device is closed, vfio_ccw_mdev_close_device() triggers
vfio_ccw_fsm_event() which synchronously executes fsm_close(). This disables
the subchannel, drops the lock, and calls cp_free():

drivers/s390/cio/vfio_ccw_fsm.c:fsm_close() {
    ...
    spin_unlock_irq(&sch->lock);
    cp_free(&private->cp);
    return;
}

If a hardware interrupt queued io_work right before the subchannel was
disabled, the work item vfio_ccw_sch_io_todo() remains queued and will
execute concurrently. It calls cp_update_scsw(), which accesses the freed
cp structures:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (scsw_is_solicited(&irb->scsw)) {
        cp_update_scsw(&private->cp, &irb->scsw);
    ...
}

Could the cancellation be moved before the FSM event to ensure work items
are drained before the channel program is freed?

> +	cancel_work_sync(&private->crw_work);
> +

[Severity: High]
This is a pre-existing issue, but lockless updates to eventfd contexts can
lead to a use-after-free.

The io_trigger pointer is read locklessly in workqueue functions to signal
events:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (private->io_trigger)
        eventfd_signal(private->io_trigger);
}

Concurrently, the VFIO_DEVICE_SET_IRQS ioctl can free the context before
setting the pointer to NULL:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (fd =3D=3D -1) {
        if (*ctx)
            eventfd_ctx_put(*ctx);
        *ctx =3D NULL;
    ...
}

If the workqueue thread reads the pointer just before the ioctl drops the
reference, it will call eventfd_signal() on a freed context. Should these
eventfd updates be protected by a lock or RCU?

>  	vfio_ccw_unregister_dev_regions(private);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D7
