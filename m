Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AF33557D;
	Thu, 10 Sep 2026 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008395; cv=none; b=O2J3dW3RT0TarHCwmDOsjR+5h6gHHq+J4GrshsVoUCP959LOoj4QXcF9cAMOq5wecvAAX2nJUdwhs22PYiTPGlf/wsfUEBlyBxlMYnM8xTlfU1i9blynVUqaNHmhPHo7BDNP/wSQMQW6Y3knldvRvKD0RszuwC97tAodUDJwXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008395; c=relaxed/simple;
	bh=NDep1kbLoC53zbGbFciEir4r3dFiZuiXU9f0Zd15nLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHgvxV84z0z0fkYlXIL43flW8CIYrEuav7r4/IvirxPTO2QNYQoa4kETQ1FR2F8LwO6Q4Q1AvTRMqcfgYdXNrtI6fwfyKNqN77+gF4BSKBg3Gmon28gSTodHJCTxZ6RhuBVhDYDiK7xdDv0w3lnjjxR7jwTOV6TGOwjSxSMaT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twshy8Mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twshy8Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71421F000FF;
	Thu, 10 Sep 2026 02:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008392;
	bh=Rw2oMcXdytlK6ipLwHrZqdNkEwKN8p1n0GL8fM2sDFk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Twshy8Mkol8MfSd79R689C7hG7aSt2GkYle005HWKJMhRKcQbAXvrAHV/XAMbheXb
	 mNj3EoEyI5XZm2lRKY1i042WdNdNVyUMNkSo2zdIqX+w/NwoA4hVMvNZgL7wy8N2Fp
	 arqZsdP94tBk9AMD5TWhC2UhzdQEMX4HQgNE+0TbVlESsE24kRdzM1zTHE7UjsN1xP
	 nzFjaG21Yu8RXiy927CXhxxh4JVBlNRzCuw1WdYtsvHixuNDfIC1dhz4QY3hyhcIlP
	 dV1LJKeG0ukfZOhwh2/sodBxnQR+Hw8NGRYzg2k06pOmKJ8tyxz9cIXx9CuYh/3MPf
	 iQq54FNSmVh2Q==
Subject: Re: [PATCH net 1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
From: netdev-bot+sashiko@kernel.org
To: nagamani@linux.ibm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Thu, 10 Sep 2026 02:46:31 +0000
Message-ID: <178900839135.219967.4379937251971534684@kernel.org>
In-Reply-To: <20260907144511.3810194-2-nagamani@linux.ibm.com>
References: <20260907144511.3810194-2-nagamani@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 (1) · High: 1 (1) · Medium: 0 (2) · Low: 2

- [High] Incomplete fix: the commit removes timer_setup() from
  fsm_addtimer()/fsm_modtimer() on the premise that "[t]he timer is…
- [Low] Documented return contract of the exported helper fsm_addtimer()
  is now false.
- [Low] The commit message justifies reachability with "including
  ctcm_main.c ctcm_send_sweep() and ctcm_mpc.c mpc_action_side_xid()",…

Pre-existing issues:
- [Critical] Invalid/double free during MPC device teardown:
  ctcm_free_netdevice() calls kfree(priv->xid) on a pointer that is not…
- [High] FSM timer teardown in ctcm_free_netdevice() still frees objects
  that an armed/executing fsm timer dereferences.
- [Medium] ctcm_init_netdevice() leaks priv->fsm when MPC group
  initialization fails.
- [Medium] fsm_addtimer()/fsm_modtimer() publish this->expire_event and
  this->event_arg with plain, unlocked stores immediately before…

--

s390/ctcm: Fix timer corruption in fsm_addtimer()

This removes the redundant timer_setup() from fsm_addtimer() and
fsm_modtimer() and replaces the open-coded expires assignment plus
add_timer() with mod_timer(), so that re-arming an already-pending fsm
timer no longer re-initializes it while it is enqueued in the wheel.

Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1

A few questions below, one about the changelog and the rest about the
resulting timer lifetime in the ctcm driver.

The changelog says:

    Multiple callsites invoke fsm_addtimer() without a preceding
    fsm_deltimer(), including ctcm_main.c ctcm_send_sweep() and
    ctcm_mpc.c mpc_action_side_xid()

[Severity: Low]
There is no symbol named ctcm_send_sweep() in the tree. The ctcm_main.c
call site that arms a timer without a preceding fsm_deltimer() appears to
be ctcmpc_send_sweep_req():

	fsm_addtimer(&ch->sweep_timer, 100, CTC_EVENT_RSWEEP_TIMER, ch);

The other cited site, mpc_action_side_xid() in ctcm_mpc.c, does exist.
Could the function name be corrected, given this patch is tagged for
stable and the changelog is what backporters use to verify the premise?

> diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
> index 9b8622aef807b..8d2e9bbb74a23 100644
> --- a/drivers/s390/net/fsm.c
> +++ b/drivers/s390/net/fsm.c
> @@ -171,12 +171,9 @@ fsm_addtimer(fsm_timer *this, int millisec, int event, void *arg)
>  	       this->fi->name, this, millisec);
>  #endif
>  
> -	timer_setup(&this->tl, fsm_expire_timer, 0);

[Severity: High]
With this removed, fsm_settimer() becomes the only timer_setup() call site
for fsm timers, and it is also called unconditionally. Does that leave the
same corruption reachable for priv->restart_timer?

fsm_settimer(priv->fsm, &priv->restart_timer) runs from
ctcm_init_netdevice() on every ccwgroup set_online, while struct ctcm_priv
(which embeds restart_timer) is allocated once in ctcm_probe_device() and
freed only in ctcm_remove_device().

No offline path disarms restart_timer. dev_action_restart() arms it for
CTCM_TIME_1_SEC / CTCM_TIME_5_SEC:

	fsm_addtimer(&priv->restart_timer, restart_timer,
			DEV_EVENT_START, dev);

only dev_action_start() deletes it, and the offline sequence

	ctcm_shutdown_device() -> ctcm_close() -> dev_action_stop()
		-> ctcm_free_netdevice()

never calls fsm_deltimer(&priv->restart_timer). So if the device is set
online again inside that 1-5 s window, doesn't fsm_settimer() call
timer_setup() on a still-enqueued timer and clear entry.pprev and flags
underneath the wheel bucket?

And in the meantime ctcm_free_netdevice() does:

		if (priv->fsm) {
			kfree_fsm(priv->fsm);
			priv->fsm = NULL;
		}

so the still-armed timer's this->fi points at freed memory, which
fsm_expire_timer() then dereferences via fsm_event(). Should the teardown
side also be fixed here, either with an fsm_deltimer(&priv->restart_timer)
in the stop path or a timer_delete_sync()/timer_shutdown_sync() before
kfree_fsm(priv->fsm)?

>  	this->expire_event = event;
>  	this->event_arg = arg;
> -	this->tl.expires = jiffies + (millisec * HZ) / 1000;
> -	add_timer(&this->tl);
> -	return 0;
> +	return mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));

[Severity: Low]
This now propagates the mod_timer() result, but the kernel-doc for the
exported fsm_addtimer() in fsm.h still says:

 * Return: Always returns 0
 */
int fsm_addtimer(fsm_timer *timer, int millisec, int event, void *arg);

mod_timer() returns 1 when the timer was already pending and got requeued,
which is exactly the case this patch targets (ctcmpc_send_sweep_req(),
mpc_action_side_xid()). None of the current call sites in
drivers/s390/net/ look at the return value, so there is no behaviour change
today, but elsewhere in this file non-zero conventionally means an error
(see fsm_event()).

Would it be better to keep mod_timer(...) followed by return 0, or update
the fsm.h kernel-doc to describe the 0/1 "was pending" semantics?

>  }
>  
>  /* FIXME: this function is never used, why */
> @@ -189,12 +186,9 @@ fsm_modtimer(fsm_timer *this, int millisec, int event, void *arg)
>  		this->fi->name, this, millisec);
>  #endif
>  
> -	timer_delete(&this->tl);
> -	timer_setup(&this->tl, fsm_expire_timer, 0);
>  	this->expire_event = event;
>  	this->event_arg = arg;
> -	this->tl.expires = jiffies + (millisec * HZ) / 1000;
> -	add_timer(&this->tl);
> +	mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));

[Severity: Medium]
This isn't a bug introduced by this patch, but with the timer_delete()
gone, the two payload stores are now published with plain stores while the
timer may be pending or its callback already running:

	this->expire_event = event;
	this->event_arg = arg;
	mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));

fsm_expire_timer() reads both fields from timer softirq context on any CPU:

	fsm_event(this->fi, this->expire_event, this->event_arg);

with no lock or barrier shared with the writer. If a writer such as
ctcmpc_send_sweep_req() or mpc_action_side_xid() re-arms a pending timer
while it expires on another CPU, can the callback deliver the new
expire_event with the old event_arg, at the old expiry rather than the newly
requested one? And since mod_timer() does not wait for an in-flight
callback, can the FSM see the event twice? The same publish pattern applies
to fsm_addtimer() above.

[Severity: High]
This is a pre-existing issue, but it interacts with the switch to
mod_timer(). fsm_deltimer() only does:

	timer_delete(&this->tl);

which does not wait for a callback running on another CPU, and
ctcm_free_netdevice() performs no cancellation at all for grp->timer or
priv->restart_timer before freeing their containers:

			if (grp->fsm)
				kfree_fsm(grp->fsm);
			dev_kfree_skb(grp->xid_skb);
			dev_kfree_skb(grp->rcvd_xid_skb);
			tasklet_kill(&grp->mpc_tasklet2);
			kfree(grp);

grp->timer is armed for MPC_XID_TIMEOUT_VALUE from mpc_channel_action()
and the XID paths in ctcm_fsms.c:

		fsm_addtimer(&grp->timer, MPC_XID_TIMEOUT_VALUE,
						MPCG_EVENT_TIMER, dev);

so a set_offline during an XID exchange leaves a struct timer_list linked
in the wheel inside memory freed by kfree(grp), and fsm_expire_timer() then
reads this->fi (the fsm_instance freed by kfree_fsm(grp->fsm)) and
indirect-calls through fi->f->jumpmatrix in fsm_event(). Can that be hit
today?

The sibling instance of this in channel_remove() is addressed later in this
series by "s390/ctcm: Fix use-after-free in channel_remove()", which
replaces fsm_deltimer(&ch->timer) / fsm_deltimer(&ch->sweep_timer) with
timer_delete_sync(&ch->timer.tl) / timer_delete_sync(&ch->sweep_timer.tl).
At the end of the series ctcm_free_netdevice() has no equivalent change, so
the grp->timer and priv->restart_timer cases look untreated.

Also, now that fsm_addtimer() uses mod_timer(), a concurrent FSM action can
silently re-arm a timer after a plain fsm_deltimer(). Should the teardown
paths use timer_delete_sync() or timer_shutdown_sync() semantics rather
than timer_delete()?

Two further observations in the same ctcm_free_netdevice() teardown path
that this series touches, neither of them introduced here:

[Severity: Critical]
This isn't a bug introduced by this patch, but ctcm_free_netdevice() frees
priv->xid with kfree() even though it is an interior pointer into an SKB
data buffer that was released a few statements earlier:

			dev_kfree_skb(grp->xid_skb);
...
		kfree(priv->xid);
		priv->xid = NULL;

ctcmpc_init_mpc_group() sets it up as:

	grp->xid = (struct xid2 *)skb_tail_pointer(grp->xid_skb);
...
	priv->xid = grp->xid;

and that is the only assignment to priv->xid in the driver. Since priv is
kzalloc'ed, non-MPC devices hit kfree(NULL), but for an MPC group does this
kfree() hand the allocator an address TH_HEADER_LENGTH bytes into an
already-freed buffer on every offline or teardown?

[Severity: Medium]
This is a pre-existing issue as well, but does ctcm_init_netdevice() leak
priv->fsm when the MPC group setup fails?

		grp = ctcmpc_init_mpc_group(priv);
		if (grp == NULL) {
			MPC_DBF_DEV(SETUP, dev, "init_mpc_group error");
			free_netdev(dev);
			return NULL;
		}

priv->fsm was allocated by init_fsm("ctcmdev", ...) just above, and
ctcmpc_init_mpc_group() returns NULL on its GFP_ATOMIC|GFP_DMA xid_skb /
rcvd_xid_skb allocation failures. free_netdev() does not release the
fsm_instance, and the caller ctcm_new_device() goes to out_ccw2 without
calling ctcm_free_netdevice(), so the instance and its jumpmatrix stay
allocated until kfree(priv) in ctcm_remove_device() drops the last
reference to them, or a retried set_online overwrites priv->fsm.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907144511.3810194-1-nagamani%40linux.ibm.com
