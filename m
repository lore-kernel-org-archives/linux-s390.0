Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6875FC63797
	for <linux-s390@archiver.kernel.org>; Tue, 17 Jan 2023 06:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjAQGFD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 17 Jan 2023 01:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjAQGFA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 17 Jan 2023 01:05:00 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662C4ED4;
        Mon, 16 Jan 2023 22:04:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VZlgqjr_1673935485;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VZlgqjr_1673935485)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 14:04:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     vneethv@linux.ibm.com
Cc:     oberpar@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] s390/chsc: Switch over to memdup_user()
Date:   Tue, 17 Jan 2023 14:04:43 +0800
Message-Id: <20230117060443.62153-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use memdup_user rather than duplicating its implementation, this is a
little bit restricted to reduce false positives.

./drivers/s390/cio/chsc_sch.c:703:7-14: WARNING opportunity for memdup_user.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3785
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/s390/cio/chsc_sch.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 180ab899289c..097769a955c3 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -700,15 +700,11 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccl_area)
 		return -ENOMEM;
-	ccl = kzalloc(sizeof(*ccl), GFP_KERNEL);
-	if (!ccl) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+
+	ccl = memdup_user(user_ccl, sizeof(*ccl));
+	if (IS_ERR(ccl))
+		return PTR_ERR(ccl);
+
 	sccl_area->request.length = 0x0020;
 	sccl_area->request.code = 0x0030;
 	sccl_area->fmt = ccl->req.fmt;
-- 
2.20.1.7.g153144c

