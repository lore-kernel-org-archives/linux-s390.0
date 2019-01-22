Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] s390: pci: no need to check return value of debugfs_create functions
Date: Tue, 22 Jan 2019 16:21:01 +0100
Message-Id: <20190122152151.16139-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/pci.h |  1 -
 arch/s390/pci/pci_debug.c   | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 10fe982f2b4b..4e0efebc56a9 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -148,7 +148,6 @@ struct zpci_dev {
 	enum pci_bus_speed max_bus_speed;
 
 	struct dentry	*debugfs_dev;
-	struct dentry	*debugfs_perf;
 
 	struct s390_domain *s390_domain; /* s390 IOMMU domain data */
 };
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 04388a254ffb..6b48ca7760a7 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -172,21 +172,14 @@ static const struct file_operations debugfs_pci_perf_fops = {
 void zpci_debug_init_device(struct zpci_dev *zdev, const char *name)
 {
 	zdev->debugfs_dev = debugfs_create_dir(name, debugfs_root);
-	if (IS_ERR(zdev->debugfs_dev))
-		zdev->debugfs_dev = NULL;
-
-	zdev->debugfs_perf = debugfs_create_file("statistics",
-				S_IFREG | S_IRUGO | S_IWUSR,
-				zdev->debugfs_dev, zdev,
-				&debugfs_pci_perf_fops);
-	if (IS_ERR(zdev->debugfs_perf))
-		zdev->debugfs_perf = NULL;
+
+	debugfs_create_file("statistics", S_IFREG | S_IRUGO | S_IWUSR,
+			    zdev->debugfs_dev, zdev, &debugfs_pci_perf_fops);
 }
 
 void zpci_debug_exit_device(struct zpci_dev *zdev)
 {
-	debugfs_remove(zdev->debugfs_perf);
-	debugfs_remove(zdev->debugfs_dev);
+	debugfs_remove_recursive(zdev->debugfs_dev);
 }
 
 int __init zpci_debug_init(void)
-- 
2.20.1
