Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E93C433E6
	for <linux-s390@archiver.kernel.org>; Mon,  1 Mar 2021 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105BB600CC
	for <linux-s390@archiver.kernel.org>; Mon,  1 Mar 2021 10:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhCAKdU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:33:20 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39104 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234503AbhCAKdF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Mar 2021 05:33:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPy7kYq_1614594732;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPy7kYq_1614594732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Mar 2021 18:32:21 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hca@linux.ibm.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] s390: Simplify the calculation of variables
Date:   Mon,  1 Mar 2021 18:32:11 +0800
Message-Id: <1614594731-37663-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix the following coccicheck warnings:

./arch/s390/include/asm/scsw.h:695:47-49: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/s390/include/asm/scsw.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index a7c3ccf..343b50f 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -692,8 +692,7 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
 	return (scsw->tm.fctl != 0) &&
 	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
 	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
+		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED));
 }
 
 /**
-- 
1.8.3.1

