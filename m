Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F041448D0C
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158785; cv=none; b=kqFT3DkJ7rlPtu4SP8PdEXTG3t40ubY0a7LRCFZZsIOLlKGGpMlcqECfCoSqqejXPbnxGuPhXSpLSAYGk5j7QAwHwRQbX8fTvOj9YK4UMtSPw/jLV7EhaMFDYDVGVXbOa/i4Vx1hrgzn/1XzOpp/Eyg4k+mt9DFsYOMgMlNhYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158785; c=relaxed/simple;
	bh=yzpRBkxSibqrHJTXbgNHHUm5aMFA5PoCQ0aiSMPTSSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nn9A3x6k7tFWv+8m8ymX9ZoslYnjXIOUHX06ECuKEWVf+Srtr0KmPx1iWJiMz5E4lsrwPZ/EY9iZvqIu9WVvlVlAuAmV6pFpX0t+9NiyGYPpaasC+4MBUGKVHlyJ4aeY2Om+6ZELEKth81rwSxtsITTqGIt1YSxv0/tqPfHM7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtVzDuGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtVzDuGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C941F000FF;
	Wed, 23 Sep 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158777;
	bh=fDKfOGXtkg2au6IUVExXi2+e3qvCBoddVpk0pEbOEBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CtVzDuGg6JS/khna3kmWSCyzaxEr+4q2TFNVaeihAzbqxB/5N0O7US5eNuQAopfFN
	 ed1ZA1KhucCuo9BjmPxSkSE9/1LW5xdFGLo5B0EfPKVmUfjYfFlLtc4AkQS3/zOim2
	 LEiULsn+inRZv0egr2/t/ajVAi71iPlCOAwjBIdui7jm1OCNAZ0yJjEzNOkHo91Zrn
	 RRna6dFoEbCelewQWfqPMPxNpg2vDmjf79yf55KKv5fS1BrggVOCAaylMaSI+CSKfP
	 MBaD4cVVgnf4mn8rvS1hOgQfvDwt45FbIwhvr+bR/pb/r1+k8Gy8U11CoQWUBz0woK
	 miHPLGVFmTRvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922101913.239103-3-nagamani@linux.ibm.com>
References: <20260922101913.239103-1-nagamani@linux.ibm.com>
 <20260922101913.239103-3-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:19:36 +0000
Message-Id: <20260923101937.24C941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/ctcm: timer_delete_sync() placed after tasklet_kill() causes =
UAF
--

commit 93e7e140a56ccbd4e4b9fe414316e60f45884b2b
Author: Nagamani PV <nagamani@linux.ibm.com>

s390/ctcm: Fix use-after-free in channel_remove()

This commit modifies the teardown sequence in channel_remove() to fix a
use-after-free. It calls timer_delete_sync() directly instead of through
fsm_deltimer(), and kills MPC tasklets and stops the sweep timer before
deleting the main channel timer and freeing memory.

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linu=
x.ibm.com?part=3D1

> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,13 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c =3D=3D ch) {
>  			*c =3D ch->next;
> -			fsm_deltimer(&ch->timer);
> -			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +			if (IS_MPC(ch)) {
> +				tasklet_kill(&ch->ch_tasklet);
> +				tasklet_kill(&ch->ch_disc_tasklet);
> +				timer_shutdown_sync(&ch->sweep_timer.tl);
> +				kfree(ch->discontact_th);
> +			}
> +			timer_delete_sync(&ch->timer.tl);

[Severity: High]
Does placing timer_delete_sync() after tasklet_kill() and kfree() leave a r=
ace
window that could lead to a use-after-free?

If the timer callback (fsm_expire_timer) is executing concurrently on anoth=
er
CPU, could it dispatch an event (e.g., via ctcm_chx_txretry()) that invokes
mpc_action_go_inop() and schedules the tasklet again?

    tasklet_hi_schedule(&wch->ch_disc_tasklet);

Since tasklet_kill() has already completed, would this newly scheduled task=
let
execute later and call mpc_action_send_discontact(), initiating a DMA
operation that reads from the already freed ch->discontact_th using the fre=
ed
ch and ch->ccw structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101913.2391=
03-1-nagamani@linux.ibm.com?part=3D2
