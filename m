From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 1/1] zfcp: return early from slave_destroy if slave_alloc returned early
Date: Fri, 18 Nov 2011 20:00:40 +0100
Message-ID: <20111118190141.434940817@linux.vnet.ibm.com>
References: <20111118190039.316785620@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline; filename=700-zfcp-only-finish-slave_destroy-if-slave_alloc-finished.diff
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, stable@kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Steffen Maier <maier@linux.vnet.ibm.com>

zfcp_scsi_slave_destroy erroneously always tried to finish its task
even if the corresponding previous zfcp_scsi_slave_alloc returned
early. This can lead to kernel page faults on accessing uninitialized
fields of struct zfcp_scsi_dev in zfcp_erp_lun_shutdown_wait. Take the
port field of the struct to determine if slave_alloc returned early.

This zfcp bug is exposed by 4e6c82b (in turn fixing f7c9c6b to be
compatible with 21208ae) which can call slave_destroy for a
corresponding previous slave_alloc that did not finish.

This patch is based on James Bottomley's fix suggestion in
http://www.spinics.net/lists/linux-scsi/msg55449.html.

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: <stable@kernel.org> #2.6.38+
---
 drivers/s390/scsi/zfcp_scsi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -55,6 +55,10 @@ static void zfcp_scsi_slave_destroy(stru
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 
+	/* if previous slave_alloc returned early, there is nothing to do */
+	if (!zfcp_sdev->port)
+		return;
+
 	zfcp_erp_lun_shutdown_wait(sdev, "scssd_1");
 	put_device(&zfcp_sdev->port->dev);
 }
