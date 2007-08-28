From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:31:41 +0000
Subject: [PATCH 10/10] zfcp: Enable debug feature before setting adapter online
Message-Id: <200708280931.43427.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

Already register the debug feature before the zfcp adapter is
set online. This allows to use the debug feature to investigate
the online/offline sequence.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_aux.c |    8 ++++++++
 drivers/s390/scsi/zfcp_ccw.c |    8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2007-08-27 13:22:21.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2007-08-27 13:22:24.000000000 +0200
@@ -1038,6 +1038,10 @@ zfcp_adapter_enqueue(struct ccw_device *
 	spin_lock_init(&adapter->san_dbf_lock);
 	spin_lock_init(&adapter->scsi_dbf_lock);
 
+	retval = zfcp_adapter_debug_register(adapter);
+	if (retval)
+		goto debug_register_failed;
+
 	/* initialize error recovery stuff */
 
 	rwlock_init(&adapter->erp_lock);
@@ -1084,6 +1088,8 @@ zfcp_adapter_enqueue(struct ccw_device *
  generic_services_failed:
 	zfcp_sysfs_adapter_remove_files(&adapter->ccw_device->dev);
  sysfs_failed:
+	zfcp_adapter_debug_unregister(adapter);
+ debug_register_failed:
 	dev_set_drvdata(&ccw_device->dev, NULL);
 	zfcp_reqlist_free(adapter);
  failed_low_mem_buffers:
@@ -1129,6 +1135,8 @@ zfcp_adapter_dequeue(struct zfcp_adapter
 		goto out;
 	}
 
+	zfcp_adapter_debug_unregister(adapter);
+
 	/* remove specified adapter data structure from list */
 	write_lock_irq(&zfcp_data.config_lock);
 	list_del(&adapter->list);
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c	2007-08-27 13:22:24.000000000 +0200
@@ -150,15 +150,12 @@ zfcp_ccw_set_online(struct ccw_device *c
 	down(&zfcp_data.config_sema);
 	adapter = dev_get_drvdata(&ccw_device->dev);
 
-	retval = zfcp_adapter_debug_register(adapter);
-	if (retval)
-		goto out;
 	retval = zfcp_erp_thread_setup(adapter);
 	if (retval) {
 		ZFCP_LOG_INFO("error: start of error recovery thread for "
 			      "adapter %s failed\n",
 			      zfcp_get_busid_by_adapter(adapter));
-		goto out_erp_thread;
+		goto out;
 	}
 
 	retval = zfcp_adapter_scsi_register(adapter);
@@ -177,8 +174,6 @@ zfcp_ccw_set_online(struct ccw_device *c
 
  out_scsi_register:
 	zfcp_erp_thread_kill(adapter);
- out_erp_thread:
-	zfcp_adapter_debug_unregister(adapter);
  out:
 	up(&zfcp_data.config_sema);
 	return retval;
@@ -201,7 +196,6 @@ zfcp_ccw_set_offline(struct ccw_device *
 	zfcp_erp_adapter_shutdown(adapter, 0);
 	zfcp_erp_wait(adapter);
 	zfcp_erp_thread_kill(adapter);
-	zfcp_adapter_debug_unregister(adapter);
 	up(&zfcp_data.config_sema);
 	return 0;
 }
