Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbgGPJDN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 05:03:13 -0400
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] s390/mm: Convert to DEFINE_SHOW_ATTRIBUTE
Date: Thu, 16 Jul 2020 17:07:03 +0800
Message-ID: <20200716090703.14315-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

From: Chen Huang <chenhuang5@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 arch/s390/mm/dump_pagetables.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9adb10a05..ce65bea17 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -261,17 +261,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 static int pt_dump_init(void)
 {
-- 
2.17.1
