Return-Path: <linux-kernel-owner+w=401wt.eu-S1755234AbYK0KgB@vger.kernel.org>
Message-Id: <20081127103132.519505737@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/60] zfcp: Report microcode level through service level interface
Content-Disposition: inline; filename=116-zfcp-service-level.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christof Schmitt <christof.schmitt@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

Register zfcp with the new /proc/service_level interface to report the
FCP microcode level. When the adapter goes offline or a channel path
disappears, zfcp unregisters, since the microcode version might change
and zfcp does not know about it.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/scsi/zfcp_aux.c |   13 +++++++++++++
 drivers/s390/scsi/zfcp_def.h |    2 ++
 drivers/s390/scsi/zfcp_erp.c |    5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/miscdevice.h>
+#include <linux/seq_file.h>
 #include "zfcp_ext.h"
 
 static char *device;
@@ -436,6 +437,16 @@ static void _zfcp_status_read_scheduler(
 					     stat_work));
 }
 
+static void zfcp_print_sl(struct seq_file *m, struct service_level *sl)
+{
+	struct zfcp_adapter *adapter =
+		container_of(sl, struct zfcp_adapter, service_level);
+
+	seq_printf(m, "zfcp: %s microcode level %x\n",
+		   dev_name(&adapter->ccw_device->dev),
+		   adapter->fsf_lic_version);
+}
+
 /**
  * zfcp_adapter_enqueue - enqueue a new adapter to the list
  * @ccw_device: pointer to the struct cc_device
@@ -500,6 +511,8 @@ int zfcp_adapter_enqueue(struct ccw_devi
 	INIT_WORK(&adapter->stat_work, _zfcp_status_read_scheduler);
 	INIT_WORK(&adapter->scan_work, _zfcp_scan_ports_later);
 
+	adapter->service_level.seq_print = zfcp_print_sl;
+
 	/* mark adapter unusable as long as sysfs registration is not complete */
 	atomic_set_mask(ZFCP_STATUS_COMMON_REMOVE, &adapter->status);
 
Index: quilt-2.6/drivers/s390/scsi/zfcp_def.h
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_def.h
+++ quilt-2.6/drivers/s390/scsi/zfcp_def.h
@@ -33,6 +33,7 @@
 #include <asm/qdio.h>
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
+#include <asm/sysinfo.h>
 #include "zfcp_dbf.h"
 #include "zfcp_fsf.h"
 
@@ -515,6 +516,7 @@ struct zfcp_adapter {
 	struct fsf_qtcb_bottom_port *stats_reset_data;
 	unsigned long		stats_reset;
 	struct work_struct	scan_work;
+	struct service_level	service_level;
 	atomic_t		qdio_outb_full;	   /* queue full incidents */
 };
 
Index: quilt-2.6/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_erp.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_erp.c
@@ -1280,8 +1280,11 @@ static void zfcp_erp_action_cleanup(stru
 		break;
 
 	case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
-		if (result != ZFCP_ERP_SUCCEEDED)
+		if (result != ZFCP_ERP_SUCCEEDED) {
+			unregister_service_level(&adapter->service_level);
 			zfcp_erp_rports_del(adapter);
+		} else
+			register_service_level(&adapter->service_level);
 		zfcp_adapter_put(adapter);
 		break;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
