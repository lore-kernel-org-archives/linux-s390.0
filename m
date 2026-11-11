Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372268;
	b=yk1EJqHF0eOfVxPbBhQHfd1pmGl/NF+sU3pdAwvOTxWPlVejfLytZHyTkZk1KG1e1Xo/
	 2PwPJupHKVDey4c82AwZysxKrW49c76KQinhTDEgdOCjOuYeGQ+IgeA0cdqqJqsfqnO+A
	 XukNxmNuXpOZoJ4ELkyyfNpgv+F3pvNN0L5NJkOA8yMEcd64fayNvh+XBLWQpTCsGY1qn
	 rc2oJS4Ll2EWAWKwi+vubYeheGY16bm/pjfbueHh8yolzyc5xJNWCp7A2ebo/bGIruZRB
	 4wOHQWm8cZOI5Fw91XbLjRWhk4VEqYyDO8+x+1NGdUNZxrFbITEwU5b814teAAYk0bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372268;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=60wkOLRxwahQDdb7KYRUXxAc1j5LBXUHCzcU/h2h5rg=;
	b=dA4N3FTJikOvOe+Af2b8G4mybzhq8vEUuf23/W5Mfyxfwnt1pm+YLji65ILBdheLXo1f
	 OPLiP+tlVtfbYpx3aXMFcMZtLQUQAQfZcXKEOrByI/Cye3fFZkBxCrMhiRLmDWTYZZgZA
	 A93Q2iCreKrxsHImpiHKA0+Vk+0DHF96WiCsDQDTpFVn3dGwvKz6bBpu9nxILv7h+65An
	 Lk5kloACyJuTsmh1oXAt+z/lzUJHGb4oEzoi/sLPYmuG6H1ShPEQgkaBXGBtFBLtWuFuZ
	 TRdXrHLduQz9XvFyy5OIB8JDho1VLMfKWF47l5wA3s4ILuHHKLbNwm6BJun3xHQMxBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw3w7eqK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AF606A320;
	Wed, 11 Nov 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qw3w7eqK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372268;
	b=umvwn5AahJvTZU5K6x7FCuD2cOmkPJvCnSKq8W6NcGgw4DPYOlBDXPdtMzCDeFJk6MeN
	 jwmt72FIM3IxDt6kZFoOG84IYGrAFkORi131hQkvYyE18SQwxH2q3Cwn/bWZE4RNTMIlO
	 lWMhgXoxW4GwO3J8MXlbC1WxTky6VZDiI+4An6jHXSj/+0srMtpWfSAjHjrqoCgywv1Mc
	 LuC4Ff9hI8cSNaBE2m4XaguBO2By+Pwp9nFyvkSFBln1lKFfSXIZjS/JZQ/R89bIdf6P2
	 49RrNoL/x6cnp9Rs2pxi97fW75sPNYC3UCPVdwGbBOoqtoseVors+IP5suaeTRv3RgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372268;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=60wkOLRxwahQDdb7KYRUXxAc1j5LBXUHCzcU/h2h5rg=;
	b=qqMAKvij1deWbR+6h9cYHK+GH2aOdXHxfjanesHA9AnN4UMlovlAxH+5u9MjxHEnLVeo
	 I+H8xBaiJhW6G/O72VEjQrg8qFw0QNMfh/qoW3uocXCRNRaREzEMAJ/AbICogBz4mM2F+
	 W/nSCShRO1bLJvsqij1cpNF/WBOdYQ/t2PmaMtyQHluqihfS9Wwgnme1dRP3CbTBj9Q+x
	 Q4mOlxD0smXouWGGPIdce/ZvvN/ZANKVujOneV7bqpkCmi9HZfQLSmfMtnjjEIP96mie8
	 vPvs+swWb0wfRDGeEzO4xDzhJ8KdkMA4mEc9lUX8zEz/79uGSHJyc2/Q3bvyPzKsPSQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CBD01F0093C;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372268;
	bh=60wkOLRxwahQDdb7KYRUXxAc1j5LBXUHCzcU/h2h5rg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Qw3w7eqK7vQ84TvfQX5lmt4xXnb0ehsl7+dfchF7fcS5UOXbE3sd6yhUQ1UtaHWji
	 KchA5PumJrEA343RYdZ3gcmYDYDwnN6L50vaUdy8k/nB/AmEqVWopu0W0R/DpdvwCV
	 VUkTac2LRh24AA8OY73WaoJhiDoI1xGzwqAAfWWtY27oU4boXiueQwzhtd5ch+Mjp2
	 lzqKrnEcILWncAV+rZKduiDOKu49inLwWnaGHchO+Lr3y+FXKUHh9/XshXBBWsHz9D
	 EHRULG4IiuQpOBld2jabXeVzf+eyhpiPHqZVkFnLwfActQ4yQGM9u5F3S68YTYu+DS
	 S+HBll9NXKrGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E4B0348D8B;
	Wed, 11 Nov 2026 04:44:26 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH RFC net v3 0/7] net/iucv: serialize the HiperSockets
 receive path with the socket lock
Date: Tue, 10 Nov 2026 23:44:25 -0500
Message-Id: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UCShihuBQ/QrbjINFMdF7Fkq
 gildzdtl+9/3ptBuQgrnJsZCn9F5Z0rtIcG+mfMD0ZJlcEZF6y1BsljEh3RxUC+DR7pxM7HI6U
 hGKjaWHiQ35a8QXe9rFvmCe77px96cT+tTViWP7CuZ9KAAAAA
X-Change-ID: 20261110-b4-disp-2a6b4364-b8e24a7bdf60
To: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Hidayath Khan <hidayath@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thorsten Winkler <twinkler@linux.ibm.com>, 
 Nagamani PV <nagamani@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372266; l=10247;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=d8o54/d6kp0nB9hUYYSv7ZxSYzhobD8xf/D0TOg89pI=;
 b=jBQissbIUeCsFBXbhqVYLYl9vpTfCkHyhBWR2gViRBouYLZV1Or1TZH6EMAee1fdYJ8ic53UJ
 oUQKiRbbBBqDzcFMi6vwNR0BN4fnm9Nr0U+9unN7WtWtgPp1f/72UDN
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

v3 of stage 1 of the socket-locking rework [1], cut down as Alexandra
asked in her review [2] of v2 [3]: on net, with nothing under it, and
without the iucv_send_ctrl() rewrite, the window update only while
connected and the credit reset. It also fixes the three items of the AI
review of v2 [4], except the window update after the FIN that the
second one ends on, which is under "Not in v3" below.

  1/7  a msglimit changed while the SYN is out no longer closes the
       socket on a peer that kept to its window, nor stalls that peer
  2/7  sendmsg() fails with -EPIPE when sending is shut down while it
       waits for the window
  3/7  recvmsg() under lock_sock()
  4/7  the frame dispatch and three state changes moved into functions
       of their own, no functional change
  5/7  the HiperSockets rx path under the socket lock: a control frame
       waits for the task that owns the socket
  6/7  shutdown(SHUT_RD) against a frame in flight
  7/7  EOF, not -ENOTCONN, for a reader parked when the peer closes

2/7 and 7/7 are fixes in their own right, here because v2 had them (7/7
was its 2/2). 2/7 applies to net by itself. 7/7 is written on top of
5/7: its two hunks are in functions that 3/7 and 4/7 add.

RFC because one thing is missing that I can't provide. Hidayath,
Alexandra: could one of you run v3 on z/VM the way Hidayath ran v1 [5]?
I depend on those numbers: my setup was tuned against that run, and v3
moves enough code to need one again before this is a PATCH. What I'd
compare, with net as the baseline (the numbers from [5] in parentheses,
on net-next unless marked):

- recvrecv (3917 backwards reads): 0 from 3/7 on
- sk_shutdown (565 of 7281 cycles): 0 from 3/7 on
- shut_rd (32 of 212): as net up to 4/7, 0 from 5/7 on. 5/7 leaves the
  window KCSAN reported on v1 [6], which shut_rd did not hit there and
  hits here only with a udelay() added to widen it; 6/7 closes it
- the blocked reader (-ENOTCONN in 13627 of 13627): EOF in all with 7/7
- rxclose (51 of 906): 0 with 7/7
- SO_MSGLIMIT lowered in IUCV_BOUND (1 message lost in 6297 cycles on
  v1; none on net-next, which has no budget): none lost at any step.
  The budget comes back with 5/7 and counts against the window of 1/7
- KCSAN: of the 29 reports on net-next, the 23 that name
  iucv_sock_shutdown() gone: 19 against recvmsg() and 2 against
  iucv_send_ctrl() with 3/7, 2 against afiucv_hs_rcv() with 6/7. The 6
  between afiucv_hs_rcv() and iucv_send_ctrl() may stay: v3 no longer
  rewrites that function, which still clears and restores SEND_SHUTDOWN
  around its allocation while the softirq tests RCV_SHUTDOWN in the same
  byte. Neither write changes the bit the softirq tests. The hs_dev
  report of the v1 run [6] is not one of the 29; 1/2 of the two fixes
  posted for net on 28 Oct [7] is for it, and is not in this series

My setup is QEMU TCG with an emulated HiperSockets adapter and CP, so
rates and real SMP come only from the hardware, and I have no KCSAN
build of it. Where the two disagree, the hardware is the reference.

Changes in v3 (details below the --- of each patch):

- on net main, with nothing under it. Of the two net fixes [7], 1/2
  applies on top as it is and 2/2 needs a rebase (Alexandra)
- split into seven, as listed above; the EOF in the receive wait went to
  7/7 (Alexandra)
- out: the iucv_send_ctrl() rewrite, the window update only while
  connected, the credit reset (Alexandra), and the purge of
  backlog_skb_q that v2 added to iucv_sock_destruct(), which is not
  about the lock and has no repro
- AI review of v2 [4]: a FIN older than the connection no longer
  disconnects it, and frames behind a recorded FIN are freed (both in
  5/7). A socket connected by a SYN|ACK it never asked for reads with
  msglimit as its window, as on net; v2 gave it a window of 0 (1/7).
  That net connects a socket on such a SYN|ACK is not changed by v3
- connect() applies a reply to its SYN that came in while it owned the
  socket. In v1 and v2 a non-blocking connect() returned -EAGAIN for a
  connection already made, or already refused
- found while reviewing v3 and fixed by it: a MSG_PEEK read that a
  second reader overtakes leaks its skb (3/7), and a SYN for a bound
  socket that does not listen leaks a child (5/7). The second is one of
  the refusal paths Hidayath flagged in August [8]; the others are
  untouched
- one forward declaration is left of v2's two, afiucv_hs_backlog_rcv(),
  which iucv_sock_alloc() installs. It could go if iucv_sock_create()
  installed it and a child copied it from its listener. But
  iucv_sock_alloc() also puts the socket on iucv_sk_list, and I'd rather
  not have one there without its backlog handler. Say if you prefer it
  the other way (Jakub on v1 [9])
- stable: "# 6.18.x" with two prerequisites: aa5ec571b93f for 3/7, and
  f38bce9af9e2 for 5/7, whose backlog queues an skb that has to be
  private. With each picked right before the patch that names it, the
  nine apply and af_iucv.o builds on 7.3.4 and 6.18.63 (built, not
  run). 6.12.y has no sk_drops_inc(), which 5/7 calls, so it and the
  older trees need a backport. Whether 4/7 to 6/7 are stable material
  at their size is for you to say; 1/7 to 3/7 do not need the rest, and
  7/7 as posted needs 3/7 to 5/7
- kernel-doc on every function added, comments in net style and short,
  the labels 3/7 adds are unlock and err_unlock, and each message says
  what is seen, when, and what it costs (Alexandra). The diffstat is
  548+/102- against v2's 444+/125-; 199 of the added lines are
  kernel-doc and comments

Not in v3, and what that costs: five of my 53 default tests (the set v2
was tested with [3]) fail on v3, as they do on net. With the first
three of the pieces dropped above applied on top again, all 53 pass.

- iucv_send_ctrl() still needs room in sk_sndbuf for every control
  frame. With the send memory used up, which on HiperSockets lasts until
  TX completion, shutdown(SHUT_WR) sends no SHT and the peer never reads
  EOF (two tests), and the FIN of NETDEV_GOING_DOWN does not go out
  (one)
- recvmsg() still sends a window update after the peer's FIN, a frame
  nobody uses (one); [7] 2/2 has the test for it
- a window update that finds no room leaves its credit, and the SHT read
  next is counted past the window: WARN_ON() and -EFAULT where EOF was
  due (one). [7] 2/2 ends that by not counting the SHT

net fails three more: two that 2/7 fixes and one that 7/7 fixes. The
dropped purge shows in no test: without it a data frame queued on
backlog_skb_q after __iucv_sock_close() emptied it is never freed, on
net as on v3. That one is by inspection, not reproduced.

Tested on s390x under QEMU TCG, KASAN + PROVE_LOCKING +
DEBUG_ATOMIC_SLEEP, on net main, against the emulated adapter under the
real qeth and qdio drivers and the emulated CP, as v2 was [3]. Two
vCPUs under -icount, which runs one at a time; the race tests also with
seeded short slices, and the two-reader test of 3/7 under MTTCG. No
KASAN or lockdep splat on net, at any step of the series or on the
kernels that follow. Of 20 kernels each with one piece of the series
taken out or changed (2 for 1/7, 3 for 2/7, 1 for 3/7, 10 for 5/7, 1
for 6/7, 3 for 7/7), 18 fail a test the series passes. The other two
show only with a delay added to hold their window open: the one without
6/7's spinlock and the one without the receive-queue test in 7/7's
wait. The numbers are below the --- of each patch. Logs on request.

Still open, as in v2: afiucv_hs_callback_txnotify() and the z/VM
callbacks change sk_state without checking whether a task owns the
socket, and so does afiucv_netdev_event(), whose fix Nagamani is holding
for this series [10]. backlog_skb_q stays unbounded for a peer that
ignores its window. A listener with a full accept queue still leaks the
child of the SYN it refuses (measured on every kernel, numbers under
5/7), and so does a SYN|ACK that fails to go out (by inspection) [8].

Seen while reviewing v3, in net as well and not touched here: on a z/VM
socket iucv_sock_shutdown() updates sk_shutdown under lock_sock() and
iucv_callback_shutdown() under bh_lock_sock(), so either can lose its
bit, and iucv_callback_rx() tests RCV_SHUTDOWN with no lock: 6/7 takes
the spinlock on the HiperSockets branch only. And
iucv_callback_connreq() answers a path request for a listener that
close() is emptying, the race 5/7 closes for a HiperSockets SYN.

[1] https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@proton.me/
[2] https://lore.kernel.org/netdev/2886dcb1-2741-4b29-86e6-dba3ccf2125a@linux.ibm.com/
[3] https://lore.kernel.org/netdev/20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me/
[4] https://lore.kernel.org/all/sashiko-outbox-183527@kernel.org/
[5] https://lore.kernel.org/netdev/51a4a40a-f34b-4d41-b049-69aa53f4dcf5@linux.ibm.com/
[6] https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/
[7] https://lore.kernel.org/netdev/20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me/
[8] https://lore.kernel.org/netdev/5f88daf4-cd8e-4464-b132-ac45be205121@linux.ibm.com/
[9] https://lore.kernel.org/netdev/20261019183223.49a59d6f@kernel.org/
[10] https://lore.kernel.org/netdev/1d9d3cc1-24fb-40e0-a4c7-6fbfbcf4dc37@linux.ibm.com/

---
Bryam Vargas (7):
      net/iucv: keep the window given to the peer in a field of its own
      net/iucv: fail sendmsg() with EPIPE once sending is shut down
      net/iucv: run recvmsg() under the socket lock
      net/iucv: factor out the HiperSockets frame dispatch and state changes
      net/iucv: serialize HiperSockets receive with the socket lock
      net/iucv: set RCV_SHUTDOWN under the socket spinlock
      net/iucv: return EOF to a reader parked when the peer closes

 include/net/iucv/af_iucv.h |   6 +
 net/iucv/af_iucv.c         | 644 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 548 insertions(+), 102 deletions(-)
---
base-commit: 8373c4e8863ac5f5120d200527aca9880330f343
change-id: 20261110-b4-disp-2a6b4364-b8e24a7bdf60

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


