Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF33BC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 28 Mar 2022 06:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiC1GV0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiC1GVZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Mar 2022 02:21:25 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5A44756;
        Sun, 27 Mar 2022 23:19:43 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 14:19:42 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 14:19:40 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH V2] s390: Simplify the calculation of variables
Date:   Mon, 28 Mar 2022 14:19:38 +0800
Message-ID: <1648448378-15356-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix the following coccicheck warnings:
./arch/s390/include/asm/scsw.h:695:47-49: WARNING
 !A || A && B is equivalent to !A || B

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: fix build error

 arch/s390/include/asm/scsw.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index a7c3ccf..f2baac8 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -692,8 +692,7 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
 	return (scsw->tm.fctl != 0) &&
 	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
 	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
+	       (scsw->tm.actl & SCSW_ACTL_SUSPENDED));
 }
 
 /**
-- 
2.7.4

