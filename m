From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 1/8] iommu: s390: enable iommu api for s390 ccw devices
Date: Fri, 29 Apr 2016 14:11:48 +0200
Message-ID: <1461931915-22397-2-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This enables IOMMU API if CONFIG_CCW is configured.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/iommu/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dd1dc39..63bbc3d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -331,11 +331,11 @@ config ARM_SMMU_V3
 	  the ARM SMMUv3 architecture.
 
 config S390_IOMMU
-	def_bool y if S390 && PCI
-	depends on S390 && PCI
+	def_bool y
+	depends on S390 && (PCI || CCW)
 	select IOMMU_API
 	help
-	  Support for the IOMMU API for s390 PCI devices.
+	  Support for the IOMMU API for s390 PCI and CCW devices.
 
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
-- 
2.6.6
