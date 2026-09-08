Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D0551993
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878744; cv=none; b=Xwz7XD3Db74/8aAxIYrM1F3Fp5PwwkJX2uczN+uY2luoWM3gALKLGR+j04ROYDhWSLCHnsMKl137BIjL5ud9zZ8UPbdEJ6Aioz0J9UZCKMTtfDi8EIGFhWIv7xCHympBRPJaJr88RJAjs0ZyvfifUWyTe+kFRZLBarbdiS+iY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878744; c=relaxed/simple;
	bh=cdtAh+39F44ooU2W5UB+eAWDJN4tt68YysyfkftghK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CrVyzKGg8pZsSixXBM0Y0dihbhaY7vgp/UIQ25WyJEqdNTZ+Y7D2Yi2LPT6tKUz4p8IoBIB3rz2OizgG59P7qSP7dX8agBCovs60vEi8FpaFZP/n3jKTBvYlQdXCznMmZce1QirqUjUZuUDCxVoizfDGkLZnJVAl+R9tFCKtIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdfgHYGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdfgHYGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04ED1F00A3A;
	Tue,  8 Sep 2026 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878737;
	bh=N9VGHU3fl0xk1GMCTaD7GtaZjIF0o9dgV/6QyWA2854=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdfgHYGJHMhK7UwDGXyxaVm9AAHZUjZPoMFSRcRYCbqwRiA5uraT4gbj7uvIfgHXz
	 lCYB+ZaXbqixm0WBc5sWnRHjRzkFGA0WFcvRBhEqZKVTM3xkYrD2Jie905kq27cBhH
	 jEx4lhLjJ2NXXzL9eKK5s8wyiZU8i8DjlS3ovvSIntjyz4NpkaNOOsbRJze3QNJvvR
	 8bjTqMJ9lrgEimZT4oSZf7VxhymwryFpZva7ekH95hjUcYsN8hOt7yDjhMSheVZpT6
	 GZ5wNYT0Ndy2IRk5uvtvxU5YADuZfw2xaOB4fu/LCqwXCmnhpHtNymXtflN+YdXgqY
	 w28UdoW/XTbuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] s390/ctcm: Fix timer corruption in
 fsm_addtimer()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260907144511.3810194-2-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260907144511.3810194-2-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:45:36 +0000
Message-Id: <20260908144536.B04ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free during teardown due to non-synchronous timer cancel=
lation of grp->timer and priv->restart_timer
--

commit 6ecc23adfe371b690518fad3a360058f37350370
Author: Nagamani PV <nagamani@linux.ibm.com>
Subject: s390/ctcm: Fix timer corruption in fsm_addtimer()

fsm_addtimer() calls timer_setup() unconditionally before add_timer(), which
corrupts the timer list if the timer is already pending. This commit removes
the redundant timer_setup() calls from fsm_addtimer() and fsm_modtimer(),
and replaces add_timer() with mod_timer().

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linu=
x.ibm.com?part=3D1

> diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
> index 9b8622aef807b..8d2e9bbb74a23 100644
> --- a/drivers/s390/net/fsm.c
> +++ b/drivers/s390/net/fsm.c

[ ... ]

> @@ -189,12 +186,9 @@ fsm_modtimer(fsm_timer *this, int millisec, int even=
t, void *arg)
>  		this->fi->name, this, millisec);
>  #endif
> =20
> -	timer_delete(&this->tl);

[Severity: High]
This is a pre-existing issue, but while reviewing the timer handling changes
here, I noticed a potential Use-After-Free during device teardown due to
fsm_deltimer() using the non-synchronous timer_delete().

While a later patch in this series ("s390/ctcm: Fix use-after-free in
channel_remove()") correctly avoids fsm_deltimer() in favor of
timer_delete_sync() for ch->timer, it appears the same vulnerability remains
for grp->timer and priv->restart_timer.

During device unbind or offline actions, the driver calls fsm_deltimer()
to cancel these timers and then immediately frees the enclosing structures.

For instance, in drivers/s390/net/ctcm_main.c:ctcm_free_netdevice():

	tasklet_kill(&grp->mpc_tasklet2);
	kfree(grp);

And similarly in ctcm_remove_device():

	if (cgdev->state =3D=3D CCWGROUP_ONLINE)
		ctcm_shutdown_device(cgdev);
	dev_set_drvdata(&cgdev->dev, NULL);
	kfree(priv);

If the fsm_expire_timer() callback is executing concurrently on another CPU
when kfree() is called, could it dereference the freed grp or priv
structures?

Would it make sense to update fsm_deltimer() to use timer_delete_sync() to
safely wait for concurrent callbacks, or otherwise ensure synchronization
during teardown?

> -	timer_setup(&this->tl, fsm_expire_timer, 0);
>  	this->expire_event =3D event;
>  	this->event_arg =3D arg;
> -	this->tl.expires =3D jiffies + (millisec * HZ) / 1000;
> -	add_timer(&this->tl);
> +	mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907144511.3810=
194-1-nagamani@linux.ibm.com?part=3D1
