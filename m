Return-Path: <linux-kernel-owner+w=401wt.eu-S1762337AbXEJN60@vger.kernel.org>
Message-Id: <20070510135644.116452125@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/15] Avoid sparse warnings.
Content-Disposition: inline; filename=006-sparse.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Monthly sparse warning avoidance patch. Sigh.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd.c      |    7 ++++---
 drivers/s390/block/dasd_eckd.c |    6 +++---
 drivers/s390/char/sclp.h       |    3 +++
 drivers/s390/char/sclp_sdias.c |    8 ++++----
 drivers/s390/char/zcore.c      |    9 +++------
 drivers/s390/net/qeth_mpc.c    |    4 ++--
 drivers/s390/scsi/zfcp_aux.c   |    8 +++-----
 drivers/s390/scsi/zfcp_dbf.c   |    2 +-
 include/asm-s390/ipl.h         |    2 +-
 9 files changed, 24 insertions(+), 25 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -2174,9 +2174,10 @@ dasd_generic_notify(struct ccw_device *c
 	return ret;
 }
 
-struct dasd_ccw_req * dasd_generic_build_rdc(struct dasd_device *device,
-					     void *rdc_buffer,
-					     int rdc_buffer_size, char *magic)
+static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
+						   void *rdc_buffer,
+						   int rdc_buffer_size,
+						   char *magic)
 {
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -450,9 +450,9 @@ dasd_eckd_generate_uid(struct dasd_devic
 	return 0;
 }
 
-struct dasd_ccw_req * dasd_eckd_build_rcd_lpm(struct dasd_device *device,
-					      void *rcd_buffer,
-					      struct ciw *ciw, __u8 lpm)
+static struct dasd_ccw_req *dasd_eckd_build_rcd_lpm(struct dasd_device *device,
+						    void *rcd_buffer,
+						    struct ciw *ciw, __u8 lpm)
 {
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h
+++ quilt-2.6/drivers/s390/char/sclp.h
@@ -132,6 +132,9 @@ int sclp_deactivate(void);
 int sclp_reactivate(void);
 int sclp_service_call(sclp_cmdw_t command, void *sccb);
 
+int sclp_sdias_init(void);
+void sclp_sdias_exit(void);
+
 /* useful inlines */
 
 /* VM uses EBCDIC 037, LPAR+native(SE+HMC) use EBCDIC 500 */
Index: quilt-2.6/drivers/s390/char/sclp_sdias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_sdias.c
+++ quilt-2.6/drivers/s390/char/sclp_sdias.c
@@ -66,9 +66,9 @@ static DEFINE_MUTEX(sdias_mutex);
 
 static void sdias_callback(struct sclp_req *request, void *data)
 {
-	struct sdias_sccb *sccb;
+	struct sdias_sccb *cbsccb;
 
-	sccb = (struct sdias_sccb *) request->sccb;
+	cbsccb = (struct sdias_sccb *) request->sccb;
 	sclp_req_done = 1;
 	wake_up(&sdias_wq); /* Inform caller, that request is complete */
 	TRACE("callback done\n");
@@ -229,7 +229,7 @@ out:
 	return rc;
 }
 
-int __init sdias_init(void)
+int __init sclp_sdias_init(void)
 {
 	int rc;
 
@@ -248,7 +248,7 @@ int __init sdias_init(void)
 	return 0;
 }
 
-void __exit sdias_exit(void)
+void __exit sclp_sdias_exit(void)
 {
 	debug_unregister(sdias_dbf);
 	sclp_unregister(&sclp_sdias_register);
Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -21,6 +21,7 @@
 #include <asm/debug.h>
 #include <asm/processor.h>
 #include <asm/irqflags.h>
+#include "sclp.h"
 
 #define TRACE(x...) debug_sprintf_event(zcore_dbf, 1, x)
 #define MSG(x...) printk( KERN_ALERT x )
@@ -564,8 +565,6 @@ static void __init zcore_header_init(int
 	get_cpu_id(&hdr->cpu_id);
 }
 
-extern int sdias_init(void);
-
 static int __init zcore_init(void)
 {
 	unsigned char arch;
@@ -582,7 +581,7 @@ static int __init zcore_init(void)
 	TRACE("wwpn:   %llx\n", (unsigned long long) ipl_info.data.fcp.wwpn);
 	TRACE("lun:    %llx\n", (unsigned long long) ipl_info.data.fcp.lun);
 
-	rc = sdias_init();
+	rc = sclp_sdias_init();
 	if (rc)
 		goto fail;
 
@@ -634,12 +633,10 @@ fail:
 	return rc;
 }
 
-extern void sdias_exit(void);
-
 static void __exit zcore_exit(void)
 {
 	debug_unregister(zcore_dbf);
-	sdias_exit();
+	sclp_sdias_exit();
 	diag308(DIAG308_REL_HSA, NULL);
 }
 
Index: quilt-2.6/drivers/s390/net/qeth_mpc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_mpc.c
+++ quilt-2.6/drivers/s390/net/qeth_mpc.c
@@ -162,7 +162,7 @@ struct ipa_rc_msg {
 	char *msg;
 };
 
-struct ipa_rc_msg qeth_ipa_rc_msg[] = {
+static struct ipa_rc_msg qeth_ipa_rc_msg[] = {
 	{IPA_RC_SUCCESS,		"success"},
 	{IPA_RC_NOTSUPP,		"Command not supported"},
 	{IPA_RC_IP_TABLE_FULL,		"Add Addr IP Table Full - ipv6"},
@@ -226,7 +226,7 @@ struct ipa_cmd_names {
 	char *name;
 };
 
-struct ipa_cmd_names qeth_ipa_cmd_names[] = {
+static struct ipa_cmd_names qeth_ipa_cmd_names[] = {
 	{IPA_CMD_STARTLAN,	"startlan"},
 	{IPA_CMD_STOPLAN,	"stoplan"},
 	{IPA_CMD_SETVMAC,	"setvmac"},
Index: quilt-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -607,8 +607,7 @@ zfcp_sg_list_free(struct zfcp_sg_list *s
  * @sg_count: elements in array
  * Return: size of entire scatter-gather list
  */
-size_t
-zfcp_sg_size(struct scatterlist *sg, unsigned int sg_count)
+static size_t zfcp_sg_size(struct scatterlist *sg, unsigned int sg_count)
 {
 	unsigned int i;
 	struct scatterlist *p;
@@ -975,8 +974,7 @@ zfcp_free_low_mem_buffers(struct zfcp_ad
 		mempool_destroy(adapter->pool.data_gid_pn);
 }
 
-void
-zfcp_dummy_release(struct device *dev)
+static void zfcp_dummy_release(struct device *dev)
 {
 	return;
 }
@@ -1336,7 +1334,7 @@ zfcp_nameserver_enqueue(struct zfcp_adap
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_FC
 
-void
+static void
 zfcp_fsf_incoming_els_rscn(struct zfcp_adapter *adapter,
 			   struct fsf_status_read_buffer *status_buffer)
 {
Index: quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_dbf.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
@@ -478,7 +478,7 @@ static struct debug_view zfcp_hba_dbf_vi
 	NULL
 };
 
-void
+static void
 _zfcp_san_dbf_event_common_ct(const char *tag, struct zfcp_fsf_req *fsf_req,
 			      u32 s_id, u32 d_id, void *buffer, int buflen)
 {
Index: quilt-2.6/include/asm-s390/ipl.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ipl.h
+++ quilt-2.6/include/asm-s390/ipl.h
@@ -79,8 +79,8 @@ struct ipl_parameter_block {
  * IPL validity flags
  */
 extern u32 ipl_flags;
-
 extern u32 dump_prefix_page;
+extern unsigned int zfcpdump_prefix_array[];
 
 extern void do_reipl(void);
 extern void ipl_save_parameters(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
