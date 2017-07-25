From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [RFC 6/9] scsi: fc: start decoupling fc_block_scsi_eh from scsi_cmnd
Date: Tue, 25 Jul 2017 16:14:24 +0200
Message-ID: <20170725141427.35258-7-maier@linux.vnet.ibm.com>
References: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Cc: linux-s390@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Scsi_cmnd is an unsuitable argument for eh_device_reset_handler(),
eh_target_reset_handler(), and eh_host_reset_handler()
which do not have the scope of one single SCSI command.
These callbacks tend to use fc_block_scsi_eh() requiring scsi_cmnd.
In order to start decoupling above eh callbacks from scsi_cmnd,
introduce a new variant of the function called fc_block_rport()
taking an fc_rport as argument.
Refactor the old fc_block_scsi_eh() to simply delegate to fc_block_rport().

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 drivers/scsi/scsi_transport_fc.c | 31 ++++++++++++++++++++++++++-----
 include/scsi/scsi_transport_fc.h |  1 +
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index d4cf32d55546..3594043834c7 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -3272,8 +3272,8 @@ fc_scsi_scan_rport(struct work_struct *work)
 }
 
 /**
- * fc_block_scsi_eh - Block SCSI eh thread for blocked fc_rport
- * @cmnd: SCSI command that scsi_eh is trying to recover
+ * fc_block_rport() - Block SCSI eh thread for blocked fc_rport.
+ * @rport: Remote port that scsi_eh is trying to recover.
  *
  * This routine can be called from a FC LLD scsi_eh callback. It
  * blocks the scsi_eh thread until the fc_rport leaves the
@@ -3285,10 +3285,9 @@ fc_scsi_scan_rport(struct work_struct *work)
  *	    FAST_IO_FAIL if the fast_io_fail_tmo fired, this should be
  *	    passed back to scsi_eh.
  */
-int fc_block_scsi_eh(struct scsi_cmnd *cmnd)
+int fc_block_rport(struct fc_rport *rport)
 {
-	struct Scsi_Host *shost = cmnd->device->host;
-	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
+	struct Scsi_Host *shost = rport_to_shost(rport);
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
@@ -3305,6 +3304,28 @@ int fc_block_scsi_eh(struct scsi_cmnd *cmnd)
 
 	return 0;
 }
+EXPORT_SYMBOL(fc_block_rport);
+
+/**
+ * fc_block_scsi_eh - Block SCSI eh thread for blocked fc_rport
+ * @cmnd: SCSI command that scsi_eh is trying to recover
+ *
+ * This routine can be called from a FC LLD scsi_eh callback. It
+ * blocks the scsi_eh thread until the fc_rport leaves the
+ * FC_PORTSTATE_BLOCKED, or the fast_io_fail_tmo fires. This is
+ * necessary to avoid the scsi_eh failing recovery actions for blocked
+ * rports which would lead to offlined SCSI devices.
+ *
+ * Returns: 0 if the fc_rport left the state FC_PORTSTATE_BLOCKED.
+ *	    FAST_IO_FAIL if the fast_io_fail_tmo fired, this should be
+ *	    passed back to scsi_eh.
+ */
+int fc_block_scsi_eh(struct scsi_cmnd *cmnd)
+{
+	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
+
+	return fc_block_rport(rport);
+}
 EXPORT_SYMBOL(fc_block_scsi_eh);
 
 /**
diff --git a/include/scsi/scsi_transport_fc.h b/include/scsi/scsi_transport_fc.h
index 6e208bb32c78..d8cae7bd8161 100644
--- a/include/scsi/scsi_transport_fc.h
+++ b/include/scsi/scsi_transport_fc.h
@@ -808,6 +808,7 @@ void fc_host_post_vendor_event(struct Scsi_Host *shost, u32 event_number,
 struct fc_vport *fc_vport_create(struct Scsi_Host *shost, int channel,
 		struct fc_vport_identifiers *);
 int fc_vport_terminate(struct fc_vport *vport);
+int fc_block_rport(struct fc_rport *rport);
 int fc_block_scsi_eh(struct scsi_cmnd *cmnd);
 enum blk_eh_timer_return fc_eh_timed_out(struct scsi_cmnd *scmd);
 
-- 
2.11.2
