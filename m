Return-Path: <linux-kernel-owner+w=401wt.eu-S1031412AbXEDQwq@vger.kernel.org>
Message-Id: <20070504165242.293966755@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/9] dasd: New read device characteristics and read configuration data.
Content-Disposition: inline; filename=011-cio-deprecate2.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Instead of the deprecated read_dev_chars() and read_conf_data_lpm(),
implement dasd_generic_read_dev_chars() and dasd_eckd_read_conf_lpm().
These should even recover better from error than the original cio
functions.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c      |   45 ++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.c |   81 +++++++++++++++++++++++++++++++++++++++--
 drivers/s390/block/dasd_fba.c  |    2 -
 drivers/s390/block/dasd_int.h  |    2 +
 4 files changed, 126 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd.c	2007-05-04 18:50:15.000000000 +0200
@@ -2174,6 +2174,51 @@
 	return ret;
 }
 
+struct dasd_ccw_req * dasd_generic_build_rdc(struct dasd_device *device,
+					     void *rdc_buffer,
+					     int rdc_buffer_size, char *magic)
+{
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+
+	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device);
+
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "Could not allocate RDC request");
+		return cqr;
+	}
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = CCW_CMD_RDC;
+	ccw->cda = (__u32)(addr_t)rdc_buffer;
+	ccw->count = rdc_buffer_size;
+
+	cqr->device = device;
+	cqr->expires = 10*HZ;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 2;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
+}
+
+
+int dasd_generic_read_dev_chars(struct dasd_device *device, char *magic,
+				void **rdc_buffer, int rdc_buffer_size)
+{
+	int ret;
+	struct dasd_ccw_req *cqr;
+
+	cqr = dasd_generic_build_rdc(device, *rdc_buffer, rdc_buffer_size,
+				     magic);
+	if (IS_ERR(cqr))
+		return PTR_ERR(cqr);
+
+	ret = dasd_sleep_on(cqr);
+	dasd_sfree_request(cqr, cqr->device);
+	return ret;
+}
 
 static int __init
 dasd_init(void)
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c	2007-05-04 18:50:15.000000000 +0200
@@ -450,6 +450,81 @@
 	return 0;
 }
 
+struct dasd_ccw_req * dasd_eckd_build_rcd_lpm(struct dasd_device *device,
+					      void *rcd_buffer,
+					      struct ciw *ciw, __u8 lpm)
+{
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+
+	cqr = dasd_smalloc_request("ECKD", 1 /* RCD */, ciw->count, device);
+
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "Could not allocate RCD request");
+		return cqr;
+	}
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = ciw->cmd;
+	ccw->cda = (__u32)(addr_t)rcd_buffer;
+	ccw->count = ciw->count;
+
+	cqr->device = device;
+	cqr->expires = 10*HZ;
+	cqr->lpm = lpm;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 2;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
+}
+
+static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
+				   void **rcd_buffer,
+				   int *rcd_buffer_size, __u8 lpm)
+{
+	struct ciw *ciw;
+	char *rcd_buf = NULL;
+	int ret;
+	struct dasd_ccw_req *cqr;
+
+	/*
+	 * scan for RCD command in extended SenseID data
+	 */
+	ciw = ccw_device_get_ciw(device->cdev, CIW_TYPE_RCD);
+	if (!ciw || ciw->cmd == 0) {
+		ret = -EOPNOTSUPP;
+		goto out_error;
+	}
+	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
+	if (!rcd_buf) {
+		ret = -ENOMEM;
+		goto out_error;
+	}
+	cqr = dasd_eckd_build_rcd_lpm(device, rcd_buf, ciw, lpm);
+	if (IS_ERR(cqr)) {
+		ret =  PTR_ERR(cqr);
+		goto out_error;
+	}
+	ret = dasd_sleep_on(cqr);
+	/*
+	 * on success we update the user input parms
+	 */
+	dasd_sfree_request(cqr, cqr->device);
+	if (ret)
+		goto out_error;
+
+	*rcd_buffer_size = ciw->count;
+	*rcd_buffer = rcd_buf;
+	return 0;
+out_error:
+	kfree(rcd_buf);
+	*rcd_buffer = NULL;
+	*rcd_buffer_size = 0;
+	return ret;
+}
+
 static int
 dasd_eckd_read_conf(struct dasd_device *device)
 {
@@ -469,8 +544,8 @@
 	/* get configuration data per operational path */
 	for (lpm = 0x80; lpm; lpm>>= 1) {
 		if (lpm & path_data->opm){
-			rc = read_conf_data_lpm(device->cdev, &conf_data,
-						&conf_len, lpm);
+			rc = dasd_eckd_read_conf_lpm(device, &conf_data,
+						     &conf_len, lpm);
 			if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
 				MESSAGE(KERN_WARNING,
 					"Read configuration data returned "
@@ -639,7 +714,7 @@
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	memset(rdc_data, 0, sizeof(rdc_data));
-	rc = read_dev_chars(device->cdev, &rdc_data, 64);
+	rc = dasd_generic_read_dev_chars(device, "ECKD", &rdc_data, 64);
 	if (rc)
 		DEV_MESSAGE(KERN_WARNING, device,
 			    "Read device characteristics returned "
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd_fba.c	2007-05-04 18:50:15.000000000 +0200
@@ -135,7 +135,7 @@
 	}
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
-	rc = read_dev_chars(device->cdev, &rdc_data, 32);
+	rc = dasd_generic_read_dev_chars(device, "FBA ", &rdc_data, 32);
 	if (rc) {
 		DEV_MESSAGE(KERN_WARNING, device,
 			    "Read device characteristics returned error %d",
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/block/dasd_int.h	2007-05-04 18:50:15.000000000 +0200
@@ -509,6 +509,8 @@
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
 
+int dasd_generic_read_dev_chars(struct dasd_device *, char *, void **, int);
+
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
