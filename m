Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B239386C3F;
	Mon,  3 Aug 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775298; cv=none; b=nvnQiyDUE5ZySCB10VOcYQZ1UY/7lGlV8Z++po8ZQfnvfleKIpa62UR9m1xirXQqXoWxmQLgc9tqbRYfTnLMtUBjKYvDB9Lq3iqCQhvQLVUBB/xcE/rP7t2r750QigK/mvXFqr5gR7gIhMmjMGw6jQ/Lw0G6oZ8W/sSEygNvYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775298; c=relaxed/simple;
	bh=8eauQcoOxaZr5hV2SNSHoZm1dEc9RASllM7ZreMnJU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hXKI0KvKvYrDkr5WRMc5nqBbNgfSFlGp4516/ZQXf1lOp1Yt+gJwct2oXBqKeH/fP+mmoHLohmKbnT25Jd5vMDo0TnhvzpZxYQmgIQ+E9ez0muINf3Ok8ORSzvhKUVyA911HRpG6BY6hjHIYMBN7QE6S0plr/vfN/mMs1kiDB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abHYbiqX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abHYbiqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5371F000E9;
	Mon,  3 Aug 2026 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775297;
	bh=u3kRSpLdKmHDt05+dtxh1K00QVpdOgkUQWblAilPyT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abHYbiqXGYU7iZasXijXBsWjsrZ1zQUO+Zz8+pk5j/l6E3cqRdq5GIzfBBP34XZ7/
	 bOQ1IOeaiaFu6xfegEgurf+CnID1hd3508J2Ia4iqSiEAn6JZL20tc+PvlXx4nf7v0
	 yrfyl80DSjcgRS7MkvxTh5B0W/31oEYoDwvhv07/m6qfycUMJyIr5OM/cih/gw8xtc
	 NaztVq5KiAEJ9hnHdPpJjuLh/U5y0dABKZoZNdjQMrEfQ6Y4nTuFcHBKqYC9/Bmpl1
	 ALuzP+rOQoZbcUym7UOHPDTM9qi83P1DiocWKvWRsCLdM8Mfy8KMyOCT0CXqVwadUP
	 Bh8vfcUNObm9g==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 07/23] s390/vfio_ccw: Cancel existing workqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803160924.236807-8-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:41:35 +0000
Message-Id: <20260803164136.CA5371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double-free and use-after-free of channel program structures due t=
o concurrent execution of `cp_free()`.
- [High] Use-after-free of `vfio_ccw_private` due to concurrent execution o=
f `vfio_ccw_mdev_remove()` and `vfio_ccw_chp_event()`.
- [High] Data race and linked list corruption of `private->crw`.
- [High] Use-after-free of `eventfd_ctx` due to lack of synchronization in =
`vfio_ccw_mdev_set_irqs()`.
--

--- Patch [7]: [GIT PULL v1 07/23] s390/vfio_ccw: Cancel existing workqueue=
s ---
commit 9c72e034f4d8d6193d6ae49cecd7dc50eda41903
Author: Eric Farman <farman@linux.ibm.com>
Subject: s390/vfio_ccw: Cancel existing workqueues

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

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

[Severity: High]
This is a pre-existing issue, but does this cancellation prevent subsequent
queuing if vfio_ccw_chp_event() races with vfio_ccw_mdev_remove()?

vfio_ccw_chp_event() reads private locklessly before it is cleared and
prepares to queue work:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
        vfio_ccw_queue_crw(private, CRW_RSC_CPATH, CRW_ERC_PERRN,
                           link->chpid.id);
}

If vfio_ccw_mdev_remove() concurrently clears the driver data, releases the
device, and drains the currently empty workqueue via
cancel_work_sync(&private->crw_work), can vfio_ccw_chp_event() subsequently
queue work on the freed private object, leading to a use-after-free when
vfio_ccw_crw_todo() executes?

>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {

[Severity: High]
This is a pre-existing issue, but is the private->crw linked list protected
against concurrent modifications here?

vfio_ccw_queue_crw() appends elements to the list with list_add_tail() while
holding sch->lock. Concurrently, userspace triggering a read on the CRW
region invokes vfio_ccw_crw_region_read(), which locklessly calls
list_first_entry_or_null() and list_del() before acquiring
private->io_mutex:

drivers/s390/cio/vfio_ccw_chp.c:vfio_ccw_crw_region_read() {
    ...
    crw =3D list_first_entry_or_null(&private->crw,
                                   struct vfio_ccw_crw, next);
    if (crw)
        list_del(&crw->next);
    mutex_lock(&private->io_mutex);
}

Can multiple concurrent reads, or a read concurrent with an asynchronous
channel path event, corrupt the list pointers?

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
This is a pre-existing issue, but does placing cancel_work_sync() after
vfio_ccw_fsm_event() leave a double-free race intact?

The device is closed via vfio_ccw_mdev_close_device(), which triggers the
FSM CLOSE event and calls fsm_close(). fsm_close() invokes cp_free()
entirely locklessly:

drivers/s390/cio/vfio_ccw_fsm.c:fsm_close() {
    ...
    spin_unlock_irq(&sch->lock);
    cp_free(&private->cp);
}

Concurrently, if the io_work workqueue is already running
vfio_ccw_sch_io_todo(), it locklessly evaluates
private->state =3D=3D VFIO_CCW_STATE_CP_PENDING and also calls cp_free():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
        cp_free(&private->cp);
    ...
}

Since the new cancel_work_sync(&private->io_work) executes after the FSM
event, can io_work still execute concurrently with the FSM close handler
and double-free the channel program structures?

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of
synchronization in vfio_ccw_mdev_set_irqs() allow a use-after-free of the
eventfd_ctx object?

In vfio_ccw_mdev_set_irqs(), userspace can unregister an eventfd, executing
eventfd_ctx_put(*ctx):

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
        if (fd =3D=3D -1) {
            if (*ctx)
                eventfd_ctx_put(*ctx);
            *ctx =3D NULL;
        }
}

There appear to be no locks preventing the workqueue from concurrently
reading private->io_trigger. If vfio_ccw_sch_io_todo() reads the pointer
locklessly:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (private->io_trigger)
        eventfd_signal(private->io_trigger);
}

Can the workqueue execute eventfd_signal() on freed memory if
vfio_ccw_mdev_set_irqs() frees the context after it was read but before it
is signaled?

> +	cancel_work_sync(&private->crw_work);
> +
>  	vfio_ccw_unregister_dev_regions(private);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D7
