Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D53CB2FA;
	Mon, 20 Jul 2026 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580456; cv=none; b=tGvjPSi5kLaXgTyEcOkAfLYZm4+tJbgwNhMHcRVNAilRSQTJnIxaCvNL+I6ob/Y0a5TzGfsq07efm9Ff/6gNEn8jleoquT4vq9sghqV4QkYh2tvOt2HAx/ZlvuVG+DqfalTDPUha6udAAdXvk8SvlcG35XvvxGwwInX1+kuV62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580456; c=relaxed/simple;
	bh=laCJ+VyVYOcjTv2Y7agaLpZHOM2aGMUvWPlaUurJt5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C87rv0fIkLj8Qd5csmfG/SqR8WaIk99lxUDiT2OLoGmnJv/u8T+W+C0i4aEySG3xziVBxr90fjecCw9z+GO7XsCU+Bjyi+3qBzvPorY4IpXFhfej3pj5OoLiVfcVQi8hvSVSCeM90xDxK0VjizcHiLDGCenhnNt+hgV0UFfNXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQNulNe2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQNulNe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E561F000E9;
	Mon, 20 Jul 2026 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580455;
	bh=Uv1K3b7WiZi4L6Fvj3y4fC8/Q0Duk5nmJLhxHMrx1Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQNulNe28llV2dgV6+qqXkL+43CxEk7ySJ2QNhL52QGc6T7vs6928PmpcMxqjqp+W
	 hv0QN/MPFbbig3QyLgVQCjUhul7RNHNYO3MgePYYH/9IPQDQIPN/b0rVgfec6AASn7
	 vM6bjUkEBl4OgQHl9oM5oKTRULR31aRW7rq5dsrqOQW9ZLPsCT1COKTF8VhZxowvFA
	 Q2MuOnGamb2PMcnrAA1vGZ64AQ9/xbjliJEVyqy3naUoUT9QoNxgES1KbINs6jv/1b
	 sAcjcAL8P1y6vY2N3o17FH1j0Y40PkRblFWaEI77GsOTP+3VmNz12MpqQrFnskffZe
	 s2itC7IXq460g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] s390/vfio_ccw: implement a crw lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260720201931.976660-8-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:47:34 +0000
Message-Id: <20260720204734.D5E561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing workqueue cancellation during device teardown leading to U=
se-After-Free.
- [High] Data race and Use-After-Free on `eventfd_ctx` via lockless modific=
ation of `crw_trigger`.
--

--- Patch [7]: [PATCH v2 7/7] s390/vfio_ccw: implement a crw lock ---
commit a667ac37b9e546d1f3d6cceb44b21f4a47909da6
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index bfb68de6e52ca..12edccb62cbf5 100644
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
This is a pre-existing issue, but could this access to private->crw_trigger
cause a use-after-free of the eventfd context?

Looking at vfio_ccw_mdev_set_irqs() in drivers/s390/cio/vfio_ccw_ops.c, it
replaces private->crw_trigger and frees the old context with
eventfd_ctx_put() without holding crw_lock or any other synchronizing lock:

vfio_ccw_mdev_set_irqs()
            if (*ctx)
                eventfd_ctx_put(*ctx);
            *ctx =3D efdctx;

If userspace calls the VFIO_DEVICE_SET_IRQS ioctl concurrently with
vfio_ccw_crw_todo(), could the eventfd context be freed before
eventfd_signal() is executed here?

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index d2475b3158cf8..b3699ffd2f1d7 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -137,10 +138,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
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

[Severity: High]
This isn't a bug introduced by this patch, but does this function need to
call cancel_work_sync() for crw_work and io_work before the device is
released?

Since private->crw_work is dynamically queued onto vfio_ccw_work_q during
asynchronous hardware events, it might be pending or executing when the
device is removed.

If vfio_ccw_mdev_release_dev() runs and the private structure is subsequent=
ly
freed by the VFIO core without explicitly canceling the work, could it
result in a use-after-free when vfio_ccw_crw_todo() dereferences the freed
private pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D7
