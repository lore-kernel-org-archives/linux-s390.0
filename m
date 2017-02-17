From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v3 03/15] vfio: ccw: define device_api strings
Date: Fri, 17 Feb 2017 09:29:27 +0100
Message-ID: <20170217082939.33208-4-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Define vfio-ccw device API strings. CCW vendor driver using mediated
device framework should use this string for device_api attribute.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 include/uapi/linux/vfio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 519eff3..6183789 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -212,6 +212,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PCI_STRING		"vfio-pci"
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
+#define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
-- 
2.8.4
