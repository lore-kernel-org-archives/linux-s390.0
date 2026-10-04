Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A1222597;
	Sun,  4 Oct 2026 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098249; cv=none; b=CJJQ5Un2bsrPF1FjWylOBfgGUg94aKEQ2Ff9GPFuWzx9RTFhn9dxpSpfjq3ZEfCNKRgAS0c4pYNbIsLhZIbg3T5e0wYZ6g6e5X6GGHuM33/2PCc8budisiqtaSEiZD8NbnabHuZxh2BO79CXrbdOpJolNSxZxAuGTUkk22fS77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098249; c=relaxed/simple;
	bh=rmIHYaP77tuuviq0E3oDx4xol1a2WJ/HafzHs45rw2s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDD1jq4IXxKufEbD+L3CkPdhKdRGHbb1U+DflO7QX8Sa8XX9ofhybGkw+POFmyX8wI9vxNPMofkJqgU/Ya/Y+kBGfT2i/44ViS2pYD+D6oXmiF6elkICfx2C9vQ+mR9LxD9wezFEXJT+ezoPJhNOonWzIo+CAEDujFI0r/uXFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCFUBbIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCFUBbIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BC01F000FF;
	Sun,  4 Oct 2026 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791098247;
	bh=w0zwF8tVJjwBa8xQzkMItcnnUR65qIQYip0V0SzgzEQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YCFUBbIp8XJyEsaT6vUj+fixda5mRuoC0bnt0Vm1bBLFqC5D/Z7mqcKJFUzd9RzAD
	 OQq2p5BjfWUuNueLFAlxajd/IeZfyot7koCkoL5+V59DrFfIdV1pHL//DfeHm8p+06
	 BqmzKlI+oG1l0giTVA/WlDDypSeqy/ygH2ShW0/aU1QPwb5xhWYsRbSPYBhnZ+QTvx
	 7KxirmKAKfIn4Lptm9kFT2EypyiSl5K7OdmdECCaTFnteedamk3qg+rM1OVr+O0usd
	 mEWazBDQcZKHTpzqlH+l6EZ9DcnAgRV0xTfvnDgACPvcUSkFTkg+046OtYHUfzX2Kt
	 MOb2jb5uK6NPw==
Subject:
 Re: [PATCH net v4 2/2] s390/ctcm: Fix use-after-free in channel_remove()
From: netdev-bot+sashiko@kernel.org
To: nagamani@linux.ibm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Sun, 04 Oct 2026 07:17:26 +0000
Message-ID: <179109824657.434549.2788045083218312906@kernel.org>
In-Reply-To: <20260930070234.569500-3-nagamani@linux.ibm.com>
References: <20260930070234.569500-3-nagamani@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch waits for channel timers and tasklets too late.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is the same
  cancel-without-sync-then-free pattern in sibling fsm_timers.

--

s390/ctcm: Fix use-after-free in channel_remove()

In channel_remove(), this patch replaces fsm_deltimer() with
timer_shutdown_sync() for ch->timer and ch->sweep_timer. It also moves
the MPC tasklet_kill() calls and kfree(ch->discontact_th) so they run
after the timers are shut down and before kfree_fsm(ch->fsm).

Link: https://sashiko.dev/#/patchset/20260922101913.239103-1-nagamani@linux.ibm.com?part=2

> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 8b0d76a47d9f0..27a22dbc92806 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,14 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c == ch) {
>  			*c = ch->next;
> -			fsm_deltimer(&ch->timer);
>  			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +				timer_shutdown_sync(&ch->sweep_timer.tl);
> +			timer_shutdown_sync(&ch->timer.tl);
> +			if (IS_MPC(ch)) {
> +				tasklet_kill(&ch->ch_tasklet);
> +				tasklet_kill(&ch->ch_disc_tasklet);
> +				kfree(ch->discontact_th);
> +			}

[Severity: High]
Do these waits run too late to protect the state that the channel
callbacks use?

The only teardown caller of channel_remove() is ctcm_shutdown_device(),
and it calls it after the net_device and its private state are gone:

drivers/s390/net/ctcm_main.c:ctcm_shutdown_device() {
    ...
	if (dev) {
		unregister_netdev(dev);
		ctcm_free_netdevice(dev);
	}
    ...
	ccw_device_set_offline(cgdev->cdev[1]);
	ccw_device_set_offline(cgdev->cdev[0]);
	channel_remove(priv->channel[CTCM_READ]);
	channel_remove(priv->channel[CTCM_WRITE]);
    ...
}

ctcm_free_netdevice() does kfree_fsm(grp->fsm), kfree(grp),
priv->mpcg = NULL, kfree_fsm(priv->fsm) and priv->fsm = NULL. Under MODULE
it also calls free_netdev(dev). The ccw_device_set_offline() calls in
between can sleep, so a channel timer or tasklet can fire in that window.

The channel callbacks reach this state through ch->netdev->ml_priv:

  ctcm_chx_txretry() (ch->timer):
	fsm_event(priv->fsm, DEV_EVENT_TXDOWN, dev);

  ctcmpc_chx_send_sweep() (sweep_timer):
	if (grp->in_sweep == 0)

  ctcmpc_bh() (ch_tasklet):
	while ((fsm_getstate(grp->fsm) != MPCG_STATE_FLOWC) &&

  ctcm_ccw_check_rc()->ctcm_chx_iofatal():
	fsm_event(priv->fsm, ...);

The circular chain in the commit message also goes through priv->fsm or
priv->mpcg. For example, mpc_action_go_inop() does this before it reaches
tasklet_hi_schedule():

	grp =  priv->mpcg;
	grp->flow_off_called = 0;

At channel_remove() time priv->fsm and priv->mpcg are already freed or
NULL. Wouldn't that chain crash before it can re-arm anything?

If so, timer_shutdown_sync() only waits for a callback that is already
dereferencing freed or NULL memory. tasklet_kill() also lets a queued
ch_tasklet run against the freed grp.

channel_free() moves ch->fsm to CTC_STATE_IDLE, which has no handlers,
so most late ch->fsm events do nothing. But that state change takes no
lock. ctcm_irq_handler() runs FSM actions under the ccwdev lock, and for
MPC ctcm_close() does nothing:

	if (!IS_MPC(priv))
		fsm_event(priv->fsm, DEV_EVENT_STOP, dev);

As a result the MPC channels are not halted. An action that races
channel_free() could leave the channel FSM in TXIDLE or TX with timers
armed.

ctcmpc_bh() never checks the ch->fsm state, and ctc_mpc_flow_control()
can schedule it at any time.

The ctcm_new_device() out_dev path uses the same order, but its channels
were never started there.

Could both channels' timers and tasklets be stopped, and the subchannels
taken offline, before ctcm_free_netdevice() and kfree_fsm(priv->fsm) run?
That would mean moving the quiescing out of channel_remove() instead of
reordering it inside channel_remove().

[Severity: High]
This isn't a bug introduced by this patch, but the other fsm_timers in
this driver seem to follow the same pattern: cancel without a sync, then
free.

priv->restart_timer is bound to priv->fsm by fsm_settimer() in
ctcm_init_netdevice(). grp->timer is bound to grp->fsm by fsm_settimer()
in ctcmpc_init_mpc_group(). Neither timer is ever cancelled with a sync
call. The only cancellations are fsm_deltimer(), which is timer_delete().

mpc_action_go_inop() always re-arms the restart timer:

	fsm_deltimer(&priv->restart_timer);
	fsm_addtimer(&priv->restart_timer, 500, DEV_EVENT_RESTART, dev);

dev_action_restart() re-arms it for 1s in the MPC case. So during MPC
group recovery the restart timer is usually pending.

For MPC, ctcm_close() does nothing. So ctcm_shutdown_device() then calls
ctcm_free_netdevice(), which frees grp->fsm, grp (which contains
grp->timer) and priv->fsm while these timers may be pending or running.
After that, ctcm_remove_device() does kfree(priv), and priv contains
restart_timer.

When one of these timers expires, fsm_expire_timer() calls
fsm_event(this->fi, ...) on a freed fsm_instance. That reads the freed
state and jumpmatrix, and calls a function pointer taken from freed
memory. A timer still pending inside freed grp or priv memory can also
corrupt the timer wheel.

There is a similar ordering problem in ctcm_free_netdevice():

	if (grp->fsm)
		kfree_fsm(grp->fsm);
	dev_kfree_skb(grp->xid_skb);
	dev_kfree_skb(grp->rcvd_xid_skb);
	tasklet_kill(&grp->mpc_tasklet2);
	kfree(grp);

Can a pending mpc_tasklet2 run here after its FSM has been freed?

Should priv->restart_timer and grp->timer also get timer_shutdown_sync()
before priv->fsm and grp are freed? And should mpc_tasklet2 be killed
before kfree_fsm(grp->fsm)?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930070234.569500-1-nagamani%40linux.ibm.com
