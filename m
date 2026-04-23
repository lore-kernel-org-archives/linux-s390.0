Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFB386444
	for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940189; cv=none; b=pfpCn5g1VApR0uilBgoc9ZBoJylTdkvorcR46otrWd/mcfYedNiOMpj4MhVjHJX28YfFfGGTQVA30rkv4D0cQnP47xCXKWDPkiAHRO1YOhCQ4cxLJo/Hc6euNpU3h705mFehpDI+ZUETaxqOoU9iVFUcghP9O733Otcq3S3h1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940189; c=relaxed/simple;
	bh=i2CfFYtrls5Mfh8jl9B0Dx35/AVjhbDxUMTHf/x0+zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1obJOcl/xI7ZmqJUHnJCrr1FgSeJnseStXGY+V9BQFetgUpmTOGF/dYjn0Jc9OIMK1wK1pnKUhK9Y95qKH2WJQLxN8tKmbIA6eJ3/cY886Ha3o6TV/09SjS7qGUCXjFAi1hVMcgXQpppwiDzUn6P6/1qLaDU00Tnei1coK1zNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc6F7Y6f; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc6F7Y6f"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c19d23b19so8320056c88.0
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2026 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776940187; x=1777544987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8w5fOH/PqUx6ePD5lx3kpu9r4IZp2v338rhXTGbYE+Q=;
        b=mc6F7Y6fMbWJOM7Yu7S0nk0nfT0lpP6fLxCPyuwsAE+x7vKOF3SrrbUn5sSOSKn3zW
         ZKYsdN+69hzRbw7T2RXbYa5YUU4Dj2DOoPeL7dMxevEYkv2CV2hvzdhbXHA8W37m+H8J
         Z7Cm0NdF8BvGvLNyd1gh5PxzdUI/Fv+FLjm1bdD4cUiq45zQDcM8ncqrM9gcdNCeSKpT
         qc2DXZc5WkFf/e3sLakBTLdHBGBx0InAcVfBbesaT/d61kWVv6ALt2WDtSvtnSlVw0Vh
         YSJpGB3uZOJpSuJxSfj7JDS0IWwyLKC59PHRLaBPQY+XkNiTVf0/P2q5TEw09/rzEQIw
         hPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776940187; x=1777544987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w5fOH/PqUx6ePD5lx3kpu9r4IZp2v338rhXTGbYE+Q=;
        b=Cz3BwBD0HPztaOXh2W5jyz8b+Ly/kLNtvkTh27JsVEg+5I4EiTGpQQ8eBdNrPpBvKk
         7zNfx+fj3BSlHfgClcKL4iGCvT9YxylUjHlc/5Nc4ojST3ite1VHVw177XG6+Vgr5lCp
         TGcyWLoypYb0wqD4ROvk+11wgAZPfFmWV9J9LAI+i3jdEa6rXE3lxwtLOqyMx43gtxAd
         aYkIu3CykLj+94zD3lAXnN9BtaJRWywmDL1OvOFv+IZSnw4F9i8WpQdvhFRxZ9GHBhi4
         R33aIVGglurs7H+kodZXXFlqddTewcCym9EwPPxp2baLjtru1i98UZxUcucvmu4tneKr
         g/Cg==
X-Forwarded-Encrypted: i=1; AFNElJ94IML9/ryN7sGbS7sAYDJ1nEntMLCeFcRq57ZDYUoj3kljEAiddfLagZhJT488sFjSduPDbhHU91qE@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNZ39Y2qyNIVayeLfx/7lnVyCucH6aHjOcWZsTDhtITgZ6C1p
	BknNPkMmZJV7OMn7NRhSY0+aaSHw/ghkO8ytyHywQ4+vmN4F+f4zSBOs
X-Gm-Gg: AeBDietWqy41FqRgTRvtOm2AySX4CHaYtUbfDq3yyL73V+KqHmLJsFeJqroKl7YyUbe
	1pd5+M6Pb8ogAqhlH+UDX3ml4vWYUra42waxjPQ/PmjLzpm1eYpK3lTUY7mirEHfAreNFtW7+RE
	hGGSUoTx4V7BlYU0taulyubNqJ4iYiTJ6BqZIkZ0HOfyfQidGapEQM5RGfnVYR3opvxKDjJnUkN
	Amxa+JM7ZJtM/LoZdXZYiXLEUBJ8+I9xrRjE6UMM3Jk0seBI204Gp1lSUiP85g0JprgMLXNScji
	BtFfnCUtXvVaw8D8ihPSCPs/WFkd46o6++KvHv3NozUpqB/OiNp0Yw/9Rcapb3DJ2CrdcO2vlpP
	kvfihp8Xd95SwEXVVXTZ33oXsuXDR2iYR5rRGgxU37rQZa5hySdAzjKG2tkz8T3y3YGqlkCNeos
	XKoy7vQy+WsfgBaVTQRUSjtWBWwsi4rCdvFrimIFB+VVbcxGglUZnBLxTUG40/tzydJXQqglnJW
	o26lD7t1I2aF1V2bpq7
X-Received: by 2002:a05:7022:10c:b0:12c:61fe:fb49 with SMTP id a92af1059eb24-12c73f6ded9mr14785443c88.6.1776940186680;
        Thu, 23 Apr 2026 03:29:46 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ab8b89csm27223984eec.12.2026.04.23.03.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:29:46 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] net/smc: fix NULL pointer dereference in smc_clc_wait_msg()
Date: Thu, 23 Apr 2026 03:02:07 -0700
Message-ID: <20260423100205.1093987-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In smc_listen_work(), smc_clc_wait_msg() is called to wait for a CLC
PROPOSAL message before any link group has been created, so
smc->conn.lgr is still NULL at this point. smc_clc_wait_msg() also
accepts CLC DECLINE messages regardless of the expected type. When a
DECLINE with SMC_FIRST_CONTACT_MASK set in hdr.typev2 arrives, the code
unconditionally dereferences smc->conn.lgr to set sync_err, causing a
NULL pointer dereference.

KASAN reported a null-ptr-deref in smc_clc_wait_msg():

 Oops: general protection fault, 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000310-0x0000000000000317]
 RIP: 0010:smc_clc_wait_msg (net/smc/smc_clc.c:793)
 Call Trace:
  <TASK>
  smc_listen_work (net/smc/af_smc.c:2491)
  process_one_work (kernel/workqueue.c:3281)
  worker_thread (kernel/workqueue.c:3440)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:164)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Add a NULL check for smc->conn.lgr before dereferencing it. 

Fixes: 0cfdd8f92cac ("smc: connection and link group creation")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/smc/smc_clc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index c38fc7bf0a7e..d22c9417d239 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -790,8 +790,10 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
 		if (((struct smc_clc_msg_decline *)buf)->hdr.typev2 &
 						SMC_FIRST_CONTACT_MASK) {
-			smc->conn.lgr->sync_err = 1;
-			smc_lgr_terminate_sched(smc->conn.lgr);
+			if (smc->conn.lgr) {
+				smc->conn.lgr->sync_err = 1;
+				smc_lgr_terminate_sched(smc->conn.lgr);
+			}
 		}
 	}
 
-- 
2.43.0

