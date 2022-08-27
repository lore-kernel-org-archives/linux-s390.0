Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBEBC0502A
	for <linux-s390@archiver.kernel.org>; Sat, 27 Aug 2022 15:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiH0P4G (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 27 Aug 2022 11:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiH0P4D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 27 Aug 2022 11:56:03 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501B12A82;
        Sat, 27 Aug 2022 08:56:01 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661615757tok05pso
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 Aug 2022 23:55:51 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: dcYQFNbI8vGFOeb2An6mh5sV8S4PnbieXEyiavi7ic9/WJDgt59fqteMlLfZ2
        iD27VJWq5ge4BrjODj0JOZRI6BeLqjA3vkUoh3qXrU4eLFJPbKW9+R9MstXdrPyTnxzv+Xi
        ibdPxcwHF82UlLpiywngJFl/Dl9Eilea8xqLh0YLm6eJz7wK/bwV8iJ8OSADja4UJz0Atca
        AvVdEkazJ3qWuR8B3krBTFG//EJjkU+tF5vRIJV1QjjIPlGpeq4ERNc7JRH11qwX4jiU0Xn
        eT2JK8K0YiUb+r8ZOUG0LSd0phh19ZgiwE2dNTuacf3/EEdWn428PZskwWQ1fT/1K/SOjUw
        3F0qftCANZ2yPHaerfVsr0d/Z7qZp60rMmgoLqEnqPd5qrp9nxsAbMEVjLNKNAa33nRlYLH
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] s390/sthyi: Fix comments typo
Date:   Sat, 27 Aug 2022 11:55:50 -0400
Message-Id: <20220827155550.12676-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove the repeated word "the" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/s390/kernel/sthyi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
 	sctns->mac.infmval1 |= MAC_CNT_VLD;
 }
 
-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
 static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 						 bool this_lpar,
 						 void *diag224_buf,
-- 
2.35.1

