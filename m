Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECB238C16
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878752; cv=none; b=oZb97x4I41d+E+eKS3xkOuc9XzmsBzdPJd5xnRTKGyKEKYX855j/GqP1DjtWm0CVmrG/ZzCGNebxL0Zzm5zmk8MwwDfwlNa5SjpQkkwabuiwIgY2nY9Z7nsoWp4MpErNcAIRbbhljIDM/wFj/beARYpx0Yh+xb9OLEzCYlvzpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878752; c=relaxed/simple;
	bh=VkDfz7rcXj/JUr8U2nYkOw5+p/RIqt+qd86mMVnAEnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KCdAVBTISB1bqDfWScWQ+S/G8+/g1WLpBQ2rlxHc/0VPFa/Z3WOyv0Vjn3+F8UY3T3yS4fzsc4s3HznQuDsFFOX76UvtATl64K1/1lLqi/7UICFfsdfzK7MTtcEW+dM/qxq0Y6MCEqVXNdcey5HBvLOTa3/CVTvraf8YWFye+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyGa8Hyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyGa8Hyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62F91F00A3E;
	Tue,  8 Sep 2026 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878738;
	bh=gIE16zoFemLjuA9ibOEoeLQkjN2jfS4CplEIzo4rmqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyGa8HyrbgORTKMltOuGARfIyMw1HDZqBb0lkFR6sKDJyWW+l9QgG2gon6AUVkFm3
	 RcukyDmrUm0pxYplS0xm6SPAFOLQfN3TUmyfKJw/4TIlLmZ9+UbgW8R0hg4vp2yc0P
	 y289U66uYw0l/t6nTiZqSd8DfsXjUnRFQzwLpuXn8Bjx2XP1r0iBldf6VZ5tG7QaEJ
	 joxh8dKASqSqKFRuOhRysJljynM6wA9poSTCyJdDlks8XIHO8lBKKFY97kIPbhDNwR
	 9ElJz1DW6Vyiq7gnj5j0NYvem8gCQDbuwdLP5rXs2E81Kv+9cZYyFvBiGlfkWpd6vB
	 OpAY52dtEjK6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907144511.3810194-3-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260907144511.3810194-3-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:45:37 +0000
Message-Id: <20260908144537.A62F91F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a use-after-free for `ch->timer` by switching to `=
timer_delete_sync()`, but fails to apply the same fix for `priv->restart_ti=
mer` and `grp->timer`, leaving identical use-after-free vulnerabilities in =
the teardown paths.
- [High] Lockless traversal and modification of the global `channels` list =
can lead to list corruption and crashes.
--

commit 0701d8bf2eb4b9bc69bd86286f3b23ff8226be83
Author: Nagamani PV <nagamani@linux.ibm.com>

s390/ctcm: Fix use-after-free in channel_remove()

The commit fixes a use-after-free vulnerability by transitioning from
fsm_deltimer() to timer_delete_sync() in channel_remove(). This prevents
timer callbacks from executing after the channel structure has been freed.

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linu=
x.ibm.com?part=3D1

> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 8b0d76a47d9f0..63f8832f9b149 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,9 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c =3D=3D ch) {
>  			*c =3D ch->next;

[Severity: High]
This is a pre-existing issue, but does modifying the global channels list
locklessly here race with other list modifications?

For example, in drivers/s390/net/ctcm_main.c:add_channel():

	ch->next =3D *c;
	*c =3D ch;

Since device teardown and probe can be triggered concurrently by sysfs
writes to the online attribute, could this lead to list corruption or
crashes?

> -			fsm_deltimer(&ch->timer);
> +			timer_delete_sync(&ch->timer.tl);

[Severity: High]
This isn't a bug introduced by this patch, but should a similar fix be
applied to grp->timer and priv->restart_timer?

In drivers/s390/net/ctcm_main.c:ctcm_free_netdevice(), grp->timer is not
synchronously canceled before the FSM and mpc_group are freed:

	if (grp->fsm)
		kfree_fsm(grp->fsm);
	...
	kfree(grp);

Similarly, in drivers/s390/net/ctcm_main.c:ctcm_remove_device(),
priv->restart_timer is not synchronously canceled before priv is freed:

	kfree(priv);

Since unprivileged userspace can trigger device teardown via the sysfs
online attribute, could a concurrent timer callback access the freed FSM
and driver state, leading to a use-after-free?

>  			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +				timer_delete_sync(&ch->sweep_timer.tl);
> =20
>  			kfree_fsm(ch->fsm);
>  			clear_normalized_cda(&ch->ccw[4]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907144511.3810=
194-1-nagamani@linux.ibm.com?part=3D2
