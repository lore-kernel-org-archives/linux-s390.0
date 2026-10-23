Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725294;
	b=qvfWNtETU+ItEb7Mng1KzIUWp7Wf+G2DAmH87oL0q8iAG5KMIeNtGKlhD7Au7kV4SGVD
	 z4Kt6K00ph7I4Dvf5jZ8PwUY+9gUiIt/j2iN8dXs7VHhBPbnS4rfff+tQLq+Y1bjef5Hf
	 Srzyi5RcpOvhv5Ucgn3dpvwpR1cyZ8QToyGyI8I4vrK8tzCo4+As8o/OpHgDVBld8iHIL
	 evSyQ2YqKpmBuhv4IeTNQKJiZawqvsa/0pXt9yuCbOkDBIFofxajQgFvp1ekCpFp0Zhfe
	 k9H3vHzBB7Euli4czX6GEiiF+QIPnrZYAN1AbrnKL5y1TxQhLSo7yYXoiQBNL3TMehg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725294;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XNd/EB0+bcXxQkOLarXx2C6rgzOFzl0BFOVq3KSj2Tc=;
	b=bbCBWwjhev+DALQodid+pRDPNwxc5Rqj81N7b3cswAyI4en09npKXueLZqwObjwMaRfA
	 0LmdBRyaNKRTF+s2diFuRCc62Vw23reS4tTG9CjPu8i+1QLm7gtLoK8AP2NY0k4Q6uVXG
	 1ue/cWfb7rjihvAx0ukE8Etx2oHN2dXSDpRWksskMSXjBqKFCy9KhoEg3yKGgp7Ea2B7x
	 IuWPMkmYzErGG4x1rSDs+grNHVkDkW08cGHwU16ggOsLEricXWRvpBl7opIM8oaAXh9DF
	 dh+YTLTWffgUYkm/Rwt/89EKa7gBjAMFnhKkoo+3nXdiMOUIJtezyXrPcvasfNyhjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZyVSfEYL;
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19C606A31A;
	Fri, 23 Oct 2026 03:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D19C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZyVSfEYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792725289; x=1792984489;
	bh=XNd/EB0+bcXxQkOLarXx2C6rgzOFzl0BFOVq3KSj2Tc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZyVSfEYLr8japIouBJacce8oVcRIlERWX7OpLw9YHCcwsMCB7KLIhDhQDVTcp+USK
	 FX+WYxJQgUZ1wNqcp717bgCtWiJ5aSqKCOMy3TvE6oxrj/N8AzkahjxERTkoaA5/zK
	 8pGpycD1eHPVdVvbNXx1S5yG5i4Hkxq5Pi00Gd9Yvhica+x7ln7Ds398fztNyX18ag
	 2PcHXc75ZDpYH5oMb3Ke6jRJ9nLpg8R5bxBeZVlyim2d+C6HUvwXOoWcQKd1r0JpYT
	 Oa0CndRYPQHfmCfMnMR8nbrdkSoXjZ14ri7K4uwqKN0zVi4XpTTIA4RaEDVjD3J979
	 yyaoEj7UBiyfQ==
Date: Fri, 23 Oct 2026 03:14:44 +0000
To: Hidayath Khan <hidayath@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nagamani PV <nagamani@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/iucv: serialize HiperSockets receive with the socket lock
Message-ID: <20261023031436.1264781-1-hexlabsecurity@proton.me>
In-Reply-To: <51a4a40a-f34b-4d41-b049-69aa53f4dcf5@linux.ibm.com>
References: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me> <82691101-92d7-4838-b16e-2e41a83f65d0@linux.ibm.com> <b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com> <51a4a40a-f34b-4d41-b049-69aa53f4dcf5@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: fc963aa64f7db3302ca9fbdd110acce70a7f0174
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

Hi Hidayath,

Thanks for the three rounds, the KCSAN baseline in particular: 29
af_iucv pairs on net-next, in four kinds; with the patch none of those
four is left, and the two races it did report are answered below as
race 1 and race 2. That is the measurement I could not make here.
Answers to the 14, 18 and 19 Oct mails in one go; the code is in two
fixes for net [1][2] and in the v2 of the series [3].

Blocked reader / rxclose: agreed it is not a corner case. The emulated
setup here reproduces the asymmetry, and I tried both forms: setting
RCV_SHUTDOWN at the FIN gives the blocked reader EOF and poll()
EPOLLRDHUP, like TCP, but leaves the z/VM path (a sever while a reader
sleeps) at -ENOTCONN; EOF in the wait loop on IUCV_DISCONN with nothing
queued covers the sever but not RDHUP. v2 does both: the wait loop
returns EOF (1/2 of the series), the FIN sets RCV_SHUTDOWN (2/2).
Measured here: the blocked reader gets EOF and poll() reports EPOLLRDHUP
with the series; net-next and v1 give -ENOTCONN and no RDHUP; 1/2 alone
gives EOF without RDHUP. The z/VM sever wakes the sleeping reader with
EOF through 1/2's loop, -ENOTCONN without it.

SO_MSGLIMIT in IUCV_BOUND: yes, that is a loss the patch introduces, and
it was the first item of the AI review I still owed an answer to. I
reproduce it as you describe (window advertised as 8, lowered to 2 while
a task owns the socket, the peer sends 8: 3 arrive, 5 are dropped with
SOCKET_BACKLOG). The budget must follow the window we advertised. One
nit on the field: msglimit_peer is the window the peer granted us
(iucv_below_msglim() uses it for our sends); what we granted the peer is
our msglimit when the SYN went out, and nothing recorded it. v2 records
it (msglimit_adv) when the SYN goes out, and on the listener's child
when the SYN|ACK goes out, and sizes the data budget from it; the
msg_recv check in recvmsg() and the window-update threshold read the
same field. In my runs all 8 messages arrive with v2 in the three forms
of the test (the window lowered before the SYN|ACK, with the reader
holding the socket, and with the minimum SO_RCVBUF); v1 delivers 3 of 8
in two of them, and net-next delivers 8 but closes the socket with
-EFAULT in the third, from the recvmsg() check on the lowered window
while backlog_skb_q holds frames. Refusing SO_MSGLIMIT once the SYN is
out would be the simpler rule, but it changes an API that works today
for z/VM IUCV and before the SYN; I left it alone.

KCSAN race 1 (sk_shutdown): that is the window I described as still
there with the patch, and you are right that it is ordering, not the
access width. The frame comes through the bypass under sk_lock.slock
while the task owns the socket; the task sets RCV_SHUTDOWN and purges
without that spinlock, so the callback can queue after the purge. v2
takes sk_lock.slock in iucv_sock_shutdown() around the set and the
purge on HiperSockets (spin_lock_bh(): shutdown() runs with BH on, and
the softirq takes the same lock; a plain bh_lock_sock() there gives a
lockdep "inconsistent lock state" splat, which the run here caught).
With a probe that widens the gap (udelay(50) after lock_sock() and
after the callback's test) 17 to 21 of 200 reads see data after
shutdown(SHUT_RD) without the spinlock, over three seeds, and 0 with
it. Without the probe neither kernel shows it; KCSAN on the hardware is
the test that counts, and a run of yours on v2 would settle it.

KCSAN race 2 (hs_dev): agreed on all three points. It is in net as [1]
with your Suggested-by; say if you would rather carry it yourself and I
will drop it. afiucv_netdev_event()'s read is Nagamani's, in the patch
he is holding for this series.

Budgets (your 14 Oct note) and release_cb(): v2 has one now. A control
frame that arrives while a task owns the socket (SYN|ACK, SYN|FIN, FIN)
is recorded in the socket and applied by the owner from release_cb(),
not queued: the review of v1 found that the backlog drops a pfmemalloc
skb, which qeth hands us under memory pressure, and nothing resends a
FIN. The backlog keeps data frames while the reply to our SYN is
pending, and behind frames already waiting, and a listener's SYNs. So
the control budget is gone with the frames it counted, and a stray can
no longer cost a FIN its place, with a repeated SYN from a conforming
peer or with junk. In both reproductions v2 applies the FIN on release
where v1 lost it; the junk is freed in afiucv_hs_rcv(), nothing waits in
the backlog while the FIN is recorded, and poll() on the held socket
reports nothing until the task releases it. backlog_skb_q is still
unbounded for a peer that ignores its window, there as on net-next; a
bit set in softirq that release_cb() turns into sk_err =3D ECONNRESET and
IUCV_DISCONN is the right approach for that, and yes, send it on top of
v2.

Pure WIN: moot in v2, I think. The FIN is not queued any more, so no
WIN waits behind one; a WIN waits while the reply to our SYN is pending,
when we have sent nothing it could credit, or behind frames already
waiting, for as long as release_sock() takes to run them. (A WIN with
credit travels on data frames -- afiucv_hs_send() sets the flag on them
-- so "pure" would have needed the length test as well.) If you have a
case where a WIN still waits, send it and I will measure it.

The child socket leaked on afiucv_hs_callback_syn()'s refusal paths
(which the list's AI review flagged as pre-existing on v1): that is the
error-path leak you flagged in August [4], and I have left it to your
patch; v2 does not touch those paths beyond the code motion. My run of
it gives the same result on every kernel: 1056 refused SYNs leave 1056
sockets behind (sockstat, and the probe counts 1091 allocated against
35 freed), while the control that accepts its 8 connections frees all
17 sockets it allocated.

SHT accounting: the empty frame is no longer counted, in net as [2];
the same patch drops the WARN_ON on the overrun path, which a peer can
reach from the network.

spin: agreed, prepare_to_wait() once outside the loop is a different
bug; please send the one-liner.

Part of the gap between your numbers and mine was on my side: your
table against the code showed me gaps in TCG's s390x CPU emulation, and
the QEMU here now carries my patches for those besides the HiperSockets
adapter, too specific to this setup to go upstream as they are. Where
the two setups disagree, your hardware is the reference. That is where
v2's delay went.

Four things that would help me match your numbers: the reproducer or
its scenario list, the .config and preemption model, /proc/interrupts
during a run, and the guest's steal (your spin figure looks like ~30%
steal from here).

[1] https://lore.kernel.org/netdev/20261022-b4-disp-b35a9153-v1-1-d74645876=
195@proton.me/
[2] https://lore.kernel.org/netdev/20261022-b4-disp-b35a9153-v1-2-d74645876=
195@proton.me/
[3] https://lore.kernel.org/netdev/20261022-b4-disp-1d26b87a-v2-0-7ee1264d8=
12a@proton.me/
[4] https://lore.kernel.org/netdev/5f88daf4-cd8e-4464-b132-ac45be205121@lin=
ux.ibm.com/

Thanks,
Bryam

