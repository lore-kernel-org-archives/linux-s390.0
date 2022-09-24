Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEEC04A95
	for <linux-s390@archiver.kernel.org>; Sat, 24 Sep 2022 01:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIXBV2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Sep 2022 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIXBV1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Sep 2022 21:21:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA6FA0CB
        for <linux-s390@vger.kernel.org>; Fri, 23 Sep 2022 18:21:26 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZB1j0w9lzHtgq;
        Sat, 24 Sep 2022 09:16:41 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:21:25 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <xiujianfeng@huawei.com>
Subject: [PATCH] s390/tape: Add __init/__exit annotations to module init/exit funcs
Date:   Sat, 24 Sep 2022 09:17:44 +0800
Message-ID: <20220924011744.230947-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/s390/char/tape_34xx.c | 4 ++--
 drivers/s390/char/tape_3590.c | 4 ++--
 drivers/s390/char/tape_core.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 751945fb6793..091018d62450 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -1194,7 +1194,7 @@ static struct ccw_driver tape_34xx_driver = {
 	.int_class = IRQIO_TAP,
 };
 
-static int
+static int __init
 tape_34xx_init (void)
 {
 	int rc;
@@ -1215,7 +1215,7 @@ tape_34xx_init (void)
 	return rc;
 }
 
-static void
+static void __exit
 tape_34xx_exit(void)
 {
 	ccw_driver_unregister(&tape_34xx_driver);
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 0d484fe43d7e..a3cf48d971ea 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1657,7 +1657,7 @@ static struct ccw_driver tape_3590_driver = {
 /*
  * Setup discipline structure.
  */
-static int
+static int __init
 tape_3590_init(void)
 {
 	int rc;
@@ -1684,7 +1684,7 @@ tape_3590_init(void)
 	return rc;
 }
 
-static void
+static void __exit
 tape_3590_exit(void)
 {
 	ccw_driver_unregister(&tape_3590_driver);
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index a6d2a4792185..c660e661e8d8 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -1271,7 +1271,7 @@ tape_mtop(struct tape_device *device, int mt_op, int mt_count)
 /*
  * Tape init function.
  */
-static int
+static int __init
 tape_init (void)
 {
 	TAPE_DBF_AREA = debug_register ( "tape", 2, 2, 4*sizeof(long));
@@ -1288,7 +1288,7 @@ tape_init (void)
 /*
  * Tape exit function.
  */
-static void
+static void __exit
 tape_exit(void)
 {
 	DBF_EVENT(6, "tape exit\n");
-- 
2.17.1

