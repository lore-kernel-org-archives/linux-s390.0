From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [RFC 7/9] zfcp: use fc_block_rport for TMFs and host reset to decouple from scsi_cmnd
Date: Tue, 25 Jul 2017 16:14:25 +0200
Message-ID: <20170725141427.35258-8-maier@linux.vnet.ibm.com>
References: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Cc: linux-s390@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_scsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 05c823ccb959..8e96196fa877 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -287,7 +287,7 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 			break;
 
 		zfcp_erp_wait(adapter);
-		ret = fc_block_scsi_eh(scpnt);
+		ret = port->rport ? fc_block_rport(port->rport) : 0;
 		if (ret) {
 			zfcp_dbf_scsi_devreset("fiof", adapter, tm_flags, NULL,
 					       scsi_id, scsi_lun);
@@ -337,11 +337,13 @@ static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *scpnt)
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(scpnt->device);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
+	struct zfcp_port *port;
 	int ret;
 
 	zfcp_erp_adapter_reopen(adapter, 0, "schrh_1");
 	zfcp_erp_wait(adapter);
-	ret = fc_block_scsi_eh(scpnt);
+	port = zfcp_sdev->port;
+	ret = port->rport ? fc_block_rport(port->rport) : 0;
 	if (ret)
 		return ret;
 
-- 
2.11.2
