Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727DFC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 23 Jun 2022 10:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiFWKVo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiFWKVn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Jun 2022 06:21:43 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9545F76;
        Thu, 23 Jun 2022 03:21:38 -0700 (PDT)
X-QQ-mid: bizesmtp85t1655979680turd5q1a
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:21:15 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: rCzLTtzQ0gf/XOGQRUZH29h41mOjzoysKu1Ok+a1VzOeVG+7B8mAb8HhmtU0Q
        crIPTIDikgc4Nx/q5sPaY4MVJbYg0HWHUqXJYTOF5MIxidKJvuz4C3aCbHKdLx26yKTKqGU
        QnWLBe/iCNG6Dz3PwX+csFQo/MCKXRR9zZp6zVmxhbUzLuoansLqK9Qll8frgFaXUwaHpaN
        +Q2ebvykfB4mIN8Uj1lQU07YgtnZmAsF9QIxfHDagdwiV2LegKSDuvEEvzhZ4vxEgUmXUEu
        pNG+CQNjppNCnGHKcrntojcFfrHc5yIjomWEnQk9NYx0qKoNRGqeBSGm9rZsDy8W+amIp+2
        Vkb+Y/zv+Xbiuw2rFM2Za7aW5MDKw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] s390/dasd: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:21:14 +0800
Message-Id: <20220623102114.33249-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/s390/block/dasd.c
line - 1728

	/* check for for attention message */

changed to:

	/* check for attention message */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/s390/block/dasd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ba6d78789660..35b94aa02f15 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1725,7 +1725,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		dasd_put_device(device);
 	}
 
-	/* check for for attention message */
+	/* check for attention message */
 	if (scsw_dstat(&irb->scsw) & DEV_STAT_ATTENTION) {
 		device = dasd_device_from_cdev_locked(cdev);
 		if (!IS_ERR(device)) {
-- 
2.17.1

