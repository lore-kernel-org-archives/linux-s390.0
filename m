From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH RESEND 4/9] zfcp: remove unused device_unregister wrapper
Date: Fri, 26 Apr 2013 16:13:50 +0200
Message-ID: <1366985635-38270-5-git-send-email-maier@linux.vnet.ibm.com>
References: <1366985635-38270-1-git-send-email-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1366985635-38270-1-git-send-email-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Remove the now unused function zfcp_device_unregister since all
users have been converted to use device_unregister directly.

Reviewed-by: Steffen Maier <maier@linux.vnet.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_aux.c |   14 --------------
 drivers/s390/scsi/zfcp_ext.h |    2 --
 2 files changed, 16 deletions(-)

--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -464,20 +464,6 @@ void zfcp_adapter_release(struct kref *r
 	put_device(&cdev->dev);
 }
 
-/**
- * zfcp_device_unregister - remove port, unit from system
- * @dev: reference to device which is to be removed
- * @grp: related reference to attribute group
- *
- * Helper function to unregister port, unit from system
- */
-void zfcp_device_unregister(struct device *dev,
-			    const struct attribute_group *grp)
-{
-	sysfs_remove_group(&dev->kobj, grp);
-	device_unregister(dev);
-}
-
 static void zfcp_port_release(struct device *dev)
 {
 	struct zfcp_port *port = container_of(dev, struct zfcp_port, dev);
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -21,8 +21,6 @@ extern struct zfcp_port *zfcp_port_enque
 					   u32);
 extern void zfcp_sg_free_table(struct scatterlist *, int);
 extern int zfcp_sg_setup_table(struct scatterlist *, int);
-extern void zfcp_device_unregister(struct device *,
-				   const struct attribute_group *);
 extern void zfcp_adapter_release(struct kref *);
 extern void zfcp_adapter_unregister(struct zfcp_adapter *);
 
