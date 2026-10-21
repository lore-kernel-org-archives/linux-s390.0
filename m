Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602808;
	b=bEBVKa2Q0HxvphLIuo4bYEYevxpqd88C5qlBczIeuEyJgFjFdCHOsawbO3F/PFkjvlpj
	 v5LepEr5fMt+lxHrd5DSBB09ge8W7IvbJ0DVGImeMA5qGPlK+GBX6q28lyhIH05SpfEif
	 4FNNU1s6UF/W9GYiplWZpVikt2DeQJQQbbGHFEPgsShLHGufz+AmW8JI+GguCA1BC7/Bk
	 vbDGKVSXGPJlmIEx0/p+UW8s1Zw1JLbz92SwuGW5yF+qZNVvKdILBxXdlR7y8WN5Wa29l
	 eVwPXxGdU9QzdQv6t4TdW/V13tDbw6HlT/i+Z9EgqI7u9B+I7I05xvz9TKsfZqYrLxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
	b=17zbh69AXtc8JShmnsE3YSCid4umIH7t6wCLLoOMcfttiubhyt3ArN3Nz7OoUH6z7bJF
	 pGXQ0EdGckO5w/dcy/umjK9xNhZQQ/iqoXvTIydM9Pfrh4Awj8V0cjeKDQF2Z2d7z4dnY
	 QVLS1KHE+PEya7k277nOch5zS/wg5/Q4yxhFukP525bOrMobMAbUBceVKzgbEpww9q69c
	 1ljTDE7mJcLjIre+ZtkhVCknbjaJhDRR8sC9npTcnBalIuLcSZj6wkPuxIgElTFIMcOk4
	 131Wu14lDwGsWQKnj0V5C4Q5qb3yPhGOY1xGA7A3DirMvzuFhN9NLFzRI+t1by4A4DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=soWqeg8C;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247A606A323
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 17:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8247A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=soWqeg8C
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35b2c599f43so2104719eec.0
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602808; x=1793207608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
        b=soWqeg8ClTWjGsUdU6T/pu3svwM0Pfxg2zZh/n9lNcDLCmLtKefWVOKifpL0zHAq1Q
         D6LtACxIh9ec8/1K2mp5qmfBvdxKMULxhe/jNV/dPtt5jFHja1SYX0/Qk340szBict3V
         QuZ38mRsn87CyEawQEZkkBVayuKUAZhkj9wst3LID72z3mWvw7f1HlpsHuR4B29d+rrF
         xNjBWHfVxPKiYyPiUwPc9mgdKoaBp28JqcNrF0lORvsQqW6BEXnCaE6rPU0vEBprTg33
         XKoK9jeF5X1sV46+j/eReNTBzPEMozvHY6FOKd82RD7CTFY/OSL1i7R6qF84ZAZO5HpP
         YEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602808; x=1793207608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
        b=ljodfzwRInX0gk1rdg6jmacH4wTlJGSVsJI0J0Wzi86fl6s2zBu3+d/PA0nGtWrkUt
         TAprfrmXBHoHWVBIGD5ckVNZR1xk6uTsCK9OmyHSLilMZblzKxKwhz7bT1CwE3gOsF4T
         zXIi+CmA0URKG1j9hc/Uq1Yx5Mq7m9N+sp9h4xt9po8kV7GcrUJ8oYm23jO+v7uCbA6O
         bWnLkUYhjEwB/6lBJnOjdVH5hU2pN4m3y4v62vgNh66/KPt3KSeAjBEy9wGTphR8Cipx
         I/l4DDXZvDhrg89H3sV8t7jLGkSfg+165WEqqXrvC5HLT11qIniWJ9qb43GQL3Tqsytr
         y26w==
X-Forwarded-Encrypted: i=1; AKwUvBz/T6Eaa+XPaYOI9BoQb0U1FY93k7wwPHv2YbwDFKGHx9IGdSjFEmP9n1P8zRsJYqQ/vMBCNadZwRi/@vger.kernel.org
X-Gm-Message-State: AFq9FYJugbC2NHTrQBEKt7v0XB2PK9zZt85EzTJTjoze67T0D29eA3fO
	8plJOAIcJIMxda0KLZWrifswWFMeuDesUHD67GT/Q+q5dm6eOffFukTd
X-Gm-Gg: AYBFou3WwNCVTBePtLoGe65dfZTpqMR05Plo479tnzYg9IbO/ZN226ezqd+glVMdP91
	k9bOliku0tLCAhpLDp768v9oGzNc90RhFGJmUk5Va6JSsC+gvNAx1wB1L6xn0pCFS5ksBMkppdP
	g4h0xhUdH6c9PtmxX6Q9IZC+NtmMDNClGR1hVtv470xXkCs7V5/lqgSGShr+yqMtxAPfrnF56uK
	//59Zk7wLHzLKGlqlSzHBVkDvTi9EFsiQS6dwIL1OQGkBJ3wTNKZXB6rUw4e+q2I13WA1iWPAjm
	vpQzbiON14gB3eeErEkzWhd9juvthhT6B/E+F2dGK3wXopfbYZh1m7FA07M7Q/1O/G2BFkF3xAo
	klVh5qBgNkZ+yt8iuqM4M64R+kUeHcbKXFvZyoy6VS/ONZZ8hFTPknFRXqLaX/WW1u7QD50pdHz
	Dy8JS6Ly8k5u25y9WYldlMlZ3Qz9kvUA7FOb1wM//+AK4njLGJWsjGdeMahNh69LnE8/6xRaAIw
	fP1Yzo3eSgaN8YMncydDl3jEMFUueMRDCSahPwaBPn2DzDs34EaUCVImYKNek/axIgVnN8kHqLm
	I5mYemE/xFTIe3AWE87ecvU7z52Dcg==
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id 5a478bee46e88-3674b82ad86mr4897440eec.5.1792602807507;
        Wed, 21 Oct 2026 10:13:27 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm12947635eec.24.2026.10.21.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:13:26 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/smc: reject CDC messages after connection teardown
Date: Wed, 21 Oct 2026 10:12:57 -0700
Message-ID: <20261021171256.166870-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

smc_cdc_rx_handler() drops the link group's connection lock after looking
up a connection. Concurrent close(2) can then set conn->freed and release a
registration-failed receive buffer before the receive handler obtains the
socket lock. The handler subsequently dereferences the released descriptor.

KASAN reports:

  BUG: KASAN: slab-use-after-free in smc_cdc_msg_recv (net/smc/smc_cdc.c:376 net/smc/smc_cdc.c:431)
  Read of size 4 at addr ffff8881064a4720 by task kworker/u48:2/233
  Workqueue: rxe_wq do_work
  Call Trace:
   <IRQ>
   smc_cdc_msg_recv (net/smc/smc_cdc.c:376 net/smc/smc_cdc.c:431)
   smc_cdc_rx_handler (net/smc/smc_cdc.c:503)
   smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445 net/smc/smc_wr.c:459 net/smc/smc_wr.c:498)
   tasklet_action_common (kernel/softirq.c:961)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq (kernel/softirq.c:546 (discriminator 19) kernel/softirq.c:533 (discriminator 19))
   </IRQ>

  Freed by task 209:
   __kasan_slab_free (mm/kasan/common.c:285)
   kfree (./include/linux/kasan.h:235 mm/slub.c:2748
          mm/slub.c:6508 mm/slub.c:6801)
   smc_conn_free (net/smc/smc_core.c:1244 net/smc/smc_core.c:1283)
   __smc_release (net/smc/af_smc.c:322)
   smc_release (net/smc/af_smc.c:361)
   __sock_release (net/socket.c:735)
   sock_close (net/socket.c:1526 (discriminator 1))
   __fput (fs/file_table.c:512)
   fput_close_sync (fs/file_table.c:617)
   __do_sys_close (fs/open.c:1560)

  The buggy address is located 32 bytes inside of
   freed 128-byte region [ffff8881064a4700, ffff8881064a4780)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Both smc_conn_free() and CDC message processing run under the socket lock.
Check conn->freed after acquiring that lock. Discard messages which passed
the lookup before teardown. This keeps the existing lock order and prevents
access to receive buffers released by smc_conn_free().

Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/smc/smc_cdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..499a2473b79b 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -428,7 +428,8 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 {
 	sock_hold(&smc->sk);
 	bh_lock_sock(&smc->sk);
-	smc_cdc_msg_recv_action(smc, cdc);
+	if (!smc->conn.freed)
+		smc_cdc_msg_recv_action(smc, cdc);
 	bh_unlock_sock(&smc->sk);
 	sock_put(&smc->sk); /* no free sk in softirq-context */
 }
-- 
2.56.0

