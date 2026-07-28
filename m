Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A62175A7B;
	Tue, 28 Jul 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204084; cv=none; b=WB76lWs3qRkviJps0y36KkkI2NNGW/Ej64a0LbZ8QDVW+NBsmbPxITU1VMw7epJFaP/Rgt0NxfQos8/5iNA8TiMoNRrlnWYGC8qL2i4L8i37LciM8P2MgocyCdWlqqGNjts9lNkf7zu1S+smdgSSJ7/7i9sCRkTJMw6Bl+U7r/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204084; c=relaxed/simple;
	bh=GcyKGx1W/KMlzC3WHeB74U2tSpKxBH73hydE7X/s9JQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nAtYBCLMLADccHf82QAs/EFEcVwrziLtRFAc8NtUqzW876oS3BODmkRjdPD5GtoCoYJxRHqUWylXP6xbIIYnKlhkEogzE7ryWMzG3sJZvjmz3VxS921akzo6q/ydepsZhI2CanyEtXhufjS62icj6KCQHQexYk07KXHNntlgK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqW6MEd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqW6MEd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8F61F00ADB;
	Tue, 28 Jul 2026 02:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785204082;
	bh=2f7VhaADrBnW603DHsC0RQvaBLDh6HaEqHpwIp40OQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqW6MEd0uQ6iILF+va//m7Rgvu87NlYkheZHw7lzCspRWDByq9LIzLiLBgfagEKlA
	 YYUrOI7JXjMvVQTgLAKawLFdLqGXPzsn+l12FLbUt0F2YBlDhJArmYK58ZBEytUJ/T
	 U59Hkr29vV1v2m/6L6IrAf6b/1uZyarY+ofvtxR09jg7gy2e2fS9DPsh+j1CbDXUOG
	 zC71fNHwx+FhGm/kcx4A2X+N/FaPFRLhRCo8Y5m4vzYof54BU6boJJfIp4XX7sfQq6
	 4HB7xCTgwAcFfjCoxzhYL17qJxwl8Kcrh6SsAQu6PVWEbROVvkl7U5TauPIuOxkdym
	 mM7hyCZirL53Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/10] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728013509.1551753-11-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-11-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 02:01:21 +0000
Message-Id: <20260728020122.0E8F61F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing cancellation of `notoper_work` during device release leads=
 to Use-After-Free.

Pre-existing issues:
- [Critical] Lockless modification of eventfd triggers in `vfio_ccw_mdev_se=
t_irqs` leads to Use-After-Free of `eventfd_ctx` in asynchronous workers.
- [High] Race condition between asynchronous CSS callbacks and mdev removal=
 leads to Use-After-Free of the `private` structure.
--

--- Patch [10]: [PATCH v8 10/10] s390/vfio_ccw: implement a crw lock ---
commit e956337911477e5c5887e514827c14569954a32d
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

This patch adds a lock to the vfio_ccw driver to manage the list of
asynchronous CRW events. It serializes access to the CRW payload list
to ensure cohesive reads between hardware events and userspace.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 757ff5b2556e3..ab6b518cc353f 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> [ ... ]
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

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential problem with how
crw_trigger is accessed here.

Does private->crw_lock actually protect private->crw_trigger from
concurrent modification?

Looking at vfio_ccw_mdev_set_irqs(), it replaces and frees eventfd contexts
without holding any locks:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (*ctx)
        eventfd_ctx_put(*ctx);

    *ctx =3D efdctx;
}

If the VFIO_DEVICE_SET_IRQS ioctl swaps and frees the eventfd_ctx while
this asynchronous worker is preparing to signal it, won't eventfd_signal()
dereference a freed pointer?

> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  }
> [ ... ]
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 1cca3ecdae45b..4a0fe2f8fdb44 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> [ ... ]
> @@ -131,6 +132,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
>  	struct vfio_ccw_private *private =3D
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
> +	unsigned long flags;
> =20
>  	/*
>  	 * Ensure these work items are fully drained, so none can
>  	 * fire after being released. The notoper_work struct is
>  	 * only meaningful if the device had been opened, which
>  	 * means it would have been cleaned in an earlier close.
>  	 */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);

[Severity: High]
The comment above suggests notoper_work is only meaningful if the device
had been opened, but could a race occur here?

If the device was never opened (state is VFIO_CCW_STATE_STANDBY), can an
asynchronous CSS callback still trigger a VFIO_CCW_EVENT_NOT_OPER event
(e.g., if the subchannel is unregistered)?

If this happens and queues notoper_work, and the device is subsequently
released, won't release_dev free the private structure while notoper_work
is still queued?

When the workqueue executes:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_notoper_todo() {
    ...
    mutex_lock(&private->io_mutex);
    cp_free(&private->cp);
    mutex_unlock(&private->io_mutex);
}

Won't this dereference the freed private pointer? Should we add
cancel_work_sync(&private->notoper_work) here?


[Severity: High]
This is a pre-existing issue, but since we are looking at the lifecycle of
the private structure, is there a race condition with asynchronous CSS
callbacks during mdev removal?

In vfio_ccw_sch_event(), the private pointer is fetched locklessly:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_event() {
    struct vfio_ccw_parent *parent =3D dev_get_drvdata(&sch->dev);
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    unsigned long flags;
    ...
    spin_lock_irqsave(&sch->lock, flags);
}

If vfio_ccw_mdev_remove() runs concurrently, it clears the drvdata
locklessly and drops the device reference:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    vfio_unregister_group_dev(&private->vdev);
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
}

If the CSS callback is preempted after fetching the pointer but before
acquiring sch->lock, and resumes after the removal path completes, won't
it use the freed private structure?

> +	spin_lock_irqsave(&private->crw_lock, flags);
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {
>  		list_del(&crw->next);
>  		kfree(crw);
>  	}
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
> [ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D10
