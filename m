From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:55 +0000
Subject: [PATCH 13/25] zfcp: decouple TMFs from scsi_cmnd by using fc_block_rport
Message-Id: <20180517171507.18237-14-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Intentionally retrieve the rport by walking SCSI common code objects
rather than zfcp_sdev->port->rport.

The latter is used for pairing the calls to fc_remote_port_add() and
fc_remote_port_delete(). [see v2.6.31 commit 379d6bf6573e ("[SCSI] zfcp:
Add port only once to FC transport class")]

zfcp_scsi_rport_register() sets zfcp_port.rport to what
fc_remote_port_add() returned.
zfcp_scsi_rport_block() sets zfcp_port.rport = NULL after having called
fc_remote_port_delete().

Hence, while an rport is blocked (or in any subsequent state due to
scsi_transport_fc timeouts such as fast_io_fail_tmo or dev_loss_tmo),
zfcp_port.rport is NULL and cannot serve as argument to fc_block_rport().

During zfcp recovery, a just recovered zfcp_port can have the UNBLOCKED
status flag, but an async rport unblocking has only started via
zfcp_scsi_schedule_rport_register() in zfcp_erp_try_rport_unblock()
[see v4.10 commit 6f2ce1c6af37 ("scsi: zfcp: fix rport unblock race with
LUN recovery")] in zfcp_erp_action_cleanup(). Now zfcp_erp_wait() can
return. This would be sufficient to successfully send a TMF.
But the rport can still be blocked and zfcp_port.rport can still be NULL
until zfcp_port.rport_work was scheduled and has actually called
fc_remote_port_add() and assigned its return value to zfcp_port.rport.
We need an unblocked rport for a successful scsi_eh TUR.

Similarly, for a zfcp_port which has just lost its UNBLOCKED status flag,
the return of zfcp_erp_wait() can race with zfcp_port.rport_work queued
by zfcp_scsi_schedule_rport_block(). Therefore we cannot reliably access
zfcp_port.rport. However, we'd like to get fc_rport_block()'s opinion on
when fast_io_fail_tmo triggered. While we might use
flush_work(&port->rport_work) to sync with the work item, we can simply use
the other way to get an rport pointer.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---

Notes:
    Changes since RFC:
    
    For consistency renamed from "zfcp: use fc_block_rport for TMFs and
    host reset to decouple from scsi_cmnd".
    
    zfcp_scsi_eh_host_reset_handler() will be converted in a later patch.
    Therefore, this patch here does not touch the host reset case any more.
    
    Since the previous "[RFC 6/9] scsi: fc: start decoupling fc_block_scsi_eh
    from scsi_cmnd" was queued for 4.14 already, I dropped it from this new
    patch set version and simply depend on it.
    
    Intentionally retrieve the rport by walking SCSI common code objects
    rather than zfcp_sdev->port->rport.
    
    This also fixes the problem that we could not synchronize if port->rport
    is NULL but still continued as if the TMF was successful as Hannes
    correctly pointed out.

 drivers/s390/scsi/zfcp_scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index e77e43a0630a..e0c5735cf3db 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -270,6 +270,7 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 	struct scsi_device *sdev = scpnt->device;
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
+	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
 	struct zfcp_fsf_req *fsf_req = NULL;
 	int retval = SUCCESS, ret;
 	int retry = 3;
@@ -281,7 +282,7 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 
 		zfcp_dbf_scsi_devreset("wait", sdev, tm_flags, NULL);
 		zfcp_erp_wait(adapter);
-		ret = fc_block_scsi_eh(scpnt);
+		ret = fc_block_rport(rport);
 		if (ret) {
 			zfcp_dbf_scsi_devreset("fiof", sdev, tm_flags, NULL);
 			return ret;
-- 
2.16.3
