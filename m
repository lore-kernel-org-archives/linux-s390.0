From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:30:59 +0000
Subject: [PATCH 6/10] zfcp: Remove braces for only one statement
Message-Id: <200708280930.59476.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

Remove braces for only one statement

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_scsi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2007-08-27 13:22:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2007-08-27 13:22:21.000000000 +0200
@@ -189,10 +189,9 @@ static void zfcp_scsi_slave_destroy(stru
 		unit->device = NULL;
 		zfcp_erp_unit_failed(unit);
 		zfcp_unit_put(unit);
-	} else {
+	} else
 		ZFCP_LOG_NORMAL("bug: no unit associated with SCSI device at "
 				"address %p\n", sdpnt);
-	}
 }
 
 /* 
@@ -361,12 +360,11 @@ zfcp_unit_lookup(struct zfcp_adapter *ad
 	list_for_each_entry(port, &adapter->port_list_head, list) {
 		if (!port->rport || (id != port->rport->scsi_target_id))
 			continue;
-		list_for_each_entry(unit, &port->unit_list_head, list) {
+		list_for_each_entry(unit, &port->unit_list_head, list)
 			if (lun == unit->scsi_lun) {
 				retval = unit;
 				goto out;
 			}
-		}
 	}
  out:
 	return retval;
