Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546447A867;
	Thu, 23 Jul 2026 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831676; cv=none; b=uwd72kXo8mLG1UGs7ZFRaZ5glUqFFiCg1Zku47O6fFl1eoBy43M7E8b43CZAWaC8RpO/K44LJempgP++t+dw3/oyXpwX17SlH6cd5kb0xnSXDqTozmc0/uJk1kuybujZO342L7Spq1RdGZShYjD+jWJ866Xa8uv2wkJ32HA1wLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831676; c=relaxed/simple;
	bh=SowO0K8L9bw2ZcCRFwDmHQFqzl//emRA88WQ9DY6/rA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l3pgtpURlXVj+/qNqToI/s57g0c9xA/OfhmJX/q8mq4d+/1DxPDkcmMykj/zhnje7UXl2i+7U0xdC5QHohqvz3VfiVWY/QUSonoQgcu82ZsBr8WjcisysjMqNG6ql4NdcGht8vo4lOO9O5CCWpG5pyYJcFW2QFaQa1oIT4PpdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6kQtpBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6kQtpBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7AE1F000E9;
	Thu, 23 Jul 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831671;
	bh=xPDcGjyGykqKroUuX5ffgXMzDsp98MslLygMD3mNRPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6kQtpBaEw0M4bMbwpNRvP45eNEBjfN74ckMGawNMEDXUFRly1VsIVkE0SJg8lUjS
	 9bqkeCAt9JN150sUaWaHLG6IjGZ7q6dwu47m2JG2yUBE68k5uLSU4Ge9QsAzn3pWzw
	 JbI5FlYPRNDOLWKyX80eXhXkXTiEFop3OgJrd9IHwnMyrmTMGf+gtAx+8XVKSHvhrD
	 6H+htR4EaCsXcsY7GCkvKlQqZv/etYQC3wFrGj37BJ270euJD2SAod/BHPmMAIEDmq
	 ysr4wOhIECFFTHUaUpn2CvbMsUViQT85VoJpJ3hFYPxKjfBvDYNWim+mgnSDnm3EIY
	 Bigu21Pc/0v2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-9-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:34:30 +0000
Message-Id: <20260723183431.2D7AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of work items (`crw_work` and `io_work`) duri=
ng device release leads to a Use-After-Free vulnerability.
- [High] Concurrent updates to eventfd contexts (`crw_trigger`, `io_trigger=
`) in `vfio_ccw_mdev_set_irqs()` lack synchronization, leading to a Use-Aft=
er-Free of the `eventfd_ctx`.
--

--- Patch [8]: [PATCH v3 8/8] s390/vfio_ccw: implement a crw lock ---
commit 9d63fadad88983453bdf16e8b5f5b2ddd01df2c8
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 1d8c2ed9da509..2c0a27851342c 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -125,8 +125,10 @@ void vfio_ccw_crw_todo(struct work_struct *work)
> =20
>  	private =3D container_of(work, struct vfio_ccw_private, crw_work);
> =20
> +	spin_lock(&private->crw_lock);
>  	if (!list_empty(&private->crw) && private->crw_trigger)
>  		eventfd_signal(private->crw_trigger);
> +	spin_unlock(&private->crw_lock);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for this work=
er
thread to race with the VFIO_DEVICE_SET_IRQS ioctl handler?

Looking at vfio_ccw_mdev_set_irqs(), it updates the eventfd pointers and
releases old contexts via eventfd_ctx_put() without holding crw_lock.

Could a worker thread read a non-null crw_trigger here, but before
eventfd_signal() executes, the ioctl frees the eventfd context, resulting i=
n a
use-after-free of the eventfd_ctx?

>  }
> =20

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 04800cfa779b6..277138f14b251 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -138,10 +139,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
evice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
> =20
> +	spin_lock(&private->crw_lock);
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {
>  		list_del(&crw->next);
>  		kfree(crw);
>  	}
> +	spin_unlock(&private->crw_lock);

[Severity: High]
This is a pre-existing issue, but does this function need to call
cancel_work_sync() for private->crw_work and private->io_work before the
private structure is torn down and freed?

If a work item was asynchronously queued (e.g., via vfio_ccw_chp_event()),
could it execute after the device is released and dereference the freed
memory?

The flush_workqueue() in vfio_ccw_sch_quiesce() doesn't appear to be
guaranteed to run on all paths, and might not prevent new works from being
queued before the structure is freed.

> =20
>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D8
