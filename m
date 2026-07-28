Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00963B1B3;
	Tue, 28 Jul 2026 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203840; cv=none; b=rAF8GJwjsB5iv+WF/Gd9xus+RWaLal5FYuyNr3MJ91FOyYoGteZJO7nXsY8oJi7hAcTwhTxwxeQzGGNX7Yv2/c1V6zW13K27jOKPSaXo1/zm5acdqwEH/Fcrfcpbt8T/gWiQoLJdsRlW+8tVHCFW++/yzIyEohaDVFj4Xc50Ajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203840; c=relaxed/simple;
	bh=9LiFuk3BEURIR52TJvSpwWCROpFoFd33pRcsJNjcIzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HatGq2u0vU0BRryDrM8i07F0cFvYsQwbh0U+NQdHH935F3R0D6HZxtrxLxhfNuzYkvgBIlLZv31bCJN2BsrgVFU0OR2Yu5z0deeKcLNBpxLHcyUz2ujgQ2lnnfGe95TLBvXSsiQj8vT+F9JRFeXegxdxdenrwPJyzYp46xPa3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBIrI25/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBIrI25/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8781F000E9;
	Tue, 28 Jul 2026 01:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203839;
	bh=ta9y+3uyPMZ8vqpyd3Ox3C2Tr/25e+sgl8TiabLj8TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBIrI25/UGuEnsyvUG0bOJn6gruCA+n3NnlKbOhpJCXxQj9MXzFsuQNJWq+b4oiHJ
	 7ZEh4GGK2yQPqkERkmHw0ocI3iq2zTSD8fnXKbLKP1t53X95Aw7hp1VEqXkKNbitXF
	 ujhl5EPOMD4QhRl9sBA0d/2Jb0NEVqTg5+G5ZG8hNZRhPfBqV3k347P+2peyakygIA
	 vXf29e+JeIM8uHqZ/RqDgqLFdHaSPNPILEw6gTriYQHX0zYQ2/cvlWT1duMcWwsiPg
	 RnxPVzuGj7LqS8L3b6KwUDl/XarM9XDoKsguL2lPvxiiz1zcxpc1tIY4Sd2AxvkpDB
	 qchBmUpY6vgTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/10] s390/vfio_ccw: selectively expand io_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-10-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:57:18 +0000
Message-Id: <20260728015718.DE8781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The `notoper_work` work item is not canceled when the mediated dev=
ice is released, leading to a Use-After-Free of the `vfio_ccw_private` stru=
cture and `io_mutex` corruption.

Pre-existing issues:
- [High] Incomplete synchronization of the `private->crw` list leads to a d=
ata race and potential list corruption between atomic writers and mutex-hol=
ding readers.
- [High] The device state (`private->state`) is vulnerable to corruption be=
cause the newly protected `io_mutex` critical sections race with lockless a=
tomic context writers.
--

--- Patch [9]: [PATCH v8 09/10] s390/vfio_ccw: selectively expand io_mutex =
---
commit 033ce2042d965485876fe10c634ebbb9d1df4992
Author: Eric Farman <farman@linux.ibm.com>
s390/vfio_ccw: selectively expand io_mutex

The io_mutex was defined to serialize the io_regions, but has also been
associated with the I/O themselves. This patch expands the scope of io_mutex
to close remaining race windows, and introduces a workqueue element for
cp_free() to avoid acquiring mutexes in interrupt context.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index f3015132d4b5f..9269b54f5cfd4 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
> =20
> +	mutex_lock(&private->io_mutex);
>  	crw =3D list_first_entry_or_null(&private->crw,
>  				       struct vfio_ccw_crw, next);
> =20
>  	if (crw)
>  		list_del(&crw->next);
> =20
> -	mutex_lock(&private->io_mutex);
>  	if (i >=3D private->num_regions) {
>  		ret =3D -EINVAL;
>  		goto out;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but does
this lock movement fully resolve the race on the private->crw list?

While this patch protects list deletion in vfio_ccw_crw_region_read() with
io_mutex, it appears the list can still be modified concurrently without
locks. For example, vfio_ccw_queue_crw() adds items to this list locklessly:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
	...
	crw->crw.rsid =3D rsid;

	list_add_tail(&crw->next, &private->crw);
	queue_work(vfio_ccw_work_q, &private->crw_work);
	...
}

Because vfio_ccw_queue_crw() can be called from atomic contexts (like
vfio_ccw_chp_event()), it cannot acquire the sleepable io_mutex. Can this
result in list corruption between the lockless atomic producer and the
mutex-holding reader?

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index c197ad5ab5805..757ff5b2556e3 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -91,6 +91,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
> =20
>  	is_final =3D !(scsw_actl(&irb->scsw) &
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> +	mutex_lock(&private->io_mutex);
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);
>  		if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
> @@ -98,9 +99,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  			cp_is_finished =3D true;
>  		}
>  	}
> -	mutex_lock(&private->io_mutex);
>  	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
> -	mutex_unlock(&private->io_mutex);
> =20
>  	/*
>  	 * Reset to IDLE only if processing of a channel program
> @@ -110,6 +109,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  	 */
>  	if (cp_is_finished)
>  		private->state =3D VFIO_CCW_STATE_IDLE;
> +	mutex_unlock(&private->io_mutex);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but could
this state update be overwritten by concurrent lockless modifications?

With the newly expanded io_mutex, vfio_ccw_sch_io_todo() reads and modifies
private->state under the lock. However, fsm_notoper() updates the state
without acquiring io_mutex:

drivers/s390/cio/vfio_ccw_fsm.c:fsm_notoper() {
	...
	css_sched_sch_todo(sch, SCH_TODO_UNREG);
	private->state =3D VFIO_CCW_STATE_NOT_OPER;
	...
}

If a device goes non-operational concurrently with the completion of a
channel program, could vfio_ccw_sch_io_todo() overwrite the NOT_OPER state
with IDLE, discarding the transition?

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> index 4d47a3c7b9a06..5fd94e9d5c618 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -170,6 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state =3D VFIO_CCW_STATE_NOT_OPER;
> =20
> +	/* This routine could be called from IRQ context, so defer */
>  	queue_work(vfio_ccw_work_q, &private->notoper_work);
>  }

[Severity: High]
Is it possible for private->notoper_work to outlive the private structure
and cause a use-after-free?

If a VFIO_CCW_EVENT_NOT_OPER event occurs while the device is in the STANDBY
state (for instance, from an offline channel path before the device is
opened), fsm_notoper() unconditionally queues notoper_work.

However, if the mediated device is then removed without ever being opened,
vfio_ccw_mdev_release_dev() appears to skip canceling this work:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_release_dev() {
	...
	/*
	 * Ensure these work items are fully drained, so none can
	 * fire after being released. The notoper_work struct is
	 * only meaningful if the device had been opened, which
	 * means it would have been cleaned in an earlier close.
	 */
	cancel_work_sync(&private->io_work);
	cancel_work_sync(&private->crw_work);
	...
}

Because the notoper_work is never canceled here, could it execute after the
private structure is freed, leading to memory corruption when
vfio_ccw_notoper_todo() attempts to acquire io_mutex?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D9
