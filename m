Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AF0C43334
	for <linux-s390@archiver.kernel.org>; Wed, 22 Jun 2022 14:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358498AbiFVObX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358571AbiFVOa5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Jun 2022 10:30:57 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE33B3D4
        for <linux-s390@vger.kernel.org>; Wed, 22 Jun 2022 07:30:13 -0700 (PDT)
X-QQ-mid: bizesmtp90t1655908040tzwku8mz
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 22:27:15 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000E00A0000000
X-QQ-FEAT: jfdGVjI73+SuiQ+tQJWl8eUmxpLnkpC8Qi6FtmpAOw1Exi+fJPUBmcMHsey8C
        MFrVFsw97pvh5lMerdwjSFcE3Li2CgJqli127Eooul5EFd/QRTStcU1pBKv2kz82gNsEZOY
        rkbbKxOhI7wLqLJ1xTzpka55ojmfhAo7KRRVpE8V/1eSM/5jLmCAhJ5tsy2HdZbrMf2QEYa
        V7TXOGa2G5346wSYzUX4IBkXxGXmbioRkYQPLpZXi1xl2+IIMwQttGln6UCUvKsDSe6EbM6
        dYdWC7jOUDEjLKrqKwyDDptbXBbvPLz2dfL4f+Gi/E98661QPQDP26rEbrKby9sY0kZistd
        QHWCMi64v6+y69KKJ0xAhleu+t8D2YRY/BfmOzR
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        oberpar@linux.ibm.com, keescook@chromium.org,
        bjorn.andersson@linaro.org, liaoyu15@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] s390/sclp: Fix typo in comments
Date:   Wed, 22 Jun 2022 22:27:13 +0800
Message-Id: <20220622142713.14187-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove the repeated word 'and' from comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/s390/char/sclp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index cb2491761958..ae1d6ee382a5 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -60,7 +60,7 @@ static LIST_HEAD(sclp_reg_list);
 /* List of queued requests. */
 static LIST_HEAD(sclp_req_queue);
 
-/* Data for read and and init requests. */
+/* Data for read and init requests. */
 static struct sclp_req sclp_read_req;
 static struct sclp_req sclp_init_req;
 static void *sclp_read_sccb;
-- 
2.17.1

