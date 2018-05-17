From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:50 +0000
Subject: [PATCH 08/25] zfcp: decouple SCSI traces for scsi_eh / TMF from scsi_cmnd
Message-Id: <20180517171507.18237-9-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The SCSI command pointer passed to scsi_eh callbacks is just one arbitrary
command of potentially many that are in the eh queue to be processed.
The command is only used to indirectly pass the TMF scope in terms of
SCSI ID/target and SCSI LUN for LUN reset.

Hence, zfcp had filled in SCSI trace record fields which do not really
belong to the TMF. This was confusing.

Therefore, refactor the TMF tracing to work without SCSI command.
Since the FCP channel always requires a valid LUN handle,
we use SCSI device as common context for any TMF (even target reset).
To make it even clearer, we set all bits to 1 for the fields, which do
not belong to the TMF, to indicate that these fields are invalid.

The old zfcp_dbf_scsi() became zfcp_dbf_scsi_common() to now handle both
SCSI commands and TMFs. The old argument scsi_cmnd is now optional and
can be NULL with TMFs. The new argument scsi_device is mandatory to carry
context, as well as SCSI ID/target and SCSI LUN in case of TMFs.

New example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : SCSI
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : [lt]r_....
Request ID     : 0x<reqid>              ID of FSF FCP request with TM flag
                 For cases without FSF request: 0x0 for none (invalid)
SCSI ID        : 0x<scsi_id>            SCSI ID/target denoting scope
SCSI LUN       : 0x<scsi_lun>           SCSI LUN denoting scope
SCSI LUN high  : 0x<scsi_lun_high>      SCSI LUN denoting scope
SCSI result    : 0xffffffff                             none (invalid)
SCSI retries   : 0xff                                   none (invalid)
SCSI allowed   : 0xff                                   none (invalid)
SCSI scribble  : 0xffffffffffffffff                     none (invalid)
SCSI opcode    : ffffffff ffffffff ffffffff ffffffff    none (invalid)
FCP rsp inf cod: 0x00                   FCP_RSP info code of TMF
FCP rsp IU     : 00000000 00000000 00000100 00000000 ext FCP_RSP IU
                 00000000 00000008                   ext FCP_RSP IU
FCP rsp IU len : 32                                  FCP_RSP IU length
Payload time   : ...
FCP rsp IU all : 00000000 00000000 00000100 00000000 full FCP_RSP IU
                 00000000 00000008 00000000 00000000 full FCP_RSP IU

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---

Notes:
    Changes since RFC:
    
    For consistency, renamed from
    "zfcp: drop unsuitable scsi_cmnd usage from SCSI traces for scsi_eh / TMF".
    Since the FCP channel always requires a valid LUN handle,
    we use SCSI device as common context for any TMF (even target reset)
    instead of explicit SCSI ID and SCSI LUN values.
    Added example trace record to commit description.

 drivers/s390/scsi/zfcp_dbf.c  | 48 ++++++++++++++++++++++++++++---------------
 drivers/s390/scsi/zfcp_dbf.h  | 21 ++++++++++++-------
 drivers/s390/scsi/zfcp_ext.h  |  5 +++--
 drivers/s390/scsi/zfcp_scsi.c | 15 +++++++-------
 4 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 1e5ea5e4992b..bb3373260169 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -578,16 +578,18 @@ void zfcp_dbf_san_in_els(char *tag, struct zfcp_fsf_req *fsf)
 }
 
 /**
- * zfcp_dbf_scsi - trace event for scsi commands
- * @tag: identifier for event
- * @sc: pointer to struct scsi_cmnd
- * @fsf: pointer to struct zfcp_fsf_req
+ * zfcp_dbf_scsi_common() - Common trace event helper for scsi.
+ * @tag: Identifier for event.
+ * @level: trace level of event.
+ * @sdev: Pointer to SCSI device as context for this event.
+ * @sc: Pointer to SCSI command, or NULL with task management function (TMF).
+ * @fsf: Pointer to FSF request, or NULL.
  */
-void zfcp_dbf_scsi(char *tag, int level, struct scsi_cmnd *sc,
-		   struct zfcp_fsf_req *fsf)
+void zfcp_dbf_scsi_common(char *tag, int level, struct scsi_device *sdev,
+			  struct scsi_cmnd *sc, struct zfcp_fsf_req *fsf)
 {
 	struct zfcp_adapter *adapter =
-		(struct zfcp_adapter *) sc->device->host->hostdata[0];
+		(struct zfcp_adapter *) sdev->host->hostdata[0];
 	struct zfcp_dbf *dbf = adapter->dbf;
 	struct zfcp_dbf_scsi *rec = &dbf->scsi_buf;
 	struct fcp_resp_with_ext *fcp_rsp;
@@ -599,16 +601,28 @@ void zfcp_dbf_scsi(char *tag, int level, struct scsi_cmnd *sc,
 
 	memcpy(rec->tag, tag, ZFCP_DBF_TAG_LEN);
 	rec->id = ZFCP_DBF_SCSI_CMND;
-	rec->scsi_result = sc->result;
-	rec->scsi_retries = sc->retries;
-	rec->scsi_allowed = sc->allowed;
-	rec->scsi_id = sc->device->id;
-	rec->scsi_lun = (u32)sc->device->lun;
-	rec->scsi_lun_64_hi = (u32)(sc->device->lun >> 32);
-	rec->host_scribble = (unsigned long)sc->host_scribble;
-
-	memcpy(rec->scsi_opcode, sc->cmnd,
-	       min((int)sc->cmd_len, ZFCP_DBF_SCSI_OPCODE));
+	if (sc) {
+		rec->scsi_result = sc->result;
+		rec->scsi_retries = sc->retries;
+		rec->scsi_allowed = sc->allowed;
+		rec->scsi_id = sc->device->id;
+		rec->scsi_lun = (u32)sc->device->lun;
+		rec->scsi_lun_64_hi = (u32)(sc->device->lun >> 32);
+		rec->host_scribble = (unsigned long)sc->host_scribble;
+
+		memcpy(rec->scsi_opcode, sc->cmnd,
+		       min_t(int, sc->cmd_len, ZFCP_DBF_SCSI_OPCODE));
+	} else {
+		rec->scsi_result = ~0;
+		rec->scsi_retries = ~0;
+		rec->scsi_allowed = ~0;
+		rec->scsi_id = sdev->id;
+		rec->scsi_lun = (u32)sdev->lun;
+		rec->scsi_lun_64_hi = (u32)(sdev->lun >> 32);
+		rec->host_scribble = ~0;
+
+		memset(rec->scsi_opcode, 0xff, ZFCP_DBF_SCSI_OPCODE);
+	}
 
 	if (fsf) {
 		rec->fsf_req_id = fsf->req_id;
diff --git a/drivers/s390/scsi/zfcp_dbf.h b/drivers/s390/scsi/zfcp_dbf.h
index e2a973cd2573..d116c07ed77a 100644
--- a/drivers/s390/scsi/zfcp_dbf.h
+++ b/drivers/s390/scsi/zfcp_dbf.h
@@ -359,7 +359,7 @@ void _zfcp_dbf_scsi(char *tag, int level, struct scsi_cmnd *scmd,
 					scmd->device->host->hostdata[0];
 
 	if (debug_level_enabled(adapter->dbf->scsi, level))
-		zfcp_dbf_scsi(tag, level, scmd, req);
+		zfcp_dbf_scsi_common(tag, level, scmd->device, scmd, req);
 }
 
 /**
@@ -402,16 +402,23 @@ void zfcp_dbf_scsi_abort(char *tag, struct scsi_cmnd *scmd,
 }
 
 /**
- * zfcp_dbf_scsi_devreset - trace event for Logical Unit or Target Reset
- * @tag: tag indicating success or failure of reset operation
- * @scmnd: SCSI command which caused this error recovery
- * @flag: indicates type of reset (Target Reset, Logical Unit Reset)
+ * zfcp_dbf_scsi_devreset() - Trace event for Logical Unit or Target Reset.
+ * @tag: Tag indicating success or failure of reset operation.
+ * @sdev: Pointer to SCSI device as context for this event.
+ * @flag: Indicates type of reset (Target Reset, Logical Unit Reset).
+ * @fsf_req: Pointer to FSF request representing the TMF, or NULL.
  */
 static inline
-void zfcp_dbf_scsi_devreset(char *tag, struct scsi_cmnd *scmnd, u8 flag,
+void zfcp_dbf_scsi_devreset(char *tag, struct scsi_device *sdev, u8 flag,
 			    struct zfcp_fsf_req *fsf_req)
 {
+	struct zfcp_adapter *adapter = (struct zfcp_adapter *)
+					sdev->host->hostdata[0];
 	char tmp_tag[ZFCP_DBF_TAG_LEN];
+	static int const level = 1;
+
+	if (unlikely(!debug_level_enabled(adapter->dbf->scsi, level)))
+		return;
 
 	if (flag == FCP_TMF_TGT_RESET)
 		memcpy(tmp_tag, "tr_", 3);
@@ -419,7 +426,7 @@ void zfcp_dbf_scsi_devreset(char *tag, struct scsi_cmnd *scmnd, u8 flag,
 		memcpy(tmp_tag, "lr_", 3);
 
 	memcpy(&tmp_tag[3], tag, 4);
-	_zfcp_dbf_scsi(tmp_tag, 1, scmnd, fsf_req);
+	zfcp_dbf_scsi_common(tmp_tag, level, sdev, NULL, fsf_req);
 }
 
 /**
diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 3299bd345076..78bcd80d0509 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -47,8 +47,9 @@ extern void zfcp_dbf_hba_basic(char *, struct zfcp_adapter *);
 extern void zfcp_dbf_san_req(char *, struct zfcp_fsf_req *, u32);
 extern void zfcp_dbf_san_res(char *, struct zfcp_fsf_req *);
 extern void zfcp_dbf_san_in_els(char *, struct zfcp_fsf_req *);
-extern void zfcp_dbf_scsi(char *, int, struct scsi_cmnd *,
-			  struct zfcp_fsf_req *);
+extern void zfcp_dbf_scsi_common(char *tag, int level, struct scsi_device *sdev,
+				 struct scsi_cmnd *sc,
+				 struct zfcp_fsf_req *fsf);
 extern void zfcp_dbf_scsi_eh(char *tag, struct zfcp_adapter *adapter,
 			     unsigned int scsi_id, int ret);
 
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 478e7ef9ea2f..0afc546b71df 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -267,7 +267,8 @@ static void zfcp_scsi_forget_cmnds(struct zfcp_scsi_dev *zsdev, u8 tm_flags)
 
 static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 {
-	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(scpnt->device);
+	struct scsi_device *sdev = scpnt->device;
+	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
 	struct zfcp_fsf_req *fsf_req = NULL;
 	int retval = SUCCESS, ret;
@@ -278,32 +279,32 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 		if (fsf_req)
 			break;
 
-		zfcp_dbf_scsi_devreset("wait", scpnt, tm_flags, NULL);
+		zfcp_dbf_scsi_devreset("wait", sdev, tm_flags, NULL);
 		zfcp_erp_wait(adapter);
 		ret = fc_block_scsi_eh(scpnt);
 		if (ret) {
-			zfcp_dbf_scsi_devreset("fiof", scpnt, tm_flags, NULL);
+			zfcp_dbf_scsi_devreset("fiof", sdev, tm_flags, NULL);
 			return ret;
 		}
 
 		if (!(atomic_read(&adapter->status) &
 		      ZFCP_STATUS_COMMON_RUNNING)) {
-			zfcp_dbf_scsi_devreset("nres", scpnt, tm_flags, NULL);
+			zfcp_dbf_scsi_devreset("nres", sdev, tm_flags, NULL);
 			return SUCCESS;
 		}
 	}
 	if (!fsf_req) {
-		zfcp_dbf_scsi_devreset("reqf", scpnt, tm_flags, NULL);
+		zfcp_dbf_scsi_devreset("reqf", sdev, tm_flags, NULL);
 		return FAILED;
 	}
 
 	wait_for_completion(&fsf_req->completion);
 
 	if (fsf_req->status & ZFCP_STATUS_FSFREQ_TMFUNCFAILED) {
-		zfcp_dbf_scsi_devreset("fail", scpnt, tm_flags, fsf_req);
+		zfcp_dbf_scsi_devreset("fail", sdev, tm_flags, fsf_req);
 		retval = FAILED;
 	} else {
-		zfcp_dbf_scsi_devreset("okay", scpnt, tm_flags, fsf_req);
+		zfcp_dbf_scsi_devreset("okay", sdev, tm_flags, fsf_req);
 		zfcp_scsi_forget_cmnds(zfcp_sdev, tm_flags);
 	}
 
-- 
2.16.3
