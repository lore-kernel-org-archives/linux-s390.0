Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C06474247;
	Thu, 23 Jul 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831555; cv=none; b=LKEJBmgWa1rr+KG2dbLAcXCFfBfAoW4LJJRNRV0Xuh4/023hvC0/iHoN061hgGe75pgjdpqs6m5yf3fXGqhFsEr4RMOCkTsgRjAF5BKDtyyf/3DIdkEj1+GoMMQ7fLjOPGJbwkfO+TSSa6JcCin5Vi0nofJjiW8WD+zyTVkCLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831555; c=relaxed/simple;
	bh=PGk/c80td/LId8hehi3OvhdCApBEbNORC3ZoNXs5MO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lx662sG8XYMULEJVkQWfxMGn03gl3vl2yyQqbTWXQ497sPv/pq15nncw5F2k2honVvXKxsEBkD5U8se6Trb7tCI5dD2Hkmp61jPS/OO1d183ekWjEeBRzg6HnvAX9TWh/enMG72WwFxvyzLqqWDEO6zXNmOJpGxTI0I7tMjnnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F1D1F00A3D;
	Thu, 23 Jul 2026 18:32:24 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] s390/vfio_ccw: implement a channel program mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260723174751.1180334-8-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:32:23 +0000
Message-Id: <20260723183224.47F1D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping `sch->lock` in `vfio_ccw_sch_event` before dispatching th=
e FSM event causes `css_sched_sch_todo` to be called locklessly, leading to=
 lost unregister events.

Pre-existing issues:
- [High] Missing locking in `vfio_ccw_mdev_reset` allows concurrent `VFIO_D=
EVICE_RESET` ioctls to trigger physical subchannel unregistration.
--

--- Patch [7]: [PATCH v3 7/8] s390/vfio_ccw: implement a channel program mu=
tex ---
commit 7b4b6e7c580cf97b697d04eaf47e890ff6d29bb0
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a channel program mutex
   =20
The channel_program struct is manipulated without a serialization
mechanism to ensure consistent behavior. Take a broad stroke of
putting the entire structure behind a mutex, and ensure everything
that needs private->cp holds this mutex.
   =20
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -259,12 +263,16 @@ static int vfio_ccw_sch_event(struct subchannel *sc=
h, int process)
>  	rc =3D 0;
> =20
>  	if (cio_update_schib(sch)) {
> -		if (private)
> +		if (private) {
> +			spin_unlock_irqrestore(&sch->lock, flags);
>  			vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
> +			goto out;
> +		}
>  	}

[Severity: High]
Since sch->lock is dropped here, does this allow css_sched_sch_todo() to be
called locklessly?

If vfio_ccw_fsm_event() routes to fsm_notoper(), we have:

vfio_ccw_sch_event()
  spin_unlock_irqrestore(&sch->lock, flags);
  vfio_ccw_fsm_event() -> fsm_notoper()
    css_sched_sch_todo(sch, SCH_TODO_UNREG);

Could this lead to a race on sch->todo, allowing other events to overwrite
SCH_TODO_UNREG and leaving the kernel state out of sync with hardware?

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -38,8 +38,13 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vde=
v, u64 iova, u64 length)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> =20
>  	/* Drivers MUST unpin pages in response to an invalidation. */
> -	if (!cp_iova_pinned(&private->cp, iova, length))
> +	mutex_lock(&private->cp_mutex);
> +	if (!cp_iova_pinned(&private->cp, iova, length)) {
> +		mutex_unlock(&private->cp_mutex);
>  		return;
> +	}
> +
> +	mutex_unlock(&private->cp_mutex);
> =20
>  	vfio_ccw_mdev_reset(private);
>  }

[Severity: High]
This is a pre-existing issue, but does vfio_ccw_mdev_reset() lack locking
protection against concurrent invocations?

If two threads concurrently trigger vfio_ccw_mdev_reset() (e.g. via the
VFIO_DEVICE_RESET ioctl), they could interleave:

Thread A issues VFIO_CCW_EVENT_CLOSE, transitioning to STANDBY.
Before Thread A issues OPEN, Thread B issues VFIO_CCW_EVENT_CLOSE.

The FSM receives CLOSE while in STANDBY state, which routes to fsm_notoper()
and schedules SCH_TODO_UNREG. Could this cause the physical subchannel to be
permanently unregistered, acting as a host denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D7
