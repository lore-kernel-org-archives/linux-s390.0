Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD1347537
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125298; cv=none; b=r8/9aHPoxDh+8O+VYIbgWy2KOWDu68D++ZBbtCKJDOeSAaSk5k0C0yg5A9vkfdD6OYFltcSUfBKRAj52z6h9VvDVJRr4Dsli6oE8X85xrLodvwRWpHGwNN2uSEf4f6+mPUwlJXAOaaPnzCvre4zvSa9hDBAf+7or1a0BDLtX/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125298; c=relaxed/simple;
	bh=JrsYXpcyeo2vtFHpIvsas/+QPGxz1jWIaodNwX7XowI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b72Z+51OrG5YyZHiPRiRhN6FN7WWZwArrx6QwfiboG3OGLFCBWF+rinz3HX5EO1Q7KieJ8o05HAnf67LcZNC4QLVDqtETr4uNrlGFSIJasaTfVacPgPlyuXLfnVsNYsNjhjbZ+7+RmBngA2UmIZCnonr1hEYJcSsD6+1gqRiL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKRtvdZ+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKRtvdZ+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2280886a91.2
        for <linux-s390@vger.kernel.org>; Sun, 26 Jul 2026 21:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785125297; x=1785730097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wy9t1vWznuOAOQDWKHxu49XmVkBSgD+heYqFc0DMi2U=;
        b=hKRtvdZ+uCyJnMjcBtQ5NgkNJGhbJuoHsvliZv5Hngm4MJqv0LBohQ7PulMdi5e0pp
         pyahL6pXCMfb3v9py8Qj6Ao/SVLsIRiWV1Vk8HCWrdGfEMh5FFC6tQWEpdbJ7wbLZNnp
         l3rvQB31gBJMYlQLsCBQaPnpnHATlLQZ3HxDvyvwIgu1JXftrwGpIdS0zw/kzJBDxmme
         hD4KcbB15m2Kc/hEiR0Wqg07xzkPh2G/fEatsydzsR1vuKLKtPUhOkFYPGBvHY6ziubs
         U+AXkiKIPqsvNP7Gfx0qXwMBAEITHL9NMVStGHodDDywMoXKXVmo3Zw0ru4gi5j78WUV
         XtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785125297; x=1785730097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wy9t1vWznuOAOQDWKHxu49XmVkBSgD+heYqFc0DMi2U=;
        b=VTS4FjseFvHFMTeAq+KyRHucKYbPuFDk1kWPide8s8C++Op6oqGGHnEk/agC4ZFgf1
         f7m7RpomqeOYNg9s3lTxeYLYebmVkR4gEKHN6AT4R4EmnuVayz1fBhtUfdsO1acFSY3v
         +m2Ka70SvV3c3f1SoMapIk4lu42agx7Bx61nS5jmzgf50EW/G/1dxfeol6bEM7g5iwh3
         IBspzV2e0NkHyCaMKQXIfORhnZpJ7DBiy5FpZ90U6h/opSF3i4XeIBrCOOf9VVUQG8T9
         z2ue05vjQoB2jKdZVCG+XmcxyUQq2nSvQT75ApaMLs/vlNOIHEI8VUIpnSKi2T9NRDkp
         Y8rQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq909CeDviWP+Sc85LFXvS8ewNVvLNVygxuDRJntDp9qc9iLwXZWIzM6/eVJTfSpKDYZDKOhxWbRlOs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqtjyiptrrj6YmrndS8F44Gl6Eg+KrjlW/yfJOsCGsQpqBpEYu
	kkd4a4uItX8ESJJc364QfFBxqYTXH6/OH+X58UPIRTqLIuRJOOHnVJ7N
X-Gm-Gg: AR+sD13QpZHdR8O1scT9IcXEVuMjJ8xYsQfpJUxWcHibsAyf8MrcDVpSYMWkAmiWaIS
	bYhvdh9vrUGL02XtYa/v0zYHZMEQlcfs3hWkkPXlVu7jbV0PCWFRs0ccCxq+0oSYxauLVSjX6np
	k80GbghM+Et+kJBiTkL19VQLMW2/BkZRGPCJ5WWxqczxTUgrvWFaYXtQnSvtyDkJ9KCiuvjbEnc
	E7EAaGCUW3s/cnAOEgneaVmxu2WwlsrL3j06PCBFQUqH7klMpR6EzTp+qEcBRaz9A/1jI1ZCEcv
	i1fYiP1wZyrIHJVE4h3L9sDGMk8NKTnWn9lZaSNeAw6qnn28TH/BVV9LCzYNVQGbFWZIlApnRyH
	vZDUD/u1amVSqQYZ4D+wRBluc0Vtz+qSSq1xOiwWheaA1yngd7fAys+ACuBtsPOgUMGEiPrx5SN
	8pWPM=
X-Received: by 2002:a17:90b:2791:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-38f293cc2eemr6412847a91.6.1785125296569;
        Sun, 26 Jul 2026 21:08:16 -0700 (PDT)
Received: from kali ([58.187.6.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0e976sm4299087a91.5.2026.07.26.21.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:08:15 -0700 (PDT)
From: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
Subject: [PATCH net] net/smc: clamp peer supplied CDC cursors to the buffer size
Date: Mon, 27 Jul 2026 00:08:06 -0400
Message-ID: <20260727040806.1911118-1-nguyenlethanhtung555@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_cdc_cursor_to_host() converts a peer supplied CDC cursor into the
connection's host cursor.  The count field is taken verbatim off the
wire and is only compared against the previously known cursor to
enforce monotonicity - it is never validated against the size of the
buffer it indexes:

	temp.count = ntohl(net.count);
	temp.wrap  = ntohs(net.wrap);
	if ((old.wrap > temp.wrap) && temp.wrap)
		return;
	if ((old.wrap == temp.wrap) && (old.count > temp.count))
		return;
	smc_curs_copy(local, &temp, conn);

On the first CDC message of a connection old is {wrap = 0, count = 0},
so both guards are false for any peer chosen pair and a count of up to
0xffffffff is accepted unconditionally.  A conforming peer never emits
count >= size: smc_curs_add() wraps at the buffer size, which is what
every consumer of the cursor assumes.

The most direct consequence is in smc_cdc_handle_urg_data_arrival(),
which uses the producer cursor as a raw index with no further check:

	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
	if (conn->urg_curs.count)
		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);

That path is reached from the receive path whenever the producer cursor
advances and prod_flags.urg_data_present is set - a single bit copied
verbatim from the wire - so a peer can read at an attacker chosen offset
of up to 4GB from a known heap pointer, far outside the RMB.  The same
unvalidated cursor also feeds the atomic_add() into conn->bytes_to_rcv,
breaking the 0 <= bytes_to_rcv <= rmb_desc->len invariant that
smc_rx_recvmsg() relies on when it computes its second copy chunk.

Clamp count to the size of the buffer the cursor refers to, so that
everything derived from it stays inside that buffer.  The producer
cursor indexes the local RMB and is bounded by conn->rmb_desc->len, the
consumer cursor refers to the peer's RMBE and is bounded by
conn->peer_rmbe_size - the same sizes smc_cdc_msg_recv_action() already
passes to smc_curs_diff() for these two cursors, and which it already
dereferences unconditionally a few lines after the conversion, so no new
pointer is assumed valid here.  The SMC-D path reads the cursors from
the DMB rather than off the wire, but they are equally peer controlled
and reach the same consumers, so clamp there as well.  For SMC-D the DMB
is registered with sizeof(struct smcd_cdc_msg) extra bytes and
buf_desc->len holds the remainder (smcd_new_buf_create()), so bounding
count by rmb_desc->len also keeps the rx_off based dereference inside
the allocation.

Found by code inspection.  The unbounded acceptance was confirmed by
calling the unmodified smc_cdc_cursor_to_host() from a module with
old = {0, 0} and a peer cursor of count = 0x40000000: the value is
copied through unchanged.  Replaying the resulting dereference against a
real 64 byte kmalloc() allocation produces a clean KASAN
slab-out-of-bounds read.

Fixes: 5f08318f617b ("smc: connection data control (CDC)")
Signed-off-by: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
---
Compile tested on 6.8.12 with CONFIG_SMC=m: `make W=1 net/smc/` produces
no new warnings.  The two functions this patch touches are byte identical
in 6.8 and current mainline.

 net/smc/smc_cdc.h | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 696cc11..a71e46d 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -219,16 +219,34 @@ static inline void smc_host_msg_to_cdc(struct smc_cdc_msg *peer,
 	peer->conn_state_flags = local->conn_state_flags;
 }
 
+/* Bound a peer supplied cursor count to the size of the buffer it indexes.
+ * A conforming peer never sends count >= size (see smc_curs_add()), and every
+ * user of the cursor - the byte accounting in smc_cdc_msg_recv_action() and
+ * the direct RMB dereference in smc_cdc_handle_urg_data_arrival() - relies on
+ * that. Nothing validates it, so do it here, once, where the value enters the
+ * connection state.
+ */
+static inline u32 smc_cdc_clamp_count(u32 count, unsigned int size)
+{
+	if (WARN_ON_ONCE(size && count >= size))
+		count = size - 1;
+	return count;
+}
+
+/* @size: size of the buffer the cursor indexes, i.e. conn->rmb_desc->len for
+ *	  a producer cursor and conn->peer_rmbe_size for a consumer cursor
+ */
 static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
 					  union smc_cdc_cursor *peer,
-					  struct smc_connection *conn)
+					  struct smc_connection *conn,
+					  unsigned int size)
 {
 	union smc_host_cursor temp, old;
 	union smc_cdc_cursor net;
 
 	smc_curs_copy(&old, local, conn);
 	smc_curs_copy_net(&net, peer, conn);
-	temp.count = ntohl(net.count);
+	temp.count = smc_cdc_clamp_count(ntohl(net.count), size);
 	temp.wrap = ntohs(net.wrap);
 	if ((old.wrap > temp.wrap) && temp.wrap)
 		return;
@@ -246,8 +264,10 @@ static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 	local->len = peer->len;
 	local->seqno = ntohs(peer->seqno);
 	local->token = ntohl(peer->token);
-	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
-	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
+	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
+			       conn->rmb_desc->len);
+	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn,
+			       conn->peer_rmbe_size);
 	local->prod_flags = peer->prod_flags;
 	local->conn_state_flags = peer->conn_state_flags;
 }
@@ -259,11 +279,13 @@ static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
 	union smc_host_cursor temp;
 
 	temp.wrap = peer->prod.wrap;
-	temp.count = peer->prod.count;
+	temp.count = smc_cdc_clamp_count(peer->prod.count,
+					 conn->rmb_desc->len);
 	smc_curs_copy(&local->prod, &temp, conn);
 
 	temp.wrap = peer->cons.wrap;
-	temp.count = peer->cons.count;
+	temp.count = smc_cdc_clamp_count(peer->cons.count,
+					 conn->peer_rmbe_size);
 	smc_curs_copy(&local->cons, &temp, conn);
 	local->prod_flags = peer->cons.prod_flags;
 	local->conn_state_flags = peer->cons.conn_state_flags;
-- 
2.53.0

