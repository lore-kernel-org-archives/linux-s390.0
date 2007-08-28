From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:31:31 +0000
Subject: [PATCH 9/10] zfcp: Disable LUN scanning from the FC transport class
Message-Id: <200708280931.31908.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

zfcp manages the valid SCSI units currently on its own. So we don't
want the FC transport class to issue scans for units.

Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_scsi.c |    1 +
 1 file changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2007-08-27 13:22:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2007-08-27 13:22:23.000000000 +0200
@@ -800,6 +800,7 @@ struct fc_function_template zfcp_transpo
 	.show_host_port_type = 1,
 	.show_host_speed = 1,
 	.show_host_port_id = 1,
+	.disable_target_scan = 1,
 };
 
 /**
