Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46273 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgCZTGb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Mar 2020 15:06:31 -0400
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] s390/ism: Remove PM support
Date: Thu, 26 Mar 2020 12:05:49 -0700
Message-Id: <20200326190549.24565-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

drivers/s390/net/ism_drv.c:570:12: warning: unused function
'ism_suspend' [-Wunused-function]
static int ism_suspend(struct device *dev)
           ^
drivers/s390/net/ism_drv.c:578:12: warning: unused function 'ism_resume'
[-Wunused-function]
static int ism_resume(struct device *dev)
           ^
2 warnings generated.

When CONFIG_PM is unset, SIMPLE_DEV_PM_OPS does not use the suspend or
resume functions. Power management was recently ripped out of s390 so
CONFIG_PM will never be set and these functions will always be unused.

Remove them so that there is no more warning.

Link: https://github.com/ClangBuiltLinux/linux/950
Fixes: 394216275c7d ("s390: remove broken hibernate / power management support")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/s390/net/ism_drv.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 4fc2056bd227..c75112ee7b97 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -567,31 +567,11 @@ static void ism_remove(struct pci_dev *pdev)
 	kfree(ism);
 }
 
-static int ism_suspend(struct device *dev)
-{
-	struct ism_dev *ism = dev_get_drvdata(dev);
-
-	ism_dev_exit(ism);
-	return 0;
-}
-
-static int ism_resume(struct device *dev)
-{
-	struct ism_dev *ism = dev_get_drvdata(dev);
-
-	return ism_dev_init(ism);
-}
-
-static SIMPLE_DEV_PM_OPS(ism_pm_ops, ism_suspend, ism_resume);
-
 static struct pci_driver ism_driver = {
 	.name	  = DRV_NAME,
 	.id_table = ism_device_table,
 	.probe	  = ism_probe,
 	.remove	  = ism_remove,
-	.driver	  = {
-		.pm = &ism_pm_ops,
-	},
 };
 
 static int __init ism_init(void)
-- 
2.26.0
