Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46CC43334
	for <linux-s390@archiver.kernel.org>; Tue, 12 Jul 2022 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiGLLvx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiGLLvm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Jul 2022 07:51:42 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF4B41B3;
        Tue, 12 Jul 2022 04:51:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VJ7zTKU_1657626695;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VJ7zTKU_1657626695)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 19:51:36 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net/smc: Use sysctl-specified types of buffers in new link group
Date:   Tue, 12 Jul 2022 19:51:28 +0800
Message-Id: <1657626690-60367-5-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657626690-60367-1-git-send-email-guwen@linux.alibaba.com>
References: <1657626690-60367-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch introduces a new SMC-R specific element buf_type
in struct smc_link_group, for recording the value of sysctl
smcr_buf_type when link group is created.

New created link group will create and reuse buffers of the
type specified by buf_type.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_core.c | 1 +
 net/smc/smc_core.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index fa3a7a8..86afbbc 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -907,6 +907,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		lgr->net = smc_ib_net(lnk->smcibdev);
 		lgr_list = &smc_lgr_list.list;
 		lgr_lock = &smc_lgr_list.lock;
+		lgr->buf_type = lgr->net->smc.sysctl_smcr_buf_type;
 		atomic_inc(&lgr_cnt);
 	}
 	smc->conn.lgr = lgr;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 7652dfa..0261124 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -284,6 +284,7 @@ struct smc_link_group {
 						/* used rtoken elements */
 			u8			next_link_id;
 			enum smc_lgr_type	type;
+			enum smcr_buf_type	buf_type;
 						/* redundancy state */
 			u8			pnet_id[SMC_MAX_PNETID_LEN + 1];
 						/* pnet id of this lgr */
-- 
1.8.3.1

