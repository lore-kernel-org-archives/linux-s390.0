Return-Path: <linux-kernel-owner+w=401wt.eu-S1755644AbZHNL00@vger.kernel.org>
Message-Id: <20090814112614.922628278@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/34] dasd: optimize cpu usage in goodcase
Content-Disposition: inline; filename=109-dasd-cpu-usage.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

remove unnecessary dbf call, remove string operations for magic

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c       |   21 +++++++-----------
 drivers/s390/block/dasd_alias.c |    3 --
 drivers/s390/block/dasd_diag.c  |    3 --
 drivers/s390/block/dasd_eckd.c  |   45 ++++++++++++++++------------------------
 drivers/s390/block/dasd_eer.c   |    2 -
 drivers/s390/block/dasd_fba.c   |    7 ++----
 drivers/s390/block/dasd_int.h   |   11 +++++++--
 7 files changed, 41 insertions(+), 51 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_alias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_alias.c
+++ quilt-2.6/drivers/s390/block/dasd_alias.c
@@ -379,8 +379,7 @@ static int read_unit_address_configurati
 	int rc;
 	unsigned long flags;
 
-	cqr = dasd_kmalloc_request("ECKD",
-				   1 /* PSF */	+ 1 /* RSSD */ ,
+	cqr = dasd_kmalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data)),
 				   device);
 	if (IS_ERR(cqr))
Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -669,14 +669,14 @@ static void dasd_profile_end(struct dasd
  * memory and 2) dasd_smalloc_request uses the static ccw memory
  * that gets allocated for each device.
  */
-struct dasd_ccw_req *dasd_kmalloc_request(char *magic, int cplength,
+struct dasd_ccw_req *dasd_kmalloc_request(int magic, int cplength,
 					  int datasize,
 					  struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
 
 	/* Sanity checks */
-	BUG_ON( magic == NULL || datasize > PAGE_SIZE ||
+	BUG_ON(datasize > PAGE_SIZE ||
 	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	cqr = kzalloc(sizeof(struct dasd_ccw_req), GFP_ATOMIC);
@@ -700,14 +700,13 @@ struct dasd_ccw_req *dasd_kmalloc_reques
 			return ERR_PTR(-ENOMEM);
 		}
 	}
-	strncpy((char *) &cqr->magic, magic, 4);
-	ASCEBC((char *) &cqr->magic, 4);
+	cqr->magic =  magic;
 	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	dasd_get_device(device);
 	return cqr;
 }
 
-struct dasd_ccw_req *dasd_smalloc_request(char *magic, int cplength,
+struct dasd_ccw_req *dasd_smalloc_request(int magic, int cplength,
 					  int datasize,
 					  struct dasd_device *device)
 {
@@ -717,7 +716,7 @@ struct dasd_ccw_req *dasd_smalloc_reques
 	int size;
 
 	/* Sanity checks */
-	BUG_ON( magic == NULL || datasize > PAGE_SIZE ||
+	BUG_ON(datasize > PAGE_SIZE ||
 	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
@@ -744,8 +743,7 @@ struct dasd_ccw_req *dasd_smalloc_reques
 		cqr->data = data;
  		memset(cqr->data, 0, datasize);
 	}
-	strncpy((char *) &cqr->magic, magic, 4);
-	ASCEBC((char *) &cqr->magic, 4);
+	cqr->magic = magic;
 	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	dasd_get_device(device);
 	return cqr;
@@ -899,9 +897,6 @@ int dasd_start_IO(struct dasd_ccw_req *c
 	switch (rc) {
 	case 0:
 		cqr->status = DASD_CQR_IN_IO;
-		DBF_DEV_EVENT(DBF_DEBUG, device,
-			      "start_IO: request %p started successful",
-			      cqr);
 		break;
 	case -EBUSY:
 		DBF_DEV_EVENT(DBF_DEBUG, device, "%s",
@@ -2533,7 +2528,7 @@ EXPORT_SYMBOL_GPL(dasd_generic_restore_d
 static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 						   void *rdc_buffer,
 						   int rdc_buffer_size,
-						   char *magic)
+						   int magic)
 {
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
@@ -2564,7 +2559,7 @@ static struct dasd_ccw_req *dasd_generic
 }
 
 
-int dasd_generic_read_dev_chars(struct dasd_device *device, char *magic,
+int dasd_generic_read_dev_chars(struct dasd_device *device, int magic,
 				void *rdc_buffer, int rdc_buffer_size)
 {
 	int ret;
Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c
+++ quilt-2.6/drivers/s390/block/dasd_diag.c
@@ -523,8 +523,7 @@ static struct dasd_ccw_req *dasd_diag_bu
 	/* Build the request */
 	datasize = sizeof(struct dasd_diag_req) +
 		count*sizeof(struct dasd_diag_bio);
-	cqr = dasd_smalloc_request(dasd_diag_discipline.name, 0,
-				   datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev);
 	if (IS_ERR(cqr))
 		return cqr;
 
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -730,7 +730,8 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
 
-	cqr = dasd_smalloc_request("ECKD", 1 /* RCD */, ciw->count, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* RCD */, ciw->count,
+				   device);
 
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
@@ -934,8 +935,7 @@ static int dasd_eckd_read_features(struc
 	struct dasd_eckd_private *private;
 
 	private = (struct dasd_eckd_private *) device->private;
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1 /* PSF */	+ 1 /* RSSD */ ,
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_features)),
 				   device);
@@ -998,7 +998,7 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	struct dasd_psf_ssc_data *psf_ssc_data;
 	struct ccw1 *ccw;
 
-	cqr = dasd_smalloc_request("ECKD", 1 /* PSF */ ,
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */ ,
 				  sizeof(struct dasd_psf_ssc_data),
 				  device);
 
@@ -1149,8 +1149,8 @@ dasd_eckd_check_characteristics(struct d
 		goto out_err3;
 
 	/* Read Device Characteristics */
-	rc = dasd_generic_read_dev_chars(device, "ECKD", &private->rdc_data,
-					 64);
+	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
+					 &private->rdc_data, 64);
 	if (rc) {
 		DBF_EVENT(DBF_WARNING,
 			  "Read device characteristics failed, rc=%d for "
@@ -1217,8 +1217,7 @@ dasd_eckd_analysis_ccw(struct dasd_devic
 
 	cplength = 8;
 	datasize = sizeof(struct DE_eckd_data) + 2*sizeof(struct LO_eckd_data);
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   cplength, datasize, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize, device);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -1499,8 +1498,7 @@ dasd_eckd_format_device(struct dasd_devi
 		return ERR_PTR(-EINVAL);
 	}
 	/* Allocate the format ccw request. */
-	fcp = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   cplength, datasize, device);
+	fcp = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize, device);
 	if (IS_ERR(fcp))
 		return fcp;
 
@@ -1783,8 +1781,8 @@ static struct dasd_ccw_req *dasd_eckd_bu
 		datasize += count*sizeof(struct LO_eckd_data);
 	}
 	/* Allocate the ccw request. */
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   cplength, datasize, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
+				   startdev);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -1948,8 +1946,8 @@ static struct dasd_ccw_req *dasd_eckd_bu
 		cidaw * sizeof(unsigned long long);
 
 	/* Allocate the ccw request. */
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   cplength, datasize, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
+				   startdev);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -2249,8 +2247,7 @@ static struct dasd_ccw_req *dasd_eckd_bu
 
 	/* Allocate the ccw request. */
 	itcw_size = itcw_calc_size(0, ctidaw, 0);
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   0, itcw_size, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -2557,8 +2554,7 @@ dasd_eckd_release(struct dasd_device *de
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
@@ -2600,8 +2596,7 @@ dasd_eckd_reserve(struct dasd_device *de
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
@@ -2642,8 +2637,7 @@ dasd_eckd_steal_lock(struct dasd_device 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
@@ -2681,8 +2675,7 @@ dasd_eckd_performance(struct dasd_device
 	struct ccw1 *ccw;
 	int rc;
 
-	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   1 /* PSF */  + 1 /* RSSD */ ,
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */  + 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_perf_stats_t)),
 				   device);
@@ -2828,7 +2821,7 @@ static int dasd_symm_io(struct dasd_devi
 	}
 
 	/* setup CCWs for PSF + RSSD */
-	cqr = dasd_smalloc_request("ECKD", 2 , 0, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 2 , 0, device);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			"Could not allocate initialization request");
@@ -3254,7 +3247,7 @@ int dasd_eckd_restore_device(struct dasd
 
 	/* Read Device Characteristics */
 	memset(&private->rdc_data, 0, sizeof(private->rdc_data));
-	rc = dasd_generic_read_dev_chars(device, "ECKD",
+	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
 					 &private->rdc_data, 64);
 	if (rc) {
 		DBF_EVENT(DBF_WARNING,
Index: quilt-2.6/drivers/s390/block/dasd_eer.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eer.c
+++ quilt-2.6/drivers/s390/block/dasd_eer.c
@@ -464,7 +464,7 @@ int dasd_eer_enable(struct dasd_device *
 	if (!device->discipline || strcmp(device->discipline->name, "ECKD"))
 		return -EPERM;	/* FIXME: -EMEDIUMTYPE ? */
 
-	cqr = dasd_kmalloc_request("ECKD", 1 /* SNSS */,
+	cqr = dasd_kmalloc_request(DASD_ECKD_MAGIC, 1 /* SNSS */,
 				   SNSS_DATA_SIZE, device);
 	if (IS_ERR(cqr))
 		return -ENOMEM;
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c
+++ quilt-2.6/drivers/s390/block/dasd_fba.c
@@ -152,8 +152,8 @@ dasd_fba_check_characteristics(struct da
 	block->base = device;
 
 	/* Read Device Characteristics */
-	rc = dasd_generic_read_dev_chars(device, "FBA ", &private->rdc_data,
-					 32);
+	rc = dasd_generic_read_dev_chars(device, DASD_FBA_MAGIC,
+					 &private->rdc_data, 32);
 	if (rc) {
 		DBF_EVENT(DBF_WARNING, "Read device characteristics returned "
 			  "error %d for device: %s",
@@ -305,8 +305,7 @@ static struct dasd_ccw_req *dasd_fba_bui
 		datasize += (count - 1)*sizeof(struct LO_fba_data);
 	}
 	/* Allocate the ccw request. */
-	cqr = dasd_smalloc_request(dasd_fba_discipline.name,
-				   cplength, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -59,6 +59,11 @@
 #include <asm/dasd.h>
 #include <asm/idals.h>
 
+/* DASD discipline magic */
+#define DASD_ECKD_MAGIC 0xC5C3D2C4
+#define DASD_DIAG_MAGIC 0xC4C9C1C7
+#define DASD_FBA_MAGIC 0xC6C2C140
+
 /*
  * SECTION: Type definitions
  */
@@ -540,9 +545,9 @@ extern struct block_device_operations da
 extern struct kmem_cache *dasd_page_cache;
 
 struct dasd_ccw_req *
-dasd_kmalloc_request(char *, int, int, struct dasd_device *);
+dasd_kmalloc_request(int , int, int, struct dasd_device *);
 struct dasd_ccw_req *
-dasd_smalloc_request(char *, int, int, struct dasd_device *);
+dasd_smalloc_request(int , int, int, struct dasd_device *);
 void dasd_kfree_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_sfree_request(struct dasd_ccw_req *, struct dasd_device *);
 
@@ -587,7 +592,7 @@ void dasd_generic_handle_state_change(st
 int dasd_generic_pm_freeze(struct ccw_device *);
 int dasd_generic_restore_device(struct ccw_device *);
 
-int dasd_generic_read_dev_chars(struct dasd_device *, char *, void *, int);
+int dasd_generic_read_dev_chars(struct dasd_device *, int, void *, int);
 char *dasd_get_sense(struct irb *);
 
 /* externals in dasd_devmap.c */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
