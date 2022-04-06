Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A8C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  6 Apr 2022 08:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiDFIej (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Apr 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349697AbiDFIco (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Apr 2022 04:32:44 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F474187BA3;
        Tue,  5 Apr 2022 19:37:40 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 6 Apr
 2022 10:37:38 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 6 Apr
 2022 10:37:37 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] s390: Simplify the calculation of variables
Date:   Wed, 6 Apr 2022 10:37:31 +0800
Message-ID: <1649212651-32038-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Ykq2H+POaGs0GHVU@osiris>
References: <Ykq2H+POaGs0GHVU@osiris>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix the following coccicheck warnings:
./arch/s390/include/asm/scsw.h:695:47-49: WARNING
 !A || A && B is equivalent to !A || B

I apply a readable version just to get rid of a warning.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: apply a readable and simple version as suggestion.

 arch/s390/include/asm/scsw.h | 47 ++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index a7c3ccf681da..b7e65f96de3c 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -508,9 +508,13 @@ static inline int scsw_cmd_is_valid_zcc(union scsw *scsw)
  */
 static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
 {
-	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       !(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
-	       (scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS);
+	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
+		return 0;
+	if (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS)
+		return 1;
+	return 0;
 }
 
 /**
@@ -522,10 +526,15 @@ static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
  */
 static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
 {
-	return (scsw->cmd.fctl != 0) &&
-	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
-		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
+	if (!scsw->tm.fctl)
+		return 0;
+	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
+		return 1;
+	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
+		return 1;
+	return 0;
 }
 
 /**
@@ -675,9 +684,13 @@ static inline int scsw_tm_is_valid_q(union scsw *scsw)
  */
 static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
 {
-	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       !(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-	       (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS);
+	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
+		return 0;
+	if (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS)
+		return 1;
+	return 0;
 }
 
 /**
@@ -689,11 +702,15 @@ static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
  */
 static inline int scsw_tm_is_valid_pno(union scsw *scsw)
 {
-	return (scsw->tm.fctl != 0) &&
-	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
+	if (!scsw->tm.fctl)
+		return 0;
+	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
+		return 0;
+	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
+		return 1;
+	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
+		return 1;
+	return 0;
 }
 
 /**
-- 
2.7.4

