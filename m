Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7121C860A;
	Sun, 26 Jul 2026 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785040070; cv=none; b=Vpbv2ISzTgkkbLk3+l9MgkbjTRY9BYhSW565Pe7SeDfwuQghdIt/+S46tjf5TCAW2gwwRAYJBBOzNXGT50peadnb6iJnLmkbTKC5IerW23k9oTtA8bcd3h2Xarhom6RGzjpymfAUF8zzcLAhM4oNDgGrZNLbaGNJUj4QVJog/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785040070; c=relaxed/simple;
	bh=QuPzNyW9paP4wfzubDtsqwYNqNV3NjhnKAeFvcHpMMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SX09l9fkYkgbKfW90XUmP1bVlkqg2zM75WPHAa2+Zp5Cm4Pb32DjJeBHHmMb22DNxiyP4dY7gf5xhcgnu94RzozJMBe6bf3CK4Uoe5ZpdPHt05TQSDPRQuMG/7KgJxNy7PZBwOKdzAQWKL8p01/cuw6ykHaSutOLzPjsKVVyMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfQgnaeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfQgnaeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222791F000E9;
	Sun, 26 Jul 2026 04:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785040068;
	bh=UpCN9q1LshfTL3cob9SjlphXDx3ezYJhAKaAvWSJzxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfQgnaeMOmx8/76BmI5CK810U4HD6Ybu0+BAJSSHoLlen25hHXfFML5u5kYiGCuQy
	 bMOuJqODKtRlb0C1dkcDmTWgd0hFhIRGONw9EhTXtZu2vQ2CB4pcAIEOoqhKajPACK
	 10hJBocKcTfbM6uVvdur9c+wu0WIZQ8qzR3PHmqLf8DnmGa6uUf5eCVFgza4jKBz4/
	 jhAJNQqOO7P+6QWHUQZu0N3rh8ZGMlGm81lx1PzxM80N70EogiN0GPn06oWs4nb3vS
	 gLFCEtphKAenAKUA64TccU+zh2qCAJgXUKRDi/z81IlOeX3Y0GE8IjjeSwIHUlt29f
	 OVHkJm2u14AYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260726040129.2946151-11-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-11-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:27:47 +0000
Message-Id: <20260726042748.222791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing write-side lock in `vfio_ccw_mdev_set_irqs` renders `crw_l=
ock` ineffective, leading to Use-After-Free of `eventfd_ctx`.
- [High] TOCTOU race between `vfio_ccw_mdev_remove` and asynchronous channe=
l path events leads to Use-After-Free of `vfio_ccw_private`.
--

--- Patch [10]: [PATCH v5 10/10] s390/vfio_ccw: implement a crw lock ---
commit b1ac07dbd7bc9e331720d0ba13ad54e4a3ae455a
Author: Eric Farman <farman@linux.ibm.com>
s390/vfio_ccw: implement a crw lock

This commit introduces a new crw_lock to serialize access to the Channel
Report Word (CRW) list elements in the vfio_ccw driver. It replaces implicit
synchronization with explicit spinlocks when queueing, reading, and freeing
CRW structures, as well as when notifying userspace via eventfd.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 4830f0dd9c3a3..437d7709b4a56 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but does crw_lock fully protect
crw_trigger from concurrent modification?

In vfio_ccw_mdev_set_irqs(), the eventfd context can be updated and the old
context freed without acquiring crw_lock:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (*ctx)
        eventfd_ctx_put(*ctx);
    *ctx =3D efdctx;
    ...
}

Because the write side in vfio_ccw_mdev_set_irqs() doesn't take the lock,
could a concurrent VFIO_DEVICE_SET_IRQS ioctl free the context while
eventfd_signal() is executing here, leading to a Use-After-Free?

[ ... ]
> @@ -290,6 +293,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
>  			       unsigned int rsid)
>  {
>  	struct vfio_ccw_crw *crw;
> +	unsigned long flags;
> =20
>  	/*
>  	 * If unable to allocate a CRW, just drop the event and
> @@ -307,7 +311,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
>  	crw->crw.erc =3D erc;
>  	crw->crw.rsid =3D rsid;
> =20
> +	spin_lock_irqsave(&private->crw_lock, flags);

[Severity: High]
This is a pre-existing issue, but could this lock access trigger a
Use-After-Free if the mdev is being concurrently removed?

The CSS core calls vfio_ccw_chp_event() asynchronously. It retrieves the
private pointer locklessly and then calls this function:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_chp_event() {
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
    if (!private || !mask)
        return 0;
    ...
    vfio_ccw_queue_crw(private, ...);
}

If vfio_ccw_mdev_remove() runs concurrently, it clears the driver data and
drops the final reference:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
    ...
}

If the channel path event handler passes the NULL check and gets preempted
before mdev removal finishes, won't taking private->crw_lock here access
freed memory?

>  	list_add_tail(&crw->next, &private->crw);
> +	spin_unlock_irqrestore(&private->crw_lock, flags);
>  	queue_work(vfio_ccw_work_q, &private->crw_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D10
