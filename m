Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705737;
	b=Jof1jVA02547sKqFhG38DLw6y0kkrcDhoqi2bN9v03z/dCXS84NEppUzlWe5is661uu0
	 ZNWSh0NGw7nFLsx6iAdrkQWUPl1fi4aQ4Qc+5LnLX0rPIiJQYWeX6qifNGUgv62g/ZTGJ
	 VZ/sDn6XSMgFTAQovQwG+nEQsKAPTIrvhPlo8KYdiPaP1JwyuKKap46lfRZkWikAhb7vi
	 cu85Ohu2eBpPqlhQewMGGyt4Td6HiH/ilsN6aeddbQaRqju/iFQKbu/cQyX5cHa4QznAu
	 OWD2724jay2Y4phlEVGlVRmyokieMQ7DefmVRm8CSGpxiDUtpUQYACb/ThEaEfQmmbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVNu5zN0GfjJcLk0ITmBm5iF9ko4DWs0+QXPKhhlsvw=;
	b=o7Ib3CgdkSjC32/sCa9ISen0pLiEek7SCXWVreTAk0nL/GufEsQMA5ttMbWB7zsDr0lL
	 zud3PPv4D96i2VdwWlcPce+XhlhL+UCY2nCteuMyywZVhX2mHWBXoBciFcOJCKi8OLUdd
	 n+AvjR/UBmvpjaZBcWeILkde+71LRzanswjCk2CI71xtPINGf4A4fSw7BnPc0OrbV4Twm
	 YUAhURPKO2kfUfJXgMieIkWsMG1jqj5afyzM6i6CjwMJX+uuRP2XVH7jW3EZdRzFgf62F
	 JvRh0e2SOOKCwiOb+aNsNDvhiJ7Ae/3eq2aEJzv+GnP1LYRMpBv5TBfzeTw6093Ylnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=ilUWE0+k;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F5606A339
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 15:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7F5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=ilUWE0+k
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f037bc348dso57029525ad.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705736; x=1796310536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVNu5zN0GfjJcLk0ITmBm5iF9ko4DWs0+QXPKhhlsvw=;
        b=ilUWE0+ksjiPFsIkknjAwDAFR5Q/2+qFUhTjvQHS1N+xk+62U5ubTQXNBsH4FxPaQk
         EjYaG4TXyHR+sLCwe6gBVX2/tXj1VHnjCYWxhQdVjjj28ehEcMMdSpSyVsFbC0R81403
         RTbis2qWf1si+qX/Wl6La6jWdN4p4aL0KnIUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705736; x=1796310536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVNu5zN0GfjJcLk0ITmBm5iF9ko4DWs0+QXPKhhlsvw=;
        b=AXgdcGbtcBEZuxxBqQ6AZVXocyWUHK0Jn28w778t01ouNPAP3zJQ/2Plzi346EpjMm
         74MiytBMUE5TCCqDXic9BskaZ3SDrf3q1R62jUTT63/Qm6ZoRYzZorUF/jaIHOuyQkGP
         Y6CdAiRq8RKH7aBp26IJCHB5UfNyynzmQ2tnVH/nztLhChPZkEGt1CgbPInlSkwonsHp
         WJDH+vARsVSTL+TiV4U0f/nDIZMTXeqWjgt255Wx4s2qoHj796FMbYJhJv5O8+oVfej1
         LICEv/9T3LlOwKTU3Lvuz1gnUCh6lCsjrxKHcCdUV54lev4wnKM3OfUwPPZgRxCuxu4t
         3egw==
X-Forwarded-Encrypted: i=1; AL+hErHcG45FYzVwMXSGP/qxMRgW08noPKji1nL0I4GCR5x2iCSolANIkybOZkY4RxQN/HBoat73+pKx6N3N@vger.kernel.org
X-Gm-Message-State: APuU4Z/I0UamDwyVuGe9ULPKYhF4GXvYD0Lf2cti0sURzoY56RvaKxFt
	Ag4no+nv1zEew5XPfUHJTo/g5llgltP3xNIfif2p9SoERn8nI91MQaibtT+3M43VUlg=
X-Gm-Gg: AZFdTZfoZeRD/baOzOs6Wpa/94YhiBmIhuc6eausbZxluVYbwZMHW+roSJ3bf8splIu
	lOEP3WorGp3CX10YHOOx2HQlHDvqj6zOHwqWDi1T1vIG1A8UpiHKxM87sxhmHmuTsNcHpmDvRcN
	S+fKNnkLNe9dyZVBP199R8/JMBxUTUKpFKEifV3GXX/V2Z28m2D1KjtAWJm0mJaQ3NOTFUiN0FG
	luYq0QLu4cFahcUboO5vC/j7DVvvmYwX3WHZm+ySJe4BrpRq7VW39eQRzHJsb8p/I2yBEhnUtiI
	+6bzcOChRHCdgIx5lT+KUqub5hGBJ7vbjXukzYCCyE90cr7pt6ECQi+pAPSi7Eo/1IWNyAaMi8q
	I8qvRP0Nmb6Bkn7zoQU3F+OdFIDQP829eDfuxFb6jFZ/Uy0ZROEcco/d4FHi5+Misayt/bm+teB
	OHm+N/HKqzHy/r8jcu8RMdQ9Ox2Yp3RLzZFjnkNFV5ZcAsUbWbWOuGYg79V5VaFdIhp5JPMVtBn
	JlmRUILgB4ehjtdrFep3+Z8M0SgC8dbaZm4S6XnXfbfdq31xbgTa/pNR5JY9A3/rpyEyVNq4MG6
	vmtg5Ys1K148Iuy0Fz52nDrIwwEJ6ydDbrGv6lF7ISh170Oi+42qcaY5KwkSDANEX04I7k53tCl
	hxg4kmMMFlHOG3gf0sESRFenCr8KJuLyT30vL1h39VFolVYKTDewapCZg7XE8fxAd
X-Received: by 2002:a17:903:1acc:b0:2f0:a113:4e46 with SMTP id d9443c01a7336-2f0a1134e76mr128224785ad.48.1795705735866;
        Thu, 26 Nov 2026 07:08:55 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0ebsm101836985ad.33.2026.11.26.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:08:55 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kapil@presceralabs.ai,
	stable@vger.kernel.org
Subject: [PATCH net v4] net/smc: drop the connection when the peer's failover cursor is impossible
Date: Thu, 26 Nov 2026 20:38:48 +0530
Message-Id: <20261126150848.2116315-1-piyus@iiitd.ac.in>
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

smc_switch_cursor() repairs the send cursors when a connection moves to an
alternate link, and the repair trusts conn->local_rx_ctrl.cons, which the
peer wrote:

	diff = smc_curs_diff(conn->peer_rmbe_size, &fin, &cons);
	smc_curs_add(conn->sndbuf_desc->len, &conn->tx_curs_sent, diff);
	atomic_add(diff, &conn->sndbuf_space);
	smc_curs_add(conn->peer_rmbe_size, &conn->local_tx_ctrl.prod, diff);

A cursor reporting more consumed than this side ever sent credits
sndbuf_space past sndbuf_desc->len, breaking the
0 <= sndbuf_space <= sndbuf_desc->len the tx path depends on, and pushes
tx_curs_sent out of the ring, which smc_tx_rdma_writes() uses as a source
offset.

Capping diff is not enough: the cap would leave local_tx_ctrl.prod behind
local_rx_ctrl.cons, which is the state this block exists to repair, so
smc_write_space() could return a negative peer_rmbe_space and the
connection would stop sending for good.  A peer that reports consuming
what was never sent has broken the protocol, so drop the connection, as
smc_cdc_msg_validate() does for a sequence number that cannot be honest.

Three things make the cursor impossible, and smc_cursor_cannot_be_honest()
checks all three:

 - cons.count at or past peer_rmbe_size.  smc_cdc_cursor_to_host() does
   not bound it.
 - a difference of peer_rmbe_size or more.  smc_curs_add() subtracts the
   size at most once, so a larger difference leaves
   local_tx_ctrl.prod.count outside the peer's RMBE.  Below peer_rmbe_size
   the repair is exact: prod starts at fin and diff is their distance, so
   prod lands on cons rather than behind it.
 - a difference past the bytes that were SENT and not yet confirmed, taken
   as the distance between two snapshots of tx_curs_fin and tx_curs_sent.

The check runs before anything is rewound, and the connection is dropped
with the cursors as they were found.  Doing it after the rewind is what
would make it unsafe: tx_curs_sent and local_tx_ctrl.prod are set back to
fin at the top of the function, and returning from there leaves prod behind
local_rx_ctrl.cons with peer_rmbe_space still holding the credit the forged
message produced.  The tx path tests conn->killed and
local_rx_ctrl.conn_state_flags.peer_conn_abort, not out_of_sync or the
local_tx_ctrl flag set here, so a send under lock_sock() can reach
smc_tx_rdma_writes() with prod < cons before abort_work gets the socket
lock - and with the wraps differing it takes the dst_len = len branch
without clamping to peer_rmbe_size - prod.count, writing past the end of
the peer RMBE.

Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
Cc: stable@vger.kernel.org
Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
v4: addresses the review of v3
    (https://lore.kernel.org/r/sashiko-outbox-233843@kernel.org)

    All three findings are right.

    - the check moved ahead of the rewind.  v3 ran it inside the fix-up
      block and returned 0 from there, after tx_curs_sent and
      local_tx_ctrl.prod had been set back to fin, which is the window the
      review describes: the tx path does not look at out_of_sync or at the
      local_tx_ctrl abort flag, so a concurrent send could reach
      smc_tx_rdma_writes() with prod < cons before abort_work took the
      socket lock.  Nothing is modified now before the connection is
      dropped.
    - the bound is the SENT bytes, not sndbuf_desc->len - sndbuf_space.
      That counter is the PREPARED bytes, so v3 would have advanced
      tx_curs_sent and tx_curs_fin over data still in sndbuf, and it is
      also where the false positive came from: smc_cdc_tx_handler()
      credits sndbuf_space before updating local_tx_ctrl_fin and this
      holds only send_lock, so an honest completion between the two could
      make diff exceed it.  Both differences now come from cursor
      snapshots, so they are consistent with each other.
    - cons.count and diff are bounded by peer_rmbe_size, which v3 left to
      smc_curs_add()'s single subtraction.

    How this was found: an AI-driven fuzzing harness built on syzkaller,
    developed jointly by Kapil Vaswani and myself, driving a forged CDC
    stream at an SMC-R link under KASAN on x86_64.  The analysis and this
    changelog were written with the assistance of a large language model
    and checked by hand against the tree; the reproducers in the earlier
    postings were produced by us.  The v4 changes come from addressing an
    AI-generated review of v3 on the list, and the tx-path guards, the
    dst_len branch and the two cursor helpers it named were each read in
    the tree first.

Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.in/

 net/smc/smc_core.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..31300ecd6b12 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1030,6 +1030,48 @@
 	return space;
 }
 
+/* Whether the peer's consumer cursor can honestly have reached where it says.
+ *
+ * smc_switch_cursor() repairs the send cursors from conn->local_rx_ctrl.cons,
+ * which the peer wrote.  A cursor reporting more consumed than this side sent
+ * credits sndbuf_space past sndbuf_desc->len and pushes tx_curs_sent out of
+ * the ring, which smc_tx_rdma_writes() uses as a source offset.  Three things
+ * make it impossible:
+ *
+ *  - cons.count at or past peer_rmbe_size, which smc_cdc_cursor_to_host()
+ *    does not bound;
+ *  - a difference of peer_rmbe_size or more, which would survive the single
+ *    subtraction smc_curs_add() does and leave local_tx_ctrl.prod.count
+ *    outside the peer's RMBE.  Below that the repair is exact: prod starts at
+ *    fin and diff is their distance, so prod lands on cons, not behind it;
+ *  - a difference past what was SENT and not yet confirmed.  That is the
+ *    distance between two cursor snapshots, not
+ *    sndbuf_desc->len - sndbuf_space: the counter covers PREPARED bytes, so
+ *    bounding by it would advance the cursors over data still in sndbuf, and
+ *    comparing a cursor difference against it is a race in its own right -
+ *    smc_cdc_tx_handler() credits sndbuf_space before it updates
+ *    local_tx_ctrl_fin, and the caller holds only send_lock, so an honest
+ *    completion in between could make diff exceed it.
+ */
+static bool smc_cursor_cannot_be_honest(struct smc_connection *conn,
+					union smc_host_cursor *fin,
+					union smc_host_cursor *cons)
+{
+	union smc_host_cursor tx_fin, tx_sent;
+	int diff, unconfirmed;
+
+	if (smc_curs_comp(conn->peer_rmbe_size, cons, fin) >= 0)
+		return false;
+
+	smc_curs_copy(&tx_fin, &conn->tx_curs_fin, conn);
+	smc_curs_copy(&tx_sent, &conn->tx_curs_sent, conn);
+	diff = smc_curs_diff(conn->peer_rmbe_size, fin, cons);
+	unconfirmed = smc_curs_diff(conn->sndbuf_desc->len, &tx_fin, &tx_sent);
+
+	return cons->count >= (u32)conn->peer_rmbe_size ||
+	       diff >= conn->peer_rmbe_size || diff > unconfirmed;
+}
+
 static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 			     struct smc_wr_buf *wr_buf)
 {
@@ -1038,11 +1080,33 @@
 	int rc = 0;
 	int diff;
 
-	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
+	/* Before anything is rewound.  Returning from inside the repair below
+	 * would leave local_tx_ctrl.prod behind local_rx_ctrl.cons with
+	 * peer_rmbe_space still holding the credit the forged message made,
+	 * and the tx path tests conn->killed and
+	 * local_rx_ctrl.conn_state_flags.peer_conn_abort rather than
+	 * out_of_sync or the flag set here - so a send under lock_sock() could
+	 * reach smc_tx_rdma_writes() with prod < cons before abort_work takes
+	 * the socket lock, and with the wraps differing that takes the
+	 * dst_len = len branch without clamping to peer_rmbe_size -
+	 * prod.count and writes past the end of the peer RMBE.
+	 */
 	smc_curs_copy(&fin, &conn->local_tx_ctrl_fin, conn);
+	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);
+	if (smc_cursor_cannot_be_honest(conn, &fin, &cons)) {
+		conn->out_of_sync = 1;	/* prevent any further receives */
+		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
+		smc_wr_tx_put_slot(conn->lnk,
+				   (struct smc_wr_tx_pend_priv *)pend);
+		sock_hold(&smc->sk); /* sock_put in abort_work */
+		if (!queue_work(smc_close_wq, &conn->abort_work))
+			sock_put(&smc->sk);
+		return 0;
+	}
+
+	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
 	/* set prod cursor to old state, enforce tx_rdma_writes() */
 	smc_curs_copy(&conn->local_tx_ctrl.prod, &fin, conn);
-	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);
 
 	if (smc_curs_comp(conn->peer_rmbe_size, &cons, &fin) < 0) {
 		/* cons cursor advanced more than fin, and prod was set
-- 
2.43.0

