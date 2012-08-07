From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/4] s390: Add a mechanism to get the subchannel id.
Date: Tue,  7 Aug 2012 16:52:46 +0200
Message-ID: <1344351168-2568-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This will be needed by the new virtio-ccw transport.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/ccwdev.h |  5 +++++
 drivers/s390/cio/device_ops.c  | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 1cb4bb3..9ad79f7 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -18,6 +18,9 @@ struct irb;
 struct ccw1;
 struct ccw_dev_id;
 
+/* from asm/schid.h */
+struct subchannel_id;
+
 /* simplified initializers for struct ccw_device:
  * CCW_DEVICE and CCW_DEVICE_DEVTYPE initialize one
  * entry in your MODULE_DEVICE_TABLE and set the match_flag correctly */
@@ -226,5 +229,7 @@ int ccw_device_siosl(struct ccw_device *);
 // FIXME: these have to go
 extern int _ccw_device_get_subchannel_number(struct ccw_device *);
 
+extern void ccw_device_get_schid(struct ccw_device *, struct subchannel_id *);
+
 extern void *ccw_device_get_chp_desc(struct ccw_device *, int);
 #endif /* _S390_CCWDEV_H_ */
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index ec7fb6d..a93f4a0 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -763,6 +763,16 @@ _ccw_device_get_subchannel_number(struct ccw_device *cdev)
 	return cdev->private->schid.sch_no;
 }
 
+/**
+ * ccw_device_get_schid - obtain a subchannel id
+ * @cdev: device to obtain the id for
+ * @schid: where to fill in the values
+ */
+void ccw_device_get_schid(struct ccw_device *cdev, struct subchannel_id *schid)
+{
+	*schid = cdev->private->schid;
+}
+EXPORT_SYMBOL(ccw_device_get_schid);
 
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_options_mask);
-- 
1.7.11.4
