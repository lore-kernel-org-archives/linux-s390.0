Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9F42B30D;
	Mon, 21 Sep 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976169; cv=none; b=Dr5Yk8ukiGxtfO0fzlW4mg/VZDT8FhXn5bm32tETRmWDrh5wZonNoeJGm846UWW9NoA1oa8RfCOkzU3A79kvBzDesN9e4PeneNvhEbqQkopwXjn0aDCwU7c4sXLhesYcHRYeXpoJY9zsf/DU+NTxdW/hjOYhFlpwGnlmhfK8pWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976169; c=relaxed/simple;
	bh=ZYvwQdF4dkLXvcc0XA1nb6f6/TC1Q0G0DWqD05Nce+8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBN16XCo9cTPL00U9w7j6LDFmIyciUucx6S33+N6qTygXgXx8Dns14TbZmT0hiM8ymupmjRkk9bQoXcNEFBXvefeDtVr9KQqZ4+byDtFD5qk0GR7+l8PElpuQEpuYnuADYycRCTvZK4yvHy44sl62LWhN0xSIGsj0jm+QSvYfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipHJh+8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipHJh+8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6921F000FF;
	Mon, 21 Sep 2026 07:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789976167;
	bh=R4XnVf9iMx6IOWvRvbZ1vvchPz+XJtT6I0Wu1seBWQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ipHJh+8a/k1E9qb01UfJkQvm+EsFW06shCHSTnmCXAOBW1wWnQECZiTXrXVDG/TEl
	 d9ND3AUlkhjUxrONcD7uqmVc+FPFTwP0mFyqwOHS5MJTs3XKi2ROQGO8QTR+FM7fwV
	 MdZH6JUJvWQKu8s/3eXW3CPFZva4W14nkpD3J5gNLwMtd0htYCj73eK9aAOuxaUXAL
	 +ZOzR114pSZBq6FTEYBjObFSFeNy3812l7Lwjf4divRy2tzC18V7MB9B8c5oDRXXD6
	 a3Rq/fp5ycKMgAfChPKSnWQbgGjJm/PjfiPVetfkp6BlJU7pUqwmSy2fiFCqUj6pMN
	 v2/m72GymyX8A==
Subject: Re: [PATCH net v2] net/iucv: fix races in afiucv_netdev_event()
From: netdev-bot+sashiko@kernel.org
To: nagamani@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 wintera@linux.ibm.com, twinkler@linux.ibm.com, horms@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hexlabsecurity@proton.me,
 hidayath@linux.ibm.com, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 07:36:05 +0000
Message-ID: <178997616539.2160803.7344690959039968898@kernel.org>
In-Reply-To: <20260917071706.23831-1-nagamani@linux.ibm.com>
References: <20260917071706.23831-1-nagamani@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] afiucv_netdev_event() Pass 2 calls lock_sock(sk) for every
  collected socket while the netdevice notifier chain is executing with…
- [Medium] Pass 1 of afiucv_netdev_event() now needs a GFP_ATOMIC
  allocation per affected socket (net/iucv/af_iucv.c:2252).
- [Medium] Pass 2 of afiucv_netdev_event() checks only `sk->sk_state ==
  IUCV_CONNECTED` and then calls iucv_send_ctrl(), which dereferences…
- [Medium] The commit claims BUG-3 ("sk_state data race") is eliminated
  by taking lock_sock() in the notifier, but af_iucv's softirq…
- [Medium] The patch documents (and annotates with READ_ONCE/WRITE_ONCE)
  an invariant that iucv->hs_dev is only concurrently written by…
- [Medium] The new Pass-2 comment in afiucv_netdev_event()
  (net/iucv/af_iucv.c:2263-2264) states that "lock_sock() serialises…
- [Low] The patch introduces a marked-access contract for
  iucv_sock->hs_dev — WRITE_ONCE(iucv->hs_dev, NULL) in…

--

net/iucv: fix races in afiucv_netdev_event()

This reworks afiucv_netdev_event() into a two-pass algorithm: pass one walks
iucv_sk_list under read_lock_bh() and collects matching sockets with
sock_hold() into a local list, pass two takes lock_sock() per socket to send
the FIN and update sk_state.  It also converts the hs_dev clearing in
iucv_sock_close() to WRITE_ONCE() and the notifier read to READ_ONCE().

Link: https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecurity@proton.me/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af1..15f5efb405abd 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -448,7 +454,7 @@ static void iucv_sock_close(struct sock *sk)
>  
>  	if (iucv->hs_dev) {
>  		dev_put(iucv->hs_dev);
> -		iucv->hs_dev = NULL;
> +		WRITE_ONCE(iucv->hs_dev, NULL);

[Severity: Low]
Should the other lockless hs_dev accesses be marked as well?  Two of the
four sites that touch hs_dev without the socket lock are left as plain
accesses by this patch:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
	read_lock(&iucv_sk_list.lock);
	sk_for_each(sk, &iucv_sk_list.head) {
		if (iucv_sk(sk)->hs_dev != dev)
			continue;
	...
}

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
	...
	niucv->hs_dev = iucv->hs_dev;
	dev_hold(niucv->hs_dev);
	...
}

With the plain read in afiucv_hs_rcv() still present, is the KCSAN report
the changelog says this suppresses (marked write in iucv_sock_close() versus
unmarked read) still reachable?  And the new READ_ONCE() in pass one is
paired against the unmarked store in afiucv_hs_callback_syn().

>  		sk->sk_bound_dev_if = 0;
>  	}
>  
> @@ -2217,21 +2223,62 @@ static int afiucv_netdev_event(struct notifier_block *this,
>  			       unsigned long event, void *ptr)
>  {
>  	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +	struct iucv_netdev_todo *entry, *tmp;
> +	LIST_HEAD(todo);
>  	struct sock *sk;
> -	struct iucv_sock *iucv;
>  
>  	switch (event) {
>  	case NETDEV_REBOOT:
>  	case NETDEV_GOING_DOWN:
> +		/*
> +		 * Pass 1: collect matching sockets under read_lock_bh.
> +		 *
> +		 * read_lock_bh(&iucv_sk_list.lock) excludes concurrent
> +		 * write_lock_bh in iucv_sock_link/unlink, so sk cannot
> +		 * be removed from the list or freed while we walk it.
> +		 * sock_hold() pins the sk so it survives after we drop
> +		 * the lock.
> +		 *
> +		 * iucv_sock_close() writes hs_dev = NULL under lock_sock,
> +		 * which is orthogonal to read_lock_bh.  READ_ONCE() documents
> +		 * the intentional concurrent access: if hs_dev is being
> +		 * cleared to NULL it will not equal event_dev (a valid
> +		 * pointer) so the socket is correctly skipped.
> +		 */

[Severity: Medium]
Is iucv_sock_close() really the only concurrent writer of hs_dev?
afiucv_hs_callback_syn() also writes it from softirq context:

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
	bh_lock_sock(sk);
	...
	niucv->hs_dev = iucv->hs_dev;
	dev_hold(niucv->hs_dev);
	...
	nsk->sk_state = IUCV_CONNECTED;
}

iucv_sock_alloc() ends with iucv_sock_link(&iucv_sk_list, sk), so the child
is already visible in iucv_sk_list before hs_dev and sk_state are written,
and the only lock held here is the parent's bh_lock_sock().

That means read_lock_bh() in pass one does not exclude this writer, and
lock_sock(nsk) in pass two does not exclude the softirq that is still
finishing the child's setup.  Can the notifier then send a FIN on a child
socket in parallel with its SYN-ACK handling, or skip a child that turns
IUCV_CONNECTED on the device that is going down?

Could the comment be extended to cover this writer?

> +		read_lock_bh(&iucv_sk_list.lock);
>  		sk_for_each(sk, &iucv_sk_list.head) {
> -			iucv = iucv_sk(sk);
> -			if ((iucv->hs_dev == event_dev) &&
> -			    (sk->sk_state == IUCV_CONNECTED)) {
> +			if (READ_ONCE(iucv_sk(sk)->hs_dev) != event_dev)
> +				continue;
> +			entry = kmalloc_obj(*entry, GFP_ATOMIC);
> +			if (!entry)
> +				continue;

[Severity: Medium]
What happens to a matching socket when this GFP_ATOMIC allocation fails?

The continue skips sock_hold() and the todo entry, so pass two never runs
for that socket: no FIN is sent through iucv_send_ctrl() on
NETDEV_GOING_DOWN, sk_state stays IUCV_CONNECTED with iucv->hs_dev still
pointing at the device going down, and sk_state_change() is never called.

Waiters depend on that transition:

net/iucv/af_iucv.c:iucv_sock_recvmsg() {
	if ((sk->sk_state == IUCV_DISCONN) &&
	    skb_queue_empty(&iucv->backlog_skb_q) && ...)
		return 0;
}

net/iucv/af_iucv.c:iucv_sock_poll() {
	if (sk->sk_state == IUCV_DISCONN)
		mask |= EPOLLIN;
}

There is no retry either, since the later notifications do nothing:

	case NETDEV_DOWN:
	case NETDEV_UNREGISTER:
	default:
		break;

The old loop needed no memory at all and could not skip a matching socket.
Could this be done without a per-socket allocation, for example sock_hold()
one socket, drop the list lock, act on it and restart the walk, or with a
list node embedded in struct iucv_sock?

The changelog describes the change purely as a race fix; should it mention
that a socket can now be skipped entirely under memory pressure?

> +			sock_hold(sk);
> +			entry->sk = sk;
> +			list_add_tail(&entry->list, &todo);
> +		}
> +		read_unlock_bh(&iucv_sk_list.lock);
> +		/*
> +		 * Pass 2: act on each socket under lock_sock.
> +		 *
> +		 * lock_sock() serialises against iucv_sock_close() and
> +		 * sock_orphan(), so sk_state and sk_socket are stable.

[Severity: Medium]
Does lock_sock() serialise against sock_orphan() here?

net/iucv/af_iucv.c:iucv_sock_release() {
	iucv_sock_close(sk);

	sock_orphan(sk);
	iucv_sock_kill(sk);
}

iucv_sock_close() takes and releases the socket lock internally, so
sock_orphan() runs with the socket lock not held, and sock_orphan() itself
uses a different lock:

include/net/sock.h:sock_orphan() {
	write_lock_bh(&sk->sk_callback_lock);
	sock_set_flag(sk, SOCK_DEAD);
	sk_set_socket(sk, NULL);
	sk->sk_wq = NULL;
	write_unlock_bh(&sk->sk_callback_lock);
}

The sk_socket claim matters because iucv_send_ctrl() ->
sock_alloc_send_pskb() dereferences sk->sk_socket->flags on the no-space
path.  Similarly, sk_state is written by the softirq callbacks under
bh_lock_sock() only, and there is no sock_owned_by_user() check anywhere in
this file.  Could the comment be narrowed to what lock_sock() actually
excludes?

> +		 * iucv_send_ctrl() may call sock_alloc_send_skb(GFP_KERNEL)
> +		 * which requires non-atomic context -- satisfied here because
> +		 * we are no longer holding read_lock_bh.
> +		 */
> +		list_for_each_entry_safe(entry, tmp, &todo, list) {
> +			sk = entry->sk;
> +			lock_sock(sk);

[Severity: High]
Can this stall the netdevice notifier chain while rtnl_lock is held?

afiucv_netdev_event() runs from the notifier chain with rtnl_lock held
(NETDEV_GOING_DOWN via __dev_close_many(), NETDEV_REBOOT via the reboot
notifier), and lock_sock() here waits for whoever currently owns the socket.

An AF_IUCV sender owns the socket lock across the whole send:

net/iucv/af_iucv.c:iucv_sock_sendmsg() {
	lock_sock(sk);
	...
	skb = sock_alloc_send_pskb(sk, headroom + linear, len - linear,
				   noblock, &err, 0);
	...
}

and the wait for send space does not drop that lock:

net/core/sock.c:sock_wait_for_wmem() {
	/* It is almost wait_for_tcp_memory minus release_sock/lock_sock. */
	...
	timeo = schedule_timeout(timeo);
	...
}

sk_sndtimeo starts at IUCV_CONN_TIMEOUT (40 * HZ) for AF_IUCV, and
setsockopt(SO_SNDTIMEO, {0,0}) makes it MAX_SCHEDULE_TIMEOUT:

net/core/sock.c:sock_set_timeout() {
	val = MAX_SCHEDULE_TIMEOUT;
	if ((tv.tv_sec || tv.tv_usec) &&
	    (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)))
		val = tv.tv_sec * HZ + ...;
}

The queued TX skbs that hold sk_wmem_alloc belong to the device being torn
down and are only purged by dev_deactivate_many(), which runs after the
notifier chain returns, so the shutdown itself does not release the waiter.

The pre-patch notifier never blocked on a socket lock.  Would a
bh_lock_sock() plus sock_owned_by_user() check, or deferring pass two to a
work item, avoid holding rtnl_lock across an unbounded socket-lock wait?

> +			if (sk->sk_state == IUCV_CONNECTED) {
>  				if (event == NETDEV_GOING_DOWN)
>  					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);

[Severity: Medium]
Pass one no longer filters on sk_state, and pass two never re-checks hs_dev
against event_dev under the socket lock.  Can iucv->hs_dev be NULL by the
time iucv_send_ctrl() dereferences it?

net/iucv/af_iucv.c:iucv_send_ctrl() {
	blen = sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);
	...
}

The dereference happens before afiucv_hs_send()'s later "if (!skb->dev)"
check can catch it.  A socket collected in IUCV_BOUND state (for example one
blocked in connect() waiting for the SYN-ACK) can reach pass two as
IUCV_CONNECTED with hs_dev already cleared:

net/iucv/af_iucv.c:iucv_sock_close() {
	default:
		iucv_sever_path(sk, 1);      /* IUCV_BOUND: state unchanged */
	}

	if (iucv->hs_dev) {
		dev_put(iucv->hs_dev);
		WRITE_ONCE(iucv->hs_dev, NULL);
	...
}

net/iucv/af_iucv.c:afiucv_hs_callback_synack() {
	if (!iucv || sk->sk_state != IUCV_BOUND) { ... }
	bh_lock_sock(sk);
	...
	sk->sk_state = IUCV_CONNECTED;
}

afiucv_hs_callback_synack() only tests sk_state, so it promotes the closed
but still IUCV_BOUND socket to IUCV_CONNECTED with hs_dev == NULL, and pass
two then calls iucv_send_ctrl() on it.  The same window also lets pass two
call sock_alloc_send_pskb() on an orphaned socket, which dereferences
sk->sk_socket->flags.

The changelog says "BUG-2: iucv_send_ctrl() is now called under lock_sock(),
not racing with concurrent socket close" - should pass two also re-validate
iucv->hs_dev == event_dev under the socket lock?

>  				sk->sk_state = IUCV_DISCONN;

[Severity: Medium]
The changelog states "BUG-3: sk_state is read and written under lock_sock(),
serialising against iucv_sock_close()".  Is that the full picture for
sk_state?

The softirq handlers in this file write sk_state with only bh_lock_sock():

net/iucv/af_iucv.c:afiucv_hs_callback_fin() {
	bh_lock_sock(sk);
	if (sk->sk_state == IUCV_CONNECTED) {
		sk->sk_state = IUCV_DISCONN;
	...
}

and the TX-completion path takes no socket lock at all:

net/iucv/af_iucv.c:afiucv_hs_callback_txnotify() {
	default:
		atomic_dec(&iucv->skbs_in_xmit);
		if (sk->sk_state == IUCV_CONNECTED) {
			sk->sk_state = IUCV_DISCONN;
	...
}

lock_sock() sets sk_lock.owned and then drops sk_lock.slock:

net/core/sock.c:lock_sock_nested() {
	spin_lock_bh(&sk->sk_lock.slock);
	...
	sk->sk_lock.owned = 1;
	spin_unlock_bh(&sk->sk_lock.slock);
}

so bh_lock_sock() users that never test sock_owned_by_user() are not
excluded, and grepping net/iucv/af_iucv.c for sock_owned_by_user() finds no
match.  Can the transition performed here be lost, or clobber a concurrent
softirq transition, while pass two sleeps inside iucv_send_ctrl() ->
sock_alloc_send_skb(GFP_KERNEL)?  Should the BUG-3 claim be scoped to
iucv_sock_close() only?

>  				sk->sk_state_change(sk);
>  			}
> +			release_sock(sk);
> +			sock_put(sk);
> +			list_del(&entry->list);
> +			kfree(entry);
>  		}
>  		break;
>  	case NETDEV_DOWN:

Thanks for looking at these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917071706.23831-1-nagamani%40linux.ibm.com
