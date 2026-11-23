Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442021;
	b=nq34//GFr/2OUHFXMP0AuDBMjI1uDoC4i+zZc2ouXWp7OAOgvyODcFtygvPgfX0a1fu4
	 Vmg4VkVr7WMNWnHiCjD4NsZeD4w5Hd8X7OROpKQS+Z4nRRV0pcOpLjt27oFzjGe49FVrZ
	 YnBBNImzDCs+GvGnwcx8tFwgAQa34sKuFGWoir8v6Z38k6WbxNcpG8F9aXcuUBeh9exZm
	 LiGakInE3DKBANJrsANZ4kiDbkyHP+XfYkiCS/YIgFwQ6p6z8YIb6dW9N6VPy5dnPedNw
	 tQQLo8fHcflAE4FeG8z2N4urwusDjSEt884BK+LwGAj7nGpsK0XonKA1hghPkwvHJpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Wm3Sj40aRyFsmu65pREyfH1l8+4v7dZwchrk4/0U/TI=;
	b=oGNS6y3PidOqQXNTEGW46wKx0235CDOJLoRWUBLT9NgGUcJ9jYj2XUq/jGGmsLYEQnKR
	 8HnUNz77qG+PSw0b7AFh7YcoxFQuD+hZ+Gx5L4C4OjIBlG+1TzLaVoT+owgTpcubHnEC9
	 Ihfr/qq7L9kbC6lnZEX192ED/VZudkoF/yeQZmia5nUobCkVMQGwkqHd+hGzPjDLeKVN/
	 xk6lIPtSUuIUguJgYHvXKA964lzOoaILbgKWSnS0L94D2FDhq3YgN7BRY2Upp4j2O+tuY
	 wgqbqOjYVMsuL18Cxc3eeSkF6bSDIaC2SYbGa3/Aj6Ej3V9voNp7HDdWWVblhFjMynw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=YF6GU2Mf;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A4606A32C
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 13:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C52A4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=YF6GU2Mf
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so1231169b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795442020; x=1796046820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wm3Sj40aRyFsmu65pREyfH1l8+4v7dZwchrk4/0U/TI=;
        b=YF6GU2MfzFL+xw6V4/1FgEhvCJ+SGtt7ZwKiCq76seKeW2U+Gmqpj4vH03OMUyVDDn
         bbKQCoH9Sz4bpDHyQY8LdxiQudYEt4WlhgauW4/H9O1bFOZxObOgqoLBVjW1cnxmAi/j
         UBvrOYUztODKaN999/b5ZgmkvhcpiB4UKNcEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442020; x=1796046820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wm3Sj40aRyFsmu65pREyfH1l8+4v7dZwchrk4/0U/TI=;
        b=kyb5einoOIP/QkYXypViBYScroqyGOex1K1CrUFaeGbfSrkbaugZOp60GfXiygwUVX
         OVfRZMSoLv5oJq02ORn3GDtsrmRjBDFC/+4/M6UPJLqwdXWJTZbJKGSfFh3ZOmqFKrwQ
         dn8aQc6jX6/wVVN0/+xpLyJvhaOsev9S1g5f592BIMSOplBOVXjG8ofXdwjit/qpcZO/
         vGgXBJ9cM2UosBpZ885TiP9pQIbXGlcA+c55yxI+cM16GujP0IOHVA8U5dk4LQN7d8ex
         7zGRR8V4Ss/gGY2JdlT+D8hCOb6g1kF1QY/uXMpUxM/fVKFOGFzcYHCD3rZ4r18ofUdA
         /sRA==
X-Forwarded-Encrypted: i=1; AL+hErHyagZ6Rg7E933SWwJNUwSC3uHnvAiP6dGatVGVGeGLCaahwArQD5TR9bwqCaiTvzk8dXjRYUeobn3C@vger.kernel.org
X-Gm-Message-State: APuU4Z+rkodmaQPgPLafMo75eTJiz8SkhuCFIlQUjHnzJ3wF2x/v7M7g
	WtCN24aORQ3XmV4gyyhQh0pfZ9pnqHpgjqxCkW2XPGGprxY95zkgQ+EsG+wVmEA0m/k=
X-Gm-Gg: AZFdTZe8JQfBQ77DDpSPFcb6oH3JaYybRruhPFHplDgvSbC+ESUC5k2RQ0FQGwOymKm
	zNiKs5Q9GjySHb1QqUBqhDgQO3nBsuPdSZjuJvs62Mhh5KW9Zfj6YCyWfuqE8BQdLs9t5q+vz5j
	J/sYDFJahEr0c1CKw4ehd9teAfi4w/FlipGm+yWr8yhhv7iajNcsQ9Aya3xlRSAMTbgQv72nkX4
	GJfHyZ7YgYfPonUmUm6tqyDZhFj9ToZgIABd97cNXxIVGgE2GRZr3FI8nsew+p2wwuF18x6xWxp
	IgKzQDIWiQg5JjdKTf9cYTFwoxZaVYFRK0dxNsyUEvXXLSc9BPQZjUnLcDaGEeD++Qs0qBo7ykJ
	fSltPSMaYoZ898I3kxUHoHa/hVlHwSg4/S4zPaVZ3cbDOBRQn6Ntunq6vyHD//MhNbSulIHiffQ
	LIfUB98qAGwHibo7E6l5AGHyFvFFfMqtAUf3VQim+E+FS6ENytQkj7KVjlpBQty8GgLxEZ9vMFd
	cdjE9WOnqawj9r5osA3aJ2KkZ0o0ctkCMO4yGxGgHl/hKa+3Vvxd6lXLQ1b62DaS8pCixpo+PLY
	7+CGH0tJjtU2XCronjf8AaRIW8bvrgPQWkIKaUhOs3WLxP/iAmESbaajbC2z98Nud7r2q3HWWpr
	qvigBQrexnYKhOr/9WQB8M4DQAlWwIuAfif/REdnkyeRVeapYMVcfeCtJEYuTrRxdYA8SfOlh2D
	VeFLb00I+Cmg==
X-Received: by 2002:a05:6a20:d10f:b0:3eb:9c9f:8b8e with SMTP id adf61e73a8af0-4014e74d04cmr10179615637.92.1795442020015;
        Mon, 23 Nov 2026 05:53:40 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfafsm5713466b3a.50.2026.11.23.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:53:39 -0800 (PST)
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
Subject: [PATCH net v2 2/2] net/smc: bound the DMB-nocopy send-buffer credit as well
Date: Mon, 23 Nov 2026 19:23:27 +0530
Message-Id: <20261123135327.3953509-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123135327.3953509-1-piyus@iiitd.ac.in>
References: <20261123135327.3953509-1-piyus@iiitd.ac.in>
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

smc_cdc_msg_recv_action() credits sndbuf_space from the peer's consumer
cursor on the SMC-D DMB-nocopy path and then assigns that cursor to this
side's tx_curs_fin:

	diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
				&conn->tx_curs_fin,
				&conn->local_rx_ctrl.cons);
	/* increase local sndbuf space and fin_curs */
	smp_mb__before_atomic();
	atomic_add(diff_tx, &conn->sndbuf_space);
	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
	smp_mb__after_atomic();
	smc_curs_copy(&conn->tx_curs_fin,
		      &conn->local_rx_ctrl.cons, conn);

sndbuf_space can already be non-zero when this runs, so the sum can
exceed sndbuf_desc->len and the comment asserting otherwise does not
hold; smcd_cdc_msg_to_host() takes the cursor in host order with no
validation, so tx_curs_fin can also be assigned a count outside the send
buffer.

Unlike the failover path in the previous patch this is not reachable from
a hostile peer today.  The branch runs only when
smc_ism_support_dmb_nocopy() is true, which needs a dibs device providing
support_mmapped_rdmb(), and the only provider is
drivers/dibs/dibs_loopback.c - where both ends of the connection are the
same kernel and the cursor is written by SMC itself.  So this is
hardening rather than a fix for an observed attack: it keeps the
invariant in the comment true by construction, keeps the cursor inside
the buffer, and stops a future device that implements the op from
inheriting the problem.

Bound the credit by what this side has outstanding and advance
tx_curs_fin by the bounded amount instead of assigning the reported
cursor.  For a cursor that reflects real consumption both are the value
that is used today.

How this was found: by AI-driven fuzzing built on top of syzkaller, on a
loopback-ism connection with the peer's consumer cursor forged by a debug
patch so that it reports consuming data this side never sent.  KASAN
reported an 869056-byte write past the send buffer in smc_tx_sendmsg()
(use-after-free in _copy_from_iter).  With this patch the same forged
cursor credits nothing beyond the outstanding bytes.

Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB are merged")
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.in/

This is 2/2 of a two-patch series; there is no cover letter.  The v2
changelog is under the --- line of patch 1/2, and in short: v1 was a single
patch that clamped the copy length in smc_tx_sendmsg() and named this
DMB-nocopy path as a remote attack.  Both were wrong - the clamp left
sndbuf_space inflated, and this path is reachable only on loopback-ism, where
both ends are the same kernel.  v2 bounds the credit at both sites where it is
added; this patch is the hardening half.
 net/smc/smc_cdc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..9ffa3e422aa1 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -333,6 +333,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	union smc_host_cursor cons_old, prod_old;
 	struct smc_connection *conn = &smc->conn;
 	int diff_cons, diff_prod, diff_tx;
+	int sent;
 
 	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
 	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
@@ -361,13 +362,26 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
 						&conn->tx_curs_fin,
 						&conn->local_rx_ctrl.cons);
+			/* This difference comes from the cursor the peer
+			 * reported, which is taken as it arrives.  A peer
+			 * cannot have consumed more than this side has
+			 * outstanding, so bound it by that and advance
+			 * tx_curs_fin by the bounded amount rather than
+			 * assigning the reported cursor: the invariant below
+			 * then holds by construction, and tx_curs_fin stays
+			 * inside the send buffer.
+			 */
+			sent = conn->sndbuf_desc->len -
+			       atomic_read(&conn->sndbuf_space);
+			diff_tx = min_t(int, diff_tx, max_t(int, sent, 0));
+
 			/* increase local sndbuf space and fin_curs */
 			smp_mb__before_atomic();
 			atomic_add(diff_tx, &conn->sndbuf_space);
 			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 			smp_mb__after_atomic();
-			smc_curs_copy(&conn->tx_curs_fin,
-				      &conn->local_rx_ctrl.cons, conn);
+			smc_curs_add(conn->sndbuf_desc->len,
+				     &conn->tx_curs_fin, diff_tx);
 
 			smc_tx_sndbuf_nonfull(smc);
 		}
-- 
2.34.1

