From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC v3 15/15] vfio: ccw: introduce support for ccw0
Date: Fri, 17 Feb 2017 09:29:39 +0100
Message-ID: <20170217082939.33208-16-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Although Linux does not use format-0 channel command words (CCW0)
these are a non-optional part of the platform spec, and for the sake
of platform compliance, and possibly some non-Linux guests, we have
to support CCW0.

Making the kernel execute a format 0 channel program is too much hassle
because we would need to allocate and use memory which can be addressed
by 24 bit physical addresses (because of CCW0.cda). So we implement CCW0
support by translating the channel program into an equivalent CCW1
program instead.

Signed-off-by: Kai Yue Wang <wkywang@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 arch/s390/Kconfig              |  7 +++++
 drivers/s390/cio/vfio_ccw_cp.c | 58 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 32008b8..f25d077 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -680,6 +680,13 @@ config VFIO_CCW
 	  To compile this driver as a module, choose M here: the
 	  module will be called vfio_ccw.
 
+config VFIO_CCW_CCW0
+	def_bool n
+	prompt "Support for CCW0 translation"
+	depends on VFIO_CCW
+	help
+	  Enable translation for CCW0 programs for VFIO-CCW subchannels.
+
 endmenu
 
 menu "Dump support"
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 16bbb54..b0a8bc05 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -15,6 +15,26 @@
 
 #include "vfio_ccw_cp.h"
 
+#ifdef CONFIG_VFIO_CCW_CCW0
+/**
+ * struct ccw0 - channel command word
+ * @cmd_code: command code
+ * @cda: data address
+ * @flags: flags, like IDA addressing, etc.
+ * @reserved: will be ignored
+ * @count: byte count
+ *
+ * The format-0 ccw structure.
+ */
+struct ccw0 {
+	__u8 cmd_code;
+	__u32 cda : 24;
+	__u8  flags;
+	__u8  reserved;
+	__u16 count;
+} __packed __aligned(8);
+#endif
+
 /*
  * Max length for ccw chain.
  * XXX: Limit to 256, need to check more?
@@ -243,12 +263,42 @@ static long copy_from_iova(struct device *mdev,
 	return l;
 }
 
+#ifdef CONFIG_VFIO_CCW_CCW0
+static long copy_ccw_from_iova(struct channel_program *cp,
+			       struct ccw1 *to, u64 iova,
+			       unsigned long len)
+{
+	struct ccw0 ccw0;
+	struct ccw1 *pccw1;
+	int ret;
+	int i;
+
+	ret = copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
+	if (ret)
+		return ret;
+
+	if (!cp->orb.cmd.fmt) {
+		pccw1 = to;
+		for (i = 0; i < len; i++) {
+			ccw0 = *(struct ccw0 *)pccw1;
+			pccw1->cmd_code = ccw0.cmd_code;
+			pccw1->flags = ccw0.flags;
+			pccw1->count = ccw0.count;
+			pccw1->cda = ccw0.cda;
+			pccw1++;
+		}
+	}
+
+	return ret;
+}
+#else
 static long copy_ccw_from_iova(struct channel_program *cp,
 			       struct ccw1 *to, u64 iova,
 			       unsigned long len)
 {
 	return copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
 }
+#endif
 
 /*
  * Helpers to operate ccwchain.
@@ -616,10 +666,14 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	 * Only support prefetch enable mode now.
 	 * Only support 64bit addressing idal.
 	 * Only support 4k IDAW.
-	 * Only support ccw1.
 	 */
-	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k || !orb->cmd.fmt)
+	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
+		return -EOPNOTSUPP;
+
+#ifndef CONFIG_VFIO_CCW_CCW0
+	if (!orb->cmd.fmt)
 		return -EOPNOTSUPP;
+#endif
 
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
-- 
2.8.4
