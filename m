Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4692877DA;
	Thu, 10 Sep 2026 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008397; cv=none; b=E9eMXpWqKFO4trU7KIFOuGaJZ5mhsQSlBIuhdPh6CQ4HO40/RajK6d8Tck+WC0KvLVyjwqCkghA+u5ix2HZb8irTU8e/5oD0SH0tMd9M0rXIRJ2+P3JzsfiAUbiZWgqUFEEkCdz0UP2F48rR2qn6uto9t2bQ+kA8MrSbsI3niTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008397; c=relaxed/simple;
	bh=/qmsOd54L9dGy5w7UMwsn3QjMYSfhO6ileP54Kvpo0c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnR1TJjlGOr/S1rIrpjQpmAZ4B9BmTbX2tcQFrMjbyf+5NALxM/liwxzeVPsC47jiVd+ZYCM3D7iAe5FD54ETh6R8cgGWILrxKzVuvKoxX4YTno1U9y7RI0fUoMxuWqI5ndjAzuaJzVaglcfy/+/nbs6ZFMGy/vmZ1ktEvUQpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDGdJx9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDGdJx9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406CE1F00898;
	Thu, 10 Sep 2026 02:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008394;
	bh=YqIciz/SXcTG0MAPoeSBkatuLFm7yoCWsBF4v79Ovn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FDGdJx9G7dt72R6UkiaeEB00jsMIVObd1quPUUclbOOEy8/OZ5w3541ILTrVfZ+QR
	 /UMVYd/oYmB398onHRvxjR1TSYzbXGSV6G+1b9Q//H2QF1n78/zuQj8mzMXjRut6zm
	 jqul/0+vVigreZhLjysTi7SEYJk8hFvQSDblVrlZ7bQYAv9bSK3IoBmdEVfQS0c/SJ
	 7P+byQehaTaNuxsrbrRnthvJBFsctTGgUXR1ea9ee4363G1mqiLlYjYtCf4B+GKU2n
	 2Xt5HLp3VB3IPrvH8WMszm9z5NyvKBnnLI/KPo2M40aMRf52ZJXHEo5F1uAzMQ0/5O
	 fxeG5lwRtr6ug==
Subject: Re: [PATCH net 2/2] s390/ctcm: Fix use-after-free in channel_remove()
From: netdev-bot+sashiko@kernel.org
To: nagamani@linux.ibm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Thu, 10 Sep 2026 02:46:32 +0000
Message-ID: <178900839280.219967.3546163075460076479@kernel.org>
In-Reply-To: <20260907144511.3810194-3-nagamani@linux.ibm.com>
References: <20260907144511.3810194-3-nagamani@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (3) · Medium: 0 · Low: 1

- [High] channel_remove() (drivers/s390/net/ctcm_main.c:214/216) uses
  timer_delete_sync() instead of timer_shutdown_sync().
- [Low] The patch fixes a real use-after-free reachable during device
  teardown but carries no `Fixes:` tag, so stable maintainers cannot…

Pre-existing issues:
- [High] The same fsm_timer/kfree_fsm() UAF pattern that this patch fixes
  for ch->timer/ch->sweep_timer remains completely unfixed for the…
- [High] The synchronous cancel was added in channel_remove(), but
  ctcm_shutdown_device() frees the objects that timer-driven FSM actions…
- [High] The MPC channel tasklets are killed only after the resources
  they dereference have been freed.

--

s390/ctcm: Fix use-after-free in channel_remove()

This replaces the two fsm_deltimer() calls in channel_remove() with
timer_delete_sync() on the embedded timer_list, so the channel timer
callback cannot still be running when kfree_fsm(ch->fsm) and kfree(ch)
free the memory it uses.

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1

[Severity: Low]
There is no Fixes: tag on this patch. git blame on the two replaced
fsm_deltimer() calls and the following kfree_fsm(ch->fsm) points at:

  293d984f0e3604 ("ctcm: infrastructure for replaced ctc driver")

Could that be added as a Fixes: tag so stable can work out the affected
range?

> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 8b0d76a47d9f0..63f8832f9b149 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,9 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c == ch) {
>  			*c = ch->next;
> -			fsm_deltimer(&ch->timer);
> +			timer_delete_sync(&ch->timer.tl);
>  			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +				timer_delete_sync(&ch->sweep_timer.tl);

[Severity: High]
The commit message states:

  timer_delete_sync() is used rather than timer_shutdown_sync() because
  the channel is fully torn down by channel_remove() and the timer is
  never re-armed after this point, making the re-arm prevention of
  timer_shutdown_sync() unnecessary.

Does that hold for the MPC case?  timer_delete_sync() leaves
timer->function intact, so a later fsm_addtimer() simply re-queues the
timer:

drivers/s390/net/fsm.c:fsm_addtimer() {
	...
	return mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));
}

Here ch->timer is cancelled before ch->sweep_timer, and the sweep timer
action re-arms both of them:

drivers/s390/net/ctcm_fsms.c:ctcmpc_chx_send_sweep() {
	...
		fsm_addtimer(&wch->sweep_timer,
			200, CTC_EVENT_RSWEEP_TIMER, wch);
	...
	fsm_addtimer(&wch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, wch);
}

For ch == priv->channel[CTCM_WRITE], can a sweep callback that has already
been dispatched on another CPU execute the fsm_addtimer(&wch->timer, ...)
above after timer_delete_sync(&ch->timer.tl) has returned?  The following
timer_delete_sync(&ch->sweep_timer.tl) waits for the sweep callback, but
nothing then re-checks ch->timer.

The MPC tasklets look like a second source of re-arms, since they are only
killed further down in channel_remove(), after both cancels:

  ctcmpc_bh() -> ctcmpc_unpack_skb() -> mpc_rcvd_sweep_req() ->
  ctcmpc_send_sweep_resp()

drivers/s390/net/ctcm_mpc.c:ctcmpc_send_sweep_resp() {
	...
	fsm_addtimer(&ch->sweep_timer, 100, CTC_EVENT_RSWEEP_TIMER, ch);
}

drivers/s390/net/ctcm_mpc.c:mpc_action_side_xid() {
	...
	fsm_addtimer(&ch->timer, 5000 , CTC_EVENT_TIMER, ch);
}

tasklet_kill() only waits for a running tasklet to finish, so a re-arm done
by that tasklet survives it.

If either re-arm wins, kfree(ch) below returns a timer_list that is still
linked into a timer base to the slab allocator, and on expiry
fsm_expire_timer() dereferences this->fi (the fsm_instance freed by
kfree_fsm()) and calls through fi->f->jumpmatrix.

Would timer_shutdown_sync(), which makes the later mod_timer() a no-op,
and/or moving the tasklet_kill() calls ahead of the timer teardown, close
this window?

>  
>  			kfree_fsm(ch->fsm);

[Severity: High]
This is a pre-existing ordering problem and not something the patch
introduces, but kfree_fsm(ch->fsm) here runs before the MPC tasklets are
stopped later in the same function:

			if (IS_MPC(ch)) {
				tasklet_kill(&ch->ch_tasklet);
				tasklet_kill(&ch->ch_disc_tasklet);

ctcmpc_bh(), which is ch->ch_tasklet, starts with:

drivers/s390/net/ctcm_mpc.c:ctcmpc_bh() {
	struct net_device *dev	= ch->netdev;
	struct ctcm_priv  *priv	= dev->ml_priv;
	struct mpc_group  *grp	= priv->mpcg;
	...
	while ((fsm_getstate(grp->fsm) != MPCG_STATE_FLOWC) &&
	...
}

By the time channel_remove() is reached from ctcm_shutdown_device(),
ctcm_free_netdevice() has already done:

drivers/s390/net/ctcm_main.c:ctcm_free_netdevice() {
	...
			if (grp->fsm)
				kfree_fsm(grp->fsm);
	...
			kfree(grp);
			priv->mpcg = NULL;
	...
#ifdef MODULE
	free_netdev(dev);
#endif
}

Can a tasklet that was pending before teardown therefore read a freed
net_device, a NULL priv->mpcg, and a freed grp->fsm, and then call through
its jumpmatrix?  Should the tasklet_kill() calls happen before the
netdevice, group and FSM frees rather than after them?

[Severity: High]
This is a pre-existing gap rather than a regression from this patch, but
the driver has two more fsm_timer instances with the same kfree_fsm()
pattern, and neither is cancelled at all in the teardown path.

grp->timer is bound to grp->fsm by fsm_settimer(grp->fsm, &grp->timer) in
ctcmpc_init_mpc_group(), and it is armed during XID negotiation:

drivers/s390/net/ctcm_mpc.c:mpc_channel_action() {
	...
			fsm_addtimer(&grp->timer, MPC_XID_TIMEOUT_VALUE,
						MPCG_EVENT_TIMER, dev);
}

ctcm_free_netdevice() then frees grp->fsm and grp itself, and the
timer_list lives inside struct mpc_group, so a pending grp->timer is handed
back to the slab allocator with no timer_delete()/timer_delete_sync()
anywhere in that path.

priv->restart_timer has the same shape: fsm_settimer(priv->fsm,
&priv->restart_timer) in ctcm_init_netdevice(), armed by
dev_action_restart() in ctcm_fsms.c, and priv->fsm is freed in
ctcm_free_netdevice() without a synchronous cancel.

For MPC devices ctcm_close() is a no-op:

drivers/s390/net/ctcm_main.c:ctcm_close() {
	...
	if (!IS_MPC(priv))
		fsm_event(priv->fsm, DEV_EVENT_STOP, dev);
}

so neither ctcm_close() nor unregister_netdev() quiesces these two timers
first.  Since fsm_deltimer() stays non-synchronous and no synchronous
counterpart is being added, would it make sense to add one (for example an
fsm_deltimer_sync() helper) and use it at these sites too?

[Severity: High]
Also pre-existing, but related to where the new synchronous cancel sits in
the overall shutdown ordering.  In ctcm_shutdown_device() the objects the
channel timer callbacks dereference are freed before channel_remove() runs:

drivers/s390/net/ctcm_main.c:ctcm_shutdown_device() {
	...
		ctcm_close(dev);
	...
	if (dev) {
		unregister_netdev(dev);
		ctcm_free_netdevice(dev);
	}

	if (priv->fsm)
		kfree_fsm(priv->fsm);

	ccw_device_set_offline(cgdev->cdev[1]);
	ccw_device_set_offline(cgdev->cdev[0]);
	channel_remove(priv->channel[CTCM_READ]);
	channel_remove(priv->channel[CTCM_WRITE]);
}

A channel timer can still be armed at that point: ctcm_close() is a no-op
for MPC, and for non-MPC the stop handler ctcm_chx_haltio() itself arms
ch->timer for CTCM_TIME_5_SEC without waiting for the halt.

If that timer expires in the window before channel_remove() is entered,
fsm_expire_timer() -> fsm_event(ch->fsm, CTC_EVENT_TIMER, ch) can dispatch:

drivers/s390/net/ctcm_fsms.c:ctcm_chx_txretry() {
	struct net_device *dev = ch->netdev;
	struct ctcm_priv *priv = dev->ml_priv;
	...
		fsm_event(priv->fsm, DEV_EVENT_TXDOWN, dev);
}

dev has already been freed by free_netdev() in MODULE builds, and
priv->fsm was set to NULL by ctcm_free_netdevice().  Should the
synchronous cancel happen before unregister_netdev()/ctcm_free_netdevice()
/kfree_fsm(priv->fsm), or should those frees move after channel_remove()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907144511.3810194-1-nagamani%40linux.ibm.com
