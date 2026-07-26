Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDE299A87;
	Sun, 26 Jul 2026 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039396; cv=none; b=gnRVivENxclJsMFegLdfGPjmBy1lNV77g0YnFpfBpPiLHzjtr6FGwS0C80LjYsg+XF2Z4ICGwuG4fgbHuPDhb9svFw60FGQBD8HbdgeG0Za/wGJCaIpQClCdcZtoGFbFbQU8wRRK+BhQVvHLHMhOgXpYnwHrun+ftDGke/V5ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039396; c=relaxed/simple;
	bh=zLa/POUCpw9RSfCvQ6HqIjGQoas2SUyWnx2eD8q1Zdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n+TAQuHcHoC7+ersaue0X1XuLDqNiaewzRNDr/tAGhF2tgl3kcrpsyPPzD/UtYoyJYEecMrq4AMD+61ShNzgm+AFz/VNA6WwEgmI7wwfD6EUACxzNFbkwaPBp0pY5X/T86zpCzSLlilBvqa1Lgm2xVPCwM82T4hTvpW4bDQ/Vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPb4/Zt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPb4/Zt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1F61F00A3A;
	Sun, 26 Jul 2026 04:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039385;
	bh=ES6ejUh/kEQs1NNB9pVA6l8yjwTlK2l48/zM//Vfjdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPb4/Zt3yMrdjnvk5Y3i0aEZiZOHurWbMrfEfNSm/9JiVJQwr5xwi0jh/lN69wPsw
	 BO4gEqCgVouwXSDAzLRdfnTsXYiAQXYhIG0d7pg0ja6W1T/wfuZms6w7zOUagXUDEe
	 pqO5Eb3x5rsgM+MDk3GOaYfO5xHKxFiKIAdRL5kX0BrV7ZYhn75ahwUX8HJihNUS3/
	 /zQ8b8jPncmcmJs2teRNwFCT/7eltd3sqWE0mSuxhjNM7BWJcMz/daW7Vv0z/tTQe2
	 KzCEyctDhPsLpExIIkVXCWFpyTV01oeuHayE9Dgdrid1uUgNFMakf1bXZ8k1CYRx38
	 WObl8Hr056OCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] s390/vfio_ccw: cancel existing workqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260726040129.2946151-8-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:16:25 +0000
Message-Id: <20260726041625.8A1F61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `private->crw` list is manipulated without locks causing l=
ist corruption, and `cancel_work_sync()` is placed after list teardown.
- [Critical] Concurrent execution of CSS event handlers and `vfio_ccw_mdev_=
remove` leads to Use-After-Free of the `private` struct.
- [High] Eventfd contexts for IRQ triggers are permanently leaked when the =
device is closed.
- [High] Data race on `private->irb` leading to corrupted I/O status being =
exposed to userspace.
- [High] Unprotected access to eventfd triggers can lead to Use-After-Free =
during event signaling.
--

--- Patch [7]: [PATCH v5 07/10] s390/vfio_ccw: cancel existing workqueues -=
--
commit 5e12c09173779e05794585584185ded44763e3e3
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: cancel existing workqueues

This commit adds cancel_work_sync() calls in vfio_ccw_mdev_release_dev()
to ensure work items are canceled and not dispatched after the private stru=
ct
is freed.

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 032a1cdf4df70..9048c1e6e7f0c 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -136,6 +136,9 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
>  		kfree(crw);
>  	}

[Severity: Critical]
Is it safe to place cancel_work_sync(&private->crw_work) after the teardown
of the private->crw list?

If the list teardown loop runs first, any work item queued by a hardware ev=
ent
after the loop but before cancellation could be leaked. Additionally, becau=
se
cancel_work_sync() blocks until running work finishes, placing it after the
list teardown means crw_work could run concurrently with the teardown and
access the list while it is being freed.

This is a pre-existing issue, but it appears the lack of locking when
manipulating private->crw in vfio_ccw_queue_crw() and
vfio_ccw_crw_region_read() could also lead to list corruption if executed
concurrently.

> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does
vfio_ccw_mdev_release_dev() leak the eventfd contexts when tearing down the
device?

In vfio_ccw_mdev_set_irqs(), the driver takes references to eventfd_ctx
objects via eventfd_ctx_fdget(). However, these references do not appear to
be released via eventfd_ctx_put() during device cleanup here or in
vfio_ccw_mdev_close_device(). Could unprivileged userspace exploit this
resource leak by configuring IRQs and then closing the VFIO device fd?

[Severity: High]
This is a pre-existing issue, but can a data race occur on private->irb?

Hardware interrupts handled by fsm_irq() in vfio_ccw_fsm.c overwrite
private->irb while holding sch->lock. It then queues
vfio_ccw_sch_io_todo(), which reads private->irb locklessly before taking
io_mutex:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    irb =3D &private->irb;
    is_final =3D !(scsw_actl(&irb->scsw) & ...);
    ...
}

If a subsequent subchannel interrupt arrives asynchronously while
vfio_ccw_sch_io_todo() is reading the structure, might this expose torn or
corrupted I/O status to userspace?

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential
use-after-free when accessing the eventfd triggers?

When userspace disables an IRQ, vfio_ccw_mdev_set_irqs() frees the eventfd
context locklessly:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (*ctx)
        eventfd_ctx_put(*ctx);
    *ctx =3D NULL;
    ...
}

Concurrently, vfio_ccw_sch_io_todo() reads private->io_trigger locklessly
and passes it to eventfd_signal():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
    ...
    if (private->io_trigger)
        eventfd_signal(private->io_trigger);
    ...
}

If the context is freed immediately after the workqueue reads the pointer,
will eventfd_signal() dereference freed memory?

[Severity: Critical]
This is a pre-existing issue, but does vfio_ccw_mdev_remove() race with
concurrent CSS event handlers?

vfio_ccw_mdev_remove() clears the drvdata and drops the VFIO device
reference, which frees the private structure:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
    ...
}

Concurrently, vfio_ccw_chp_event() fetches private locklessly and
dereferences it:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
    vfio_ccw_queue_crw(private, ...);
    ...
}

If the removal completes before vfio_ccw_chp_event() accesses private,
could this result in a kernel crash due to accessing freed memory?

>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D7
