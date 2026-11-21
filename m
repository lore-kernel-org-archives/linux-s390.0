Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289640;
	b=vqzqT8dyUY5IE4sgHwe93bYvFBqj/OmXXEKcccis1pHMNXArkKHQbep8E1REee6xVDI8
	 S94nwof35TiXWlBsw/RxC6icNXrW61IXkVBSaLLBWawgVMer1kH1Bq4Re23d2FTVu9ia3
	 GlxAJFwAUDEaVjJFrgwJ9SkbL1zINVGO/DBQ9caaaYJ9Zz8qQLjUA1Mpv/8s2TLcX58ih
	 h5aAd6d0WghUDv+8DLSZ5Uoi08r4YEjXOgqlq3F6p8ke80M6a4tn/Jo30DOlqmzNwzbjj
	 E+hRPcZRAfYP7lZwu9wumJ3V0rWi3HY6ZWBdgc973mFEP0iWJ072oaqh43IIwmCGs0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qkofz/lYLKL2hpqydjvK6PT32xSgmVVrNto+vh8mHvc=;
	b=jFdBGuB4Aab8fbUA4GVbneBtd0wsoLfJhSkLRUszqe+bEx7sFci5WN8MR9Ej+Soy/gtz
	 UwD7vas9rL85GH7zLYWPl4+10XnkoM28fTQ2XGefKZ+Pzzpl5dMJ7o8ZZ3jri83BLb0fZ
	 tVtq3bkRwc8AXo9O3IJmBB17toMtx2tKysjB5wiTqcIO/VHcEJOb8y0pBIdD8vN8MCDlc
	 qjG+pflZg1Jm8wI5jEPBsiXHwb0DM+oNZC1ML2UjmxdLkpOwFvTajS053mgWFemZEw5SP
	 6qaiGZy3jKqJjU3vDSkU+BUfhm6IG3gRTr5f2OQZKZPiXJH5PZ2p+qF4np0T6ubYIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=B3NvasS5;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AE606A320
	for <linux-s390@vger.kernel.org>; Sat, 21 Nov 2026 19:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 345AE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=B3NvasS5
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso747168a91.3
        for <linux-s390@vger.kernel.org>; Sat, 21 Nov 2026 11:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795289638; x=1795894438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkofz/lYLKL2hpqydjvK6PT32xSgmVVrNto+vh8mHvc=;
        b=B3NvasS5R/IpAlX35qIRffdT3cwwxA+C5KhRyjduvO6OfBM5PoxUFJ34UkMCznsPKs
         +vrKPx8Z0obOdAXYWT4SbfTLGJe+7NSqTR/hbiBns8Q0974IPiWn1HvCs47vQmeAw7BM
         ZQsCXjcTImbsXzOZ+Fx+dPYlnkaFqH7reEVr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795289638; x=1795894438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qkofz/lYLKL2hpqydjvK6PT32xSgmVVrNto+vh8mHvc=;
        b=df+LGxUVfA2Gghv9mzins3sQKD+/0crFnL5Q3Y6KJnEwMOt4DvUvKNISPinIJqB+Gc
         I9LHOcA49V79Ng5aybCN3qT8c11tuaT1CQPQEfaT+YQQRqDuQMW+2shgO5LCGPD9N+ED
         7bkCQqD1d5XFqhn5p/Q8cG0LQLeDJhLUZY+J2P1OcpYD+O9sFCv09IWvaW98UGR75W+0
         lT1S2prJNdnojviUT/Atyl0ucc8Jvr1gggDb4Op+NdZ9grkE/ePDGqKBFgjk8AwWK8O1
         x8aoCuueZVwSDViJRf3x+QtNfaroMmayYyCayvJuHWmXfCNKP+9MXd4tdyPg8LuAT4qF
         G/kw==
X-Forwarded-Encrypted: i=1; AL+hErHWfMtsiqNeH7MXfNe+Do/Z1BP2QYQwXofz4tgc3j6t02Nn0Mr4XpLRovJ7YzIBxHlU90b1ZS2esths@vger.kernel.org
X-Gm-Message-State: APuU4Z9ao3yPC80ss/1Ym80N4ez0wjJpbcVZiIDGjfLVhMhXpnONRuzu
	FNWrxFxF02KoCWKYW41Hv6IWX1MLxtwjafH6FBF4zJB9Hfp1oEeJr2gtP/2cQfI0h0Y=
X-Gm-Gg: AZFdTZdunh3pRLfeWR+h8dZrkVBjh+moGFFblfZ5GhgEMPqokZt4AsgUh5dKmbhfzeu
	AXMYsocm3+zA9hdyUqsjXEcLWUfkFXNZ+5mL+OsOy819ZKU8daK5I/Xle/UxXlHsxkzWcC2eSr9
	DavhtypEc72kjexbOGOoUUQR3guP5+MaTS9zd2aElE8YRufvLwJ8gCihAIg7Vl3mNdWzV1G/Sts
	5OV3KLZzkQzooRk0dZrIvTNJFOpnSry7VFBYso+iJKwIHvrJpk8fDmX1Rfp49uKPlhpwNzcfi/6
	BGPpfNobXbqCUPBpGIJjPBQiiJaNDZeI0XpBpjc+0cFVCj+XVNbLMhzPyeCy/CQWQTNtKrt6A+1
	1opo6dg+G8mjHPTqo/GtVUoXp3oZS1F686RxqRZmk3W0hYpV+3t4D1gUZILIwaGAt6mQCA+qbkG
	M16iOcb3DlkzML0xkb6Uie/ScE642DMjJXjJ6RcTlYDfX8TKQJCXecOxbjgIQM8ZBH2jAFYhWhX
	eGNXE9N6heaZZbPy+W3LhV4f4O3ybajApuPNtsIq1oxyzrZ2JlvzEnRSvBukahIs7l00C7ww5Mz
	95XlOrJ45q+JZO4ns800ECY7tKWTiURkQDh0A1MFvAhu/lKy8tqKK4GA7LCncdFAhAmqpp5zyhA
	YO63uGj0sPn8w60m112DWcBKMC+CViahV3NgNnE7VNHUZAT1mlLuwh5qHTw+gRh/r
X-Received: by 2002:a17:90a:d2c7:b0:3b3:fe22:273d with SMTP id 98e67ed59e1d1-3b41c95b0cdmr6070089a91.41.1795289638560;
        Sat, 21 Nov 2026 11:33:58 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm2686818a91.0.2026.11.21.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:33:58 -0800 (PST)
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
Subject: [PATCH net] net/smc: validate the peer's CDC cursors against our own buffers
Date: Sun, 22 Nov 2026 01:03:45 +0530
Message-Id: <20261121193345.2148966-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121193345.2148966-1-piyus@iiitd.ac.in>
References: <20261121193345.2148966-1-piyus@iiitd.ac.in>
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
it has taken from the RMB it published to us.  Neither is checked anywhere.

smcr_cdc_msg_to_host() copies both into the connection as they arrive, and
every later user treats them as trustworthy:

 - smc_cdc_msg_recv_action() adds the producer difference to
   conn->bytes_to_rcv under a comment asserting
   "guarantee 0 <= bytes_to_rcv <= rmb_desc->len", which nothing enforces;
 - smc_cdc_handle_urg_data_arrival() reads
   *(base + conn->urg_curs.count - 1), an unbounded index into the RMB;
 - smc_rx_recvmsg() clamps only the first of its two ring chunks
   (rmb_desc->len - cons.count) and uses the remainder unclamped for the
   second, so bytes_to_rcv becomes a copy length.

A peer that reports a cursor larger than the buffer therefore makes the
kernel read past it.  With a 64 KiB RMB and a forged cursor, KASAN on
7.4.0-rc3 reports a 1-byte read in the urgent-data path and a 131072-byte
read in the receive path, the latter via _copy_to_iter() - i.e. the
out-of-bounds bytes are delivered to userspace by recvmsg().

Validate both cursors where the message is accepted, next to the existing
length and sequence-number checks, so that one test covers every consumer.
Each cursor is bounded by the buffer its own arithmetic uses: the producer
cursor by conn->rmb_desc->len as in smc_cdc_msg_recv_action(), the consumer
cursor by conn->peer_rmbe_size as in the diff_cons calculation beside it.
A cursor equal to the buffer length is legitimate (a full ring), so only a
larger one is rejected.  An out-of-range cursor cannot occur in a correct
peer, and the malformed message is dropped like any other.

Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/smc/smc_cdc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df..03ff10fef 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -466,6 +466,26 @@ void smcd_cdc_rx_init(struct smc_connection *conn)
 
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
@@ -499,6 +519,9 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 			   conn->local_rx_ctrl.seqno))
 		/* received seqno is old */
 		goto out;
+	if (smcr_cdc_cursors_invalid(conn, cdc))
+		/* peer cursor outside the buffer it describes */
+		goto out;
 
 	smc_cdc_msg_recv(smc, cdc);
 out:
