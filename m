Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E1379C56;
	Tue, 28 Jul 2026 04:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211523; cv=none; b=MMzzqBQoetLss86x8PFo6FpmhYX9+wTKyatcU5AmXK1TS0JxChH5/HqWlcPj/Y2DLG2ho+gPmbcoHwjBl2QAOY53cAyiNMpYYsOtowfY8PXI5LMbIMJ50ioAWMqoWmhbeSTIyH49+BLrbBv2U/+KtTz3uoYg8XEMgR3j3187q3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211523; c=relaxed/simple;
	bh=HTI33PgqdoG3MftIkk8N2M5WDHS5W9F3rFUQzw9U0zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I4/H1Bt++Qv3EAfi3g7bcfRHMAVrCjQXz5KQTVb8RQoDAwyZNyLHA9VTHWj9n5SDCa3NbsxQ5G2sbEdfF3Vf9v/5Z675OTqC4dEofen1wL8q5cunnWEShLhWIqjxKi631NH66yieBAu7U7E4j1S65zmWZzLKYjjZqdf+PtFq/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA0Tl1Ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA0Tl1Ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5785D1F000E9;
	Tue, 28 Jul 2026 04:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211522;
	bh=zmklOlI6dmMbaCpTs0A20JH7nokbJ5Ivq595DXYjHFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kA0Tl1Ms/Tp9d95i4wUTn3EPu6gv/VqFzBW8Tjdjllf73BvUeGe4zYHBqtxWlh7Uw
	 7AlvBCjTvOMivHB5GKdN59y444AiHQzRJuXfbceNVIyq/3AdZtWv6tK/qkAZYwXVCA
	 46Z0335h/fSi7GpbPxFdRXxBtThoV/xr5p6dq0qfwAlJIHe4MTrOu3E5OVELRlFNK7
	 wYMxVAU4R6KYKXWImPI47JjlWcTyY2pVKeuiThuTBI9HctCEMTxfqKJtSqeEYg6JyX
	 6t9OHyYCWIMzc3ctgh12rZycbO6NGEOzMzj0cBI1lb607mBbEG2YdOo3ywCVH3OwSQ
	 Q7+8TqtPx64qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/10] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-11-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-11-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:05:21 +0000
Message-Id: <20260728040522.5785D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent lockless modification of eventfd triggers in `vfio_=
ccw_mdev_set_irqs` causes a Use-After-Free of the `eventfd_ctx`.
- [High] Concurrent execution of asynchronous CSS events and mdev removal c=
auses a Use-After-Free of the `private` structure.
--

--- Patch [10]: [PATCH v9 10/10] s390/vfio_ccw: implement a crw lock ---
commit 1d80144375864b24376def1fe3aa7c470ed46eba
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

This commit introduces a spinlock to serialize access to the CRW region,
which relies exclusively on asynchronous events from hardware. It ensures
cohesive reading of those payloads and manages the list of those payloads.

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

[Severity: Critical]
This is a pre-existing issue, but can this concurrent lockless access to
private->crw_trigger lead to a use-after-free of the eventfd_ctx?

The ioctl writer in vfio_ccw_mdev_set_irqs() modifies and releases the even=
tfd
pointers locklessly:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (*ctx)
        eventfd_ctx_put(*ctx);
    *ctx =3D NULL;
    ...
}

Concurrently, this worker thread reads the trigger pointer here without any
synchronization against the ioctl writer (no RCU, no matching locks).

Could the ioctl free the context immediately after the worker validates the
pointer but before it signals it? (This same pattern also appears in
vfio_ccw_sch_io_todo() with private->io_trigger).

> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  }

[ ... ]

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
This isn't a bug introduced by this patch, but can the private pointer be f=
reed
before this lock is acquired, leading to a use-after-free?

Concurrent mdev removal clears the driver data and drops the device referen=
ce
without synchronizing against the CSS subsystem:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
    ...
}

Concurrently, an asynchronous CSS event triggers vfio_ccw_chp_event(), which
fetches the private pointer locklessly just before it is cleared:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    ...
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
}

This path uses the potentially freed pointer to lock memory here and push a
freed work_struct onto the kernel workqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D10
