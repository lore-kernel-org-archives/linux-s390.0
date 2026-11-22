Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795321290;
	b=abseF7Fjx3nqGDCMMsQTfe9z920FYSqv1llKjTW3JPnnHcprnXJIV4nBn37Uzo2v2Nkc
	 mVUKQySGv3Rt+QiZW8FUeecd153s9amxab92QvRBkT3mqEkwLo7NOBcgtRTPT64tQxgaS
	 Kz2nhGuSbuWDHwo8STYmM7Gz+itkcznWdJtfedoRgPNw/N8dqU8dBmplYX9Dw4gC9QmTG
	 IN6LTfBhRrV++RIFzkuG8NGR4dKE27h6SyqjUomPHI7x1UqOLqtU+GIOGojX08fehBcBE
	 IkKtp2wHC+nE+ucTLJMmq22OzsN6/vjhU3gRlV6sQI2aCkqPVRO2Pqtyz3iLCPyhmpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795321290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HJWH9hxOjGLkWCyzc+2OYWRLFu1BzAPngPtrjIxuofY=;
	b=kDC3Nd26sq5fxY1+HnxJrjsf/zeWmzUmry21OvgyfOtbWBYkD0MJVmQLiEIltO9eEOrZ
	 +Yc7/6aRNy/Vyhxw7O+YqXPHDu8sLJCwX4tE6UZIDAvgnbjAyttrNZw5o5myG2H1Ca4jJ
	 Y0uPoeJWh6vt17QjCokfFj0Gx5olitwG3izXPIXtd+OmC52gDOnHeF0unekpyuzgKCxa7
	 gwQF/bpB+eMO+soBfnX3wglIVtTuxan5ZhF/+1/mgBUdo4APAi0SjUQ96Xz7PwBujECBB
	 wAzL+VgY5859HeQAa2N3u8o1FqwI9DCkkh0lYephTr73tDv0rUupXONFfjMhUahtoCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=WDnYFfJo;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8B606A332
	for <linux-s390@vger.kernel.org>; Sun, 22 Nov 2026 04:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B8B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=WDnYFfJo
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1097258a91.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Nov 2026 20:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795321290; x=1795926090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJWH9hxOjGLkWCyzc+2OYWRLFu1BzAPngPtrjIxuofY=;
        b=WDnYFfJomB/kWbXSv6O7VFw9HUzZQwf4GYzRkJ8Q9YIbj0PuamJ7grUC1Hoa81wWPM
         XIq0wXvdKZM2q7s+Ld04jnBAz/Tc1+q47kS5jKgUepxD+auwbwcBXtMLwJLWz4QsZGlg
         ZIUEIYGC1xdoaf+OFn1M/jfl/fNd2hc2tEayM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795321290; x=1795926090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJWH9hxOjGLkWCyzc+2OYWRLFu1BzAPngPtrjIxuofY=;
        b=AuQhRjrH8H2kGunD+fve8YFMUaJA9yjiGB+5QzEFAyA1oRghUz61/eZ2Qv/H9h+4qB
         GrwUvjUtJFEtYC+UbMYfHVOqLJc/sDFf9YFReaRMsT2p5MHLwd/0CQQ3JXc/ttJnfSeF
         BVuakNX+hA3ukiEKNM1fEa6EF1aUhSH7RNwN4SByHEfAkTTmYw4mHDHZvbV2Yz6dw4FS
         LWKPkbfMw8MVtq3LUjcKsZkyN4dYQ3zgqclKleTIJES8maer4RGqdUtR7ORkWaf3EgfS
         eiwft8swrEGzCkZztvouikrxtq8xXJqi54plWmFNRyUWAfTkdoz0TAD/dGFyfgZ/10Wg
         dniQ==
X-Forwarded-Encrypted: i=1; AL+hErH5boiGCpbudujT4zx9XBadyAE35AdNyRYSob0t61x7oQOcPqjNrYkYAjjWOdcTMdRyVu+5ShlXOAWM@vger.kernel.org
X-Gm-Message-State: APuU4Z9Y642C4kRl+ojr/KnJiImE/54FW7yqnznLA4Q6SNA/2J5vP0yM
	w0uIOzOJLFDZWqu4t4TwEXZ8G1DzWgzchynpbF0EN+73+8gbj4Eho1pbbM9IAd3SVvWzH9RHpD9
	3X3q+reI=
X-Gm-Gg: AZFdTZcOC71eUjhcTbP4JvLiR4GKV5Nr8x+c7/mLExl/B4A/ILh+F7WJ96RB9NyKtBC
	1QisASOQ/31jWe1SNcdS7vm8MR2QooqD6gbG4a2V16/lrI/I6oc1xVB1Ijx2Rn8AGXdm3ouFR50
	RWDNTKJ2lXYGwU1yMpZ/CP3uRz3aoXgT264Wu8dGbPd8KKvS/ZrAwo9A0H1s5HF66QtJQ8eG3GI
	54uyde55u8Q4Ff31eSrPySjKoUNgX6oC6db+q/M8yJeZc0QNhPQPXCym7eoBYqkd63rjb736JDn
	b912ipwGNbtMcVa2MCvwCf+JM92pdwPVTforEkLj/SrcQRE1q2vkd341hEjWGsJt8YPOrCh5Fqs
	vOzMeQc3b22VWMNqjSCQsP1toetCzVfBOojUQfwDUQxsXv13Q8uC6Up4NwqaNpb/hyUYp7adgjL
	HuesRuBdFUQNHG2DuAyiWIEYRLu0n5QHxqN0Qynzjzq4qAh6bDg90hVRr+DPVyaCZRVSePJ5Xy0
	XjiJWXdPfL0G2Zzr9ajwG8N23weO25bAu2YQ9677SrZj/69bu1B5lpz5Zp6qlIbotA1ID1bj5zy
	S7AYJw51ekkkB2NoyQHu+7Bnos5crEzVZQeIF8J+VNk5RKC+Zh4J84xXEoGDKx4fv3oT0+bVIMq
	IUisNYLGBnyGBabBdV90PuMCYfoR3l+N4kmm+vBi7wJD01Ye0HuhjYzOkq3bLfrXT
X-Received: by 2002:a17:90a:e705:b0:3ad:3e8:12 with SMTP id 98e67ed59e1d1-3b41cb056e2mr5675261a91.48.1795321289774;
        Sat, 21 Nov 2026 20:21:29 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm13775407a91.16.2026.11.21.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 20:21:29 -0800 (PST)
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
	Piyus Kedia <piyus@iiitd.ac.in>
Subject: [PATCH net v2] net/smc: validate the peer's CDC cursors against our own buffers
Date: Sun, 22 Nov 2026 09:51:20 +0530
Message-Id: <20261122042120.2430434-1-piyus@iiitd.ac.in>
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

A peer's CDC message carries two cursors that are offsets into buffers
described on this side: the producer cursor counts the bytes the peer has
written into the RMB we published to it, and the consumer cursor the bytes
it has taken from the RMB it published to us.  Neither is checked, on either
transport.

smcr_cdc_msg_to_host() and smcd_cdc_msg_to_host() copy both into the
connection as they arrive, and every later user treats them as trustworthy:

 - smc_cdc_msg_recv_action() adds the producer difference to
   conn->bytes_to_rcv under a comment asserting
   "guarantee 0 <= bytes_to_rcv <= rmb_desc->len", which nothing enforces;
 - smc_cdc_handle_urg_data_arrival() reads
   *(base + conn->urg_curs.count - 1), an unbounded index into the RMB;
 - smc_rx_recvmsg() clamps only the first of its two ring chunks
   (rmb_desc->len - cons.count) and uses the remainder unclamped for the
   second, so bytes_to_rcv becomes a copy length;
 - smc_rx_splice() walks PAGE_ALIGN(len + offset) / PAGE_SIZE pages calling
   vmalloc_to_page() without checking the result, and get_page() then
   dereferences NULL once the walk passes the end of the RMB.

A peer that reports a cursor larger than the buffer therefore makes the
kernel read past it.  With a 64 KiB RMB and a forged cursor, KASAN on
7.4.0-rc3 reports a 1-byte read in the urgent-data path and a 131072-byte
read in the receive path, the latter via _copy_to_iter() - i.e. the
out-of-bounds bytes are delivered to userspace by recvmsg() - and splice()
oopses on the NULL page.

Validate both cursors where each transport accepts the message, so that one
test per transport covers every consumer.  Each cursor is bounded by the
buffer its own arithmetic uses: the producer cursor by conn->rmb_desc->len
as in smc_cdc_msg_recv_action(), the consumer cursor by
conn->peer_rmbe_size as in the diff_cons calculation beside it.  A cursor
equal to the buffer length is legitimate (a full ring), so only a larger one
is rejected.  An out-of-range cursor cannot occur in a correct peer, and the
malformed message is dropped like any other.

The SMC-R check sits next to the existing length and sequence-number tests
in smc_cdc_rx_handler().  SMC-D needs its own, because smcd_cdc_rx_tsklet()
reads the cursors straight out of the DMB the peer writes into, in host
byte order and with no validation of any kind on that path today.

How this was found: by AI-driven fuzzing built on top of syzkaller.  Its
analysis was then checked by hand against the code, and all three faults
were reproduced on net.git main under KASAN, with the patched kernel clean
on the same three reproducers and ordinary SMC-R and SMC-D traffic
unaffected.

Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/smc/smc_cdc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df..8d24e0c83 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -433,6 +433,18 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 	sock_put(&smc->sk); /* no free sk in softirq-context */
 }
 
+static bool smcd_cdc_cursors_invalid(struct smc_connection *conn,
+				     struct smcd_cdc_msg *cdc)
+{
+	if (!conn->rmb_desc)
+		return true;
+	if (cdc->prod.count > (u32)conn->rmb_desc->len)
+		return true;
+	if (cdc->cons.count > (u32)conn->peer_rmbe_size)
+		return true;
+	return false;
+}
+
 /* Schedule a tasklet for this connection. Triggered from the ISM device IRQ
  * handler to indicate update in the DMBE.
  *
@@ -452,6 +464,15 @@ static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
 	data_cdc = (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
 	smcd_curs_copy(&cdc.prod, &data_cdc->prod, conn);
 	smcd_curs_copy(&cdc.cons, &data_cdc->cons, conn);
+	/* This CDC was written by the peer into the DMB we published to it, so
+	 * both cursors are peer-supplied and index buffers described on this
+	 * side.  Nothing else checks them, and smc_cdc_msg_recv_action() uses
+	 * the producer cursor as a receive length and the consumer cursor to
+	 * credit sndbuf_space - which under DMB-nocopy is the memory the peer
+	 * itself owns.  Unlike the SMC-R path these values are host order.
+	 */
+	if (smcd_cdc_cursors_invalid(conn, &cdc))
+		return;
 	smc = container_of(conn, struct smc_sock, conn);
 	smc_cdc_msg_recv(smc, (struct smc_cdc_msg *)&cdc);
 }
@@ -466,6 +487,26 @@ void smcd_cdc_rx_init(struct smc_connection *conn)
 
 /***************************** init, exit, misc ******************************/
 
+/* A peer's cursors are offsets into OUR buffers: the producer cursor counts the
+ * bytes it has written into the RMB we gave it, the consumer cursor the bytes it
+ * has taken from the RMB it published to us.  Nothing else checks them.  smcr_cdc_msg_to_host()
+ * copies both into the connection, and from there smc_cdc_msg_recv_action() adds the
+ * producer difference to conn->bytes_to_rcv and the receive path uses that as a
+ * length - so a peer that reports more than the buffer holds makes the kernel read
+ * past it.
+ */
+static bool smcr_cdc_cursors_invalid(struct smc_connection *conn,
+				     struct smc_cdc_msg *cdc)
+{
+	if (!conn->rmb_desc)
+		return true;
+	if (ntohl(cdc->prod.count) > (u32)conn->rmb_desc->len)
+		return true;
+	if (ntohl(cdc->cons.count) > conn->peer_rmbe_size)
+		return true;
+	return false;
+}
+
 static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 {
 	struct smc_link *link = (struct smc_link *)wc->qp->qp_context;
@@ -499,6 +540,9 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 			   conn->local_rx_ctrl.seqno))
 		/* received seqno is old */
 		goto out;
+	if (smcr_cdc_cursors_invalid(conn, cdc))
+		/* peer cursor outside the buffer it describes */
+		goto out;
 
 	smc_cdc_msg_recv(smc, cdc);
 out:
