Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A6282F13
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196283; cv=none; b=mgsEbEl74QOpaBlcDd/+eovLMt2gJqEHF21LJ6wEkHDabBbyYxHgWK8p0Rd9Z1esPtyuVpBAK0JOVyH6JmAEp+DIo5l4HwZLJM9eBl/SUVNYukcVqpK8MIQi355R+qZrkIarrtHbLUhCKYtfQQWFeSGk8sy6ZW7pSOGrsNErhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196283; c=relaxed/simple;
	bh=WQvmfCGnbKxjF5LaXvvW4nWnluX51lFIA16cGZjnJV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbZLMn1HGGr9QW3yM5Jq3BGuWy23v22pAfjd8kbZ7iG3Y+LO2GIONPb3fVUFsW21xeg63Lv8VWoHyII/9QHFa8xESAXXNwtDMtGUC0dYvJupdpj578s4tLGI3XfImqSIxkf5LxPZa5xQXEYDDNt35edTLAMOnU+aB89wKw1OZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECfB3r8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECfB3r8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E24F1F000E9;
	Mon, 31 Aug 2026 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196281;
	bh=M6aMUPAS6F4tZOhTeT67Z1JpL25ED4xTNWeXWvZ1XxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECfB3r8juWR+cXRikOjj45VKBrGFrREIwicN35qVoZ3LJhCWiKBo1BnbzGYNZ4YmD
	 2vw8PMOlJrxHWn2hjmbnKwRY298CB27ODz/x3QtlMeWUgP0f8sZoMg1cMTe/PD8PRV
	 /EiNLhYSLBCEaaBhYEDdIGjTA/Illo1jsxuUu+TToQxkh3iAkzKx0jvSc80kgYRNP2
	 mlaRWgJ5uNHfk81bJGmh0M9bUB6mxmCo34oDqxiSu8o33S7TpYntyNgWj1QiOpBM8T
	 ewrNaH5qftoUkxlWLlckMHItYouf1DEK0JttCBKcV7lLJqhMQfsehg8cfpydG2OC9s
	 EHVIkHuTyxtoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] s390/cio: Purge based on the cdev's
 online status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831133314.4125787-536-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-536-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:11:20 +0000
Message-Id: <20260831171121.5E24F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Purging devices in intermediate FSM recognition states leads to a =
use-after-free when un-canceled FSM timers expire.
- [High] The `cdev->online` check in `purge_fn()` introduces a race conditi=
on with active device offlining, leading to a NULL pointer dereference.
--

commit 78ddd0e46a2cf7d853e46c6adaa8bbe4677d971f
Author: Vineeth Vijayan <vneethv@linux.ibm.com>

s390/cio: Purge based on the cdev's online status

This commit updates the purging logic to rely on the online variable in
the cdev structure rather than the internal FSM state, ensuring offline
devices are purged correctly.

> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 4b2dae6eb3760..7f8f78b1f8aea 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1329,7 +1329,7 @@ static int purge_fn(struct subchannel *sch, void *d=
ata)
> =20
>  	cdev =3D sch_get_cdev(sch);
>  	if (cdev) {
> -		if (cdev->private->state !=3D DEV_STATE_OFFLINE)
> +		if (cdev->online)

[Severity: High]
Can this change introduce a use-after-free for devices in intermediate
recognition states?

If a device is in an intermediate state like DEV_STATE_SENSE_ID (where
cdev->online =3D=3D 0), is blacklisted, and a purge is triggered via
/proc/cio_ignore, this new check allows the purge to proceed. Since sysfs
is not holding the onoff atomic, purge schedules CDEV_TODO_UNREG.

This leads to the device memory being freed because it hasn't been added
yet, bypassing device_del():

drivers/s390/cio/device.c:ccw_device_release() {
	...
	kfree(cdev->private);
	kfree(cdev);
}

However, the pending FSM timer is never canceled before freeing. When it
later expires, can it dereference the freed memory?

drivers/s390/cio/device_fsm.c:ccw_device_timeout() {
	struct ccw_device_private *priv =3D timer_container_of(priv, t, timer);
	struct ccw_device *cdev =3D priv->cdev;

	spin_lock_irq(cdev->ccwlock);
	...
}

[Severity: High]
Could this also introduce a race condition with active device offlining,
leading to a NULL pointer dereference?

When a driver initiates ccw_device_set_offline(), it clears cdev->online
early, drops locks, and waits for the FSM to transition to an offline state.

If a purge is concurrently triggered during this window, purge_fn() now sees
cdev->online =3D=3D 0, grabs the onoff atomic, and schedules unregistration=
. The
workqueue then unlinks the device:

drivers/s390/cio/device.c:ccw_device_todo() {
	...
	sch_set_cdev(sch, NULL);
}

When the offlining thread wakes up and calls io_subchannel_quiesce(), it
fetches the now-NULL cdev and attempts to dereference its handler:

drivers/s390/cio/device.c:io_subchannel_quiesce() {
	cdev =3D sch_get_cdev(sch);
	...
	if (cdev->handler)
		cdev->handler(cdev, cdev->private->intparm, ERR_PTR(-EIO));
}

Can this result in a kernel panic if the purge occurs during the offlining
race window?

>  			goto unlock;
> =20
>  		if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) !=3D 0)
>  			goto unlock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-536-sashal@kernel.org?part=3D1
