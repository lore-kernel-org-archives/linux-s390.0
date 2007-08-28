From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:30:22 +0000
Subject: [PATCH 3/10] zfcp: correct indentation for nested if-else
Message-Id: <200708280930.22809.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

correct indentation for nested if-else

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_fsf.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2007-08-27 13:21:50.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2007-08-27 13:22:19.000000000 +0200
@@ -3586,17 +3586,17 @@ zfcp_fsf_send_fcp_command_task(struct zf
 			ZFCP_LOG_DEBUG(
 				"Data did not fit into available buffer(s), "
 			       "waiting for more...\n");
-		retval = -EIO;
-	} else {
-		ZFCP_LOG_NORMAL("error: No truncation implemented but "
-				"required. Shutting down unit "
-				"(adapter %s, port 0x%016Lx, "
-				"unit 0x%016Lx)\n",
-				zfcp_get_busid_by_unit(unit),
-				unit->port->wwpn,
-				unit->fcp_lun);
-		zfcp_erp_unit_shutdown(unit, 0);
-		retval = -EINVAL;
+			retval = -EIO;
+		} else {
+			ZFCP_LOG_NORMAL("error: No truncation implemented but "
+					"required. Shutting down unit "
+					"(adapter %s, port 0x%016Lx, "
+					"unit 0x%016Lx)\n",
+					zfcp_get_busid_by_unit(unit),
+					unit->port->wwpn,
+					unit->fcp_lun);
+			zfcp_erp_unit_shutdown(unit, 0);
+			retval = -EINVAL;
 		}
 		goto no_fit;
 	}
