Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653914;
	b=x8EksNXHPvIu2m4whx0c5qkWKobP7RzQWWgtEj4JB41ByxTC5MkPQAOh3iySlFBUgC/g
	 RTFOnVTKfrDI6ydklmliT3X8o0O8Wo7RtmZK7kH9wek+n/9mcJToN+2CWUNftQuMcAAvq
	 6/8KN3KD+/tqy5f+WoyH+rYJx7lPj1NOqmAIDj+OCjvB8KI2K3oaIMq972YVNVKURUhbW
	 Q57Pb47dgr0BpMqDUWG/zjD9JJRH6bQrx+yfTbYYtaeqR8eyIKVjBJvyDGPnUK9MdNjNg
	 +bM+TlYLx9mosytGGtQwnyicWTjaS2XXIzVJXBrVawnRtRQ/R8Eq+CHM6FeMR97XSeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653914;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kY3rxeufBWnulhzLNXslToghbLfgKp38Kw8D+5p+OLA=;
	b=x82Buc68AqXg1wM4CAm6MTlP5IB9wp9Z+1QrZ1P2ueCB1Eb/2OGo8IQ2N3EFoLaajLo8
	 Yqm+n6jWetqBKCiKVh8hKN8HRPKL90eH2CQm0r8FRP38oyHhIfnBP9KYcsbUuk7yMx8ru
	 x5O2hAzODJLt/7cbNa0E92Vy+6LddWdrBuuwHQSXeTK6tVoLou1Nk0YfJXZ7hFw8nneIw
	 gSUWOET6FOu6ETkDO65ItDBKVLSnLOoadzk7e4eh/d6rU0Qx4ioWuKhSvwxSsK67nIZ2v
	 hMn4Y1NoVkEW8hKS2fAdVEOgyMXbac7ucSrErs7yJqeZ4GoeZMAbe16eBpe6x9K+xsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG1lraI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED7606A31E;
	Thu, 22 Oct 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG1lraI8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E51F000C1;
	Thu, 22 Oct 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792653913;
	bh=kY3rxeufBWnulhzLNXslToghbLfgKp38Kw8D+5p+OLA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AG1lraI8+UjpC5FCk1hv1QZorsZYrs9nv8g4ADtlR17dPO0GhMmmfILvHM5nLeKWN
	 SMX2uRvSGiJ2YI9pLxNo8cZEduejciJBLHVBN4lP98zChOLAjl9wYb2Duj9HdHoSWE
	 DS3TywAXwXVvgX2rKTZI4s4ltMg1NkJcQ6p7zrETREvC6hsdqhozF1/WO5et7pywh5
	 RMH+flt/TUpavP2GWJwpimmrJ//9Kjv2ZfQ1wXA5OVtvO5dSsmRaii0dUnrFNJ9wLX
	 1ssLk+cuR5dADrkOF1sQTfD07GNoueHUdl8YJxwlWLvfp/SEyHq270SrU4Xw8AWgMY
	 AVGlwHoZ4/HAQ==
Subject: Re: [PATCH] iucv: fix lockless sk_for_each in afiucv_netdev_event
From: netdev-bot+sashiko@kernel.org
To: haoranwangsec@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 07:25:12 +0000
Message-ID: <179265391209.3135.1121448339141763327@kernel.org>
In-Reply-To: <179241612354.5916.12881323209252769976@whr>
References: <179241612354.5916.12881323209252769976@whr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Race with concurrent close() that can dereference a NULL hs_dev,
  in afiucv_netdev_event() (net/iucv/af_iucv.c).
- [High] Self-deadlock on iucv_sk_list.lock in afiucv_netdev_event()
  (net/iucv/af_iucv.c, lines 2229 and 2244).
- [Medium] New failure path in afiucv_netdev_event() (net/iucv/af_iucv.c,
  lines 2240-2242) that skips the whole disconnect.
- [Medium] In afiucv_netdev_event() (net/iucv/af_iucv.c), the second pass
  stops at `if (n == count) break;`, but count was taken in an earlier,…
- [Low] The commit fixes a user-reachable use-after-free: the lockless
  sk_for_each() in afiucv_netdev_event() races with iucv_sock_kill() ->…

--

iucv: fix lockless sk_for_each in afiucv_netdev_event

This patch takes iucv_sk_list.lock around the sk_for_each() traversal in
afiucv_netdev_event(). Matching sockets are counted in a first pass. An
array is then allocated and filled with sock_hold() references in a second
pass, and iucv_send_ctrl(), the state change and sock_put() run after the
lock is dropped.

> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>

[Severity: Low]
This isn't a bug, but this fixes a use-after-free in the lockless
traversal. Should it carry a Fixes: tag, and possibly Cc: stable? The
function and its lockless sk_for_each() were added by:

Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")

The sk_for_each() line itself was changed later by b67bfe0d42cac.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af..20c8943b85cd 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2222,18 +2222,49 @@ static int afiucv_netdev_event(struct notifier_block *this,
>  
>  	switch (event) {
>  	case NETDEV_REBOOT:
> -	case NETDEV_GOING_DOWN:
> +	case NETDEV_GOING_DOWN: {
> +		struct sock **matches;
> +		int i, n = 0, count = 0;
> +
> +		read_lock(&iucv_sk_list.lock);

[Severity: High]
Can this deadlock against a softirq writer on the same CPU?

The notifier runs in process context under RTNL with BH enabled. The same
rwlock is also write-locked from softirq context:

afiucv_hs_rcv()                 /* netif RX softirq */
  afiucv_hs_callback_syn()
    iucv_sock_alloc(NULL, ..., GFP_ATOMIC, 0)
      iucv_sock_link()
        write_lock_bh(&l->lock);

The IUCV tasklet path iucv_callback_connreq()->iucv_sock_alloc() reaches
the same writer. So do the error branches through
iucv_sock_kill()->iucv_sock_unlink().

Suppose a HiperSockets SYN arrives and NET_RX softirq runs on the CPU that
holds the read lock in either pass. Wouldn't the writer then spin forever,
waiting for a reader that can't run again on that CPU?

The commit message says this matches the other two sites, but
iucv_callback_connreq() and afiucv_hs_rcv() already run with BH disabled.
The other process context users, iucv_sock_bind(), iucv_sock_autobind()
and iucv_sock_link()/iucv_sock_unlink(), all use the _bh variants.

Should both passes use read_lock_bh()/read_unlock_bh() instead?

>  		sk_for_each(sk, &iucv_sk_list.head) {
>  			iucv = iucv_sk(sk);
> -			if ((iucv->hs_dev == event_dev) &&
> -			    (sk->sk_state == IUCV_CONNECTED)) {
> -				if (event == NETDEV_GOING_DOWN)
> -					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
> -				sk->sk_state = IUCV_DISCONN;
> -				sk->sk_state_change(sk);
> +			if (iucv->hs_dev == event_dev &&
> +			    sk->sk_state == IUCV_CONNECTED)
> +				count++;
> +		}
> +		read_unlock(&iucv_sk_list.lock);
> +
> +		if (!count)
> +			break;
> +		matches = kmalloc_array(count, sizeof(*matches), GFP_KERNEL);
> +		if (!matches)
> +			break;

[Severity: Medium]
If this allocation fails, does every socket bound to event_dev stay in
IUCV_CONNECTED?

The break skips the FIN, the move to IUCV_DISCONN and sk_state_change()
for all matching sockets. __dev_close_many() ignores the notifier's return
value and carries on with the shutdown. NETDEV_DOWN and NETDEV_UNREGISTER
do nothing in this notifier, so nothing retries later.

iucv_sock_poll() only sets EPOLLIN once sk_state is IUCV_DISCONN. Readers
waiting for that would stay blocked.

The previous loop did no allocation, so it could not fail this way.

> +
> +		read_lock(&iucv_sk_list.lock);
> +		sk_for_each(sk, &iucv_sk_list.head) {
> +			if (n == count)
> +				break;

[Severity: Medium]
Can this cap skip sockets that were counted in the first pass?

count comes from a separate critical section, and the lock is dropped
around kmalloc_array(). NETDEV_GOING_DOWN is sent before
__dev_close_many() clears __LINK_STATE_START, so RX is still active.

In that window, afiucv_hs_callback_syn() can link a new socket on the same
device:

	niucv->hs_dev = iucv->hs_dev;
	...
	nsk->sk_state = IUCV_CONNECTED;

Also, afiucv_hs_callback_synack() can move an existing BOUND socket to
IUCV_CONNECTED.

iucv_sock_link() uses sk_add_node(), which inserts at the head, so the new
sockets fill matches[] first. Once n reaches count, the walk stops before
it reaches older sockets that are still IUCV_CONNECTED on event_dev. Those
sockets would get no FIN and no move to IUCV_DISCONN.

> +			iucv = iucv_sk(sk);
> +			if (iucv->hs_dev == event_dev &&
> +			    sk->sk_state == IUCV_CONNECTED) {
> +				sock_hold(sk);
> +				matches[n++] = sk;
>  			}
>  		}
> +		read_unlock(&iucv_sk_list.lock);
> +
> +		for (i = 0; i < n; i++) {
> +			sk = matches[i];
> +			if (event == NETDEV_GOING_DOWN)
> +				iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
> +			sk->sk_state = IUCV_DISCONN;
> +			sk->sk_state_change(sk);
> +			sock_put(sk);
> +		}

[Severity: High]
Can a concurrent close() set hs_dev to NULL before this loop runs?

sock_hold() keeps the struct sock allocated, but this loop does not take
lock_sock(). It also does not recheck hs_dev or sk_state after the list
lock is dropped.

close() goes through iucv_sock_release()->iucv_sock_close(). That path
holds only lock_sock(), not RTNL, and ends with:

net/iucv/af_iucv.c:iucv_sock_close() {
    ...
	if (iucv->hs_dev) {
		dev_put(iucv->hs_dev);
		iucv->hs_dev = NULL;
		sk->sk_bound_dev_if = 0;
	}
    ...
}

If that runs between the second pass and this loop, iucv_send_ctrl() then
computes:

	blen = sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);

That reads through a NULL hs_dev before afiucv_hs_send() gets to check
skb->dev.

The loop also writes sk->sk_state = IUCV_DISCONN on a socket that
iucv_sock_close() has already moved to IUCV_CLOSED, which moves its state
backwards. iucv_send_ctrl() also changes sk->sk_shutdown without the
socket lock.

The old code had the same check-then-use race, but the check and the use
were back to back. Here the check happens during collection, and the use
only comes after the whole list has been walked.

For comparison, afiucv_hs_callback_fin() does this transition under the
socket lock:

	bh_lock_sock(sk);
	if (sk->sk_state == IUCV_CONNECTED) {
		sk->sk_state = IUCV_DISCONN;

The commit message says:

  sock_hold() pins each sk for the out-of-lock work, so a concurrent
  close can no longer free it from under the notifier.

Given the above, does that claim hold for the fields used here? Would it
make sense to take lock_sock(sk) in this loop and recheck
sk->sk_state == IUCV_CONNECTED and iucv->hs_dev == event_dev before
acting?

> +		kfree(matches);
>  		break;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179241612354.5916.12881323209252769976%40whr
