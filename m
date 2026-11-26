Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705586;
	b=hcDeYBJICt39hOlzmUhKk4/moQP9Y9EDylpdVqcaTDpPzU0MG/+jGnyj9jk5tQkZIAdA
	 nH1J0CRPQaH6RMq1HmkyqHrj8u5M03ll4UoZzxxoLikBeyr6PaB1/dlT5TZvYu5vMeTsM
	 MoHWQ+hAc5ze29pdBy+eVuqv3USIRIYVhGffNEEbM+b1Hn4qg4MQcZ8Urmi9GfnB8+KwU
	 aCB8fZkI7v7ErG5rMmIDEiic2TmRykVILXN1Ppnlc5QJu1BygH+HUuWOJ5rZkqJFgJmxj
	 Jxi9IQ/ecYmo0KGIFg45aluI+eNMQvJNPTHvITSszufPyKPigk8kEr30zrKRSYHxUFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+aRn42NYa4Pq+u5LUKua26cG0QzSBuOuVe0hITLGUNs=;
	b=d9+s6HR2+4RSLvW67T/NX3RsqgIE0LHpEe8FbJqldDOFwWfPvI7XCy/jHROqAEeI7stJ
	 I1klGQAxfKp3oIaRYwN75sjeFNx0CJIKRs7Jr9LfJD8Me34A4RAEPOHMKwYDTtN5Tk4/s
	 Jer/6V+1zXfBIZCfd+m0hGJHPx0rr/KuskxBWsAP5D4soZAqD/nL25CjrMuszqklN7k26
	 nNweW2jsEtdW3uoW5to+FeIMYx/IIzflzZIVozh4eYBc4cue3knVEU3acjv1yLN+06DJH
	 iOUuUfDBhd1E34D+EyWl/MDlTuKH3bxRzSRHYA7FIder9Zg5ZN8D6Y2xQlp1nfbzS9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=aFdrxz7J;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C2606A330
	for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 15:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215C2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=aFdrxz7J
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9ae391a05so49540615ad.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2026 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705584; x=1796310384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+aRn42NYa4Pq+u5LUKua26cG0QzSBuOuVe0hITLGUNs=;
        b=aFdrxz7JOo7v6U/alV2jtQL5L4JWnjR0wrbrHI3pYeN3J1UxcyJBrS0RjHbPbyJZhJ
         bY8ASzvbHcpjg/vK3IljclqBCnKmGbkFppJ/BqbqQft31FE9qwfh7BKDPER1WmMHkAff
         dmZfKOwbwmrbrF1EaZRIqDG8VEOR+DndCNK1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705584; x=1796310384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+aRn42NYa4Pq+u5LUKua26cG0QzSBuOuVe0hITLGUNs=;
        b=G6Eo62vbZx1BZ1nrzPQn1dLXD3d5vYfwZRkf9c9RODDY81qTdHDIgomaXnxaorauiL
         zL3GRBhZuBxnUb/okmmHuuvZWSa8oXY7h0qXfcS5iKSD8isuJrVzENtIsMahnCsx5Req
         BHyFozOtl7to5KIVwg+a9e7XOX1UaYPjlNATXD6tP1d8XOg64wSSFOFk9fiHZKJ2pmMD
         JuqEkvO2hTUqJqivOmSLtMZcM9gZHdHmVE9cXj/DjTydnRE+io1OQdunsARz+h8G9vpw
         Wo4KHN7VNWayNjmI0W7phrt1fidDux0omGXoUXC7ftao22mo1+wKww+Gi0c5XvhS7CkF
         +Pow==
X-Forwarded-Encrypted: i=1; AL+hErHy6xr5A5hkVAVmiBbPWY7jbg3XGnGBE1XSfwiUXoCa+TcQEI8wpH8GHuEVEBgYlsx7SM5mcTRyZTof@vger.kernel.org
X-Gm-Message-State: APuU4Z//RdAnKLsM8JOTvNE643grylme5lO1I4IzqSVXFy44jUNwqnxU
	8sQc2bR47apCilpMsx/7Uf4gmU8EanDpnlILlHb+grQSQXiReOMbi+hsUPXfwgbRb/E=
X-Gm-Gg: AZFdTZd1uf7zb5+4on3gi9iWgvFzGN7d39sEgBVVMJx751/Dk9TBKlj8l/KzxByQHqw
	prFLfmkAIZejWy29tZbJ9s7GbxQVx9eGdqq1RKPiCE/PNFcEDcHxMGlV8uHLUDlwFCfBqklbQ6h
	MpkginwMW/kbkKdAMjbiblOFVhVSCGvsB7q5NNesqu7mJ+U8bKPIdEvjHqIdO6HNmRW1+6sU+Xz
	vmsvB0U5MX46NdHteS7r17kd2IN2V7555LX8fZo5TqzmRvT8zMbtRH/E8YYvyeklcMV2RitI0/k
	ZR8ewkd1IUGAlavCfLANEFhOaERxVPQAICZSh6t4yZrGoy1Lab+qUgxKXpzHpbRagqZXFmifE8Q
	RKq/e5PuDPEmXTYVN8nkcLovgIao6c7Z4jfuR63y6NTaM+r3EN1573dcBJWDY8+Z7LF45PP3Urx
	I77Ut1gpI1Prz7TNHR7V63Jwl8cPEfWVKSFDgEKjq/NNZQ10mrvpItaJSrUCzxfoZVtNmMSVxpE
	qCGwrGxI+EurAM0IKQNaicTiyZV6T9XM5owPmidZsavqDKfwcHUfuSs9R543hfqTKgiiTiMAP9l
	aPAsuSJlKSPfkUwLLi33iKd2ES6rOg8aSQtr+BLLiFfaAiTFCLKU/VL0qG3eJlxPKPd1uuiNx/4
	rnCONs1xwApZBAqEU70zxNK4ZjXShpaYzV4/GFRt7gZcURkZnfpeJa4FGFcatYNjF
X-Received: by 2002:a17:903:298d:b0:2f0:3dc0:9bbb with SMTP id d9443c01a7336-2f03f2115e7mr153388725ad.34.1795705584340;
        Thu, 26 Nov 2026 07:06:24 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f146b84sm104231065ad.71.2026.11.26.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:06:23 -0800 (PST)
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
Subject: [PATCH net v4] net/smc: bound the DMB-nocopy send-buffer credit by what was sent
Date: Thu, 26 Nov 2026 20:36:17 +0530
Message-Id: <20261126150617.2113159-1-piyus@iiitd.ac.in>
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

On the SMC-D DMB-nocopy receive path, smc_cdc_msg_recv_action() credits
sndbuf_space from the consumer cursor the peer reported and then assigns
that cursor to tx_curs_fin:

	diff_tx = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
				&conn->local_rx_ctrl.cons);
	atomic_add(diff_tx, &conn->sndbuf_space);
	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
	smc_curs_copy(&conn->tx_curs_fin, &conn->local_rx_ctrl.cons, conn);

The peer writes that cursor into the DMB itself, so under DMB-nocopy the
value is remote input and nothing bounds it.  A cursor reporting more
consumed than this side ever sent raises sndbuf_space past
sndbuf_desc->len, and the assignment moves tx_curs_fin past tx_curs_sent,
breaking the fin <= sent <= prep order the three cursors are documented
with.

The peer can only have consumed what was sent, so bound the difference by
the unconfirmed bytes between tx_curs_fin and tx_curs_sent, and advance
tx_curs_fin by the bounded amount instead of assigning the reported
cursor.  Bounding by sndbuf_desc->len - sndbuf_space would also admit
bytes that are only PREPARED, which would move tx_curs_fin past
tx_curs_sent.

Take the two cursors as snapshots and write tx_curs_fin back as one
cursor.  smc_curs_diff() reads wrap and count with plain loads, and this
runs in a tasklet under bh_lock_sock() while smc_tx_rdma_writes() advances
tx_curs_sent under conn->send_lock, so reading it in place can pair a
pre-wrap wrap with a post-wrap count: the difference then either collapses
to zero, losing the credit after local_rx_ctrl.cons has already moved, or
exceeds the buffer and the bound does nothing.  smc_curs_add() sets count
and then wrap with plain stores and transiently leaves
count >= sndbuf_desc->len, so advancing tx_curs_fin in place would replace
an atomic 64-bit update with a torn one.  smc_tx_prepared_sends() takes
the same snapshots for the same reason.

Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB are merged")
Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
v4: addresses the review of v3
    (https://lore.kernel.org/r/sashiko-outbox-233892@kernel.org)

    The finding is right on both halves, and the remedy is the one it
    names.  v3 passed &conn->tx_curs_sent and &conn->tx_curs_fin straight
    to smc_curs_diff() and advanced tx_curs_fin in place with
    smc_curs_add().  v4 snapshots both with smc_curs_copy(), computes both
    differences from the snapshots, advances the local copy and writes it
    back with smc_curs_copy(), so the cursor update stays a single atomic
    64-bit write and neither read can tear.  The torn read in the diff_tx
    computation predates this series - it read &conn->tx_curs_fin in place
    - and the snapshot closes that too.

    No change to what is bounded or to the bound itself.

v3: bounded the credit by the unconfirmed sent bytes and advanced
    tx_curs_fin by the bounded difference rather than assigning the
    reported cursor.

    How this was found: an AI-driven fuzzing harness built on syzkaller,
    developed jointly by Kapil Vaswani and myself, driving a forged CDC
    stream at an SMC-D link under KASAN on x86_64.  The analysis and this
    changelog were written with the assistance of a large language model
    and checked by hand against the tree; the reproducers in the earlier
    postings were produced by us.  The v4 change comes from addressing an
    AI-generated review of v3 on the list, and the locking and the two
    cursor helpers it described were each read in the tree first.

Link: https://lore.kernel.org/all/179552966151.3135.8162716126718648323@kernel.org/

 net/smc/smc_cdc.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..8f4351e1d4ad 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -333,6 +333,8 @@
 	union smc_host_cursor cons_old, prod_old;
 	struct smc_connection *conn = &smc->conn;
 	int diff_cons, diff_prod, diff_tx;
+	union smc_host_cursor fin, sent;
+	int unconfirmed;
 
 	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
 	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
@@ -358,16 +360,55 @@
 			/* Calculate consumed data and
 			 * increment free send buffer space.
 			 */
+			/* Snapshots, not the live cursors.  smc_curs_diff()
+			 * reads wrap and count with plain loads, and this runs
+			 * in a tasklet under bh_lock_sock() while
+			 * smc_tx_rdma_writes() advances tx_curs_sent under
+			 * conn->send_lock, so reading it in place can pair a
+			 * pre-wrap wrap with a post-wrap count.  Either the
+			 * difference collapses to zero and the credit is lost,
+			 * or it exceeds the buffer and the bound below does
+			 * nothing.  smc_tx_prepared_sends() takes the same
+			 * snapshots for the same reason.
+			 */
+			smc_curs_copy(&fin, &conn->tx_curs_fin, conn);
+			smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
 			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
-						&conn->tx_curs_fin,
+						&fin,
 						&conn->local_rx_ctrl.cons);
+			/* This difference comes from the cursor the peer
+			 * reported, which is taken as it arrives.  The peer
+			 * can only have consumed what this side actually
+			 * sent - smc_tx_rdma_writes() advances tx_curs_sent
+			 * together with the producer cursor the peer sees -
+			 * so bound it by that and advance tx_curs_fin by the
+			 * bounded amount rather than assigning the reported
+			 * cursor.  The invariant below then holds by
+			 * construction, tx_curs_fin stays inside the send
+			 * buffer, and it stays at or behind tx_curs_sent:
+			 * bounding by sndbuf_desc->len - sndbuf_space would
+			 * also admit bytes that are only PREPARED, which
+			 * would move tx_curs_fin past tx_curs_sent and break
+			 * the fin <= sent <= prep order the three cursors are
+			 * documented with.
+			 */
+			unconfirmed = smc_curs_diff(conn->sndbuf_desc->len,
+						    &fin, &sent);
+			diff_tx = min_t(int, diff_tx, unconfirmed);
+
 			/* increase local sndbuf space and fin_curs */
 			smp_mb__before_atomic();
 			atomic_add(diff_tx, &conn->sndbuf_space);
 			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 			smp_mb__after_atomic();
-			smc_curs_copy(&conn->tx_curs_fin,
-				      &conn->local_rx_ctrl.cons, conn);
+			/* Advance the snapshot and write it back as one
+			 * cursor.  smc_curs_add() sets count and then wrap
+			 * with plain stores, and transiently leaves
+			 * count >= sndbuf_desc->len, so in place it would
+			 * replace an atomic 64-bit update with a torn one.
+			 */
+			smc_curs_add(conn->sndbuf_desc->len, &fin, diff_tx);
+			smc_curs_copy(&conn->tx_curs_fin, &fin, conn);
 
 			smc_tx_sndbuf_nonfull(smc);
 		}
-- 
2.43.0

