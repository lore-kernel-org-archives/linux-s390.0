From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] iommu/s390: drop duplicate header pci.h
Date: Wed, 23 Nov 2016 23:23:19 +0800
Message-ID: <4cc3123e0ea4ee25b46e463e698ece75f9ff966e.1479914526.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Joerg Roedel <joro@8bytes.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Drop duplicate header pci.h from s390-iommu.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/iommu/s390-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 3b44b1d..179e636 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -8,7 +8,6 @@
 #include <linux/pci.h>
 #include <linux/iommu.h>
 #include <linux/iommu-helper.h>
-#include <linux/pci.h>
 #include <linux/sizes.h>
 #include <asm/pci_dma.h>
 
-- 
2.9.3
