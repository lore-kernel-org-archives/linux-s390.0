Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B513C1F36
	for <linux-s390@vger.kernel.org>; Wed, 30 Sep 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752486; cv=none; b=lN7Vvl5fQxiotLH4dT4Gi/CE/S2847wSinNQix/GDhA3D/eC/g9H2vMZiNzSvKq70FEe5kvaF8ebUxlIKsKRJXgbmZSZrJWJqJk9aC+Y/fj6z3yDcfKOtPUpU/bpWc5rJ4ybswPIVz/NbBWmhwF/zqjQyUuP2ypiqiu/X3noaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752486; c=relaxed/simple;
	bh=ZRlR5aYT8d3ZME76cNB222B+hIbRGOJGzrxrLEaWDoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9iM41WxSIc2jdZj0kp7T784DXGzREI5RTIi9E6QtiY1GUMNpJMd+t5DA68seHuJqu0ujbwNxgvB77YBWO7VOGv+a85Dn70yx+qi5hcqtq4Z4A5OTyyUeN+Q/Q9DjX0zkoYP9KhBl+qt2uU/8sgLMYI6qnVrP7k/ybmMo5F5UrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSHWQLep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSHWQLep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22C61F00893;
	Wed, 30 Sep 2026 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752485;
	bh=jG84qYEByOGTcIWhve7x5rkivHRV5te2FtyXKofdFqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZSHWQLepLzAeWIkmMiy2Q3yOk6BNyviPkbrUOgOc/+9zg1OtKcUM0u4bckqkN9Lu6
	 1VkJZ7oPQcndJtPMEl2dPRtbJYXhoxEHjzWEVU3BNyk+SNeGQyslb0zwgBhX7wt1+B
	 Pech5AS+/8KF7PlNfrkTHoXLThMgZEZmAvjC3CD916TRpC8ImTO15abXp78SAa8BGw
	 xOumKmAMf7gvthyy4nYdTG4lnXwMvzZko4LTX0kWZY0GMvON7FXguVjD869D5ZRZSP
	 cMp7bx5VdR1ivMPb8PWMaqp8rREcXYUGpkRwgcBd+aBEGMYaKgymWNpv3M9imzak8p
	 ztmEaG5p7V7uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260930070234.569500-3-nagamani@linux.ibm.com>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
 <20260930070234.569500-3-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:14:44 +0000
Message-Id: <20260930071444.A22C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> channel_remove() uses fsm_deltimer() which calls timer_delete(),
> returning immediately even if the timer callback is running on
> another CPU. This leaves a window where fsm_expire_timer() accesses
> ch->fsm after kfree_fsm().
>=20
> For MPC channels the teardown has a circular dependency:
>=20
>   ch->timer callback -> ctcm_chx_txretry() -> mpc_action_go_inop()
>     -> tasklet_hi_schedule(&ch->ch_disc_tasklet)
>=20
>   ch_tasklet -> ctcmpc_send_sweep_resp() -> fsm_addtimer(&ch->sweep_timer)
>=20
>   sweep_timer callback -> fsm_addtimer(&ch->timer)
>=20
> Use timer_shutdown_sync() for both timers: it waits for any running
> [ ... ]
> Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
> Cc: stable@vger.kernel.org # depends on: s390/ctcm: Fix timer corruption =
in fsm_addtimer()
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260922101913.239103-1-nagamani@lin=
ux.ibm.com?part=3D2
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930070234.5695=
00-1-nagamani@linux.ibm.com?part=3D2

