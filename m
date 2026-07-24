Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3E47012C;
	Fri, 24 Jul 2026 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932193; cv=none; b=impWH10MYYNnrkPn3xpZqyj7RnLMjErDh7+PotRsnf/XOspotRU1du5hIvElsFLSEd8MDQ/GTFS2TnqzQRRd+r2Bjs+2qKAjEejrwg1xx1A6IgRsZ0PB+GnlQT238F3ATpMTjXb7pfb/3Tqpr/eSgwTcmZHnASMCUeYPNH+i+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932193; c=relaxed/simple;
	bh=tvKPuajhTaZsyCJS0yd/8MIfiFO5xZueWVuR55NwJ9g=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jJwrO9sMOLQ68NYVLEiym/yhp3KMUVTJ7AmtBj1XkhYMhXd4GfhO4slVwbSVywHG6KPJsXPNuEVaNDR5DZGLwipqWKNbHvJf4f+iful5W25Dsj53eygbaD9V0CAUEtsYW2vF8L5YJ1yFfbgeCvFQQ+57E8Vti/CBgv67Ym2LlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hlHvCd/Q; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hlHvCd/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784932173; x=1785191373;
	bh=lG1Wl8yH++K7aSjBIGzowvZbkpRVyjB2RBUfeehVNKs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hlHvCd/QdYtviYno2ZdsAxRvNxJf35eIarIc1KpPqBYSo22G3MvpqYEIjPIwuWIEW
	 TEpLwrsRWBjpilDiqwywif+4ail1fDuO817KJ92kd5SwFNqcDgPiBm0z6zkPTUGKxY
	 zpb+RZAYECzyxi64Ik6PCRSmMaRZIM6e9XRIPI0Q4gVF3HIGwSSNtYyk97PjucbqL2
	 FK0IHEwgtmFwzgB9IXBVxh3OkAHsu1paIYSbCOEuFfnkqLBs0p7ypFIYJm2Zo13U8c
	 6GRfvb5GNmEZPEs+SKwiNxwKRp6CFfw0ITU+gPbDDt9mScOlOjlKoNyKSKi4qhErha
	 P/sRPME4zQzdQ==
Date: Fri, 24 Jul 2026 22:29:27 +0000
To: Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] net/iucv: af_iucv socket locking - accounting, and a staged plan
Message-ID: <20260724222917.134769-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: f94b326394b4743eaf58c76a193bdbfa9b31db65
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

Here is the socket-locking RFC I promised. No patches yet, on purpose: the
accounting turned up one result that changes which fix is right, and I'd
rather agree the direction with you than post a series you have to redirect=
.

All line numbers are against net-next 0c452fbdf413.


What's there today
------------------

sk->sk_state has 20 assignment sites. One (iucv_sock_alloc:504) runs before=
 the
socket is published on iucv_sk_list at :506, and two set a child socket und=
er
the parent's lock (below). The other 17 are spread across five contexts:

  process, under lock_sock():
    iucv_sock_bind:633,647   iucv_sock_listen:806   iucv_sock_close:411,417=
,432
    iucv_sock_cleanup_listen:306
  process, under no lock:
    iucv_sock_recvmsg:1338
  iucv tasklet, under bh_lock_sock():
    iucv_callback_txdone:1793   iucv_callback_connrej:1810
  iucv tasklet, under no lock:
    iucv_callback_connack:1708
  NET_RX softirq, under bh_lock_sock():
    afiucv_hs_callback_synack:1941   afiucv_hs_callback_synfin:1961
    afiucv_hs_callback_fin:1983
  qeth TX completion, under no lock:
    afiucv_hs_callback_txnotify:2190,2197
  netdev notifier, under no lock:
    afiucv_netdev_event:2222

Two counts sum it up: sock_owned_by_user() appears zero times in the file, =
and
there is no socket backlog at all - no .backlog_rcv in iucv_proto, no
sk_add_backlog() anywhere. iucv->backlog_skb_q is a private data queue, not=
 the
socket layer backlog. So the machinery your option A refers to isn't being
mis-used here, it's absent.

Child sockets get their state set under the parent's lock: connreq:1696 and
hs_callback_syn:1917 both set nsk->sk_state while holding bh_lock_sock on t=
he
parent, and iucv_sock_alloc:506 already published the child on iucv_sk_list
before its state was set.


Three gaps, each with a herd7 witness
-------------------------------------

I modelled the locking discipline in LKMM rather than argue it in prose. Si=
x
litmus tests, herd7 7.58. Each RED has a GREEN whose only delta is the lock=
 or
the check, plus a CONTROL so the harness is shown to discriminate:

  RED     bh_lock_sock vs lock_sock, no owner check     Flag data-race
  GREEN   ... same, with sock_owned_by_user() + defer   clean
  RED     recvmsg unlocked, softirq HAS the owner check Flag data-race
  GREEN   ... same, with recvmsg under lock_sock        clean
  RED     a writer holding no lock at all               Flag data-race
  CONTROL two bh_lock_sock writers                      clean

The first pair is your sentence from f558120cd709 ("bh_lock_sock() is not
serializing the tasklet context against process context") as a model verdic=
t.
lock_sock() releases sk_lock.slock before its critical section and leaves o=
nly
sk_lock.owned set; bh_lock_sock() holds slock through its critical section.=
 The
two critical sections share no lock, so only an explicit sock_owned_by_user=
()
check can order them.

The third row is the one the plan turns on, so it's spelled out below. The =
rest
inline or in a follow-up, whichever you prefer.


The result that changes the plan
--------------------------------

Option A as written in f558120cd709 doesn't reach the receive path.

iucv_sock_recvmsg (1237-1362) takes no socket lock - not lock_sock, not
bh_lock_sock - and it writes sk->sk_state at :1338. Since it never sets
sk_lock.owned, a sock_owned_by_user() check added in the softirq always rea=
ds
zero and always takes the "process now" branch. The deferral branch is dead
code against recvmsg. That's the third litmus above; since it's the one the
plan turns on, here it is rather than on request. P1 already has the option=
-A
fix applied:

  C iucv-recvmsg-vs-hs-callback
  {}

  P0(int *sk_state)
  {
        *sk_state =3D 5;                  /* recvmsg:1338 -- no socket lock=
 held */
  }

  P1(spinlock_t *slock, int *owned, int *sk_state, int *backlog)
  {
        int r0;

        spin_lock(slock);               /* bh_lock_sock */
        r0 =3D READ_ONCE(*owned);         /* sock_owned_by_user() */
        if (r0 =3D=3D 0)
                *sk_state =3D 2;          /* always taken: recvmsg never se=
ts owned */
        else
                WRITE_ONCE(*backlog, 1);        /* the branch that never ru=
ns */
        spin_unlock(slock);
  }

  exists (sk_state=3D2)

  $ cd tools/memory-model && herd7 -conf linux-kernel.cfg iucv-recvmsg.litm=
us
  Flag data-race

Give P0 the lock_sock() handshake (set owned under slock, write sk_state, c=
lear
it) and the flag goes away, with nothing else changed.

So the owner check plus re-enqueue fixes the state machine against
close/bind/listen/shutdown, but not against the reader -- and the reader is=
 the
path you asked about.

Putting recvmsg under lock_sock isn't a one-liner either. Two things in the
way, both of which I'd rather you ruled on:

  a) recvmsg:1313 calls iucv_sock_close(), which takes lock_sock:401. Takin=
g
     the lock in recvmsg self-deadlocks there unless the close is split int=
o a
     __iucv_sock_close() that assumes the lock.

     That exact call already cost a CVE: 3589d20a666c ("net/iucv: fix locki=
ng
     in .getsockopt", CVE-2026-64004), which you reviewed and tested, fixed=
 a
     NULL deref from getsockopt(SO_MSGSIZE) racing the iucv_sock_close() th=
at
     recvmsg invokes at :1313. Locking getsockopt closed it because
     iucv_sock_close() takes the socket lock itself - which is also exactly=
 why
     recvmsg cannot simply take it too.

  b) skb_recv_datagram() doesn't release the socket lock while it waits, so=
 a
     blocking recv would hold it across the sleep and stall backlog process=
ing
     for the duration. __iucv_sock_wait already has the right shape for thi=
s
     (release_sock / schedule_timeout / lock_sock), but it changes recvmsg'=
s
     blocking behaviour.


Staged plan
-----------

Why split rather than send one rework: your caveat in f558120cd709 about re=
turn
values and "changes to all users of iucv" applies to the tasklet path, beca=
use
those handlers run from iucv_tasklet_fn while holding iucv_table_lock and
iucv_handler is shared with monreader, vmlogrdr, smsgiucv and hvc_iucv. It
doesn't apply to the HiperSockets path: afiucv_hs_rcv is a packet_type hand=
ler
in NET_RX softirq that owns the skb, so it can defer to the socket backlog =
with
no core change and no other driver touched.

Stage 1, HiperSockets receive path. Add iucv_proto.backlog_rcv, hoist
bh_lock_sock from the individual afiucv_hs_callback_* into afiucv_hs_rcv, a=
nd
defer via sk_add_backlog() when the socket is owned. Put recvmsg under
lock_sock, with the two items above. Entirely inside af_iucv.c, and it's th=
e
part you named.

Stage 2, iucv tasklet path. This is where option A vs option B actually has=
 to
be answered, and where the core and the four other iucv users are affected.
Option B subsumes it but needs iucv_tasklet_fn to stop holding iucv_table_l=
ock
across handler dispatch, or dispatch moved to the existing iucv_work_fn.

Stage 3, the writers holding no lock. No amount of owner-check discipline a=
t
the other sites reaches these; they need a lock first. iucv_callback_connac=
k is
unambiguous - same tasklet as connrej and shutdown, which already take
bh_lock_sock - so it can just do the same. I have that one ready as a
standalone patch if you want it independently.


Questions
---------

Q1. For stage 1, is putting iucv_sock_recvmsg under lock_sock acceptable to
    you, given (b) changes its blocking behaviour? The alternative is to
    promote message_q.lock to the receive-path lock and move sk_state under=
 it,
    which leaves recvmsg's sleep alone but makes message_q.lock cover somet=
hing
    it doesn't cover today.

Q2. For stage 2, option A or option B? B is more invasive in net/iucv/iucv.=
c
    but makes Q1 and stage 3 moot. If you and Hidayath would rather own the
    core change, I'll do stage 1 and hand you the analysis for the rest.

Q3. afiucv_hs_callback_txnotify runs in two contexts, which is why I didn't
    just add a lock to it: qeth_tx_poll (NAPI, softirq) and
    qeth_drain_output_queue (process, teardown) both reach it through
    qeth_notify_skbs. Which one should the locking be written for?


Caveats
-------

I have no IBM Z, so none of this is validated on real HiperSockets. herd7
proves the accesses race under LKMM; it says nothing about memory-safety
impact, which would need a KASAN run on hardware. Treat the model results a=
s an
argument about which lock covers which write, not as a reproduction. I'd re=
ly
on you or Hidayath to validate each revision on real HW before anything lan=
ds.

One coordination note: Hidayath's "net/af_iucv: fix use-after-free of liste=
n
sock in iucv_callback_connreq()" is still open, and I'm deliberately not
touching that function. The staged plan resolves connreq as a consequence o=
f
the general direction rather than competing with his patch.

Prior discussion, for anyone picking this up cold:
https://lore.kernel.org/all/20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@pro=
ton.me/
https://lore.kernel.org/all/20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@pro=
ton.me/
https://lore.kernel.org/all/20260706084825.6231-1-hidayath@linux.ibm.com/

Thanks,
Bryam

