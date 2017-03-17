From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v4 15/16] vfio: ccw: introduce support for ccw0
Date: Fri, 17 Mar 2017 04:17:42 +0100
Message-ID: <20170317031743.40128-16-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
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

Based upon an orginal patch by Kai Yue Wang.
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 arch/s390/include/asm/cio.h    | 18 ++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.c | 32 +++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index f7ed88c..7a38ca8 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -33,6 +33,24 @@ struct ccw1 {
 	__u32 cda;
 } __attribute__ ((packed,aligned(8)));
 
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
+
 #define CCW_FLAG_DC		0x80
 #define CCW_FLAG_CC		0x40
 #define CCW_FLAG_SLI		0x20
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 16bbb54..ba6ac83 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -247,7 +247,34 @@ static long copy_ccw_from_iova(struct channel_program *cp,
 			       struct ccw1 *to, u64 iova,
 			       unsigned long len)
 {
-	return copy_from_iova(cp->mdev, to, iova, len * sizeof(struct ccw1));
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
+			if ((pccw1->cmd_code & 0x0f) == CCW_CMD_TIC) {
+				pccw1->cmd_code = CCW_CMD_TIC;
+				pccw1->flags = 0;
+				pccw1->count = 0;
+			} else {
+				pccw1->cmd_code = ccw0.cmd_code;
+				pccw1->flags = ccw0.flags;
+				pccw1->count = ccw0.count;
+			}
+			pccw1->cda = ccw0.cda;
+			pccw1++;
+		}
+	}
+
+	return ret;
 }
 
 /*
@@ -616,9 +643,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	 * Only support prefetch enable mode now.
 	 * Only support 64bit addressing idal.
 	 * Only support 4k IDAW.
-	 * Only support ccw1.
 	 */
-	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k || !orb->cmd.fmt)
+	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
 		return -EOPNOTSUPP;
 
 	INIT_LIST_HEAD(&cp->ccwchain_list);
-- 
2.8.4
