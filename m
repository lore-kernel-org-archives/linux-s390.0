Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADD347FC8;
	Sat, 25 Jul 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994374; cv=none; b=pySjLHOT+dY3epN96zIYJ9FkMUzoPAOpYw0xxstC+tVL1RL9sS2O5kUbUAUlJS20frseJnEl3ZEKFh3qCL0cgeVAVdiYPJTX/CWTkLLev0nXAl4nBsmcrod+AeO8WtTX9K6rxFTPfZjnChZW96GoczExL7gDiV0sK0KAL7WSutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994374; c=relaxed/simple;
	bh=tPtT3UpMl800DwW7fLNmF7c1jDsQ9Flh1Yh1EH5+Ndc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OoIcCkO1H1ASgH9+iiKcPqKnsn2ieDfA404lNl6o0ySAcerI7NFqOprzKconVMTnVz+LfkPjhZ2qLydCf2899sDDTsz83SK2biL1XyUx5ykMSZI06xGcm2BLqWO5QvK80+WDPzjMGXgivj0jtXda8ccYtmt86iFTc+ltYq7dDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXYinKlJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXYinKlJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09621F000E9;
	Sat, 25 Jul 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994373;
	bh=nmHKbkM5iDw4IWzqqTEKraGRh0hBOpJnaqY4F+Vc2QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXYinKlJr8WH1GK4BBKhnObRiyzlAkPd5c/wfrlUYDyEvZ0z4PHyzt/SbCtttmJPm
	 DiJ315o/h0/E+IWyrJjZhsa2hdr4nFQBsPEClwDCb9Cu04kiqd0BE7Kbnmi/10X41e
	 i4kxzMjPF7pCIhyPF03f1qCLgZqX2qxUNPnqw7g7+B7dLZvAU+D2agMIWIupoytrOs
	 /12I+C8goPzcvIvnDVYruI4jGt+UtuAUOoBsgMlQi7fh3aLN+viodobOGkMbrOE/ny
	 DGLM3+R1XxhOZGc9f3NHy7iePLJm5UwNxyR8DkE/g61Umf8gj8t95rSctOwfqSmv5+
	 a2IvzfiUgKIWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260725152705.3958100-10-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:46:12 +0000
Message-Id: <20260725154612.F09621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of asynchronous work items (`crw_work`, `io_w=
ork`, `notoper_work`) during device release leads to a Use-After-Free of th=
e `vfio_ccw_private` structure.
- [High] Unsynchronized modification of `crw_trigger` in the `SET_IRQS` ioc=
tl causes a Time-of-Check to Time-of-Use (TOCTOU) race and Use-After-Free d=
uring eventfd signaling.
--

--- Patch [9]: [PATCH v4 9/9] s390/vfio_ccw: implement a crw lock ---
commit 5187e6c3172f066c510e9c2798199ac3a8915b42
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware. This patch
implements a lock to manage the list of those payloads to ensure
they are read cohesively.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 4830f0dd9c3a3..32f631d086205 100644
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
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does checking
private->crw_trigger under crw_lock fully protect against a Use-After-Free
during eventfd signaling?

If a guest userspace process concurrently calls the VFIO_DEVICE_SET_IRQS io=
ctl
to change or unset the crw_trigger while crw_work is running, the writer pa=
th
modifies private->crw_trigger locklessly:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
    ...
    if (*ctx)
        eventfd_ctx_put(*ctx);
    *ctx =3D NULL;
    ...
}

If the ioctl thread frees the context right after vfio_ccw_crw_todo() reads=
 it
but before calling eventfd_signal(), could the worker thread dereference a
freed pointer?

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 9242a37677a06..6735b5f4c07a2 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
[ ... ]
> @@ -139,10 +140,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
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
> =20
>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);

[Severity: High]
This is a pre-existing issue, but does the device release function need to
cancel asynchronous work items before freeing the private structure?

If the administrator removes the mdev while an asynchronous hardware event =
is
queued, vfio_ccw_mdev_release_dev() will free private without canceling the
work items, such as crw_work, io_work, or notoper_work.

Could the queued work run and access the freed private pointer, like in
vfio_ccw_crw_todo():

    private =3D container_of(work, struct vfio_ccw_private, crw_work);
   =20
    spin_lock(&private->crw_lock);
    if (!list_empty(&private->crw) && private->crw_trigger)
        eventfd_signal(private->crw_trigger);

causing a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D9
