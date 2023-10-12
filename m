Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D35CDB47E
	for <linux-s390@archiver.kernel.org>; Thu, 12 Oct 2023 12:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378632AbjJLMhn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjJLMhk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Oct 2023 08:37:40 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D81DC4;
        Thu, 12 Oct 2023 05:37:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vu-nLib_1697114249;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vu-nLib_1697114249)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 20:37:30 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dust Li <dust.li@linux.alibaba.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: return the right falback reason when prefix checks fail
Date:   Thu, 12 Oct 2023 20:37:29 +0800
Message-Id: <20231012123729.29307-1-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In the smc_listen_work(), if smc_listen_prfx_check() failed,
the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
SMC_CLC_DECL_NOSMCDEV was returned.

Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
the real reason is much friendly for debugging.

Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..21d4476b937b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2361,7 +2361,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 		smc_find_ism_store_rc(rc, ini);
 		return (!rc) ? 0 : ini->rc;
 	}
-	return SMC_CLC_DECL_NOSMCDEV;
+	return prfx_rc;
 }
 
 /* listen worker: finish RDMA setup */
-- 
2.19.1.6.gb485710b

