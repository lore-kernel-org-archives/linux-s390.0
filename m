Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8D21255A
	for <linux-s390@vger.kernel.org>; Sun,  9 Aug 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786240178; cv=none; b=KQmMgWs57L3R/gmBqyD6dYFN49T/9t9JyD7Z41Vut5WvwMA32mN2dpq6OHQFHnH4uAfZ16w0uVDMGzJZ5BqebMbpvHovshRASthMB8x3hzkbkoQfW2nWaP3vjZ7fOG+uOHdL25Y+DAPy+SVft4fytHTnxPavrsn3zv6oXz/zBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786240178; c=relaxed/simple;
	bh=fbWMCnLA27YH7DXqm7lLNbL5Ej7RajU2bpPU2Kj669A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMQqHPCLM/4bCjosR6x2PUyHL+x3FPXWhgJKY7rTbtvM/pq8onP2cSN/WoM6a4o8zB0UazKA/HNwlfwlm3oJECC3BaP+zWZnlK5j0Pegzvpo6pTsTmJMM3h/FMqhwMEYv4GMMCkmwT7Zr3932wf7w87we6434YyRvFiYG8+RVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lOs8gXqk; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lOs8gXqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7q5u5koad5hq7phwgw5adzl2vm.protonmail; t=1786240163; x=1786499363;
	bh=fbWMCnLA27YH7DXqm7lLNbL5Ej7RajU2bpPU2Kj669A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lOs8gXqktmpLbC9lQumH3dMOt6xNbtn1bstLKESnDT7PbUYKVWWqijaEZXeaicZLj
	 2SmCOwY2hhiS2I4KlmWY7Y9KNQqZMkqBASmrilWHFQe404TVgmr0/tNPx3pc2FsbRm
	 4eUQ8o6Uwlsw0vX5eenY4lNC0Ir3GLH8O419cNnvhA33L7obtKBwF/5ta5GGXz47mZ
	 8SRmNgH0APcrHIAsV/EbEGM4J/P8TDID7hTyIwG8OIfyxYFgeW4ZPH6IpHIAuDF7Ql
	 /hiyfbe2jeOfxvAjcm7mD0SSiaPh2BLM967Ab38IYN0Qzr+j2M+hvFPA7+NlzBcdKG
	 JjgkCGzf5K3BA==
Date: Sun, 09 Aug 2026 01:49:20 +0000
To: Alexandra Winter <wintera@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Winkler <twinkler@linux.ibm.com>
Subject: Re: [RFC] net/iucv: af_iucv socket locking - accounting, and a staged plan
Message-ID: <20260809014911.752106-1-hexlabsecurity@proton.me>
In-Reply-To: <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com>
References: <20260724222917.134769-1-hexlabsecurity@proton.me> <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 2c68e6b841fca3e02b15ea9b4604672833a3a68c
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

Four things in the RFC were wrong. Two of them change what I asked you to
decide, so they go first.

The data races. I called them that on the strength of herd7, and that was
wrong. sk_state is volatile unsigned char skc_state, and LKMM raises its
data-race flag only when one side of a conflict is a plain access, so a
volatile access never qualifies. My litmus encoded the writes as plain, whi=
ch
manufactured the flag - and the flag was the only thing separating the bug =
arms
from the fixed ones. That set did not show what I said it showed. I rebuilt=
 it
three times and every rebuild described code that does not exist; the last =
one
paired a writer that only fires on the classic transport with a waker that =
only
fires on HiperSockets, which no single socket can be. There is no replaceme=
nt
litmus. The unsynchronized writes are still unsynchronized and that part re=
ads
straight from the source.

"The owner check plus re-enqueue fixes the state machine against
close/bind/listen/shutdown". It does not fix close. iucv_sock_close() sets
IUCV_CLOSING at :417 and then, when !err and skbs_in_xmit is non-zero at :4=
20,
sleeps in iucv_sock_wait() for IUCV_CLOSED. That macro does release_sock()
before schedule_timeout() and lock_sock() after, so sk_lock.owned is clear =
for
the whole sleep, up to IUCV_DISCONN_TIMEOUT. A sock_owned_by_user() check i=
n a
softirq writer reads false across that window, and release_sock() would dra=
in a
deferred write into it on the way out. Option A orders the tasklet against =
a
process context holding the lock and does nothing for one sleeping inside i=
t.
Tell me if I have misread iucv_sock_wait().

"Stage 2 affects the core and the four other iucv users". It doesn't have t=
o.
Below.

The hardware caveat was too broad. iucv_packet_type is registered with
dev_add_pack() on every af_iucv init and carries no .dev, so an ETH_P_AF_IU=
CV
frame on any netdev reaches afiucv_hs_rcv, and the dispatch from there bran=
ches
only on trans_hdr->flags. The softirq sk_state writers are drivable in a pl=
ain
s390x guest. What needs your hardware is the classic transport and the real
qeth TX-completion contexts.

> I would prefer option A: keep the tasklet and use bh_lock_sock(). You see=
m to
> think that is doable?
> Less invasive is attractive.

Yes, with one ordering constraint and one shortcut.

The constraint is stage 1, which you already signed off on. Option A can't
order the tasklet against the reader until recvmsg holds the socket lock:
recvmsg sets no sk_lock.owned today, so the deferral branch has nothing to =
test
and never fires against it. Stage 1 is a prerequisite for stage 2, not a
parallel track.

The shortcut removes the cost you flagged in f558120cd709, "this may requir=
e
adding return values to the tasklet functions and thus changes to all users=
 of
iucv". struct proto has .release_cb, and net/smc already uses it
(smc_release_cb). af_iucv can set iucv_proto.release_cb and keep a per-sock=
et
mask of pending state changes: af_iucv.c plus one field in af_iucv.h, no re=
turn
values, nothing in net/iucv/iucv.c, and monreader, vmlogrdr, smsgiucv and
hvc_iucv untouched.

I prototyped it on an s390x kernel: a writer that finds sock_owned_by_user(=
)
true sets a bit instead of touching sk_state, and release_sock() applies it=
 --
sk_state 1 -> 5, defer flags cleared. Synthetic __init probe, not the real
handler path; it shows the deferral vehicle works, nothing more. Log on req=
uest.

release_cb runs under sk_lock.slock with BH disabled, so whatever gets defe=
rred
there must not sleep. Writing sk_state and waking the state-change waiters =
is
fine.

> No, I don't like that. message_q is a concept for iucv not HS - I see mes=
sage_q.lock
> is already used in both paths, but I don't want to stretch it further.
> I prefer your proposal above and would like to test it with KASAN etc.

Agreed, and I'd drop that alternative. Worth adding that message_q.lock alr=
eady
reaches further than it should on that path: iucv_sock_recvmsg() calls
iucv_send_ctrl() with it held, and iucv_send_ctrl() allocates through
sock_alloc_send_skb(), which uses sk->sk_allocation - GFP_KERNEL for these
sockets. On a default-msglimit HiperSockets socket the msglimit/2 gate fire=
s at
64 receives, so it's not a corner case. I have a DEBUG_ATOMIC_SLEEP splat f=
or
it from an s390x guest, from the same __init probe as above with msg_recv s=
et
rather than received: the state is staged, the sleeping allocation under
spin_lock_bh is not.

> I wonder, if there is more required than taking and releasing the socket =
lock.
> e.g. I think recvmsg needs to check (sk->sk_state =3D=3D IUCV_CONNECTED) =
before
> iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN).
> But let's take it one by one.

The check belongs there, and I'd put it in with the lock rather than before=
 it.
Unlocked it narrows the window without closing it: iucv_sock_close() clears
hs_dev under lock_sock while recvmsg holds nothing, so the gap between the =
test
and iucv_send_ctrl() stays open. It becomes sound once recvmsg holds the so=
cket
lock, which is where stage 1 puts it.

iucv_send_ctrl() has one more defect at that call site, independent of the
locking: five callers, and this is the only one not gated on the transport,=
 so a
classic z/VM socket sends a HiperSockets control frame it has no device for=
. It
sizes the skb via LL_RESERVED_SPACE(iucv->hs_dev), afiucv_hs_send() returns
-ENODEV on a null skb->dev, and recvmsg turns that into IUCV_DISCONN. It ta=
kes
SO_MSGLIMIT set to 1 to get there: msg_recv is only incremented on the
HiperSockets path, so on a classic socket it stays zero and the msglimit/2 =
test
passes only when msglimit is 1. On a guest booted without relocate_lowcore =
the
read through the null hs_dev lands in the mapped lowcore instead of faultin=
g,
which is why I saw a spurious disconnect and not an oops; with lowcore
relocation that read would fault.

> This is a tough one. Maybe we need to add a context parameter to qeth_not=
ify_skbs() ?

Yes, and one of the two obvious candidates doesn't work.

qeth_notify_skbs() has two calling functions. qeth_iqd_tx_complete() reache=
s it
three times and has a single caller, qeth_tx_poll(), so it is NAPI only.
qeth_tx_complete_pending_bufs() reaches it once and has two callers:
qeth_drain_output_queue() with drain=3Dtrue, and qeth_tx_poll() with drain=
=3Dfalse.
The drain path is the only non-NAPI reach, so drain is already an exact
discriminator at that call site and it's in scope there. budget is not:
netpoll calls napi->poll(napi, 0) from atomic context, so budget =3D=3D 0 h=
appens on
both sides. qeth_tx_complete_buf() on the next line passes budget to
napi_consume_skb(), correct there and wrong here.

No single primitive covers both contexts, which is why the parameter is
unavoidable: bh_lock_sock() is a plain spin_lock() on sk_lock.slock with no=
 BH
disable, so it's unsafe from the drain path, and lock_sock() sleeps, so it'=
s
unsafe from NAPI. sk_txnotify is an af_iucv/qeth private pointer, so the
signature change touches af_iucv.h, af_iucv.c and qeth_core_main.c and none=
 of
the four other iucv_handler users.

I also read your reply on Nagamani PV's afiucv_netdev_event() patch, and I =
agree
with the call. The notifier runs in process context, so lock_sock() is avai=
lable
there; the two-line fix closes the traversal use-after-free and leaves
sk->sk_state =3D IUCV_DISCONN and sk->sk_state_change() in the loop body wi=
th no
socket lock. I had that site filed as stage 3, on the assumption it needed =
a
lock chosen for it. Process context makes it the same shape as stage 1 -
lock_sock, owned_by_user, backlog - so it folds into the combined fix.

> That would be great, we are also working on several small fixes. Let's ge=
t them out of the way.

The connack patch is written: bh_lock_sock() in iucv_callback_connack(), th=
e one
site whose context is unambiguous, since connrej and shutdown run in the sa=
me
tasklet and already take it. Fixes: eac3731bd04c - the function has held no=
 lock
since 2007. checkpatch --strict is quiet and it builds for s390x. Which tre=
e do
you want it against?

> Thanks again for working on this. You identified several workitems, are t=
here any
> where you would prefer me or Hidayath to work on?
> Otherwise we will continue with issues that are not on this list and work=
 on
> running and improving our testcases.

You already answered the only thing I would have asked for: you will valida=
te
any revision. The analysis I can do here; z/VM and real HiperSockets I can'=
t,
and QEMU is not z/VM, so machine_is_vm() is false and the classic transport=
 is
not reachable at all. If you would rather own the stage 2 change yourselves=
,
take it.

Thanks,
Bryam

