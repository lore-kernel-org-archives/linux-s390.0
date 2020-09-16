Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:58392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgIPC2C (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:02 -0400
From: Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] s390/diag: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date: Wed, 16 Sep 2020 10:50:29 +0800
Message-ID: <20200916025029.3992939-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/s390/kernel/diag.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index ccba63aaeb47..b8b0cd7b008f 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -104,18 +104,7 @@ static const struct seq_operations show_diag_stat_sops = {
 	.show	= show_diag_stat,
 };
 
-static int show_diag_stat_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &show_diag_stat_sops);
-}
-
-static const struct file_operations show_diag_stat_fops = {
-	.open		= show_diag_stat_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
+DEFINE_SEQ_ATTRIBUTE(show_diag_stat);
 
 static int __init show_diag_stat_init(void)
 {
-- 
2.25.1
