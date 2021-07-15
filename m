Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F22C12002
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 03:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F4661374
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 03:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhGODSy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Jul 2021 23:18:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhGODSx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 23:18:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470411042;
        Wed, 14 Jul 2021 20:16:01 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6865B3F7D8;
        Wed, 14 Jul 2021 20:15:58 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH RFC 01/13] s390/hmcdrv: remove the redundant directory path in format string
Date:   Thu, 15 Jul 2021 11:15:21 +0800
Message-Id: <20210715031533.9553-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
it would be better to use '%pD' instead of hard coding the parent
mountpoint.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/s390/char/hmcdrv_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 20e9cd542e03..cdde75508c8a 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -137,7 +137,7 @@ static int hmcdrv_dev_open(struct inode *inode, struct file *fp)
 	if (rc)
 		module_put(THIS_MODULE);
 
-	pr_debug("open file '/dev/%pD' with return code %d\n", fp, rc);
+	pr_debug("open file '%pD' with return code %d\n", fp, rc);
 	return rc;
 }
 
@@ -146,7 +146,7 @@ static int hmcdrv_dev_open(struct inode *inode, struct file *fp)
  */
 static int hmcdrv_dev_release(struct inode *inode, struct file *fp)
 {
-	pr_debug("closing file '/dev/%pD'\n", fp);
+	pr_debug("closing file '%pD'\n", fp);
 	kfree(fp->private_data);
 	fp->private_data = NULL;
 	hmcdrv_ftp_shutdown();
@@ -231,7 +231,7 @@ static ssize_t hmcdrv_dev_read(struct file *fp, char __user *ubuf,
 	retlen = hmcdrv_dev_transfer((char *) fp->private_data,
 				     *pos, ubuf, len);
 
-	pr_debug("read from file '/dev/%pD' at %lld returns %zd/%zu\n",
+	pr_debug("read from file '%pD' at %lld returns %zd/%zu\n",
 		 fp, (long long) *pos, retlen, len);
 
 	if (retlen > 0)
@@ -248,7 +248,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 {
 	ssize_t retlen;
 
-	pr_debug("writing file '/dev/%pD' at pos. %lld with length %zd\n",
+	pr_debug("writing file '%pD' at pos. %lld with length %zd\n",
 		 fp, (long long) *pos, len);
 
 	if (!fp->private_data) { /* first expect a cmd write */
@@ -272,7 +272,7 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 	if (retlen > 0)
 		*pos += retlen;
 
-	pr_debug("write to file '/dev/%pD' returned %zd\n", fp, retlen);
+	pr_debug("write to file '%pD' returned %zd\n", fp, retlen);
 
 	return retlen;
 }
-- 
2.17.1

