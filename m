Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EECC0502A
	for <linux-s390@archiver.kernel.org>; Sat, 27 Aug 2022 16:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiH0QPp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 27 Aug 2022 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiH0QPb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 27 Aug 2022 12:15:31 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C193237FA
        for <linux-s390@vger.kernel.org>; Sat, 27 Aug 2022 09:15:28 -0700 (PDT)
X-QQ-mid: bizesmtp72t1661616922t36rfuzr
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 Aug 2022 00:15:17 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: ZdHcY4j9T+JiRL0Rnk33T73nGYt/va4IGsN5EXO+Hdxd02PpnKU04WW9Ua3+W
        oSOG+6WDl9Wchu4tNj6g5eTJ5CR7xqKwQYMc0Jck97gF7iY16X7E/PwvMsDNgKdRFCFYPG2
        UsMi1cqSP0+ERNmiYRcEdNTzifeKHGmsubzrhj6m3D5uURbjOuadjFnF461CrJ4L71oOVzy
        pgauRMLtl1TrNVcxBLV/0Pwopr0jgUIYMvSt70uUbAhCL4UjeiGAfkavBy8sh06B4S1gjlD
        E0gm31qOTEu+mGNLVH9dXCcXO7HxpCFP6yrzGwU2OFG6r83ID+tVU84DjSxxx2+2QrLYVeR
        Hjawjwmb2iC4qSOzDQ=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] s390: Remove the initialization of statics to 0
Date:   Sat, 27 Aug 2022 12:15:16 -0400
Message-Id: <20220827161516.17635-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

No need to initialise statics to 0 or NULL, compiler will do that.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/s390/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 53ed3884fe64..c809c32210c7 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -152,7 +152,7 @@ void __s390_handle_mcck(void)
 	 * Though one suffices, we may get one interrupt per (virtual) cpu.
 	 */
 	if (mcck.warning) {	/* WARNING pending ? */
-		static int mchchk_wng_posted = 0;
+		static int mchchk_wng_posted;
 
 		/* Use single cpu clear, as we cannot handle smp here. */
 		__ctl_clear_bit(14, 24);	/* Disable WARNING MCH */
-- 
2.35.1

