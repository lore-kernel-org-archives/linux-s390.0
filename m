Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FD367F3A;
	Sun, 26 Jul 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087527; cv=none; b=VACn1c3X14YYcr/skWnYtiyLvb7N6RH8llpF7TTEws/X3iRh21jN2aBcj7IXm7AEPZB+Fgm7akM6LWZH5HvZQkisI4mg1kACesp6Kgs8yf83GXM5jIxz0VFxAV28avBFho5ya8NrbRl4k3l9fzfUmhkX00Ew3N634Zgp/vKPtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087527; c=relaxed/simple;
	bh=p0rCDEgzpABKww2XiNwTJnLmNXg1kglvC1YuN0pxkZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PM2+5ybaHYjPXrr7XSNBLpUC2pBaKeJI0/MZ054iUsMasH7IxtJ/XOBuyOS3w3LJwFYK0XRCJ46ml76b+VU5z8NKy/eJAqqFKkKKh9NPESkqyQUZhlwr0wzP3buzrv2qlAxtZXSoKkNGK9s00Rexr0Ztmc429Aek7+HTjb7hH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+YoAP9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+YoAP9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CBC1F000E9;
	Sun, 26 Jul 2026 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087525;
	bh=dV1MgW+IitiMa3hNaki8lKsm+xAWL0avDvv8yjOAVEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+YoAP9YH66znXgNxAvqbNXCFp46Sktig3qAYibXv3hMHLNilMlx0h5YnQkPbNe8B
	 cnSOeIlSDg+Ae1z8qLQM53rm/zndX7/56CzYCupMVD9Pls/ERLPHXpOiPFg8CupMUL
	 T/AIrlFoTHB6Lg9ujQ1sIkT8T8xK5Qm9eE25s2qKGaj99SADbwRF601UJ6LpaX6i8t
	 kGRSOCQAoL6aAAoC5f2T8yuyf1RiCMvrCZ8DxGDorIAKfUWNCPbZi4d9ZLs7vNLByE
	 iMDhRQ2G+4yLfgpS3WObHclpUMPvWty4wyQXPIdYyM6apgCuWNt1/7W/JiLr4vRNfv
	 dWOtJdwWX357w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] s390/vfio_ccw: cancel existing workqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260726172153.1818056-8-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:38:44 +0000
Message-Id: <20260726173845.56CBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] The patch places `cancel_work_sync(&private->crw_work)` after th=
e list cleanup loop, introducing a memory leak race condition.

Pre-existing issues:
- [High] Concurrent execution of `cp_free(&private->cp)` can lead to a doub=
le free of `cp->ccwchain` list elements.
- [High] The `private->crw` list is manipulated and read concurrently witho=
ut any locking, leading to severe list corruption.
- [High] The `crw_work` can be queued on a freed `private` structure due to=
 a TOCTOU race between asynchronous hardware events and device removal.
- [High] Eventfd contexts (io_trigger, crw_trigger, req_trigger) are leaked=
 if userspace closes the device without explicitly un-setting the IRQs.
- [High] Eventfd contexts can be accessed after being freed due to a lack o=
f synchronization when disabling IRQs.
--

--- Patch [7]: [PATCH v6 07/10] s390/vfio_ccw: cancel existing workqueues -=
--
commit dab37cbb4c3a359f582e42660725b5b18fcda1e7
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: cancel existing workqueues

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev and _close_device to ensure work isn't
dispatched after the private struct is freed.

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
> +

[Severity: Medium]
Could this introduce a race condition that leaks vfio_ccw_crw elements?

If a concurrent channel path event executes vfio_ccw_queue_crw() right after
the list cleanup loop finishes but before cancel_work_sync() is called, the
newly queued work is cancelled. This would leave the allocated crw stranded
on the list to be leaked when the overarching private structure is freed.

[Severity: High]
This is a pre-existing issue, but is the private->crw list safe from
corruption?

While the cleanup loop above uses spin_lock_irqsave(&private->crw_lock,
flags), other paths manipulate the list locklessly:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
    ...
    list_add_tail(&crw->next, &private->crw);
    queue_work(vfio_ccw_work_q, &private->crw_work);
    ...
}

drivers/s390/cio/vfio_ccw_chp.c:vfio_ccw_crw_region_read() {
    ...
    crw =3D list_first_entry_or_null(&private->crw, struct vfio_ccw_crw, ne=
xt);
    if (crw)
        list_del(&crw->next);
    ...
}

Can an unprivileged guest performing CRW reads concurrently with channel pa=
th
hardware events cause doubly-linked list corruption?

[Severity: High]
This isn't a bug introduced by this patch, but could there be a use-after-f=
ree
if asynchronous hardware events race with device removal?

If a hardware event triggers:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
    if (!private || !mask)
        return 0;

And then a concurrent device removal clears drvdata and frees the private
structure:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    ...
    vfio_unregister_group_dev(&private->vdev);
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
    ...
}

When vfio_ccw_chp_event() resumes, it calls vfio_ccw_queue_crw() utilizing
the freed private pointer, which then submits a freed work_struct.
Can this be prevented by synchronizing device removal against active channel
path events?

>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);

[Severity: High]
This is a pre-existing issue, but does this function leak eventfd contexts?

Neither vfio_ccw_mdev_close_device() nor vfio_ccw_mdev_release_dev() calls
eventfd_ctx_put() to release the eventfd contexts (io_trigger, crw_trigger,
req_trigger). If a user application configures interrupts via
VFIO_DEVICE_SET_IRQS and then exits abruptly or closes the device without
explicitly un-setting the IRQs, are these kernel objects permanently leaked?

[ ... ]

> @@ -202,6 +206,10 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> =20
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
> +
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +
>  	vfio_ccw_unregister_dev_regions(private);
>  }

[Severity: High]
This is a pre-existing issue, but is it possible to double-free
cp->ccwchain list elements here?

vfio_ccw_mdev_close_device() triggers fsm_close(), which drops sch->lock
and explicitly calls cp_free(&private->cp):

drivers/s390/cio/vfio_ccw_fsm.c:fsm_close() {
    ...
    private->state =3D VFIO_CCW_STATE_STANDBY;
    spin_unlock_irq(&sch->lock);
    cp_free(&private->cp);
    ...
}

Concurrently, if a previously queued asynchronous I/O interrupt worker exec=
utes:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
        cp_free(&private->cp);
        cp_is_finished =3D true;
    }
    ...
}

Since cp_free() checks and unsets cp->initialized without atomics or
locks:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    if (!cp->initialized)
        return;
    cp->initialized =3D false;
    list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
    ...
}

Can both threads execute the list teardown simultaneously, leading to memory
corruption? Also, the newly added cancel_work_sync() runs after this
event, so it doesn't prevent this race.

[Severity: High]
This isn't a bug introduced by this patch, but can eventfd contexts be acce=
ssed
after being freed due to a lack of synchronization when disabling IRQs?

Userspace invoking VFIO_DEVICE_SET_IRQS can disable the interrupt:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (fd =3D=3D -1) {
        if (*ctx)
            eventfd_ctx_put(*ctx);
        *ctx =3D NULL;
    }
    ...
}

Concurrently, a worker thread might read private->io_trigger locklessly:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (private->io_trigger)
        eventfd_signal(private->io_trigger);
    ...
}

Since eventfd_ctx_put(*ctx) can drop the final reference and free the conte=
xt
before the structure pointer is set to NULL, and there is no RCU protection
or locking, can the worker thread dereference the freed eventfd context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D7
