Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442021;
	b=HoZyQmLqgNeR2jsJ7Kr8oLdDTgOOF4PAcl5+u1cVPADBH4Vwptl49HH7dfURcuN/YZrA
	 tRPRD0gmK3cK3F/13x/ameds9LtOU61D2eRzS5yMCVvYcWaRbMvyr5R/B9b99RfPrc5KZ
	 WfjFXkyeX5VGCcK1btdE9/+EIOWYhCLMC/vVNiO1mhJTU4H9VRg8BjBAF5tp47pGq7y8o
	 IqmpahRg/BNaUgK9VNWZ+CFBnX0+Cfzn2SrZrMuRT9HkPYuAGKQIh9gEZW6ayFhP/jp/r
	 NJAV8//aWBDYb087/gujRsYhbvQHBIdRPIVt+PCSqMoZOz+jqYJ7TP6f2bjp0THMN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJA1Mx+hi1xZ6sMkH8I1j9DsgU9hex1yMjgo0es64EA=;
	b=HmVScqsGgSvIuTaKU4PAhGzUhxXwfgLGOzlXPCy7TDCsusSun3PamY0wlrpS6MDfikRw
	 RiEFgHv2AqppT7d1Luofd5nPcKkRxmGLkSm64z8q6YfQUajLoZ68Nc63kZtSlJurWb2on
	 dTrcLJ4F8FDORBXNwFLk6S3FEaCZRnnR6AeSAfjKrJFboCsi4mvaGThoNAeB+HDLpqywL
	 cj0kKmrKmw9SwMENnSLL58mwhaa+ZrO4MvY3U5WBvEA3LzPOTQODBlLsVzK56RxqWNRUX
	 LJi9/Z8B6wBjtP01wtsMPNU5pqxgoOLU5hvJsbS4YK1FacKMzg3mKMohZ9WGAYnwEiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=U9G5iww3;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B787606A31A
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 13:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B787606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=U9G5iww3
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso2394537b3a.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 05:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795442016; x=1796046816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FJA1Mx+hi1xZ6sMkH8I1j9DsgU9hex1yMjgo0es64EA=;
        b=U9G5iww3ty6df8p3bEjxBTFkMjPtqfsMEV777nVwf+GnIHPsE0VzumR7b2p6hK33Au
         toKp6nAU1vGoGXsE9dxmuSZJLe0I+2jAwBKuMRs9F92eqf2Iy5ZLnGcRJROvYKOnhRmi
         x2kkod4SwwoOwxZ4AVMXkwNSQfoMnBuXB9l0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442016; x=1796046816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJA1Mx+hi1xZ6sMkH8I1j9DsgU9hex1yMjgo0es64EA=;
        b=bh9OX3n9fbplHH9+ukG5lZJcMl3Yu9i4iCQxp3pt0WTsj+ZBhlgV70yPXbO6ITrNlS
         7iZHjaRx6Q7k02ZlEofNAlwXVpRs7SrrCSKWpjmupvPCXC1qfkkZ63MCUn2qGIHgqG7g
         NWAKp14UN4YlhmV5U0wZeVlFg9L5p8hTTBhCv3h8Wbzgi7FaYgTNQ7vdjnAsn+Ye/rgK
         Qx2EW//Xi4Bpwgtt4LMH1Lav9Q5OD+9smBzbnvr9sH7cUGHWfSEijAukdicOHOkebaNZ
         UO0qBAryqaIaw+zdw2Or40aCi5ZrjFcGGnttaRZpbLHgfisgclMWkTvDPqldCRgim26r
         6hRA==
X-Forwarded-Encrypted: i=1; AL+hErGv7K/vUoPBrKnOo4jLgq13438rJ9G/vEBskt+D61gXc4eyvg80ukf5QSgJLLEuwHZEvJfrlqD9wRxO@vger.kernel.org
X-Gm-Message-State: APuU4Z9cmLpcCObznxLZsi4jKkt56wVVVWLyDK1erO57XWXlXFz5whog
	qBpbLhdfzFejJt8gAL6bEYQlVOONl0W92uruK2/qT4NCVapqWJ54+WoC9H8ywcnzXLpOIkrRn0+
	QThwCLuNYAg==
X-Gm-Gg: AZFdTZezwS/YcV/uzWnerGW+jPE2cgxAAi2XuLWfrFYfTijDdbNED1pt3RBX9oRA28r
	x0Dtc0pR209ZbxepoQ9aTDR0f8w7eTIgt8LsJB1WTen+3LPPI6QRpnWTc5IjAxvZMANQIwhQzps
	fr7VQgPBsXazCHxDKgjuz/Fhcy2J5B143KYm1XVeTfIeMlKFEv7kQUKrxWQ/soTMKdxAtk1tN7V
	lfL+BurslG0WoZYP4o0gjCdcxrFsDYmarCN4MJTgOO0FlCnlk1oFtEszHgnptwUFlrhLeIBFX7X
	fIFba+HXrXfDfA7bPBhRukmesnSyZf9s4rREFTsFd+rKjOKZbmAdebRf4tOPNrF7L8MjaiG3nTY
	xII0gn5b62YDIfi2CwLWmDp+JultZ+mtOUhswF74pyKhKIdUCj9qCZUBSggdgyR4NQC84uWVY7Y
	+ZKuMXJrUVsrco5RJK7lEvfhCGIwroCU5o7s2frNG1PzbT4i5LIAi33qbQ4um/IQe+ozl5kl1jR
	Ai1i3A8Xj8Pp1ydBTJWPP1WlzNah7hkg5qyXc+MEg0NEHExPt+kJ8wUZGKyKaKjbiWZM3fsHW1U
	a/jn8mOz6ZifbQdmya+ZtAzdLlJqC5sAzGpKxwqCWOl29td7ctYgVgL8XalsrSFdq1RRU8qJvfu
	3wiqBb105ZSN0fHmUebXurc50H4OTxhHcVciwsG66elCdLJAsmqSUusISjKyt1WJ/9G8QmSFAdW
	0J+rURGfX3AA==
X-Received: by 2002:a05:6a21:62ca:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-4014e35c5a5mr7994102637.33.1795442015677;
        Mon, 23 Nov 2026 05:53:35 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfafsm5713466b3a.50.2026.11.23.05.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:53:35 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: alibuda@linux.alibaba.com,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	netdev@vger.kernel.org
Cc: Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net/smc: bound the failover cursor catch-up by what is outstanding
Date: Mon, 23 Nov 2026 19:23:26 +0530
Message-Id: <20261123135327.3953509-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_switch_cursor() credits conn->sndbuf_space from the consumer cursor
the peer reported, with nothing bounding the amount:

	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);

	if (smc_curs_comp(conn->peer_rmbe_size, &cons, &fin) < 0) {
		diff = smc_curs_diff(conn->peer_rmbe_size, &fin, &cons);
		smc_curs_add(conn->sndbuf_desc->len,
			     &conn->tx_curs_sent, diff);
		smc_curs_add(conn->sndbuf_desc->len,
			     &conn->tx_curs_fin, diff);

		smp_mb__before_atomic();
		atomic_add(diff, &conn->sndbuf_space);

local_rx_ctrl.cons is whatever arrived in the peer's last CDC message.
smc_cdc_cursor_to_host() drops only a cursor that moves backward within
one wrap, so a peer can advance cons.count by nearly peer_rmbe_size and
report consuming data this side never sent.  diff becomes that amount and
sndbuf_space ends above sndbuf_desc->len, which the tx path reads as free
room in the send ring:

	writespace = atomic_read(&conn->sndbuf_space);
	/* not more than what user space asked for */
	copylen = min_t(size_t, send_remaining, writespace);

The first chunk of a two-part write is clamped against the buffer, the
second is not, so memcpy_from_msg() copies past the end of the send
buffer.  The two cursors advanced beside the credit can also leave the
ring: smc_curs_add() subtracts the size only once, so a diff of two
buffers or more leaves tx_curs_sent.count at or above sndbuf_desc->len,
and smc_tx_rdma_writes() uses that count as a source offset.

A peer reaches this path on an SMC-R link group with a second link by
asking for the active one to be deleted:

  smc_llc_rx_delete_link()
    smc_llc_process_cli_delete_link()
      smc_switch_conns()
        smc_switch_cursor()

An honest peer cannot have consumed more than this side has outstanding,
so bound the catch-up by that.  For a correct peer the bound changes
nothing.  For a lying one sndbuf_space keeps the invariant that
smc_tx_sendmsg(), smc_tx_prepared_sends() and SIOCOUTQ in smc_ioctl()
all depend on, and both cursors stay inside the send buffer.

Bounding the credit where it is added is deliberate.  Clamping the copy
length in smc_tx_sendmsg() instead stops the overflow but leaves
sndbuf_space inflated, so the producer never blocks in smc_tx_wait(),
later writes can overwrite data that has not been sent yet, and SIOCOUTQ
reports a negative queue length.

How this was found: by AI-driven fuzzing built on top of syzkaller.  It
reached the overflow through the other writer of sndbuf_space, the
DMB-nocopy credit patched next, on a loopback-ism connection with the
peer's consumer cursor forged by a debug patch: KASAN reported an
869056-byte write past the send buffer in smc_tx_sendmsg()
(use-after-free in _copy_from_iter).  The failover route above was then
found by reading the other writers of that counter; we do not have a
multi-link SMC-R group with two RDMA devices, so that route comes from
the code and not from a run.  The bound was tested on the path we can
drive, where the forged cursor no longer inflates sndbuf_space and the
write stays inside the buffer.

Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.in/

Changes in v2:

 - Corrected the threat model, which was wrong in v1 in a way that matters.
   v1's subject and commit message named the SMC-D DMB-nocopy path as the
   attack.  That path runs only when smc_ism_support_dmb_nocopy() is true,
   which needs a dibs device providing support_mmapped_rdmb(), and the only
   provider in the tree is drivers/dibs/dibs_loopback.c - where both ends of
   the connection are the same kernel and the cursor is written by SMC
   itself.  It is not reachable from a hostile peer.  The remotely reachable
   writer is smc_switch_cursor(), which v1 did not mention at all; it is
   patch 1/2 here.

 - Replaced the fix.  v1 clamped the copy length in smc_tx_sendmsg().  That
   stops the overflow but leaves sndbuf_space inflated, so the producer never
   blocks in smc_tx_wait(), later writes can overwrite data that has not been
   sent yet while sendmsg() reports success, smc_tx_prepared_sends()
   misreports pending bytes, and SIOCOUTQ in smc_ioctl() returns a negative
   queue length.  v2 bounds the credit where it is added instead, and does
   not touch smc_tx.c.

 - Fixed a second fault v1 left alone: the cursors advanced beside the credit
   in smc_switch_cursor() could also leave the ring, because smc_curs_add()
   subtracts the size only once, and smc_tx_rdma_writes() uses
   tx_curs_sent.count as a source offset.  Bounding the difference fixes both.

 - Added Fixes: tags to both patches, each confirmed by blaming the
   atomic_add() in question, and Cc: stable to 1/2 only.  2/2 is unreachable
   on any device in the tree, so by stable-kernel-rules it is not a bug that
   bothers anyone.

 - One patch became two, since the two sites have different Fixes: tags and
   different reachability.

Measured, and not: the overflow and the fix were both measured on a
loopback-ism connection with the peer's consumer cursor forged by a debug
patch - KASAN reported an 869056-byte write past a 65504-byte send buffer
without the series, and with it no report at forged cursors of 100000,
1000000 and 2000000, the credit refused because nothing was outstanding, and
ordinary SMC-D traffic unaffected (SMC_DIAG mode=2, fb_reason=0x0).  The
route to the writer in 1/2 is from reading the code: we have no multi-link
SMC-R group with two RDMA devices, so the LLC DELETE_LINK path to
smc_switch_cursor() has not been exercised here.

The receive side has the same unclamped second chunk in smc_rx_recvmsg(),
credited from the peer's producer cursor; that is a separate patch, "net/smc:
validate the peer's CDC cursors against our own buffers".  The two are
independent: that one bounds cons by peer_rmbe_size, which still permits "I
consumed more than you sent", so it does not bound the credit this series
bounds.
 net/smc/smc_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a3164201c142..436a702f3d8d 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1057,6 +1057,7 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 	union smc_host_cursor cons, fin;
 	int rc = 0;
 	int diff;
+	int sent;
 
 	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
 	smc_curs_copy(&fin, &conn->local_tx_ctrl_fin, conn);
@@ -1069,6 +1070,16 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 		 * fin above, so now prod is smaller than cons. Fix that.
 		 */
 		diff = smc_curs_diff(conn->peer_rmbe_size, &fin, &cons);
+		/* The peer's consumer cursor is taken as it arrives, so this
+		 * difference is a value the peer chose.  An honest peer cannot
+		 * have consumed more than this side has outstanding, so bound
+		 * the catch-up by that: sndbuf_space then keeps the invariant
+		 * the tx path relies on, and the cursors advanced below stay
+		 * within the send buffer.
+		 */
+		sent = conn->sndbuf_desc->len - atomic_read(&conn->sndbuf_space);
+		diff = min_t(int, diff, max_t(int, sent, 0));
+
 		smc_curs_add(conn->sndbuf_desc->len,
 			     &conn->tx_curs_sent, diff);
 		smc_curs_add(conn->sndbuf_desc->len,
-- 
2.34.1

