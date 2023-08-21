Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA03EE4996
	for <linux-s390@archiver.kernel.org>; Mon, 21 Aug 2023 01:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHUBw5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 20 Aug 2023 21:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHUBw4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 20 Aug 2023 21:52:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A09C
        for <linux-s390@vger.kernel.org>; Sun, 20 Aug 2023 18:52:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTb595NnpzLp5P;
        Mon, 21 Aug 2023 09:49:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 09:52:51 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-s390@vger.kernel.org>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] s390/dasd: Remove redundant NULL check for debugfs_create_dir
Date:   Mon, 21 Aug 2023 09:52:33 +0800
Message-ID: <20230821015233.1899299-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since debugfs_create_dir() returns ERR_PTR, IS_ERR() is enough to
check whether the directory is successfully created. So remove the
redundant NULL check.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/s390/block/dasd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 215597f73be4..2788f6fd6499 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -219,7 +219,7 @@ static struct dentry *dasd_debugfs_setup(const char *name,
 	if (!base_dentry)
 		return NULL;
 	pde = debugfs_create_dir(name, base_dentry);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR(pde))
 		return NULL;
 	return pde;
 }
@@ -1071,11 +1071,11 @@ static void dasd_statistics_createroot(void)
 
 	dasd_debugfs_root_entry = NULL;
 	pde = debugfs_create_dir("dasd", NULL);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR(pde))
 		goto error;
 	dasd_debugfs_root_entry = pde;
 	pde = debugfs_create_dir("global", dasd_debugfs_root_entry);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR(pde))
 		goto error;
 	dasd_debugfs_global_entry = pde;
 	dasd_profile_init(&dasd_global_profile, dasd_debugfs_global_entry);
-- 
2.34.1

