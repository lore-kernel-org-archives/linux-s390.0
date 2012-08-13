From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] s390: Add a mechanism to get the subchannel id.
Date: Mon, 13 Aug 2012 19:16:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1208131859540.1774@c4eb>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com> <1344351168-2568-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351168-2568-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 7 Aug 2012, Cornelia Huck wrote:
> This will be needed by the new virtio-ccw transport.

We already have ccw_device_get_subchannel_id which is currently used by
qdio only and thus buried in an internal header file. So it would be
better to just clean up this one and make it available to virtio-ccw.
The function looks a little different to what you suggested by it should
do the trick.

---
 arch/s390/include/asm/ccwdev.h |    2 ++
 drivers/s390/cio/device.c      |   11 -----------
 drivers/s390/cio/device.h      |    2 --
 drivers/s390/cio/device_ops.c  |   13 +++++++++++++
 4 files changed, 15 insertions(+), 13 deletions(-)

--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <asm/schid.h>
 #include <asm/fcx.h>
 #include <asm/irq.h>
 
@@ -226,5 +227,6 @@ int ccw_device_siosl(struct ccw_device *
 // FIXME: these have to go
 extern int _ccw_device_get_subchannel_number(struct ccw_device *);
 
+extern struct subchannel_id ccw_device_get_subchannel_id(struct ccw_device *);
 extern void *ccw_device_get_chp_desc(struct ccw_device *, int);
 #endif /* _S390_CCWDEV_H_ */
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -2037,16 +2037,6 @@ void ccw_driver_unregister(struct ccw_dr
 	driver_unregister(&cdriver->driver);
 }
 
-/* Helper func for qdio. */
-struct subchannel_id
-ccw_device_get_subchannel_id(struct ccw_device *cdev)
-{
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-	return sch->schid;
-}
-
 static void ccw_device_todo(struct work_struct *work)
 {
 	struct ccw_device_private *priv;
@@ -2139,4 +2129,3 @@ EXPORT_SYMBOL(ccw_device_set_offline);
 EXPORT_SYMBOL(ccw_driver_register);
 EXPORT_SYMBOL(ccw_driver_unregister);
 EXPORT_SYMBOL(get_ccwdev_by_busid);
-EXPORT_SYMBOL_GPL(ccw_device_get_subchannel_id);
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -142,9 +142,7 @@ int ccw_device_notify(struct ccw_device 
 void ccw_device_set_disconnected(struct ccw_device *cdev);
 void ccw_device_set_notoper(struct ccw_device *cdev);
 
-/* qdio needs this. */
 void ccw_device_set_timeout(struct ccw_device *, int);
-extern struct subchannel_id ccw_device_get_subchannel_id(struct ccw_device *);
 
 /* Channel measurement facility related */
 void retry_set_schib(struct ccw_device *cdev);
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -763,6 +763,19 @@ _ccw_device_get_subchannel_number(struct
 	return cdev->private->schid.sch_no;
 }
 
+/**
+ * ccw_device_get_subchannel_id - obtain a subchannel id
+ * @cdev: device to obtain the id for
+ * Return struct subchannel_id of the parent subchannel.
+ */
+struct subchannel_id ccw_device_get_subchannel_id(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(cdev->dev.parent);
+	return sch->schid;
+}
+EXPORT_SYMBOL_GPL(ccw_device_get_subchannel_id);
 
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_options_mask);
