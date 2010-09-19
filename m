Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vasiliy Kulikov <segooon@gmail.com>
Subject: [PATCH 01/14] s390: scsi: fix error path
Date: Sun, 19 Sep 2010 16:54:36 +0400
Message-Id: <1284900877-24201-1-git-send-email-segooon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kernel-janitors@vger.kernel.org
Cc: Christof Schmitt <christof.schmitt@de.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Bottomley <James.Bottomley@suse.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

zfcp_unit_add() doesn't free all allocated resources in error case.

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 I cannot compile this driver, so it is not tested at all.

 drivers/s390/scsi/zfcp_unit.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
index 1119c53..8eb4046 100644
--- a/drivers/s390/scsi/zfcp_unit.c
+++ b/drivers/s390/scsi/zfcp_unit.c
@@ -119,6 +119,7 @@ static void zfcp_unit_release(struct device *dev)
 int zfcp_unit_add(struct zfcp_port *port, u64 fcp_lun)
 {
 	struct zfcp_unit *unit;
+	int err;
 
 	unit = zfcp_unit_find(port, fcp_lun);
 	if (unit) {
@@ -136,21 +137,20 @@ int zfcp_unit_add(struct zfcp_port *port, u64 fcp_lun)
 	unit->dev.release = zfcp_unit_release;
 	INIT_WORK(&unit->scsi_work, zfcp_unit_scsi_scan_work);
 
-	if (dev_set_name(&unit->dev, "0x%016llx",
-			 (unsigned long long) fcp_lun)) {
-		kfree(unit);
-		return -ENOMEM;
-	}
+	err = dev_set_name(&unit->dev, "0x%016llx",
+			 (unsigned long long) fcp_lun);
+	if (err)
+		goto err_free;
 
-	if (device_register(&unit->dev)) {
+	err = device_register(&unit->dev);
+	if (err) {
 		put_device(&unit->dev);
-		return -ENOMEM;
+		goto err_free;
 	}
 
-	if (sysfs_create_group(&unit->dev.kobj, &zfcp_sysfs_unit_attrs)) {
-		device_unregister(&unit->dev);
-		return -EINVAL;
-	}
+	err = sysfs_create_group(&unit->dev.kobj, &zfcp_sysfs_unit_attrs);
+	if (err)
+		goto err_unreg;
 
 	get_device(&port->dev);
 
@@ -161,6 +161,12 @@ int zfcp_unit_add(struct zfcp_port *port, u64 fcp_lun)
 	zfcp_unit_scsi_scan(unit);
 
 	return 0;
+
+err_unreg:
+	device_unregister(&unit->dev);
+err_free:
+	kfree(unit);
+	return err;
 }
 
 /**
-- 
1.7.0.4
