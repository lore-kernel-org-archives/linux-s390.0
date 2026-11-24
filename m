Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490464;
	b=y/2X2SKlRV3p78doQrbJ70MavcAid4gIlZ8bQvMWjQC4C9UN+9kpAcQt71PZA1H9sFja
	 H3jPT8tJ33O1R2M6FGbqIZdSFxxcFWAwbytMxv2T68MwvRBG/cMUEz32ITLPDX3W6vG5c
	 Tv2RXdVrnRiw/sfyjlaL1Nc0IYCI5Uc1SSJ0LurjONhz5lDMCpqHzBXkBj7+n1TVljCf8
	 /xL4QoJfQY77coN3yi3J+8Nv+1e6fczP58UksXbBjO5lI77fDxYr3TKL6EJggFy7rl2/z
	 33w/b6egkLfe2dofyAusRduLdQwt1zL/Id6jTrjHXIoKch4V9fwcoFNNws1/xRlrJdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=dQLdeF9jwjKOm16H9Rh/oCI9s4JuYbrfLxFcAqEQOUI=;
	b=IAi/91JaqfhQ7gnHyez3LSKAv+ljwPfl8deczS72Av8eZzCuhDnkoH4MRAArM+fNAR8t
	 BYJWFfflYpuhVEdI8HN3aEMCB5YlHxNhrrkcAhI1FYgC6E2m1uF3dJlyoccC65fdJR9xf
	 +7G36t80H8l2qa5SXUZ4mu2llm7dKOMNN0CYvpcJKEsih1wqYk3GsZzujNbGcr8G1QzKS
	 DLJUy7P3QMHgLBZBzeUM3hprDhzKud+YYmW6fnlmEoUZQPOrhb1CJBRKlGB3jAJrFS4tm
	 GyZCawMk0GurKqcwXTWCvNlv6KWmc1+H1SLKqyuq4TcstylTvibM7hhLnbqEj+s3rDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tn6/6sCB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC1606A321
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 03:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DFC1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tn6/6sCB
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67db0791748so4493194d50.1
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 19:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490462; cv=none;
        d=google.com; s=arc-20260327;
        b=pG5/gpLm6SJL6i1AJyAcmPvt+QgrpQdJFCdIVTAIt6I+BcIxT2j9LAB8tNNjf3b7px
         LqTcFOcvPJAYpRv3xgiw9Fwn2ugm2Vq5HIKx8ivGPr6FvzBM9WsZIjFZEEPBH46FqFTD
         5OVsNlRinfvSTNn6aa9AWPZLrmpVFwcZccechTBHhhAx5QLJH8rGhmzgBhhlSLdXVr02
         XylHbWbfO4AwL7H86fZD1SxQusObEntXF3k06njyGNFHI/+zT+t7T33qpyGiDRGMkOaV
         o3oFBwO7cU91p87XEddMDn5LL9auaAlsk26VQY27NUp9ysRRq7nwKlmr5g30VeR1Gyyz
         6jbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=dQLdeF9jwjKOm16H9Rh/oCI9s4JuYbrfLxFcAqEQOUI=;
        fh=CnqNAo90pMY/981+nNuggMyYNzaBYtS9wqVLxVyb00U=;
        b=Zq6wIBlKt1nH+BG/XC+mKaDqW3fARgDfq5Qr4UlXX3bQ8Rhosq5WnBQlUy3OfSh40U
         lY/0y5xRrPdAvgHSUfaMKHRBvXzDsvAZHcpMd1Uwu6As5fxHRNsq0Z7rUOSJDL7Rcs2G
         mA5JGqi9C6zJPCFX217o1AFhzZ50C6DsGHyWwP/rNZOG+WyJph5aVLlqmXL4uy6NbZAY
         40U/eSzjDb8DvSVYLCofwTcw96tkVcv2dCTIT1Do9ZB0OEJOCcXr6Sh9oyuy1IaOB4WY
         kB4LqNP7Ry3csmInxcfdta5hSfXbDaNVBcym9nZYJYvdXvTo9cX/DlCuo0RvzWbgZjqq
         /g6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490462; x=1796095262; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQLdeF9jwjKOm16H9Rh/oCI9s4JuYbrfLxFcAqEQOUI=;
        b=Tn6/6sCBM2z1QteltRHf3JVlPrQx1QfFDpcq+nFYZCZOKfU26pOIEZmHkWQ1/o4261
         qdQ+84gC352gwLnCNCXBHpyQ++5rL/jtxYpVIUg55znQSOluEglySt5ZPpldLzDWyFWy
         T9f4enOw8u5dhqq0D/t50vJbPiQ9pvbbRazOfxhn7PsfGv3fDBmXs8ctnCnLjyNOLmZM
         lIjBjfwnpEjS4bE1RyTmnt0CrR9FKrZY7593C3axqBGAkiBatP6piioC7cK0GCBmtjt/
         GSAlWY87t8KPhPEZsjagLz68eiKKxgQsDPVHb/F/C//99as/rjt6n/Zuobk6Ln3ZY9k3
         /8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490462; x=1796095262;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dQLdeF9jwjKOm16H9Rh/oCI9s4JuYbrfLxFcAqEQOUI=;
        b=2iEiAyAR8VdZbczJZlyYHRZ6PxuqK3OiD/OJKTL51oMUo/XI3a9EPuZgONtvB04H0D
         1RR9X1sGXMN0GwhbI3E5isKWgSIjxhwGnoowrlaJXUEeq2NbSZOOEYK71VPkNHrrMBHK
         ujfLAicXk7+ROnu4I7FBeotRE8LsLIGa8ivcWU7yCH4WOWvT+BDUXEZR62MnH1CQT9EO
         +YzBcx4MkNvFiUSxekXUkhULm5iG74w/Oilh0bBE++08fbqtsTYsnuelTuB4F1zSyAaE
         khYbvORkSHDDfnj2lKi30FgpNCWYu3cLWcN6hldZ3Y+uje5lFoYLa+e5IzD43hDfI7bu
         DAnA==
X-Forwarded-Encrypted: i=1; AL+hErFQsxrtg/hXi6/sP5okypCcpd4IY0yWDYgQjCacWzoTse5OBfTiPugcbdlJfp60CDtWeR7jfxB8FyPq@vger.kernel.org
X-Gm-Message-State: APuU4Z9yyaFdNPD4Rd4V81Xl35YfcUfMSVqJAqhM42NrYS7gwaN2CR1+
	zTjXOq6XCF4Vj68zqFSjMgQDeDdQEaioUUlTV20mCEEN1Cm2L9y6gmQ71vzmxP4iWzE7l8olWRo
	Qvp7hdcdkXC+JSsySepAzZtYuzLt6eDs=
X-Gm-Gg: AZFdTZf6/JUDSJeI6FdcfuhFPQ6RQOgTCgiu0ALOApEos/o/g9JSovfXsqwI1fZyIi4
	G0+dEaOqegWukFQFp/BOzuJP9gDSiOoec6MOPL9p9k5+zsT1HT9sum27m5UUavssBcEUtzvoYJ3
	GgM4nt3fqzlrQEJu2+CoaWH4PP0Ikes8wsaENUIwPY9l3u8vqxvzX0j7uXGHFqYc99/Vriy6yZy
	BtMMaUdQsQ21/uAYYauUyNARbFxyV9tWLhBJ+tBmXHjYMDuvMmdPmDzJatdrxBWwAUoSbN92Np5
	H75YD9aV4cUAqREvZKSVp7yCrLyMUS5PmgBO9ccPx8qCzW/nWw/tbh/e2sBntS8Rxfs5ERkO+N0
	kuveq9SnDDv23DKUgCXQVXHDxSudX3nb70uF+
X-Received: by 2002:a05:690e:4852:10b0:67c:664a:9006 with SMTP id
 956f58d0204a3-67df442350bmr3743774d50.64.1795490462283; Mon, 23 Nov 2026
 19:21:02 -0800 (PST)
Received: from 723974502065 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 19:21:01 -0800
From: Qican Ma <goonsomeway@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 19:21:01 -0800
X-Gm-Features: Aa3M54o-isdJh2GWELyKgDAhaVRdXLz0zHe-XJNinNk_CrP5_D5lsQjTiIb73Yw
Message-ID: <CA+OT+ON4Lt9mLvWPK8rUaHKZ01_p0fGCiCsWHwXWzT1sGaTtLA@mail.gmail.com>
Subject: [PATCH net] net/smc: validate peer CDC cursors against buffer bounds
 and window
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

smc_cdc_cursor_to_host() only checks cursor monotonicity and
smcd_cdc_msg_to_host() copies peer cursors without any validation. Neither
verifies that prod.count < conn->rmb_desc->len or
cons.count < conn->peer_rmbe_size, nor that the resulting cursor deltas
stay within available buffer capacity. A malformed or malicious peer CDC
message can therefore:

1. Drive conn->urg_curs.count past conn->rmb_desc->len in
   smc_cdc_handle_urg_data_arrival(), causing an out-of-bounds read from
   conn->rmb_desc->cpu_addr exposed via recvmsg(MSG_OOB).
2. Inflate conn->bytes_to_rcv past conn->rmb_desc->len (either via an
   out-of-range prod.count or repeated wrap increments), causing the
   second chunk iteration in smc_rx_recvmsg() to copy past the end of
   rcvbuf_base.
3. On SMC-D dmb_nocopy links, inflate conn->sndbuf_space past
   conn->sndbuf_desc->len, causing the second chunk iteration in
   smc_tx_sendmsg() to write past the end of sndbuf_base.

Decode incoming CDC messages into a temporary smc_host_cdc_msg and verify
both cursor offsets and their deltas against rmb_desc->len,
peer_rmbe_size, and (for dmb_nocopy) sndbuf_desc->len before committing
the update to conn->local_rx_ctrl.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only; not runtime-tested due to lack
of an SMC-R/SMC-D setup.

Fixes: 5f08318f617b ("smc: connection data control (CDC)")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
 net/smc/smc_cdc.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df32..fd5e296e8be 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -332,14 +332,48 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 {
 	union smc_host_cursor cons_old, prod_old;
 	struct smc_connection *conn = &smc->conn;
-	int diff_cons, diff_prod, diff_tx;
+	struct smc_host_cdc_msg rx_ctrl = {};
+	int diff_cons, diff_prod, diff_tx = 0;

 	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
 	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
-	smc_cdc_msg_to_host(&conn->local_rx_ctrl, cdc, conn);
+	rx_ctrl.prod = prod_old;
+	rx_ctrl.cons = cons_old;
+	smc_cdc_msg_to_host(&rx_ctrl, cdc, conn);
+
+	if (rx_ctrl.prod.count >= conn->rmb_desc->len ||
+	    rx_ctrl.cons.count >= conn->peer_rmbe_size)
+		return;

 	diff_cons = smc_curs_diff(conn->peer_rmbe_size, &cons_old,
-				  &conn->local_rx_ctrl.cons);
+				  &rx_ctrl.cons);
+	if (diff_cons > conn->peer_rmbe_size - atomic_read(&conn->peer_rmbe_space))
+		return;
+
+	if (diff_cons && conn->lgr->is_smcd &&
+	    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
+		if (rx_ctrl.cons.count >= conn->sndbuf_desc->len)
+			return;
+		diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
+					&conn->tx_curs_fin, &rx_ctrl.cons);
+		if (diff_tx > conn->sndbuf_desc->len - atomic_read(&conn->sndbuf_space))
+			return;
+	}
+
+	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
+				  &rx_ctrl.prod);
+	if (diff_prod > conn->rmb_desc->len - atomic_read(&conn->bytes_to_rcv))
+		return;
+
+	conn->local_rx_ctrl.common.type = rx_ctrl.common.type;
+	conn->local_rx_ctrl.len = rx_ctrl.len;
+	conn->local_rx_ctrl.seqno = rx_ctrl.seqno;
+	conn->local_rx_ctrl.token = rx_ctrl.token;
+	smc_curs_copy(&conn->local_rx_ctrl.prod, &rx_ctrl.prod, conn);
+	smc_curs_copy(&conn->local_rx_ctrl.cons, &rx_ctrl.cons, conn);
+	conn->local_rx_ctrl.prod_flags = rx_ctrl.prod_flags;
+	conn->local_rx_ctrl.conn_state_flags = rx_ctrl.conn_state_flags;
+
 	if (diff_cons) {
 		/* peer_rmbe_space is decreased during data transfer with RDMA
 		 * write
@@ -355,12 +389,6 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		 */
 		if (conn->lgr->is_smcd &&
 		    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
-			/* Calculate consumed data and
-			 * increment free send buffer space.
-			 */
-			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
-						&conn->tx_curs_fin,
-						&conn->local_rx_ctrl.cons);
 			/* increase local sndbuf space and fin_curs */
 			smp_mb__before_atomic();
 			atomic_add(diff_tx, &conn->sndbuf_space);
-- 
2.50.1 (Apple Git-155)
