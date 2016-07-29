Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jul 2016 14:01:50 +0530
From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] s390/pci: Remove unnecessary if condition
Message-ID: <20160729083150.GA8819@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-ID: <linux-s390.vger.kernel.org>

Remove unnecessary error handling because the only failure value that
can be returned is NULL and so the test can never be true.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e;
@@

  e = debugfs_create_file(...);
- if(IS_ERR(e)) { e = NULL; }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/s390/pci/pci_debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 4129b0a..8a25b04 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -139,8 +139,6 @@ void zpci_debug_init_device(struct zpci_dev *zdev)
 				S_IFREG | S_IRUGO | S_IWUSR,
 				zdev->debugfs_dev, zdev,
 				&debugfs_pci_perf_fops);
-	if (IS_ERR(zdev->debugfs_perf))
-		zdev->debugfs_perf = NULL;
 }
 
 void zpci_debug_exit_device(struct zpci_dev *zdev)
-- 
1.9.1
