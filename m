Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D275497B7E;
	Mon, 28 Sep 2026 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638459; cv=none; b=lcdMB9S9PgxiCzIv0vdfM3cYIu30T4X1GPjHJIP21D0s2ZCf2enP1bmz1vVSF6ag0RoVWxQL6HKQeTYy9/y1qK6SCEt/FLfV9MAJYmi8T/AgHhvRO1oKkMUBfHInpSV5968bGz7ZZr+xK6uGavWIh1XB7IzIjVuaMFbsaUG3smU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638459; c=relaxed/simple;
	bh=7Yl9Oh/Fu5cbYaVAko3whfR2No4jxP/RzjDp4WNfqKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoaKoAqiO5TMsZ1KPO6GSus2ppysNR42NqNbmCrZrVG5DXeU4PmFZvquBBtY+icU1t6g8a8yt/CQskN6Qps/51aCSDodIEwKBFyQV4YuiRf2H4XY1KMblzSPSDjym+vKcZ2U/rFQiBSi0NDOYZJ4msRBYic1oUqm7HhBK0VPKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0jvJOml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0jvJOml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D190C1F000FF;
	Mon, 28 Sep 2026 23:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638458;
	bh=dWMsX/mJz1WQAYgPYmUMD67CTJEC9CAGLM7/55rhDYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0jvJOmlY9eF49LIkpfN7exQnaf/t1lpMC0j+jsVWJALwuG7IlJu8/kVcJVMRbkVt
	 PVK6a2dLXQSP73OIrE2YrmULz+hNMkxqcKEcc08luQqB49mwRpG5QmbGUgJbME8gCY
	 /dhtj7uTa2vzFco6ZVfU+NpZzhSeug7Y7UJL+WvWwEEt7FrMkokBd1OraNbwJSzjTQ
	 B/Yz3rwKtj2v3e/8M4GYn9+aVptBtfofkunxiIyJdDkuDfZRCq9B/WNrctwwGW82Z4
	 1Urx5sRSyCtySrD8CqlEYh9B+mluV2RB86C4uGSfAmsI1FJRLibh0AMHCAN60y6usD
	 pJYCaZGszNH0w==
From: Jakub Kicinski <kuba@kernel.org>
To: nagamani@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	kees@kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] s390/ctcm: Fix use-after-free in channel_remove()
Date: Mon, 28 Sep 2026 16:34:16 -0700
Message-ID: <20260928233416.2796559-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922101913.239103-3-nagamani@linux.ibm.com>
References: <20260922101913.239103-3-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
s390/ctcm: Fix use-after-free in channel_remove()

The patch changes channel_remove() so that it no longer calls
fsm_deltimer(). It calls timer_delete_sync() and timer_shutdown_sync() on
the underlying timer_list instead. It also moves the MPC tasklet_kill()
calls and kfree(ch->discontact_th) ahead of kfree_fsm(ch->fsm). The aim is
to stop timer and tasklet callbacks from running against freed channel
memory.

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1

> Patch 1 changes fsm_addtimer() to use mod_timer() without reinitializing
> the timer, which is required for timer_shutdown_sync() to reliably
> prevent subsequent re-arms.
>
> Backporting patch 2 without patch 1 is not safe because the old
> fsm_addtimer() reinitializes the timer with timer_setup() before
> add_timer().

[Severity: Low]
This isn't a bug, but "Patch 1" and "patch 2" won't mean anything once
these commits are in git history.

The prerequisite is "s390/ctcm: Fix timer corruption in fsm_addtimer()".
Its Fixes: tag (e99e88a9d2b0) is different from the one on this commit
(293d984f0e36). Without it, fsm_addtimer() calls timer_setup() again, which
restores ->function and undoes timer_shutdown_sync(&ch->sweep_timer.tl).

Could the commit message name the prerequisite by title or SHA? Could the
Cc: stable line also use the "Cc: stable@vger.kernel.org # <ver>: <sha>:
<title>" form, so the dependency is recorded in a way tools can pick up?

> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 8b0d76a47d9f0..5053737f11fc7 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,13 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c == ch) {
>  			*c = ch->next;
> -			fsm_deltimer(&ch->timer);
> -			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +			if (IS_MPC(ch)) {
> +				tasklet_kill(&ch->ch_tasklet);
> +				tasklet_kill(&ch->ch_disc_tasklet);

[Severity: High]
Is this quiesce early enough? On the offline path, channel_remove() only
runs after ctcm_free_netdevice() has already freed the shared MPC state:

ctcm_shutdown_device()
    channel_free(priv->channel[CTCM_READ])
    channel_free(priv->channel[CTCM_WRITE])
    unregister_netdev(dev)
    ctcm_free_netdevice(dev)
        kfree_fsm(grp->fsm)
        kfree(grp)
        priv->mpcg = NULL
        kfree_fsm(priv->fsm)
        free_netdev(dev)        /* MODULE builds only */
    ...
    channel_remove(priv->channel[CTCM_READ])
    channel_remove(priv->channel[CTCM_WRITE])

ctcmpc_bh(), the ch_tasklet handler, dereferences these objects without
checking the channel FSM state. Setting CTC_STATE_IDLE in channel_free()
therefore doesn't stop a tasklet that is already pending:

drivers/s390/net/ctcm_mpc.c:ctcmpc_bh() {
	struct net_device *dev	= ch->netdev;
	struct ctcm_priv  *priv	= dev->ml_priv;
	struct mpc_group  *grp	= priv->mpcg;
    ...
	while ((fsm_getstate(grp->fsm) != MPCG_STATE_FLOWC) &&
    ...
}

Suppose the RX path scheduled rch->ch_tasklet just before the device was
taken offline, and the tasklet is still pending (for example deferred to
ksoftirqd) when ctcm_free_netdevice() runs. Can it then dereference a NULL
priv->mpcg, or a freed dev in MODULE builds, before channel_remove() gets
to tasklet_kill()?

Something similar can happen with sweep_timer. An in-flight action in
ctcmpc_chx_send_sweep() can overwrite the CTC_STATE_IDLE set by
channel_free() and re-arm wch->timer:

	fsm_addtimer(&wch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, wch);
	fsm_newstate(wch->fsm, CTC_STATE_TX);

If that timer fires before channel_remove(), the TX timer action would use
ch->netdev and priv->mpcg, which by then are freed or NULL.

The error path in ctcm_new_device() has the same order: it calls
ctcm_free_netdevice() at out_dev and channel_remove() on both channels
afterwards.

Would it make sense to quiesce the tasklets and timers of both channels
before ctcm_free_netdevice() is called?

> +				timer_shutdown_sync(&ch->sweep_timer.tl);
> +				kfree(ch->discontact_th);
> +			}
> +			timer_delete_sync(&ch->timer.tl);

[Severity: Medium]
Can a timer callback schedule ch_disc_tasklet again after the
tasklet_kill() above?

tasklet_kill() waits for the current run and clears TASKLET_STATE_SCHED.
It doesn't stop a later tasklet_hi_schedule(), and the timer actions can
reach one. ctcmpc_chx_send_sweep() raises MPCG_EVENT_INOP when
set_normalized_cda() fails:

	if (set_normalized_cda(&wch->ccw[4], skb->data)) {
		...
		fsm_event(grp->fsm, MPCG_EVENT_INOP, dev);

CTC_EVENT_TIMER actions such as ctcm_chx_txretry() can also end up raising
MPCG_EVENT_INOP. mpc_action_go_inop() then does:

	case MPCG_STATE_FLOWC:
	case MPCG_STATE_READY:
	default:
		tasklet_hi_schedule(&wch->ch_disc_tasklet);

Consider a timer action that read a non-IDLE state before channel_free()
and is still running across the tasklet_kill() calls.
timer_shutdown_sync() and timer_delete_sync() wait for that callback, but
not for the tasklet it queued. mpc_action_send_discontact() would then run
on the freed ch and start I/O through ccw[15]. add_channel() pointed
ccw[15].cda at the discontact_th buffer, which is freed just above.

On the ctcm_shutdown_device() path, the same callback would also touch the
grp->fsm that ctcm_free_netdevice() has already freed. The window is
narrow, but nothing blocks the reschedule.

Would a second tasklet_kill() after the timers are synced, or a
tasklet_disable() before them, close this?

>  
>  			kfree_fsm(ch->fsm);

[Severity: High]
This isn't a bug introduced by this patch, but the same removal sequence
seems to leave two other FSM timers running on freed memory.

ctcmpc_init_mpc_group() binds grp->timer, which is embedded in grp, with
fsm_settimer(grp->fsm, &grp->timer). ctcm_init_netdevice() binds
priv->restart_timer to priv->fsm. ctcm_free_netdevice() frees all of these
without first cancelling either timer synchronously:

drivers/s390/net/ctcm_main.c:ctcm_free_netdevice() {
    ...
		if (grp) {
			if (grp->fsm)
				kfree_fsm(grp->fsm);
			...
			kfree(grp);
			priv->mpcg = NULL;
		}
		if (priv->fsm) {
			kfree_fsm(priv->fsm);
			priv->fsm = NULL;
		}
    ...
}

priv, which embeds restart_timer, is freed later in ctcm_remove_device().

For MPC devices ctcm_close() does nothing, so no FSM event stops these
timers during ctcm_shutdown_device(). grp->timer is armed for
MPC_XID_TIMEOUT_VALUE during XID negotiation. restart_timer is armed for
500 ms by mpc_action_go_inop() and for 1 s by dev_action_restart(). With
port_persist == 1 and an unreachable peer, restart_timer keeps cycling.

If the MPC device is taken offline while either timer is pending,
fsm_expire_timer() would call fsm_event(this->fi, ...) on a freed
fsm_instance. For grp->timer, the timer_list itself also lives in freed
memory, which can corrupt the timer wheel. In MODULE builds the dev event
argument has been freed by free_netdev() as well.

Should grp->timer and priv->restart_timer be stopped with
timer_delete_sync() or timer_shutdown_sync() before ctcm_free_netdevice()
frees them?

[ ... ]
