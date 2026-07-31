Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90B353A92
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481544; cv=none; b=IMc0TZU+q5QcxS7HCQrgavgY2DrC6FSDQSyjeDBa5y//cJe5R2bAkin1ZiePT4iT3BfD1n0i1Z1PblQ5kQb9DFHlIiJWk9QOJlnJGx/yaP1MznwKcNk2Ykysre91Qut+ORj3PFlpV+ikMtu57VvaFWlvHRbmIsOkbTACrUsAFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481544; c=relaxed/simple;
	bh=o8ZLTYxhcXzPRf5S2bPjLwVLXQm4w7mMn2A1mL4EhI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab0h7MqobolXoIDN0jHVUcOVlwDLCWoIyULSqlOu9hkBbBDMDpnHzu+XBB/uLBllysTEOZo0uIxI2kbtlx5unU5aL5jNkU9yUGfjFJdg/s+4ghqFDSUHe23fhWLDDYgPfL4dpqfYx3/mG+Rv2vt1CLQAlzSrSA4ZreL76GI5DZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=GM7jkiP1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="GM7jkiP1"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8484f229529so593985b3a.2
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785481542; x=1786086342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgLt4GkS9rEaQzQpllAATuVO40pAU6qd6YyA7G+85XY=;
        b=GM7jkiP1VhBAfcQWWthw7Opgblz5IBFGvkLxLQwNeK+0E7FNjRx8/GfDX7F1Mx5U9X
         onb82ls7cqlgRSZR03OcA/+soY7YRLC779PzoB9+EHwbUuApeieChoKSlXnEqeCUs0C2
         HhcCO1EvyTNz50LAfHA2kXKBiqadSvhvU0lN9astGv7bahybQ6E0pIbkbE7bWh8NS3A1
         hE81Kfp1yAmSNx+B6/7GiAh+02EwIjNH4BtY1UtW88vz4KIGC5ZwVzjOmEPvurXrHk5E
         ceI1X0uoPcxNywTyXMoG/x1wMITxlVgdsLDkiuT/6lrp2nO9/h+V5FxZe+4W2siSnQtp
         evqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481542; x=1786086342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgLt4GkS9rEaQzQpllAATuVO40pAU6qd6YyA7G+85XY=;
        b=tHI1IQIW5rXZVwo/sSqs4qwmD1IsskiXv4WRxdT6m1YSrPlsdmEC7V6Mb69bTm7YgI
         rXMRNHij4TjGNZGt/iR9zhGi/VCx2rKt0fcNJlnDBPcYPHnIrd39wCysQzRkMuw274hq
         fr3ym31/HqonSbQYlmTAKpiZMCV5vXez8NwElxmVULCd/fISq3hfJm3jb8aqJiWU7zLD
         ylqPhknhDsfadouXtBRZOkK54xvE+tVNvoy7jgjjrRDrgTLlaPcWea/CDq4PA0q9PZAL
         pcrf3RsNIGIU3vDDYJ+XSLq4Kp2pzg2BejZ/8K+ThJlRXOVEOWtBjqhuBOCRkIf/9TSu
         7teQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGEvdg7KvYEcRCaxn6UWdhzHycN0UVfxWdS2Xap8CJk+Z3KOsbb8n/BuwGVcVqtsA3Wii8cX14/Aa4@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnxPLoPPxznqcY/FfzwCgAwYuwxFGOMhpcrJOMzLs1XYiN2CA
	Knj+XCt2xaGdKJK87xYQMp+bWqK7Kt+MZQKxZqfpCV/su9yomI7I2I+OUJLRPuu7YFc=
X-Gm-Gg: AR+sD10ZaZZgW99Df8NfoT4kvJ+02KCOXIPvYb0+3CQIcnbnMEsYWuK9n+kZ9cHE8s+
	xddqmH+UvIK7/11xxz7ah4ks1S8NlUo3PE7DtnXfb5O1dtkj7E8wlpuCeNasODB1p4m0GZzH9QV
	auCgoalT+NpGz3ZX9gWM4qAZzIwUWR3QIynwU+RB/P8FZNBkMI5ySlr8z1TWXQKCDOOl4pPdYcn
	oF1imMLEM7l4vwladyQMJ2QJctES7qUMt8IvAg+j/Sfry344skn2gPZAKd4ahVIgWk6zu1wT2Dv
	Zw0xaR+vDBptP/BtJETdi0z/JOVVla+JMnakVUT7HmZPF2K43LlXkhw89qjkKIEF1GP9MmD1FGY
	hDmC78tsK9rsed4SFmUFio57imvGrNqYZh3+0QujvngUBmBawnnYKpKxWnLa2wx7f7MD0WQT3in
	mPw4z4qQLhMfU7Rp+DdYCzYQNNbv0WEraFlsGgFDjYpkSxmBDYCnPrcBSLFskItzn4TiJH
X-Received: by 2002:a05:6a00:1705:b0:84a:2dcb:5ace with SMTP id d2e1a72fcca58-84ed6f1ef31mr739210b3a.62.1785481541624;
        Fri, 31 Jul 2026 00:05:41 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm39233b3a.40.2026.07.31.00.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:05:41 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v4 3/3] net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry
Date: Fri, 31 Jul 2026 16:05:09 +0900
Message-ID: <20260731070509.1818665-4-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An LLC message longer than the 44-byte union smc_llc_msg arrives either
whole in the receive buffer or split into the link group's shared v2
buffer, and both consumers of the tail rebuild that layout themselves.
Copy the tail into the queue entry instead, so its length and its lifetime
are those of the message that arrived, and declare the rkeys that do fit
inline as a member of the union rather than reaching them through a cast of
a shorter type.

The bound the previous patch placed on links without a shared v2 receive
buffer is no longer needed here: the extension is read from the qentry,
whose length is the length of the message that arrived.

A DELETE_RKEY_V2 is now bounded by what arrived rather than by the buffer
it landed in: a 44-byte message declaring 255 rkeys processed 255 of them
before, and processes the 9 that fit now.

Suggested-by: D. Wythe <alibuda@linux.alibaba.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Measured over rxe with KASAN: a DELETE_RKEY_V2 carrying 12 rkeys over a link
with a shared v2 receive buffer round-trips all 12 values, the last three
coming from the copied tail; 8, 9 and 10 rkeys and a 44-byte message declaring
10 give 8, 9, 10 and 9 processed rkeys respectively.  kmemleak reports nothing
over the link-addition path, and does report the queue entry when the free
added by patch 1 is removed again.

 net/smc/smc_llc.c | 109 +++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 40 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 606d2dc8c7ec..1b153173dd51 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -157,6 +157,7 @@ struct smc_llc_msg_confirm_rkey {	/* type 0x06 */
 };
 
 #define SMC_LLC_DEL_RKEY_MAX	8
+#define SMC_LLC_DEL_RKEY_V2_INLINE	9
 #define SMC_LLC_FLAG_RKEY_RETRY	0x10
 #define SMC_LLC_FLAG_RKEY_NEG	0x20
 
@@ -177,6 +178,15 @@ struct smc_llc_msg_delete_rkey_v2 {	/* type 0x29 */
 	__be32 rkey[];
 };
 
+/* the leading rkeys of a DELETE_RKEY_V2 fit into union smc_llc_msg */
+struct smc_llc_msg_delete_rkey_v2_inline {	/* type 0x29 */
+	struct smc_llc_hdr hd;
+	u8 num_rkeys;
+	u8 num_inval_rkeys;
+	u8 reserved[2];
+	__be32 rkey[SMC_LLC_DEL_RKEY_V2_INLINE];
+};
+
 union smc_llc_msg {
 	struct smc_llc_msg_confirm_link confirm_link;
 	struct smc_llc_msg_add_link add_link;
@@ -186,6 +196,7 @@ union smc_llc_msg {
 
 	struct smc_llc_msg_confirm_rkey confirm_rkey;
 	struct smc_llc_msg_delete_rkey delete_rkey;
+	struct smc_llc_msg_delete_rkey_v2_inline delete_rkey_v2;
 
 	struct smc_llc_msg_test_link test_link;
 	struct {
@@ -194,15 +205,23 @@ union smc_llc_msg {
 	} raw;
 };
 
+static_assert(SMC_LLC_DEL_RKEY_V2_INLINE ==
+	      (sizeof(union smc_llc_msg) -
+	       offsetof(struct smc_llc_msg_delete_rkey_v2, rkey)) /
+	      sizeof(__be32));
+
 #define SMC_LLC_FLAG_RESP		0x80
 
 struct smc_llc_qentry {
 	struct list_head list;
 	struct smc_link *link;
+	u16 body_len;
 	union smc_llc_msg msg;
+	u8 body[] __counted_by(body_len);
 };
 
-static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc);
+static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc,
+			    u32 byte_len);
 
 struct smc_llc_qentry *smc_llc_flow_qentry_clr(struct smc_llc_flow *flow)
 {
@@ -998,23 +1017,19 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 
 static void smc_llc_save_add_link_rkeys(struct smc_link *link,
 					struct smc_link *link_new,
-					u8 *llc_msg)
+					struct smc_llc_qentry *qentry)
 {
 	const u32 rt_off = offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
 	struct smc_llc_msg_add_link_v2_ext *ext;
 	struct smc_link_group *lgr = link->lgr;
 	int max, i;
 
-	/* The extension follows the 44 bytes of the LLC message.  Without a
-	 * shared v2 receive buffer nothing beyond those 44 bytes was received,
-	 * so not even ext->num_rkeys is there to be read.
-	 */
-	if (!smc_link_shared_v2_rxbuf(link))
+	/* the rkey count itself is only there if enough bytes arrived */
+	if (qentry->body_len < rt_off)
 		return;
-	ext = (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
-						     SMC_WR_TX_SIZE);
+	ext = (struct smc_llc_msg_add_link_v2_ext *)qentry->body;
 	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
-	max = min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
+	max = min_t(u32, max, (qentry->body_len - rt_off) /
 			      sizeof(ext->rt[0]));
 	down_write(&lgr->rmbs_lock);
 	for (i = 0; i < max; i++) {
@@ -1108,9 +1123,7 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	if (rc)
 		goto out_clear_lnk;
 	if (lgr->smc_version == SMC_V2) {
-		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
-			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
-		smc_llc_save_add_link_rkeys(link, lnk_new, llc_msg);
+		smc_llc_save_add_link_rkeys(link, lnk_new, qentry);
 	} else {
 		rc = smc_llc_cli_rkey_exchange(link, lnk_new);
 		if (rc) {
@@ -1511,9 +1524,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	if (rc)
 		goto out_err;
 	if (lgr->smc_version == SMC_V2) {
-		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
-			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;
-		smc_llc_save_add_link_rkeys(link, link_new, llc_msg);
+		smc_llc_save_add_link_rkeys(link, link_new, qentry);
 	} else {
 		rc = smc_llc_srv_rkey_exchange(link, link_new);
 		if (rc)
@@ -1564,7 +1575,8 @@ void smc_llc_add_link_local(struct smc_link *link)
 	add_llc.hd.common.llc_type = SMC_LLC_ADD_LINK;
 	smc_llc_init_msg_hdr(&add_llc.hd, link->lgr, sizeof(add_llc));
 	/* no dev and port needed */
-	smc_llc_enqueue(link, (union smc_llc_msg *)&add_llc);
+	smc_llc_enqueue(link, (union smc_llc_msg *)&add_llc,
+			sizeof(union smc_llc_msg));
 }
 
 /* worker to process an add link message */
@@ -1600,7 +1612,8 @@ void smc_llc_srv_delete_link_local(struct smc_link *link, u8 del_link_id)
 	del_llc.link_num = del_link_id;
 	del_llc.reason = htonl(SMC_LLC_DEL_LOST_PATH);
 	del_llc.hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
-	smc_llc_enqueue(link, (union smc_llc_msg *)&del_llc);
+	smc_llc_enqueue(link, (union smc_llc_msg *)&del_llc,
+			sizeof(union smc_llc_msg));
 }
 
 static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
@@ -1822,29 +1835,28 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	link = qentry->link;
 
 	if (lgr->smc_version == SMC_V2) {
-		const u32 rkey_off =
-			offsetof(struct smc_llc_msg_delete_rkey_v2, rkey);
-		struct smc_llc_msg_delete_rkey_v2 *llcv2;
-		u32 buf_len;
-
-		if (smc_link_shared_v2_rxbuf(link)) {
-			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
-			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
-			buf_len = SMC_WR_BUF_V2_SIZE;
-		} else {
-			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)llc;
-			buf_len = sizeof(qentry->msg);
-		}
+		struct smc_llc_msg_delete_rkey_v2_inline *llcv2;
+
+		/* The leading SMC_LLC_DEL_RKEY_V2_INLINE rkeys are declared in
+		 * the message itself, any further ones were received into
+		 * qentry->body.
+		 */
+		llcv2 = &qentry->msg.delete_rkey_v2;
 		llcv2->num_inval_rkeys = 0;
 
 		max = min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
-		/* the rkeys live in the buffer llcv2 points at, and nothing
-		 * beyond it was received
-		 */
-		max = min_t(u32, max, (buf_len - rkey_off) /
-				      sizeof(llcv2->rkey[0]));
+		max = min_t(u32, max, SMC_LLC_DEL_RKEY_V2_INLINE +
+				      qentry->body_len / sizeof(__be32));
 		for (i = 0; i < max; i++) {
-			if (smc_rtoken_delete(link, llcv2->rkey[i]))
+			__be32 rkey;
+
+			if (i < SMC_LLC_DEL_RKEY_V2_INLINE)
+				rkey = llcv2->rkey[i];
+			else
+				memcpy(&rkey, qentry->body +
+					      (i - SMC_LLC_DEL_RKEY_V2_INLINE) *
+					      sizeof(rkey), sizeof(rkey));
+			if (smc_rtoken_delete(link, rkey))
 				llcv2->num_inval_rkeys++;
 		}
 		memset(&llc->rkey[0], 0, sizeof(llc->rkey));
@@ -2085,18 +2097,35 @@ static void smc_llc_rx_response(struct smc_link *link,
 	wake_up(&link->lgr->llc_msg_waiter);
 }
 
-static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc)
+static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc,
+			    u32 byte_len)
 {
 	struct smc_link_group *lgr = link->lgr;
 	struct smc_llc_qentry *qentry;
 	unsigned long flags;
+	u16 body_len = 0;
 
-	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
+	/* V2 messages can be longer than the inline union smc_llc_msg. Carry
+	 * the remainder in the qentry itself, so that its lifetime and its
+	 * length match the message the peer actually sent.
+	 */
+	if (lgr->smc_version == SMC_V2 && byte_len > SMC_WR_TX_SIZE)
+		body_len = min_t(u32, byte_len, SMC_WR_BUF_V2_SIZE) -
+			   SMC_WR_TX_SIZE;
+
+	qentry = kmalloc_flex(*qentry, body, body_len, GFP_ATOMIC);
 	if (!qentry)
 		return;
+	qentry->body_len = body_len;
 	qentry->link = link;
 	INIT_LIST_HEAD(&qentry->list);
 	memcpy(&qentry->msg, llc, sizeof(union smc_llc_msg));
+	if (body_len) {
+		u8 *src = smc_link_shared_v2_rxbuf(link) ?
+			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
+
+		memcpy(qentry->body, src + SMC_WR_TX_SIZE, body_len);
+	}
 
 	/* process responses immediately */
 	if ((llc->raw.hdr.flags & SMC_LLC_FLAG_RESP) &&
@@ -2128,7 +2157,7 @@ static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
 			return; /* invalid message */
 	}
 
-	smc_llc_enqueue(link, llc);
+	smc_llc_enqueue(link, llc, wc->byte_len);
 }
 
 /***************************** worker, utils *********************************/
-- 
2.43.0

