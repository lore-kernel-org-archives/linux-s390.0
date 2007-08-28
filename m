From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:30:50 +0000
Subject: PATCH 5/10] zfcp: Remove unnecessary assignment
Message-Id: <200708280930.50577.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

zfcp_adapter_enqueue initialized adapter->ccw_device twice with
the same value. Remove the second assignment, since it is not
necessary.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_aux.c |    1 -
 1 file changed, 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2007-08-27 13:22:19.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2007-08-27 13:22:20.000000000 +0200
@@ -1058,7 +1058,6 @@ zfcp_adapter_enqueue(struct ccw_device *
 	/* mark adapter unusable as long as sysfs registration is not complete */
 	atomic_set_mask(ZFCP_STATUS_COMMON_REMOVE, &adapter->status);
 
-	adapter->ccw_device = ccw_device;
 	dev_set_drvdata(&ccw_device->dev, adapter);
 
 	if (zfcp_sysfs_adapter_create_files(&ccw_device->dev))
