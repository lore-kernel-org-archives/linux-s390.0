Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1455237A0
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651347; cv=none; b=IIKcOi2fo/c8vZk+PBiyKgx0QKY2qnmvHtquNh62YWH3g4rDORGsjFBp2OBuKDN1iADbXUCPe6ZO5Rvc067dM2BEcQnwS5QYoZc0k82JZZIAnc0q5HMTL+VxeIwnohlRjapv7Vxk4tWJuR0YJXs02MtvshzcyUByrdAbZ8e7weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651347; c=relaxed/simple;
	bh=aGdGXNNLwJ0yQoeXlkF5HBes0GuPKpKOn3XppLNO4p8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+xOeIwxGmNgHTp486JQnSktMoHJg8Oh8mHckEMfkTxVrAQg58A3Kv8R7+KtTxE3ktbjf3G9dG21pddFiRgYKLY0Vxmpr46SPrNEBEUdPhZizoVI9FSy6g5baJD2T6QBDerNL6x5/kRYRNfCykXA69XJjznnf5wvTTBFZXysdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcvZJ528; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcvZJ528"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FF1F00898;
	Thu, 17 Sep 2026 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651345;
	bh=Goll1IogCekTcXs0iXnmzR1k1bl5JM0Gwd6drVo+77E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XcvZJ5282BwoQ53YtnHN+0LR9OI4M7Wm6q7I2PXiwEjwQx7Pwa38YZpI8xt7UyUsb
	 KVjREXmkFlWTXvEIOSj7Wu9NnvT+PNpf9wuquth9A04S7Z7SU5J6pxVT9kx5hVw6hV
	 EqG6Mmw/QDuvjxkaUp16Ju93vgH2qZJNpc9hOjse54spW6JB2kqZG7OMTA1SvQSnMm
	 dcMhFQ/4swW8uYER6s6lYjw4u7vZZb+y3OjUeiPjp+VohuoCgRKAHDPsjXK7xpmUg/
	 vcoNtPnbvy1FiICaIO4b634uTRyqXF1VOJRsCeMHYDgNFx++58dUkLz9VO1ujaL+rL
	 AvI9uIxC6FNCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260916132149.4185912-3-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-3-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:22:24 +0000
Message-Id: <20260917132225.646FF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] timer: use-after-free in channel_remove() due to re-arming after t=
imer_delete_sync()
--

commit f0230a69308edd523997bd09005283eab61bb03e
Author: Nagamani PV <nagamani@linux.ibm.com>

s390/ctcm: Fix use-after-free in channel_remove()

This commit attempts to fix a use-after-free in channel_remove() by replaci=
ng
fsm_deltimer() calls with direct calls to timer_delete_sync() before freeing
the channel structure. The commit message states timer_shutdown_sync() was
avoided to prevent self-deadlocks if FSM action functions call fsm_deltimer=
()
from within the timer callback chain.

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linu=
x.ibm.com?part=3D1

> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,9 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c =3D=3D ch) {
>  			*c =3D ch->next;
> -			fsm_deltimer(&ch->timer);
> +			timer_delete_sync(&ch->timer.tl);
>  			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +				timer_delete_sync(&ch->sweep_timer.tl);

[Severity: High]
Can this sequence lead to a use-after-free if the main timer is re-armed
during teardown?

Looking at channel_remove(), the patch deliberately uses timer_delete_sync()
instead of timer_shutdown_sync(). While timer_delete_sync() waits for a
running callback to finish, it does not mark the timer as shut down or
prevent it from being re-armed.

If a concurrent sweep_timer callback executes during channel_remove(), it
can re-arm the main timer via ctcmpc_chx_send_sweep():

drivers/s390/net/ctcm_fsms.c:ctcmpc_chx_send_sweep() {
    ...
    fsm_addtimer(&wch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, wch);
    fsm_newstate(wch->fsm, CTC_STATE_TX);
    ...
}

If channel_remove() calls timer_delete_sync() on ch->timer.tl first, and
then spin-waits for ch->sweep_timer.tl, the sweep_timer callback could
re-arm ch->timer right before the teardown thread proceeds to free the
channel structure via kfree(ch).

Since the kernel Timer API requires timer_shutdown_sync() to safely
prevent this exact re-arming scenario before freeing, does leaving the
timer capable of being re-armed leave it active on the timer wheel after
the channel memory is gone?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916132149.4185=
912-1-nagamani@linux.ibm.com?part=3D2
