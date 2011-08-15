From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 1/3] zfcp: non-experimental support for DIF/DIX
Date: Mon, 15 Aug 2011 14:40:30 +0200
Message-ID: <20110815124058.684182245@linux.vnet.ibm.com>
References: <20110815124029.627237499@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline; filename=3.2/700-zfcp-dif-dix.diff
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Steffen Maier <maier@linux.vnet.ibm.com>

DIF/DIX support for zfcp is no longer experimental,
and config option is no longer necessary.
Return error from queuecommand for unsupported data directions.

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_fsf.c  |    3 ++-
 drivers/s390/scsi/zfcp_scsi.c |    5 +----
 drivers/scsi/Kconfig          |    4 ----
 3 files changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2207,7 +2207,8 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *
 		io->ref_tag_value = scsi_get_lba(scsi_cmnd) & 0xFFFFFFFF;
 	}
 
-	zfcp_fsf_set_data_dir(scsi_cmnd, &io->data_direction);
+	if (zfcp_fsf_set_data_dir(scsi_cmnd, &io->data_direction))
+		goto failed_scsi_cmnd;
 
 	fcp_cmnd = (struct fcp_cmnd *) &req->qtcb->bottom.io.fcp_cmnd;
 	zfcp_fc_scsi_to_fcp(fcp_cmnd, scsi_cmnd, 0);
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -24,11 +24,8 @@ module_param_named(queue_depth, default_
 MODULE_PARM_DESC(queue_depth, "Default queue depth for new SCSI devices");
 
 static bool enable_dif;
-
-#ifdef CONFIG_ZFCP_DIF
-module_param_named(dif, enable_dif, bool, 0600);
+module_param_named(dif, enable_dif, bool, 0400);
 MODULE_PARM_DESC(dif, "Enable DIF/DIX data integrity support");
-#endif
 
 static bool allow_lun_scan = 1;
 module_param(allow_lun_scan, bool, 0600);
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1871,10 +1871,6 @@ config ZFCP
           called zfcp. If you want to compile it as a module, say M here
           and read <file:Documentation/kbuild/modules.txt>.
 
-config ZFCP_DIF
-	tristate "T10 DIF/DIX support for the zfcp driver (EXPERIMENTAL)"
-	depends on ZFCP && EXPERIMENTAL
-
 config SCSI_PMCRAID
 	tristate "PMC SIERRA Linux MaxRAID adapter support"
 	depends on PCI && SCSI && NET
