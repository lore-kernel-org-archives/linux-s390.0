Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1751BC433DB
	for <linux-s390@archiver.kernel.org>; Thu, 25 Feb 2021 06:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C664164EBD
	for <linux-s390@archiver.kernel.org>; Thu, 25 Feb 2021 06:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhBYGQ1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 Feb 2021 01:16:27 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39923 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233331AbhBYGQ0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Feb 2021 01:16:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPVyCj-_1614233737;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPVyCj-_1614233737)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 14:15:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hca@linux.ibm.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] s390/cpumf: remove unneeded semicolon
Date:   Thu, 25 Feb 2021 14:15:36 +0800
Message-Id: <1614233736-87331-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix the following coccicheck warnings:

./arch/s390/kernel/perf_cpum_cf.c:272:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 0eb1d1c..b3beef6 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -269,7 +269,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 	case CPUMF_CTR_SET_MAX:
 		/* The counter could not be associated to a counter set */
 		return -EINVAL;
-	};
+	}
 
 	/* Initialize for using the CPU-measurement counter facility */
 	if (!atomic_inc_not_zero(&num_events)) {
-- 
1.8.3.1

