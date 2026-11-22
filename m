Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795325556;
	b=3okSommqLoeOc2S1PrzVJiRgWquIciBRfv3K9ZexuvU1QrQUuNuoeLK7jg0lgwmrLLlE
	 SwjPP6Bh74F4v/zZzPBI0vWCwgAvjUH/b3oNPj9A4IK7DVNWMIM3VdKaJUGJrKtxXmmSR
	 o5TS9uuko4ccHLDvYFpmh2tVvLeht9V+mpoSfxH/JI5rnIwrWeHeQI4vIoPOc5hyDiDcy
	 KjiYqP9O4cCBiagFe/E0sQvAVmEuS5CWj1zbvfimJRXoqxd7MVJZkB+3QyMuQmEQvzeVR
	 X9AeCTI/Diol6iV0dHXOtrtaSr9dm49a///6U+rHv6ZsRPAiC0UL+pFi5pV9lDLxszg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795325556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=me3WsNLpXOGi8AyO4bI1Q8J5wDfbd+89c9dLbnje7nk=;
	b=uyNdbTc7BRWiEFhD7tCieoNK/CdSzfY6UVRsKMSSxewTxn+9qXkJvS0idayKk9vimDe4
	 F60A48wSFTdZ/MNAz+lHlN7D7KcEMqqAQ6sDI8Lzas6wRoZiizESiyY0TdCQtkYLMQeJW
	 7XQMHhpUgNumn1AFcyQQn/OBTYTxKtiiHlIGd+AepDCl4tY0MekRSeuFbR040YSvJoM74
	 PYWJMvZyn10GTwambKGgDuxyiK0g7J809dPyT68zirqmd5iXO5WFYUY7D60PQV9mFo5Or
	 01x3MYvCP2O0Pofxn05KgxHDE8RNd0bFxoZVh6hPbWMbqbQ3JJA6p6QngbtOs4A5Dsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b="I0/L9b2N";
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48052606A684
	for <linux-s390@vger.kernel.org>; Sun, 22 Nov 2026 05:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48052606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=I0/L9b2N
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2127303a12.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Nov 2026 21:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795325555; x=1795930355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me3WsNLpXOGi8AyO4bI1Q8J5wDfbd+89c9dLbnje7nk=;
        b=I0/L9b2NAEt9spob3UTfZkfqR7v0oKiQ3pwcYAoqWy/eyYJhdrShvSaa9i3f7TqQW8
         qVMEC0hzQhmJcnnWDIfjNwe3BuEw43U8pqnvODNXrs89EAZ9UGThfCVncEul77NQcZek
         VaQ0cWDFpdxNKnAWqAU+gtQAsNPvqr+ErR3OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795325555; x=1795930355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=me3WsNLpXOGi8AyO4bI1Q8J5wDfbd+89c9dLbnje7nk=;
        b=0ZKAzxTp4wq376jlwbb4a5TJT8VEJpgCjNU9mgDVav48OeVB1tTnWsWEKUslCC04uO
         fEys6Lks/qABOpnWJy3exsUIY731NNQFbRxP9UZ851BfDMra7LNXX2vnJZLOgJOm64mz
         BSZ83h/YG36JK3ZbsCuX+OVpEPea5ts2KNdGKxyp7+79FWvgH/jZo9X2o8aWy1OwpWD1
         dpceKHdENhpbpkJ4QbcTWRzkbTEWQRWc0aLpokeS/0wj3NwI+cMV+JPvWguMC2KB5vA/
         UeAvzNPv7RGbVjcDtAiuaOq8NK1ZlDusvqPr0C9LK1ORRUy5R9MuqUg9mN8Hd6ugL4b5
         DWtA==
X-Forwarded-Encrypted: i=1; AL+hErGZOeCzPZtSwPvZZmGYKBy/6k0jUHqOdRJwUZjInHlvllqYUbFABXfp5iQ7cy/DekPCwhlElngKc+CS@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jo1twhBGwyR8JcJuiYb9iFLPVyaxGdhkaZRC1ZXXf7Vm0rbcF
	tZSb3mKBs6ELq9iSezKUHekeRMt5+GsCMab0LZQkHXDdbDsyjqStspCG6haYXqh/O64=
X-Gm-Gg: AZFdTZc+Ubxasq/ClX+x+QU9TcpOdD8wEpZBXdJd/WoidaQ9MlC93jT1OaRlh7oWz/3
	1e7NnE69NSoaChl5+kmFbn/QjvWlFnt4JjggKobXgywbpE3uw3At/srimu0UKL0uaO8JG9GOsO1
	faXVnm0w7CWGcJy5AA2V5NwiajrOEzxWtY+Q0ygsmy9HhPPPEq9aHL5o0018tyjNJz1+FyxjHh7
	et7F1lEhVRZ+wfWipYvWOKdkv8dfcSlp3O4z3gPcdXZwLpq5XZB1ydN14KCNEUiDXzMwp/OrepN
	ynbbTyAGG3ZpRjwKbkyDJ8d3dovFuDxmR22Afieh1C6raCZ7lim4f7j2P5/5Da8lux8SaW8Vy90
	jfEJH5KM9mJ1plCgffnVyc0mYkBbmxHnS4MHQjteJkVzPecpq06U8xRLK4Bkbfqy/rTdNxqSnJI
	MiUSkJu7fs/GSekNWyK9grJIf1TLn/cAaN/nzcqS7yZ/Dth59QBubvdLq7DEYPF1GqjKdBZKsJ0
	uzVAScCuQo54D5J+rHbnZY2DvZ7t1qWLZNBa/PvpiIGokGC5aEWQMmOv3u3XnrnNJSbZnpcbEpy
	QB1xmFj20prCa5nybavG29ccnZnaRTHx1xhPxMrCp3dxKb7b2MMZZZqf0iuxvk9Hb8UW01/Q/FF
	cZ7AeReH7KLGOqU0pI75Ks2yvYVCRrqUsL78b7UpKBc5TkpMjvP6j8kN/RdAmpNK2
X-Received: by 2002:a17:90b:268f:b0:3b3:a421:7e00 with SMTP id 98e67ed59e1d1-3b41c8d4831mr6844074a91.16.1795325555557;
        Sat, 21 Nov 2026 21:32:35 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d135e9sm14076748a91.4.2026.11.21.21.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 21:32:35 -0800 (PST)
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
Subject: [PATCH net] net/smc: bound a send by the send buffer, not by the peer's credit
Date: Sun, 22 Nov 2026 11:02:23 +0530
Message-Id: <20261122053223.2497832-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261122053223.2497832-1-piyus@iiitd.ac.in>
References: <20261122053223.2497832-1-piyus@iiitd.ac.in>
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

smc_tx_sendmsg() decides how much to copy from the sendmsg() iterator with

	writespace = atomic_read(&conn->sndbuf_space);
	copylen = min_t(size_t, send_remaining, writespace);

and then splits the copy into the two chunks of the ring.  The first chunk
is
clamped against the buffer:

	chunk_len = min_t(size_t, copylen, conn->sndbuf_desc->len - tx_cnt_prep);

but the second is not - it is simply the remainder:

	chunk_len = copylen - chunk_len;	/* remainder */
	chunk_off = 0;

and each chunk is written with memcpy_from_msg(sndbuf_base + chunk_off,
msg,
chunk_len).  So the write is bounded only by sndbuf_space.

That counter is not always a value this side computed.  On the SMC-D
DMB-nocopy path smc_cdc_msg_recv_action() credits it from the peer's
consumer cursor:

	diff_tx = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
				&conn->local_rx_ctrl.cons);
	smp_mb__before_atomic();
	atomic_add(diff_tx, &conn->sndbuf_space);
	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */

The comment states the invariant that smc_tx_sendmsg() relies on; the code
does not establish it, because local_rx_ctrl.cons arrives from the peer.  A
peer that reports an oversized consumer cursor therefore inflates
sndbuf_space, and the unclamped second chunk writes sendmsg() data past the
end of the send buffer - which under DMB-nocopy is the DMB the peer
published, so the overflow runs off the end of that mapping.

Clamp copylen to the buffer.  This bounds the write regardless of how the
credit was arrived at, which is the property smc_tx_sendmsg() needs and the
one a reader of the second chunk currently has to take on trust.  A correct
peer never credits more than the buffer holds, so this changes nothing for
one.

Capping the credit itself at the atomic_add() would also enforce the stated
invariant, and we would be glad to send that instead or as well; we chose
the
clamp because it bounds the copy at the point the copy is made.

Reproduced.  A hostile peer needs an ISM device we do not have, so the peer
was stood in for by a debug patch that overrides the consumer cursor after
validation, on an SMC-D connection over the loopback-ISM device.  The
credit then reads

  SMC2DBG diff_tx=1000000 space_before=65504 sndlen=65504 cons=1000000

- sndbuf_space 1065504 on a 65504-byte buffer - and one sendmsg() of 4 MB
turns that into an oversized copy, with the second chunk written at offset
0:

  SMCTXDBG chunk=0 off=0 len=65504  sndlen=65504  in bounds
  SMCTXDBG chunk=1 off=0 len=869056 sndlen=65504  past the end

  BUG: KASAN: use-after-free in _copy_from_iter+0x197/0xfd0
  Write of size 869056 at addr ffff888057980020 by task b/9467
   _copy_from_iter+0x197/0xfd0
   smc_tx_sendmsg+0x1011/0x12c0

With this patch applied and the same injected credit, every chunk stays
within the buffer (len 65504 or less, no second chunk past the end), KASAN
is silent, and an 8 MB transfer over the same connection completes with its
contents verified.  The injected cursor is the only thing the debug patch
changes; the fault and the fix are in the code above.

How this was found: by AI-driven fuzzing built on top of syzkaller, while
it was working on the receive-side cursor bugs fixed by "net/smc: validate
the peer's CDC cursors against our own buffers".  Its analysis was then
checked by hand against the code, and the credit inflation above measured.

Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/smc/smc_tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 0f0c6df3b..5dc489bf6 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -235,6 +235,13 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		writespace = atomic_read(&conn->sndbuf_space);
 		/* not more than what user space asked for */
 		copylen = min_t(size_t, send_remaining, writespace);
+		/* and never more than the send buffer holds.  sndbuf_space is
+		 * credited in smc_cdc_msg_recv_action() from the peer's
+		 * consumer cursor on the SMC-D DMB-nocopy path, so it is not a
+		 * value this side computed, and the second chunk below is not
+		 * clamped against the buffer the way the first one is.
+		 */
+		copylen = min_t(size_t, copylen, conn->sndbuf_desc->len);
 		/* determine start of sndbuf */
 		sndbuf_base = conn->sndbuf_desc->cpu_addr;
 		smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
