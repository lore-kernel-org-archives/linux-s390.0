From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:56 +0000
Subject: [PATCH 14/25] zfcp: decouple our scsi_eh callbacks from scsi_cmnd
Message-Id: <20180517171507.18237-15-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Note: zfcp_scsi_eh_host_reset_handler() will be converted in a later patch.

zfcp_scsi_eh_device_reset_handler() now only depends on scsi_device.
zfcp_scsi_eh_target_reset_handler() now only depends on scsi_target.
All derive other objects from these intended callback arguments.

zfcp_scsi_eh_target_reset_handler() is special: The FCP channel requires
a valid LUN handle so we try to find ourselves a stand-in scsi_device as
suggested by Hannes Reinecke. If it cannot find a stand-in scsi device,
trace a record like the following (formatted with zfcpdbf from s390-tools):

Timestamp      : ...
Area           : SCSI
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : tr_nosd        target reset, no SCSI device
Request ID     : 0x0000000000000000                     none (invalid)
SCSI ID        : 0x00000000     SCSI ID/target denoting scope
SCSI LUN       : 0xffffffff                             none (invalid)
SCSI LUN high  : 0xffffffff                             none (invalid)
SCSI result    : 0x00002003     field re-used for midlayer value: FAILED
SCSI retries   : 0xff                                   none (invalid)
SCSI allowed   : 0xff                                   none (invalid)
SCSI scribble  : 0xffffffffffffffff                     none (invalid)
SCSI opcode    : ffffffff ffffffff ffffffff ffffffff    none (invalid)
FCP rsp inf cod: 0xff                                   none (invalid)
FCP rsp IU     : 00000000 00000000 00000000 00000000    none (invalid)
                 00000000 00000000

Actually change the signature of zfcp_task_mgmt_function() used by
zfcp_scsi_eh_device_reset_handler() & zfcp_scsi_eh_target_reset_handler().
Since it was prepared in a previous patch, we only need to delete
a local auto variable which is now the intended argument.

Suggested-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---

Notes:
    Changes since RFC:
    
    Since the FCP channel always requires a valid LUN handle,
    we now use scsi_device as context data with any TMF instead of
    zfcp_port for FCP_TMF_TGT_RESET and an optional scsi_device for
    FCP_TMF_LUN_RESET.
    
    zfcp_scsi_eh_target_reset_handler() became more involved as it needs
    to find a stand-in scsi_device within the target scope as suggested by
    Hannes.
    Trace if we could not find a stand-in scsi_device along with
    an example trace in the commit description.
    Put the refcount from shost_for_each_device for the stand-in scsi_device.
    
    NB:
    zfcp_scsi_eh_host_reset_handler() will be converted in a later patch.
    I need more time to resolve the proper sync with all fc_rports states
    with support for FAST_IO_FAIL.

 drivers/s390/scsi/zfcp_scsi.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index e0c5735cf3db..fcc832b73960 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -265,9 +265,14 @@ static void zfcp_scsi_forget_cmnds(struct zfcp_scsi_dev *zsdev, u8 tm_flags)
 	write_unlock_irqrestore(&adapter->abort_lock, flags);
 }
 
-static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
+/**
+ * zfcp_task_mgmt_function() - Synchronously send a task management function.
+ * @sdev: Pointer to SCSI device to send the task management command to.
+ * @tm_flags: Task management flags,
+ *	      here we only handle %FCP_TMF_TGT_RESET or %FCP_TMF_LUN_RESET.
+ */
+static int zfcp_task_mgmt_function(struct scsi_device *sdev, u8 tm_flags)
 {
-	struct scsi_device *sdev = scpnt->device;
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
@@ -315,12 +320,40 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 
 static int zfcp_scsi_eh_device_reset_handler(struct scsi_cmnd *scpnt)
 {
-	return zfcp_task_mgmt_function(scpnt, FCP_TMF_LUN_RESET);
+	struct scsi_device *sdev = scpnt->device;
+
+	return zfcp_task_mgmt_function(sdev, FCP_TMF_LUN_RESET);
 }
 
 static int zfcp_scsi_eh_target_reset_handler(struct scsi_cmnd *scpnt)
 {
-	return zfcp_task_mgmt_function(scpnt, FCP_TMF_TGT_RESET);
+	struct scsi_target *starget = scsi_target(scpnt->device);
+	struct fc_rport *rport = starget_to_rport(starget);
+	struct Scsi_Host *shost = rport_to_shost(rport);
+	struct scsi_device *sdev = NULL, *tmp_sdev;
+	struct zfcp_adapter *adapter =
+		(struct zfcp_adapter *)shost->hostdata[0];
+	int ret;
+
+	shost_for_each_device(tmp_sdev, shost) {
+		if (tmp_sdev->id == starget->id) {
+			sdev = tmp_sdev;
+			break;
+		}
+	}
+	if (!sdev) {
+		ret = FAILED;
+		zfcp_dbf_scsi_eh("tr_nosd", adapter, starget->id, ret);
+		return ret;
+	}
+
+	ret = zfcp_task_mgmt_function(sdev, FCP_TMF_TGT_RESET);
+
+	/* release reference from above shost_for_each_device */
+	if (sdev)
+		scsi_device_put(tmp_sdev);
+
+	return ret;
 }
 
 static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *scpnt)
-- 
2.16.3
