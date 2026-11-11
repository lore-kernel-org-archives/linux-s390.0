Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396170;
	b=RfTlFE225dxGcvLh0eBoajFzmD+4oollb6S5x2RKZICheqaAnHUjHLQP4IPnearggJC0
	 Q0weREvXc4SGLuwCdwHhFOtdsHvtLmZTPiqzZUBWC4pOvM4NR0AVWbi2zkSv5r2AjAcT5
	 kQsJudQE9iqWGuGVqoCHX3HVtIa5JSW2QoE6RfTpw8DxFW1WSHVHOJZfNA6irHhXIGh6a
	 YblOkeHoXHfX6RSWopUhFG1ihclGHn88n96G1mpkzsAyuDbJi27jxbJABASiGs5lBpW8A
	 vZ3TNFSVq/K0ZpSB9k6lH4BN4tEHBrbf+Rj4dg/++NHVKiRVAn3ceDrMbtFhWsecDLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396170;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GwUxgo2F06L4r18IX7FmrxoBrrKFhr9IVgxmMx5m73c=;
	b=COqxmBqhccRz+Zp+Qmc0CZOHx0x8IIaDRvyClmwA+u+eJNsmCHH7C7fCZs3KTZIItCtf
	 q4WBWatRu/6BGQtdWW9M6VbJeL5r/Ld9f4rXVuRydxDkdH7c6MLTgza4XA8GlbqYmDHN0
	 EH98OPc0eky2CzmPuwSWb4tGqdbJ/6Mdh9Vh71Urc2H9fVYAL+0cL3gjWeF9GTuybgJDl
	 1fg6prjzZB8+n0UP5AFVipAKXjjNmaqia1zir73SH0DJ/YSwe55WdhIT26dnJ4iX9sdde
	 e6lpZm37PK5IqSfYiv661RycWLhQs5ERZVmYMoaDOKS8tQUxHXtvgcZLoMhseAU/y+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=zpdrlzr5wfgwdo423vf547bmsq.protonmail2 header.b=CDf6iXqO;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58878606A321;
	Wed, 11 Nov 2026 11:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58878606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=zpdrlzr5wfgwdo423vf547bmsq.protonmail2 header.b=CDf6iXqO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zpdrlzr5wfgwdo423vf547bmsq.protonmail2; t=1794396165;
	x=1794655365; bh=GwUxgo2F06L4r18IX7FmrxoBrrKFhr9IVgxmMx5m73c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CDf6iXqO+ebgKa+rLH/oETH3n01H4XHbhQ12otRG696DICKKP4K9NUFwj8bKk3iBw
	 9uaul7OrPiLjy+zQ1QLC2dHJ9uBMOhZ0SybMvp4xQBYICrZEYuhPDt5+zTxxdvZ9nC
	 uMcYdBRgeUx2g4h7HhPT0LvqQYXTcx/FwSlmuDOV9yyIJGnr9rzUTrS9thfPBI0Hsb
	 QRCUeCw+0ZAztwsiI9Jysre0A83F6QwtMCnnkqWa46ZBzjQ/dvrF4uZPZcPDGvkM4O
	 /Lf6Grm2tgwvb1RcprvWDIwgKBsQpOGerDGx4BMG1HB//TSkt0wuFeV8jl7VZNwOg8
	 SKwsGOE2zZ6+A==
Date: Wed, 11 Nov 2026 11:22:39 +0000
To: Alexandra Winter <wintera@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nagamani PV <nagamani@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 1/2] net/iucv: serialize HiperSockets receive with the socket lock
Message-ID: <20261111112230.831095-1-hexlabsecurity@proton.me>
In-Reply-To: <2886dcb1-2741-4b29-86e6-dba3ccf2125a@linux.ibm.com>
References: <20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me> <20261022-b4-disp-1d26b87a-v2-1-7ee1264d812a@proton.me> <2886dcb1-2741-4b29-86e6-dba3ccf2125a@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: ee15947cf76c3df87186756eb1a4ee4150c1ee43
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

On Mon, 9 Nov 2026 16:12:52 +0100, Alexandra Winter wrote:
> To me this is the most urgent of the open fixes. I'd like to focus on
> getting this upstream.
[...]
> Can we reduce the scope even more?

Yes. v3 [1] is on net, with nothing under it, and split so that the
lock patch, 5/7, has only the softirq side:

  1/7  msglimit_adv, on its own
  2/7  sendmsg() fails with -EPIPE when sending is shut down under it
  3/7  recvmsg() under lock_sock()
  4/7  code moved for 5/7, no functional change
  5/7  the HiperSockets rx path under the socket lock
  6/7  RCV_SHUTDOWN set under sk_lock.slock
  7/7  EOF for a reader parked when the peer closes (was 2/2)

v3 drops the iucv_send_ctrl() rewrite, the window update only while
connected and the credit reset. With them out, v3 fails five of my 53
default tests, the way net fails them; the cover letter lists them so
nobody reads them as regressions.

> Can you polish the style (comments, commit message) some more?

Every function 4/7 and 5/7 add has a kernel-doc header that says who
holds what (softirq under bh_lock_sock(), or the owner under
sk_lock.slock) and what the function decides; the comments inside are
in net style and short.

> For stable team to evaluate, the commit message should include symptoms,
> conditions and consequences.

Each of the six that fix something says what is seen, under which
conditions and what it costs, and has its Fixes: tag. 4/7 only moves
code.

> Let us know, if you want Hidayath or myself to take on any of this.

One thing, and it's the part I can't do: the run on z/VM. Hidayath's
numbers on v1 [2] are what I calibrated my setup against, and v3 moves
enough code that I'd like the same run on it before the RFC tag goes:
the scenarios at 120 s each with net as the baseline, the blocked reader
and SO_MSGLIMIT in IUCV_BOUND, and the KCSAN build. Here it's QEMU TCG
with an emulated adapter and CP: rates, KCSAN and real SMP only come
from the hardware. The cover letter says what I expect from each
scenario, patch by patch, so a miss is easy to spot.

> what follows is alist of 3(?) problems in current code, may
> format it as a list?

3/7 lists the three that are recvmsg()'s own. 5/7 has the softirq's
two in its first paragraph, and a list for what happens to each kind of
frame. The window update and the credit are out.

> What are possible consequences? UAF? Can you give 1 example, maybe even
> with KASAN(?) output?

No UAF AFAICT, and no KASAN splat: the KASAN runs here and Hidayath's
are clean on net-next for these paths. What's measured is wrong
behaviour and leaks, not memory corruption. On his guest, 120 s
per scenario on net-next: 3917 reads that go backwards with two readers
on one socket, the sk_shutdown bit lost in 565 of 7281 cycles, data read
after shutdown(SHUT_RD) in 32 of 212, and 29 KCSAN reports with af_iucv
on both sides, 19 of them recvmsg() against shutdown().

The example in the commit message of 5/7 is a listener. A SYN that
arrives while close() is emptying the accept queue is answered under
the closing task, and its child is queued on a socket that is freed a
moment later. Nothing can accept or close that child: it is never
freed, and since it carries the listener's name, the next bind() to
that name fails with -EADDRINUSE. I reproduced it on net with an
mdelay() in iucv_sock_cleanup_listen() to hold the window open, which
is otherwise a few instructions wide; with 5/7 and the same delay the
SYN waits for the close and is refused. KASAN stayed quiet: the child's
pointer to the freed listener is never followed.

The one that comes with kernel output is the third item of 3/7, which I
found while reviewing v3: a MSG_PEEK read that a second reader
overtakes never frees its skb, and iucv_sock_destruct() takes its
WARN_ON() on sk_rmem_alloc when the socket goes. On net main:

  WARNING: net/iucv/af_iucv.c:292 at iucv_sock_destruct+0xb8/0xe0, CPU#1: i=
nit/1
  Call Trace:
   iucv_sock_destruct+0xbc/0xe0
   __sk_destruct+0x5a/0x430
   iucv_sock_release+0xbc/0xd0
   __sock_release+0x74/0x140
   sock_close+0x2a/0x40

It's gone with 3/7.

> > recvmsg()
> > takes no socket lock and sends a due window update in any state, even
> > after the FIN;
>
> Is that a problem? Or only bad style?

On its own, close to style: a window update for a peer that has sent
its FIN is a frame nobody uses. It's the IUCV_CONNECTED test you
suggested in July. v2 had it because the credit reset needed it (next
point); v3 leaves that code as net has it. The test is in [3] 2/2,
where you asked whether it can be false the next cycle without the
socket lock. On top of v3 a FIN can no longer change sk_state under
recvmsg() (5/7). afiucv_hs_callback_txnotify() and the netdev notifier
still can; the cover letter lists both as open.

> > one that fails keeps its credit.
>
> You mean, when sending out a WIN fails?
> What are the consequences? Overrun scenario? But isn't that covered
> by your other patch [1] ?

Yes, when iucv_send_ctrl() has no room in sk_sndbuf for the WIN:
recvmsg() sets IUCV_DISCONN and keeps msg_recv. The next frame read is
the peer's SHT, counted one past the window: WARN_ON() and -EFAULT where
EOF was due. And yes, your [1], which is [3] 2/2 below, covers it: with
the SHT not counted, the credit that was kept cannot pass the window. So
the reset is gone from v3. On net without [3] that case still ends in
the WARN_ON(); one of my tests shows it on v3 as on net.

> It took me a while to understand this.
> I guess you are saying: Don't queue the SYN|ACK, SYN|FIN or FIN,
> because they must not be dropped, not even unde rmemory pressure?

Yes. Nothing resends them, and the socket backlog can refuse an skb
under memory pressure. The commit message and the comment on
afiucv_hs_record() say so now.

> I wonder, if you can split the msglimit_adv vs msglimit into a separate
> patch?

1/7. It goes first because the backlog of 5/7 counts against that
window; on the live msglimit it would drop data without a trace, which
is what Hidayath's SO_MSGLIMIT scenario found on v1. On its own it
fixes two things on net, both after SO_MSGLIMIT is changed with the SYN
out: lowered, the socket is closed on a peer that kept to its window
(WARN_ON() and -EFAULT); raised far enough, the peer never gets a
window update.

> I wonder whether this should be in a seperate patch.
> Is it really related to 'HiperSockets receive with the socket lock'?
> You already have another patch that is about fixing shutdown [1], maybe
> add this there?

(the iucv_send_ctrl() rewrite) It isn't related to the lock, and it's
out of v3. I wouldn't put it in [3] 2/2 either: that one is the
receiver not counting an SHT, this is the sender finding no room in
sk_sndbuf for its own FIN or SHT. What v3 keeps from that area is 2/7,
which is sendmsg() only.

> I'd prefer kernel-doc comments and network style (without the first line
> /*  [2])

Done for everything the series adds.

> This applies only on top of [1]
> Can we do this one first? i.e. independently and based on upstream net?

v3 is on net main (8373c4e8863a) with nothing under it. Of [3], 1/2
applies on top of it as it is; 2/2 needs a rebase, since it touches the
lines 1/7 changes.

> I wonder whether this should be in a seperate patch.
> Is it really related to 'HiperSockets receive with the socket lock'?

(the atomic_set() of msg_recv) No, and it's out; see the credit above.

> done,out,err_out,out_err: Not very descriptive label names. Do you have
> a better idea?

The two 3/7 adds to recvmsg() are unlock and err_unlock: they release
the socket and return. 5/7 has one more, refuse, in
afiucv_hs_backlog_add(), for a frame that cannot wait. done and err_out
are the file's own; I left them so the diff stays on the locking.

> ^^ This comment sounds important, but I don't get what it is trying to
> point out.

It was wrong. "a reader holding the lock would otherwise wait for its
own window" was the reason in an earlier draft, before recvmsg() slept
without the lock. The kernel-doc on
afiucv_hs_defer() now gives the two cases in which a data, SHT or WIN
frame waits: the reply to our SYN is recorded and not applied yet, so
the socket is still IUCV_BOUND and would free the data; or frames wait
already, and a later one must not overtake them.

> A full sentence may be even clearer:
> "Don't use sk_add_backlog() here, because its limit is in bytes..." (?)
[...]
> It ma ybe helpful to mention why we need to count frames: Because
> msglimit for iucv is defined in frames (?).

Both taken. And yes, that's why: the window is in frames, and
sk_add_backlog() counts bytes, the receive queue's included, so it can
refuse a frame the peer was entitled to send.

> I like the new afiucv_hs_rcv() a lot.

Its shape is the same in v3. The filter at its top changed: the AI
review of v2 [4] found that a FIN reaching a socket still in IUCV_BOUND
was recorded and disconnected it once the SYN|ACK arrived, and that
frames behind a recorded FIN were still taken. Both repro here on v2
and are fixed in 5/7.

Thanks for the review.

Bryam

[1] https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-0-35677b68e=
697@proton.me/
[2] https://lore.kernel.org/netdev/51a4a40a-f34b-4d41-b049-69aa53f4dcf5@lin=
ux.ibm.com/
[3] https://lore.kernel.org/netdev/20261028-b4-disp-dd3e4ebb-v2-0-3747658d5=
9bd@proton.me/
[4] https://lore.kernel.org/all/sashiko-outbox-183527@kernel.org/

