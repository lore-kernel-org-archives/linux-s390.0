Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396E186284;
	Sat, 25 Jul 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994232; cv=none; b=sPZJAvZA3PTccyw+nIadJo/b4EOnfEYCSoThrlX8DVwJO8Ztbc5v2pMfSFtfHhzz5RzUUqWS51S4UzwIYMG/4megpSyGUx88pIEhCBsxq6Sk6nnbfd6ubTxt/lD/khGb0+MFwRAAtD10wyZvp5fldDdiZ6tuvuxitHTU6GByn8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994232; c=relaxed/simple;
	bh=M3T7jqCZv4ERe07VxXhXOrQ16LeZ3HQ8gx5Pc9nv9xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UAB70ji9YBMezTCU/KgKL4ah+3lFG4afm7gSoT+pNyOR80VeFLm9wLiu4rnFLxM1sHaLNoVwfp02/wlGI7PVUjfBoJkdAoV8lIpVk2BwJi4bgTiBuz6FGVXpr4YkbaOJ2Le+QVzgwJJSsFULFcjtHGsD39jMm+stfZqQJowyFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXia7pEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXia7pEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A0C1F000E9;
	Sat, 25 Jul 2026 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994231;
	bh=AorF4A6F0JuN6hiQ51jQcHx2eXdCqjVUFzFoRMqBkmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXia7pEvtctrJXdehiMbVAH2Na7/01DM3WcHCv+uvLRvOAgr79iN+/qEk21Ru0Osb
	 2gIM6J8GAAmprt8KDEkADq8VqabgKBDNnzmTgrdfo0VbGlVikYZHbdMAeUMpMi8o/Z
	 vr7PLa2Y4fzNoApyY7+sdg5ckC7WxrU5JNss6Tt/IKWjbb2ZOToNUKDfY3bqkrKGN4
	 itmIjCGyAZOKRwN4T4IrESxv1ZkFNqLga1ZulWg8uI8RyRY3QEoZM+d7gf3G7UIBIh
	 VcrtS8VLWmRcz9CyotqfnEdI1valYMskYV4grOYt9zkS1h4uEhDdZlFUgTsmT3upCn
	 KSVubL1mA4m3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] s390/vfio_ccw: implement a channel program mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-9-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:43:50 +0000
Message-Id: <20260725154351.11A0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pending asynchronous work items are not cancelled or flushed durin=
g device release, leading to a use-after-free and locking a destroyed mutex.
- [High] Unprotected update of `private->state` in `vfio_ccw_sch_io_todo()`=
 causes a race condition that permanently bricks the device.
--

--- Patch [8]: [PATCH v4 8/9] s390/vfio_ccw: implement a channel program mu=
tex ---
commit dd565d50b000e987452a43655c08441c643c355d
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a channel program mutex

This patch introduces a cp_mutex to protect the channel_program struct
from concurrent manipulation. It updates various functions to acquire
this mutex instead of relying on the cio layer's subchannel lock.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index c197ad5ab5805..4830f0dd9c3a3 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -91,6 +91,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
> =20
>  	is_final =3D !(scsw_actl(&irb->scsw) &
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> +
> +	mutex_lock(&private->cp_mutex);
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);
>  		if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
> @@ -98,6 +100,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  			cp_is_finished =3D true;
>  		}
>  	}
> +	mutex_unlock(&private->cp_mutex);

[Severity: High]
This is a pre-existing issue, but does this unlocked state update in
vfio_ccw_sch_io_todo() cause a race condition with concurrent close
operations?

In vfio_ccw_sch_io_todo(), private->state =3D VFIO_CCW_STATE_IDLE is assign=
ed
unconditionally outside of any locks shortly after this mutex_unlock. If a
user closes the device concurrently, fsm_close() disables the subchannel and
sets the state to VFIO_CCW_STATE_STANDBY.

If vfio_ccw_sch_io_todo() then overwrites this state with IDLE, a subsequent
device open will encounter fsm_notoper() because the state machine handles
OPEN in the IDLE state by transitioning to NOT_OPER, which bricks the device
until it is manually recreated.

> +
>  	mutex_lock(&private->io_mutex);
>  	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
>  	mutex_unlock(&private->io_mutex);

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 6c74d596be9de..9242a37677a06 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -142,6 +149,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>  	kmem_cache_free(vfio_ccw_io_region, private->io_region);
>  	kfree(private->cp.guest_cp);
> +	mutex_destroy(&private->cp_mutex);
>  	mutex_destroy(&private->io_mutex);
>  }

[Severity: High]
This is a pre-existing issue, but could destroying these mutexes here cause
a use-after-free and crash if pending asynchronous work items are still
active?

If an I/O interrupt fires right before the device is released (for example,
during unbind) and cio_disable_subchannel() returns 0 because the subchannel
is idle, the workqueue flush in vfio_ccw_sch_quiesce() gets skipped.

vfio_ccw_mdev_release_dev() will then destroy cp_mutex and io_mutex, and
free the private structure without cancelling queued work like io_work or
notoper_work. When vfio_ccw_sch_io_todo() or vfio_ccw_notoper_todo()
subsequently runs, it accesses the freed private struct and attempts to lock
the destroyed cp_mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D8
