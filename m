Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0A30C618;
	Tue, 28 Jul 2026 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211311; cv=none; b=RhLUPxGYl9grINLNdcz8yhjLmUEjgEy0xPe7kUw74zHztemof6I/6u+djz7DOogYcciHxmIX/s4+nnRwfs0kkwibuAdeSKEj0QySUCTN0RbRyY171Gl9LhkU5/UlCbP5o+9chF9+vP7/UJbFcifXJ4Pw3FGGQ8LIr6Ad7CB8JU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211311; c=relaxed/simple;
	bh=I08ewCYqfPMZ6vCU0//94UDLD987z3K2JT7HxZkm+/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sJWOc3IuKjDNz4nTHttq3HbXCFxh05Nw21ceh5X91nZXZjmXl8KtR1pav38ixaQySBYXJ2SOka8BqdJAlY9rR/NH/ZXGgnaie5wvEdTqAA92qc8PdYEvPNiDIfdmjOrXuzARoB9232DE8LVmxeXMvi+Yfrgeabd9Amykf0KmOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkMDk5GD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkMDk5GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0041F000E9;
	Tue, 28 Jul 2026 04:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211310;
	bh=C+71wp9GN0qkqczwgv8rnvEvOLHIEdy91s3PGtG6yAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkMDk5GDXNa/f3faMN4mgRoocxwmKdvhkTCsCBNYfqfzpPBKfX5QKRGcleqruPxzu
	 PZkBJBIsk54Ai4eKYSzsz0yc2yTeVGS4tVYOIYIgtPXew0BUbx+kNKL85ZEzUD628Z
	 7Ifk2w4VhW05T9Jb2kb80+7yDwvXduPL1WuZTPXc36hmK/mM74G0JLR1uh6td8qfnb
	 SHeIM2JzBOBKtRJOhYvp1kcqJshI2xhiJaowVrcuHFTzHmLJCcmzgWulY2/a4ipQOI
	 3YxXmpx5RZM+BsiHizJGhGms/7wsize3fQFIKg7tVWXs5n0yhnQyPyIG/cWo4u5nbI
	 DJ8HXz2N9OitQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-9-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:01:49 +0000
Message-Id: <20260728040149.CB0041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `vfio_ccw_notoper_todo` work function calls `cp_free()` wi=
thout acquiring `private->io_mutex`, leading to a severe data race with use=
rspace I/O request processing.
- [High] Asynchronous subchannel events can queue `notoper_work` after `flu=
sh_work()` has completed during device release, leading to a use-after-free=
 of the `private` structure.
- [High] Concurrent execution of `cp_free()` from `fsm_close()` and the new=
 `notoper_work` leads to a double free of channel program resources.
--

--- Patch [8]: [PATCH v9 08/10] s390/vfio_ccw: move cp cleanup out of not o=
perational ---
commit 6c38f1bdce307c2af2028b820c48f0ec882d90de
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: move cp cleanup out of not operational

This commit moves the cleanup of the channel program out of the
fsm_notoper() routine and defers it to a workqueue. This avoids
performing the cleanup while holding the cio subchannel lock.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c

[ ... ]

> @@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
>  		eventfd_signal(private->crw_trigger);
>  }
> =20
> +void vfio_ccw_notoper_todo(struct work_struct *work)
> +{
> +	struct vfio_ccw_private *private;
> +
> +	private =3D container_of(work, struct vfio_ccw_private, notoper_work);
> +
> +	cp_free(&private->cp);
> +}

[Severity: Critical]
This isn't a bug introduced by this patch, but does moving the cleanup
to a workqueue create a data race with userspace I/O requests?

If vfio_ccw_notoper_todo() runs concurrently with a guest operating system
issuing an I/O request via vfio_ccw_mdev_write_io_region() (which acquires
private->io_mutex), might cp_free() execute locklessly?

If notoper_todo executes during fsm_io_request() processing cp_prefetch(),
it could tear down the channel program and free ccwchain pointers while
they are actively being iterated and dereferenced.

The commit message notes a future patch manages locking, but should this
be protected by io_mutex here to avoid memory leaks and use-after-free
conditions?

[Severity: High]
This is also a pre-existing issue, but could this lockless execution lead
to a double free if the device is closed concurrently?

When the device is closed, fsm_close() drops sch->lock and calls cp_free().
If a notoper event occurs simultaneously after the lock is dropped,
vfio_ccw_sch_event() queues notoper_work.

Since cp_free() is lockless and cp->initialized is not atomically updated,
could both the fsm_close() thread and the new workqueue thread read
cp->initialized as true and double-free the channel program allocations?

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -134,9 +135,16 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
>  	/*
>  	 * Ensure these work items are fully drained, so none can
>  	 * fire after being released.
> +	 *
> +	 * notoper_work should have nothing to do here, because only
> +	 * open devices could have channel_program resources in use
> +	 * and those would be released during close. Nevertheless,
> +	 * call flush here as well to be certain anything that was
> +	 * allocated is freed.
>  	 */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	flush_work(&private->notoper_work);

[Severity: High]
This is a pre-existing issue, but does flushing the work here guarantee
that new work cannot be queued afterwards?

If a user removes the mdev via sysfs concurrently with a subchannel event,
vfio_ccw_sch_event() fetches the private pointer from drvdata outside
the subchannel lock:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_event() {
	struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
	...
	if (cio_update_schib(sch)) {
		if (private)
			vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
	}
}

If the event thread is preempted, vfio_ccw_mdev_remove() can complete
unregistering the device and invoke vfio_ccw_mdev_release_dev(). Once
release finishes, flush_work() returns and the private structure is freed.

When the preempted vfio_ccw_sch_event() thread resumes, won't it use the
freed private pointer to call fsm_notoper() and execute queue_work() on
the freed private->notoper_work memory?

Calling queue_work() after the workqueue shutdown sequence completes
might corrupt the workqueue linked list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D8
