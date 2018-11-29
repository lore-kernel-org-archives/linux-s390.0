From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 29 Nov 2018 12:09:56 +0000
Subject: [PATCH v2 01/23] zfcp: make DIX experimental, disabled, and independent of DIF
Message-Id: <1543493396-1348-1-git-send-email-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Fedor Loshakov <loshakov@linux.ibm.com>

Introduce separate zfcp module parameters to individually
select support for:
DIF which should work (zfcp.dif, which used to be DIF+DIX, disabled) or
DIX+DIF which can cause trouble (zfcp.dix, new, disabled).

If DIX is enabled, we warn on zfcp driver initialization.
As before, this also reduces the maximum I/O request size to half,
to support the worst case of merged single sector requests with one
protection data scatter gather element per sector. This can impact the
maximum throughput.

In DIF-only mode (zfcp.dif=1 zfcp.dix=0), we can use the full maximum
I/O request size as there is no protection data for zfcp.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Co-developed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Signed-off-by: Fedor Loshakov <loshakov@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
---

Changes in description since v1:
Don't erroneously blame non-zfcp code for DIX issues.
Explain technical reasons why DIF-only mode is interesting for zfcp.

 drivers/s390/scsi/zfcp_aux.c  |  3 +++
 drivers/s390/scsi/zfcp_ext.h  |  1 +
 drivers/s390/scsi/zfcp_scsi.c | 10 +++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 94f4d8fe85e0..08cdc00e8299 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -124,6 +124,9 @@ static int __init zfcp_module_init(void)
 {
 	int retval = -ENOMEM;
 
+	if (zfcp_experimental_dix)
+		pr_warn("DIX is enabled. It is experimental and might cause problems\n");
+
 	zfcp_fsf_qtcb_cache = zfcp_cache_hw_align("zfcp_fsf_qtcb",
 						  sizeof(struct fsf_qtcb));
 	if (!zfcp_fsf_qtcb_cache)
diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index bd0c5a9f04cb..0940bef35020 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -144,6 +144,7 @@ extern void zfcp_qdio_close(struct zfcp_qdio *);
 extern void zfcp_qdio_siosl(struct zfcp_adapter *);
 
 /* zfcp_scsi.c */
+extern bool zfcp_experimental_dix;
 extern struct scsi_transport_template *zfcp_scsi_transport_template;
 extern int zfcp_scsi_adapter_register(struct zfcp_adapter *);
 extern void zfcp_scsi_adapter_unregister(struct zfcp_adapter *);
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index a8efcb330bc1..2b8c33627460 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -27,7 +27,11 @@ MODULE_PARM_DESC(queue_depth, "Default queue depth for new SCSI devices");
 
 static bool enable_dif;
 module_param_named(dif, enable_dif, bool, 0400);
-MODULE_PARM_DESC(dif, "Enable DIF/DIX data integrity support");
+MODULE_PARM_DESC(dif, "Enable DIF data integrity support (default off)");
+
+bool zfcp_experimental_dix;
+module_param_named(dix, zfcp_experimental_dix, bool, 0400);
+MODULE_PARM_DESC(dix, "Enable experimental DIX (data integrity extension) support which implies DIF support (default off)");
 
 static bool allow_lun_scan = true;
 module_param(allow_lun_scan, bool, 0600);
@@ -788,11 +792,11 @@ void zfcp_scsi_set_prot(struct zfcp_adapter *adapter)
 	data_div = atomic_read(&adapter->status) &
 		   ZFCP_STATUS_ADAPTER_DATA_DIV_ENABLED;
 
-	if (enable_dif &&
+	if ((enable_dif || zfcp_experimental_dix) &&
 	    adapter->adapter_features & FSF_FEATURE_DIF_PROT_TYPE1)
 		mask |= SHOST_DIF_TYPE1_PROTECTION;
 
-	if (enable_dif && data_div &&
+	if (zfcp_experimental_dix && data_div &&
 	    adapter->adapter_features & FSF_FEATURE_DIX_PROT_TCPIP) {
 		mask |= SHOST_DIX_TYPE1_PROTECTION;
 		scsi_host_set_guard(shost, SHOST_DIX_GUARD_IP);
-- 
2.16.4
