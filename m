Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B003C1991;
	Sun, 26 Jul 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087543; cv=none; b=nzUVKd1y1IR37+izb/sbTsrbj4MFNXPOZfDAY6HoIYui1dN55Dnj/y4/NeJlsQG8KImjtBKvewhxPzRWbGDz2B6sgoI78Xu1POdrYol5NqqOCDIt+D1AjZlxkFygCJaSqfa2lPi4VZT0R+tapVEWzjtaEG6zKvF73r38+GyyESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087543; c=relaxed/simple;
	bh=Vjpl3iYMYT0IrxHTYUJgBJUeUo6CABeyu0ZN3c/QI5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WrHYr93HTwBGXrWxqFbaNce1GOdvihBH44b1teF8ra/SpPOfcDaOMsOCdF73q4fUnTYVMDo8//sr+j7tu6Oa/Fox47BsF2j0YiKFmTlv2HUXuZ+OWmR1wsJlBhiz7Mg7aZ8S8wE3gDRhG4cNVcqzkbfAc+RBs8tPPouJ7hTKfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePlDnU5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePlDnU5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D311F000E9;
	Sun, 26 Jul 2026 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087541;
	bh=W7ixV6Jpk18NmoaqKlcuyRQNXdjxTf/jIWd8ZYwVS+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePlDnU5rkHA8BCXETBB9D8LdI7UYcYtFGEj9BIbTjpZ8Ydeq2MCOgj4ruardJ146K
	 baPwilPC0GBzJQrbO6SapqfczFUFXITWYtNaCGbq+6mafGMTTUOpcQJzsEpR4Wq+QY
	 IzOp3PVWT2Jwt855+54aDsKHD4xVkEVnbc8S0PzIWC/T1PnJsp2Z2rfe1CBGs6UIeL
	 M6qboO8CN8nQrB7/Dnzuwh9o6W7+ohU9GfF3hjga+Et9m8HhfSudaPq4wIdt86O3oF
	 zc0p0Xn+ZsaUxmht1F7pH+pjDW1DUzsOLuvJgeIVOsv1iBOvR58L3JFAmp4r1Mi/wf
	 rxsjZhK2goGkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260726172153.1818056-11-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-11-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:39:00 +0000
Message-Id: <20260726173901.48D311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition between asynchronous channel path events (vfio_cc=
w_chp_event) and device removal (vfio_ccw_mdev_remove) can cause a Use-Afte=
r-Free of the private structure.
- [High] Unbounded growth of the CRW queue leads to kernel memory leaks and=
 potential OOM.
- [High] Unsynchronized replacement and freeing of eventfd triggers in vfio=
_ccw_mdev_set_irqs races with their usage, leading to a Use-After-Free.
- [High] Incorrect teardown sequence in vfio_ccw_mdev_release_dev frees lis=
t elements before cancelling asynchronous work, causing a memory leak or UA=
F.
- [Medium] A 0-byte read operation on the CRW region inappropriately consum=
es and drops a CRW event.
--

--- Patch [10]: [PATCH v6 10/10] s390/vfio_ccw: implement a crw lock ---
commit a24849c415dabc5f49c5f9509d897bea1c9a72dc
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.
Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index f3015132d4b5f..7708eb4d6de0b 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
[ ... ]
> @@ -113,6 +108,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_=
ccw_private *private,
>  	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);
> +	crw =3D list_first_entry_or_null(&private->crw,
> +				       struct vfio_ccw_crw, next);
> +
> +	if (crw)
> +		list_del(&crw->next);
> +
> +	/* Drop CRW lock while copying to userspace */
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
> +

[Severity: Medium]
This is a pre-existing issue, but does a 0-byte read operation on the CRW
region inappropriately consume and drop a CRW event?

If userspace performs a read operation on the CRW region with count =3D=3D =
0, the
driver proceeds to dequeue an event from private->crw here, performs a 0-by=
te
copy_to_user(), and then frees the CRW object. The event would be lost fore=
ver
without being delivered.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index faf2de074a10f..d7e93b9d491ca 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -122,11 +122,14 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
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
This is a pre-existing issue, but is there an unsynchronized replacement and
freeing of eventfd triggers in vfio_ccw_mdev_set_irqs() that races with the=
ir
usage here?

Userspace can call the VFIO_DEVICE_SET_IRQS ioctl to change or clear eventf=
ds.
vfio_ccw_mdev_set_irqs() handles this and calls eventfd_ctx_put() without
holding any locks to serialize it against asynchronous readers like
vfio_ccw_crw_todo().

If a reader holds a pointer to private->crw_trigger while the ioctl drops t=
he
reference, could the reader call eventfd_signal() on a freed object?

> @@ -296,7 +300,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
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
This is a pre-existing issue, but could unbounded growth of the CRW queue
lead to kernel memory leaks and potential OOM?

vfio_ccw_queue_crw() unconditionally allocates new struct vfio_ccw_crw obje=
cts
using kzalloc_obj(GFP_ATOMIC) and appends them to private->crw. Without bou=
nds
checking or a limit on the number of elements, a stream of events could cau=
se
the queue to grow infinitely, consuming un-reclaimable kernel memory.

[Severity: High]
This is a pre-existing issue, but is there a race condition between
asynchronous channel path events and device removal?

In vfio_ccw_chp_event(), the private structure is fetched using
dev_get_drvdata() without acquiring a reference count:

vfio_ccw_chp_event()
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);

Concurrently, if a user unbinds the device, vfio_ccw_mdev_remove() executes,
clearing the drvdata and dropping the final reference via vfio_put_device(),
which frees the private structure.

Could vfio_ccw_chp_event() then call vfio_ccw_queue_crw(), dereferencing the
freed pointer and causing a Use-After-Free?

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index ddfcd2b4296f1..2f28846fdf724 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
[ ... ]
> @@ -137,11 +138,14 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
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
This is a pre-existing issue, but does this teardown sequence free list
elements before cancelling asynchronous work?

By iterating through private->crw and freeing all elements before calling
cancel_work_sync(&private->crw_work), the lifecycle ordering violates the
principle of stopping asynchronous work before freeing the resources it
operates on.

If an event concurrently calls vfio_ccw_queue_crw() and inserts an element
after the list is emptied but before cancel_work_sync(), could the element
be leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D10
