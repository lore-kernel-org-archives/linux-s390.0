Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E2330328;
	Sat, 25 Jul 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994140; cv=none; b=BH7cZSMhjJt4zzMb+C9/RqsVRJVZhV6FO1hdndGG3qaWeKS8ktuZfUi3vudD3av4ePEzjPFnQYEe/TL7X1zJ+xEKvSQ99ihsXLfccjR+Klywb+PaOUGwT4/MbxABlDO2KBW1ZTTwOhwvW5OvBCwJDWXEs1k7Qw1SvsAZrbjIh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994140; c=relaxed/simple;
	bh=4pIH/SbOSSx4fNImt5mrO9v1Wy6Q9q6XuiHWqDkKFMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mDTBdd2U1bMKJyf5aWiws1VrssOwdbB9Le1QsGoqyH6JNc+0cYEYZGuoV73wnXKei02L/dIIcmhicFd9tl8ejtG3yq0RAaBZG7jACFFoKdnn4ER+cL306/Kz9RkGft9pyfXKGlhWGkAuuRqHFpQfNnR/04ikgjta6M7nRKBx2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jln6xM3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jln6xM3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B0E1F000E9;
	Sat, 25 Jul 2026 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994138;
	bh=PUNeq3ydYtDfKAYg9Ug/q5tYdz7lbnQnB1mkZd1IrJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jln6xM3zzLLFXhf+tmy7eoWyERJ2vObA/HqViYzoYjTNzn+gnaej40hXPuyaFqJ5F
	 PpSn0bRtSfCR9ykivxtXA4MoiRfe05ZW3xiaj+E7bCYN+4tWclw09EHbMpA6ChRjRZ
	 TgGxdY7MvoTaYBXcYOEAdK4Bg3Bng9EzaT+vP4NcjeHoNp0nMOVCN9WO5AusWAe2h3
	 /nW2gtLPUo7/oXlzjG6sC4i7T15t220/SKOgVMu2c+zb6qN6jm6Vzo9Z3ls6cozK0X
	 CcMrvJGR+NWU+ZjfuHG/MpVwOQj1Fr+yhi/XKUySe+89fAPWrvwD9OQrM/bMalI0V3
	 3QRnUiQOMgLig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] s390/vfio_ccw: move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-8-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:42:17 +0000
Message-Id: <20260725154218.75B0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly introduced `notoper_work` is queued asynchronously but n=
ever cancelled or flushed when the device is released, leading to a Use-Aft=
er-Free.
- [High] The asynchronous execution of `cp_free()` in `vfio_ccw_notoper_tod=
o()` runs without any locks, creating a critical race condition with concur=
rent callers.
--

--- Patch [7]: [PATCH v4 7/9] s390/vfio_ccw: move cp cleanup out of not ope=
rational ---
commit fa524c6f90fe876d05c7a596474d882a3c80e457
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: move cp cleanup out of not operational

This commit shifts the cleanup of channel program resources out of the
synchronous fsm_notoper state handler. It defers the cp_free operation
to a workqueue, avoiding potential lock contention with the cio subchannel
lock.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 1a095085bc728..c197ad5ab5805 100644
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

[Severity: High]
Does this asynchronous execution of cp_free need some form of locking?

If userspace closes the device file at the same time this work executes,
fsm_close might call cp_free() concurrently. Since cp_free() checks and
clears cp->initialized non-atomically:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    if (!cp->initialized)
        return;
    cp->initialized =3D false;
    ...
}

Could both threads observe cp->initialized as true, leading to a
double-free of the chain structures?=20

The commit message mentions this will be done "(soon) under its own
serialization mechanism", but should that be included in this patch to
prevent the race condition entirely?

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> index 4d7988ea47ef0..4d47a3c7b9a06 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c

[ ... ]

> @@ -170,8 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state =3D VFIO_CCW_STATE_NOT_OPER;
> =20
> -	/* This is usually handled during CLOSE event */
> -	cp_free(&private->cp);
> +	queue_work(vfio_ccw_work_q, &private->notoper_work);
>  }

[Severity: High]
If this work is queued, but the device is subsequently removed and released
via vfio_ccw_mdev_release_dev(), will the work item still be pending?

Since vfio_ccw_mdev_release_dev() frees the private structure, is there a
risk of a use-after-free if the workqueue thread eventually executes
vfio_ccw_notoper_todo() and dereferences the freed private pointer?

Should cancel_work_sync(&private->notoper_work) or flush_work() be added to
the device teardown path to ensure the work is safely stopped before private
is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D7
