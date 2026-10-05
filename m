Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EC4DD3C4;
	Mon,  5 Oct 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220603; cv=none; b=XojPyr7DS5nvg+4G+mrVjDNE9wuMxkHayb06OqUww/Rklf9rlw2/PwnaU9uIDvWLRWoPinQWuhvAfESL4R/2VlZCaHrVEYUB7incfp6KTF5Ud1ZKm4HAXdgAv36JWAmBQLKH1REFbxrvIg5g+RsrtRXd3QszlZgMA32n69yuvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220603; c=relaxed/simple;
	bh=HfVtJ9GnUdwhB8aS6FijORJCCLlhE4nn++9e5pz6qPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCiXKM0y+KVt0xaPV2K04H+XAT1Mk8dpG4ul1h0i4qa/hnNRMdVkHPGMyMfz9ELPgfU7UODiZi6gi4Ai7x4M/MUIlu+gZXiA0S6FKfhwu7iTW+LvKiPngbSrm6e69dBcxnR86VkseW58POMOq1q0CSKs3xyBDGBMnuOxQROaWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHfbiYOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHfbiYOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E61F1F000FF;
	Mon,  5 Oct 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220601;
	bh=EfWMGtVA8d02vQINOKkV2Q8OHs3X3KjSjxJAQvuYqP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHfbiYObLeg5HgFnG7oHNe4U7TvIlkeou8gxKzjk+G8fBA6/7A2vwmUMe+01XtImy
	 jOeH7LLvZ5CVudFttoaN3/OxKDbCuUe9Ngl6tJQNT6BYKBjjonKHAUyqdyRpoe3MYu
	 6DaC1gFvULVCoZOK0tsM1IARR/VbQSZjG9WL1i9ajMnCKjnDc1ac4kpfoevqgDTPSs
	 84FVybEQsp1ReO6iENUn08sMTtOnsDlWPpbbwlZv3zlMZzpzwxp7Mp9VJ0tLSFrT1f
	 5Me5eOt0sMA2Gp1cjXd7a7wdzvJAOgqxRP1UDk0KPBsbad1ZS8rlo66HZY8QntahW7
	 6SS+zu7c+/SyA==
Date: Mon, 5 Oct 2026 18:16:36 +0100
From: Simon Horman <horms@kernel.org>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
	aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v4 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
Message-ID: <20261005171636.GD83879@horms.kernel.org>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
 <20260930070234.569500-3-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930070234.569500-3-nagamani@linux.ibm.com>

On Wed, Sep 30, 2026 at 09:02:34AM +0200, Nagamani PV wrote:
> channel_remove() uses fsm_deltimer() which calls timer_delete(),
> returning immediately even if the timer callback is running on
> another CPU. This leaves a window where fsm_expire_timer() accesses
> ch->fsm after kfree_fsm().
> 
> For MPC channels the teardown has a circular dependency:
> 
>   ch->timer callback -> ctcm_chx_txretry() -> mpc_action_go_inop()
>     -> tasklet_hi_schedule(&ch->ch_disc_tasklet)
> 
>   ch_tasklet -> ctcmpc_send_sweep_resp() -> fsm_addtimer(&ch->sweep_timer)
> 
>   sweep_timer callback -> fsm_addtimer(&ch->timer)
> 
> Use timer_shutdown_sync() for both timers: it waits for any running
> callback and permanently prevents rearming. Shut down sweep_timer
> first (its callback rearms ch->timer at ctcm_fsms.c), then
> ch->timer. Only then call tasklet_kill() -- catching any tasklet
> scheduled by an in-flight callback before shutdown.
> kfree(ch->discontact_th) follows tasklet_kill(ch_disc_tasklet) since
> ch->ccw[15].cda points to discontact_th and
> mpc_action_send_discontact() starts I/O through ch->ccw[15].
> 
> timer_shutdown_sync() is also used for non-MPC ch->timer:
> ctcm_chx_txretry() (CTC_STATE_TX + CTC_EVENT_TIMER) calls
> fsm_addtimer(&ch->timer) on both paths.
> 
> Depends on "s390/ctcm: Fix timer corruption in fsm_addtimer()" which
> replaces add_timer() with mod_timer(). mod_timer() on a shut-down
> timer is discarded; without it fsm_addtimer() calls timer_setup()
> defeating timer_shutdown_sync(). Backporting without that
> prerequisite is unsafe.
> 
> Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
> Cc: stable@vger.kernel.org # depends on: s390/ctcm: Fix timer corruption in fsm_addtimer()
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260922101913.239103-1-nagamani@linux.ibm.com?part=2
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
> ---
> Changes in v4:
> - Shut down timers before tasklet_kill() rather than after,
>   shutting down sweep_timer before ch->timer.
> - Use timer_shutdown_sync() for ch->timer on both MPC and non-MPC paths.
> - Name prerequisite by commit title and add structured stable tag
>   dependency (Jakub Kicinski).
> - Code changed; Reviewed-by and Tested-by dropped.

Reviewed-by: Simon Horman <horms@kernel.org>

