From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v4 16/16] MAINTAINERS: Add vfio-ccw maintainers
Date: Fri, 17 Mar 2017 04:17:43 +0100
Message-ID: <20170317031743.40128-17-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Add Cornelia Huck and myself as the vfio-ccw driver maintainers.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..01a6675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10859,6 +10859,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/iommu/s390-iommu.c
 
+S390 VFIO-CCW DRIVER
+M:	Cornelia Huck <cornelia.huck@de.ibm.com>
+M:	Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+L:	linux-s390@vger.kernel.org
+L:	kvm@vger.kernel.org
+S:	Supported
+F:	drivers/s390/cio/vfio_ccw*
+F:	Documentation/s390/vfio-ccw.txt
+F:	include/uapi/linux/vfio_ccw.h
+
 S3C24XX SD/MMC Driver
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.8.4
