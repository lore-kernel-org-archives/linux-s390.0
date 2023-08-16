Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5EC41513
	for <linux-s390@archiver.kernel.org>; Wed, 16 Aug 2023 03:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbjHPDpZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Aug 2023 23:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbjHPDpP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Aug 2023 23:45:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDF211E
        for <linux-s390@vger.kernel.org>; Tue, 15 Aug 2023 20:45:14 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQYs36X25zrSBR;
        Wed, 16 Aug 2023 11:43:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 11:45:12 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] s390/hmcdrv: Switch to memdup_user_nul() helper
Date:   Wed, 16 Aug 2023 11:44:36 +0800
Message-ID: <20230816034437.2012372-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use memdup_user_nul() helper instead of open-coding
to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v2:
- Fix the NULL assignment timing issue of fp->private_data.
---
 drivers/s390/char/hmcdrv_dev.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 8d50c894711f..2b43a403a715 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -252,19 +252,13 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 		 fp, (long long) *pos, len);
 
 	if (!fp->private_data) { /* first expect a cmd write */
-		fp->private_data = kmalloc(len + 1, GFP_KERNEL);
-
-		if (!fp->private_data)
-			return -ENOMEM;
-
-		if (!copy_from_user(fp->private_data, ubuf, len)) {
-			((char *)fp->private_data)[len] = '\0';
-			return len;
+		fp->private_data = memdup_user_nul(ubuf, len);
+		if (IS_ERR(fp->private_data)) {
+			retlen = PTR_ERR(fp->private_data);
+			fp->private_data = NULL;
+			return retlen;
 		}
-
-		kfree(fp->private_data);
-		fp->private_data = NULL;
-		return -EFAULT;
+		return len;
 	}
 
 	retlen = hmcdrv_dev_transfer((char *) fp->private_data,
-- 
2.34.1

