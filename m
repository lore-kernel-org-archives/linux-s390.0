Return-Path: <linux-kernel-owner+w=401wt.eu-S1753973AbYJAJAu@vger.kernel.org>
Message-Id: <20081001084127.267390607@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/21] more bus_id -> dev_name conversions
Content-Disposition: inline; filename=107-cio-busid3.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Some further bus_id -> dev_name() conversions in s390 code.

Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/char/raw3270.c    |    4 ++--
 drivers/s390/cio/device.c      |    2 +-
 drivers/s390/net/claw.c        |   13 ++++++++-----
 drivers/s390/net/ctcm_main.c   |    4 ++--
 drivers/s390/scsi/zfcp_def.h   |    2 +-
 drivers/s390/scsi/zfcp_erp.c   |    2 +-
 drivers/s390/scsi/zfcp_sysfs.c |    2 +-
 7 files changed, 16 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -1171,7 +1171,7 @@ static int raw3270_create_attributes(str
 	rp->clttydev = device_create_drvdata(class3270, &rp->cdev->dev,
 					     MKDEV(IBM_TTY3270_MAJOR, rp->minor),
 					     NULL,
-					     "tty%s", rp->cdev->dev.bus_id);
+					     "tty%s", dev_name(&rp->cdev->dev));
 	if (IS_ERR(rp->clttydev)) {
 		rc = PTR_ERR(rp->clttydev);
 		goto out_ttydev;
@@ -1180,7 +1180,7 @@ static int raw3270_create_attributes(str
 	rp->cltubdev = device_create_drvdata(class3270, &rp->cdev->dev,
 					     MKDEV(IBM_FS3270_MAJOR, rp->minor),
 					     NULL,
-					     "tub%s", rp->cdev->dev.bus_id);
+					     "tub%s", dev_name(&rp->cdev->dev));
 	if (!IS_ERR(rp->cltubdev))
 		goto out;
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1526,7 +1526,7 @@ void ccw_device_set_notoper(struct ccw_d
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
 	CIO_TRACE_EVENT(2, "notoper");
-	CIO_TRACE_EVENT(2, sch->dev.bus_id);
+	CIO_TRACE_EVENT(2, dev_name(&sch->dev));
 	ccw_device_set_timeout(cdev, 0);
 	cio_disable_subchannel(sch);
 	cdev->private->state = DEV_STATE_NOT_OPER;
Index: quilt-2.6/drivers/s390/net/claw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/claw.c
+++ quilt-2.6/drivers/s390/net/claw.c
@@ -2880,7 +2880,8 @@ claw_new_device(struct ccwgroup_device *
 	int ret;
 	struct ccw_dev_id dev_id;
 
-	printk(KERN_INFO "claw: add for %s\n",cgdev->cdev[READ]->dev.bus_id);
+	printk(KERN_INFO "claw: add for %s\n",
+	       dev_name(&cgdev->cdev[READ]->dev));
 	CLAW_DBF_TEXT(2, setup, "new_dev");
 	privptr = cgdev->dev.driver_data;
 	cgdev->cdev[READ]->dev.driver_data = privptr;
@@ -2904,14 +2905,16 @@ claw_new_device(struct ccwgroup_device *
 	if (ret != 0) {
 		printk(KERN_WARNING
 			"claw: ccw_device_set_online %s READ failed "
-			"with ret = %d\n",cgdev->cdev[READ]->dev.bus_id,ret);
+		       "with ret = %d\n", dev_name(&cgdev->cdev[READ]->dev),
+		       ret);
 		goto out;
 	}
 	ret = ccw_device_set_online(cgdev->cdev[WRITE]);
 	if (ret != 0) {
 		printk(KERN_WARNING
 			"claw: ccw_device_set_online %s WRITE failed "
-			"with ret = %d\n",cgdev->cdev[WRITE]->dev.bus_id, ret);
+		       "with ret = %d\n", dev_name(&cgdev->cdev[WRITE]->dev)
+		       ret);
 		goto out;
 	}
 	dev = alloc_netdev(0,"claw%d",claw_init_netdevice);
@@ -2987,7 +2990,7 @@ claw_shutdown_device(struct ccwgroup_dev
 	struct net_device *ndev;
 	int	ret;
 
-	CLAW_DBF_TEXT_(2, setup, "%s", cgdev->dev.bus_id);
+	CLAW_DBF_TEXT_(2, setup, "%s", dev_name(&cgdev->dev));
 	priv = cgdev->dev.driver_data;
 	if (!priv)
 		return -ENODEV;
@@ -3017,7 +3020,7 @@ claw_remove_device(struct ccwgroup_devic
 	struct claw_privbk *priv;
 
 	BUG_ON(!cgdev);
-	CLAW_DBF_TEXT_(2, setup, "%s", cgdev->dev.bus_id);
+	CLAW_DBF_TEXT_(2, setup, "%s", dev_name(&cgdev->dev));
 	priv = cgdev->dev.driver_data;
 	BUG_ON(!priv);
 	printk(KERN_INFO "claw: %s() called %s will be removed.\n",
Index: quilt-2.6/drivers/s390/net/ctcm_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/ctcm_main.c
+++ quilt-2.6/drivers/s390/net/ctcm_main.c
@@ -1518,8 +1518,8 @@ static int ctcm_new_device(struct ccwgro
 
 	type = get_channel_type(&cdev0->id);
 
-	snprintf(read_id, CTCM_ID_SIZE, "ch-%s", cdev0->dev.bus_id);
-	snprintf(write_id, CTCM_ID_SIZE, "ch-%s", cdev1->dev.bus_id);
+	snprintf(read_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev0->dev));
+	snprintf(write_id, CTCM_ID_SIZE, "ch-%s", dev_name(&cdev1->dev));
 
 	ret = add_channel(cdev0, type, priv);
 	if (ret)
Index: quilt-2.6/drivers/s390/scsi/zfcp_def.h
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_def.h
+++ quilt-2.6/drivers/s390/scsi/zfcp_def.h
@@ -682,7 +682,7 @@ struct zfcp_fsf_req_qtcb {
            ((atomic_read(target) & mask) == mask)
 #endif
 
-#define zfcp_get_busid_by_adapter(adapter) (adapter->ccw_device->dev.bus_id)
+#define zfcp_get_busid_by_adapter(adapter) (dev_name(&adapter->ccw_device->dev))
 #define zfcp_get_busid_by_port(port) (zfcp_get_busid_by_adapter(port->adapter))
 #define zfcp_get_busid_by_unit(unit) (zfcp_get_busid_by_port(unit->port))
 
Index: quilt-2.6/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_erp.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_erp.c
@@ -1439,7 +1439,7 @@ static int zfcp_erp_thread(void *data)
 	struct zfcp_erp_action *act;
 	unsigned long flags;
 
-	daemonize("zfcperp%s", adapter->ccw_device->dev.bus_id);
+	daemonize("zfcperp%s", dev_name(&adapter->ccw_device->dev));
 	/* Block all signals */
 	siginitsetinv(&current->blocked, 0);
 	atomic_set_mask(ZFCP_STATUS_ADAPTER_ERP_THREAD_UP, &adapter->status);
Index: quilt-2.6/drivers/s390/scsi/zfcp_sysfs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_sysfs.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_sysfs.c
@@ -394,7 +394,7 @@ static ssize_t zfcp_sysfs_scsi_##_name##
 static DEVICE_ATTR(_name, S_IRUGO, zfcp_sysfs_scsi_##_name##_show, NULL);
 
 ZFCP_DEFINE_SCSI_ATTR(hba_id, "%s\n",
-	unit->port->adapter->ccw_device->dev.bus_id);
+		      dev_name(&unit->port->adapter->ccw_device->dev));
 ZFCP_DEFINE_SCSI_ATTR(wwpn, "0x%016llx\n", unit->port->wwpn);
 ZFCP_DEFINE_SCSI_ATTR(fcp_lun, "0x%016llx\n", unit->fcp_lun);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
