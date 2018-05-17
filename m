From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:03 +0000
Subject: [PATCH 21/25] zfcp: support SCSI_ADAPTER_RESET via scsi_host sysfs attribute host_reset
Message-Id: <20180517171507.18237-22-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Make use of feature introduced with v3.2 commit 294436914454
("[SCSI] scsi: Added support for adapter and firmware reset").
The common code interface was introduced for commit 95d31262b3c1
("[SCSI] qla4xxx: Added support for adapter and firmware reset").

$ echo adapter > /sys/class/scsi_host/host<N>/host_reset

Example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : REC
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1                      ZFCP_DBF_REC_TRIG
Tag            : scshr_y                SCSI sysfs host_reset yes
LUN            : 0xffffffffffffffff                     none (invalid)
WWPN           : 0x0000000000000000                     none (invalid)
D_ID           : 0x00000000                             none (invalid)
Adapter status : 0x4500050b
Port status    : 0x00000000                             none (invalid)
LUN status     : 0x00000000                             none (invalid)
Ready count    : 0x00000001
Running count  : 0x00000000
ERP want       : 0x04                   ZFCP_ERP_ACTION_REOPEN_ADAPTER
ERP need       : 0x04                   ZFCP_ERP_ACTION_REOPEN_ADAPTER

This is the common code equivalent to the zfcp-specific
&dev_attr_adapter_failed.attr in zfcp_sysfs_adapter_attrs.attrs[]:

$ echo 0 > /sys/bus/ccw/drivers/zfcp/<devbusid>/failed

The unsupported case returns EOPNOTSUPP:

$ echo firmware > /sys/class/scsi_host/host<N>/host_reset
-bash: echo: write error: Operation not supported

Example trace record formatted with zfcpdbf from s390-tools:

Timestamp      : ...
Area           : SCSI
Subarea        : 00
Level          : 1
Exception      : -
CPU ID         : ..
Caller         : 0x...
Record ID      : 1
Tag            : scshr_n                        SCSI sysfs host_reset no
Request ID     : 0x0000000000000000                     none (invalid)
SCSI ID        : 0xffffffff                             none (invalid)
SCSI LUN       : 0xffffffff                             none (invalid)
SCSI LUN high  : 0xffffffff                             none (invalid)
SCSI result    : 0xffffffa1                     -EOPNOTSUPP==-95
SCSI retries   : 0xff                                   none (invalid)
SCSI allowed   : 0xff                                   none (invalid)
SCSI scribble  : 0xffffffffffffffff                     none (invalid)
SCSI opcode    : ffffffff ffffffff ffffffff ffffffff    none (invalid)
FCP rsp inf cod: 0xff                                   none (invalid)
FCP rsp IU     : 00000000 00000000 00000000 00000000    none (invalid)
                 00000000 00000000

For any other invalid value, common code returns EINVAL without invoking
our callback:

$ echo foo > /sys/class/scsi_host/host<N>/host_reset
-bash: echo: write error: Invalid argument

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c   | 11 +++++++++++
 drivers/s390/scsi/zfcp_ext.h   |  1 +
 drivers/s390/scsi/zfcp_scsi.c  | 26 ++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_sysfs.c |  5 +----
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 2968d2f57788..e7e6b63905e2 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -1691,3 +1691,14 @@ void zfcp_erp_clear_lun_status(struct scsi_device *sdev, u32 mask)
 		atomic_set(&zfcp_sdev->erp_counter, 0);
 }
 
+/**
+ * zfcp_erp_adapter_reset_sync() - Really reopen adapter and wait.
+ * @adapter: Pointer to zfcp_adapter to reopen.
+ * @id: Trace tag string of length %ZFCP_DBF_TAG_LEN.
+ */
+void zfcp_erp_adapter_reset_sync(struct zfcp_adapter *adapter, char *id)
+{
+	zfcp_erp_set_adapter_status(adapter, ZFCP_STATUS_COMMON_RUNNING);
+	zfcp_erp_adapter_reopen(adapter, ZFCP_STATUS_COMMON_ERP_FAILED, id);
+	zfcp_erp_wait(adapter);
+}
diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index ad7c28ffd49f..f3b55cce748a 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -76,6 +76,7 @@ extern void zfcp_erp_thread_kill(struct zfcp_adapter *);
 extern void zfcp_erp_wait(struct zfcp_adapter *);
 extern void zfcp_erp_notify(struct zfcp_erp_action *, unsigned long);
 extern void zfcp_erp_timeout_handler(struct timer_list *t);
+extern void zfcp_erp_adapter_reset_sync(struct zfcp_adapter *adapter, char *id);
 
 /* zfcp_fc.c */
 extern struct kmem_cache *zfcp_fc_req_cache;
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index f69ef78ea930..9a01f583e562 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -372,6 +372,31 @@ static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *scpnt)
 	return ret;
 }
 
+/**
+ * zfcp_scsi_sysfs_host_reset() - Support scsi_host sysfs attribute host_reset.
+ * @shost: Pointer to Scsi_Host to perform action on.
+ * @reset_type: We support %SCSI_ADAPTER_RESET but not %SCSI_FIRMWARE_RESET.
+ *
+ * Return: 0 on %SCSI_ADAPTER_RESET, -%EOPNOTSUPP otherwise.
+ *
+ * This is similar to zfcp_sysfs_adapter_failed_store().
+ */
+static int zfcp_scsi_sysfs_host_reset(struct Scsi_Host *shost, int reset_type)
+{
+	struct zfcp_adapter *adapter =
+		(struct zfcp_adapter *)shost->hostdata[0];
+	int ret = 0;
+
+	if (reset_type != SCSI_ADAPTER_RESET) {
+		ret = -EOPNOTSUPP;
+		zfcp_dbf_scsi_eh("scshr_n", adapter, ~0, ret);
+		return ret;
+	}
+
+	zfcp_erp_adapter_reset_sync(adapter, "scshr_y");
+	return ret;
+}
+
 struct scsi_transport_template *zfcp_scsi_transport_template;
 
 static struct scsi_host_template zfcp_scsi_host_template = {
@@ -387,6 +412,7 @@ static struct scsi_host_template zfcp_scsi_host_template = {
 	.slave_configure	 = zfcp_scsi_slave_configure,
 	.slave_destroy		 = zfcp_scsi_slave_destroy,
 	.change_queue_depth	 = scsi_change_queue_depth,
+	.host_reset		 = zfcp_scsi_sysfs_host_reset,
 	.proc_name		 = "zfcp",
 	.can_queue		 = 4096,
 	.this_id		 = -1,
diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 3ac823f2540f..b277be6f7611 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -200,10 +200,7 @@ static ssize_t zfcp_sysfs_adapter_failed_store(struct device *dev,
 		goto out;
 	}
 
-	zfcp_erp_set_adapter_status(adapter, ZFCP_STATUS_COMMON_RUNNING);
-	zfcp_erp_adapter_reopen(adapter, ZFCP_STATUS_COMMON_ERP_FAILED,
-				"syafai2");
-	zfcp_erp_wait(adapter);
+	zfcp_erp_adapter_reset_sync(adapter, "syafai2");
 out:
 	zfcp_ccw_adapter_put(adapter);
 	return retval ? retval : (ssize_t) count;
-- 
2.16.3
