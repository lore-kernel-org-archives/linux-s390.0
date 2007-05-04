Return-Path: <linux-kernel-owner+w=401wt.eu-S1755422AbXEDQzC@vger.kernel.org>
Message-Id: <20070504165242.733308338@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 8/9] tape: New read configuration data.
Content-Disposition: inline; filename=013-cio-deprecate4.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Instead of the deprecated read_conf_data(), implement a new function
tape_3590_read_dev_chars().

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape.h      |    1 +
 drivers/s390/char/tape_3590.c |   29 +++++++++++++++++++++++++----
 drivers/s390/char/tape_3590.h |    4 ++++
 drivers/s390/char/tape_core.c |    3 ++-
 4 files changed, 32 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/char/tape_3590.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_3590.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/char/tape_3590.c	2007-05-04 18:50:16.000000000 +0200
@@ -788,6 +788,7 @@
 	case TO_SIZE:
 	case TO_KEKL_SET:
 	case TO_KEKL_QUERY:
+	case TO_RDC:
 		break;
 	}
 	return TAPE_IO_SUCCESS;
@@ -1549,6 +1550,26 @@
 	return TAPE_IO_STOP;
 }
 
+
+static int tape_3590_read_dev_chars(struct tape_device *device,
+				    struct tape_3590_rdc_data *rdc_data)
+{
+	int rc;
+	struct tape_request *request;
+
+	request = tape_alloc_request(1, sizeof(*rdc_data));
+	if (IS_ERR(request))
+		return PTR_ERR(request);
+	request->op = TO_RDC;
+	tape_ccw_end(request->cpaddr, CCW_CMD_RDC, sizeof(*rdc_data),
+		     request->cpdata);
+	rc = tape_do_io(device, request);
+	if (rc == 0)
+		memcpy(rdc_data, request->cpdata, sizeof(*rdc_data));
+	tape_free_request(request);
+	return rc;
+}
+
 /*
  * Setup device function
  */
@@ -1557,7 +1578,7 @@
 {
 	int rc;
 	struct tape_3590_disc_data *data;
-	char *rdc_data;
+	struct tape_3590_rdc_data *rdc_data;
 
 	DBF_EVENT(6, "3590 device setup\n");
 	data = kzalloc(sizeof(struct tape_3590_disc_data), GFP_KERNEL | GFP_DMA);
@@ -1566,12 +1587,12 @@
 	data->read_back_op = READ_PREVIOUS;
 	device->discdata = data;
 
-	rdc_data = kmalloc(64, GFP_KERNEL | GFP_DMA);
+	rdc_data = kmalloc(sizeof(*rdc_data), GFP_KERNEL | GFP_DMA);
 	if (!rdc_data) {
 		rc = -ENOMEM;
 		goto fail_kmalloc;
 	}
-	rc = read_dev_chars(device->cdev, (void**)&rdc_data, 64);
+	rc = tape_3590_read_dev_chars(device, rdc_data);
 	if (rc) {
 		DBF_LH(3, "Read device characteristics failed!\n");
 		goto fail_kmalloc;
@@ -1579,7 +1600,7 @@
 	rc = tape_std_assign(device);
 	if (rc)
 		goto fail_rdc_data;
-	if (rdc_data[31] == 0x13) {
+	if (rdc_data->data[31] == 0x13) {
 		PRINT_INFO("Device has crypto support\n");
 		data->crypt_info.capability |= TAPE390_CRYPT_SUPPORTED_MASK;
 		tape_3592_disable_crypt(device);
Index: quilt-2.6/drivers/s390/char/tape_3590.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_3590.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/char/tape_3590.h	2007-05-04 18:50:16.000000000 +0200
@@ -129,6 +129,10 @@
 	char pad2[116];
 } __attribute__ ((packed));
 
+struct tape_3590_rdc_data {
+	char data[64];
+} __attribute__ ((packed));
+
 /* Datastructures for 3592 encryption support */
 
 struct tape3592_kekl {
Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/char/tape_core.c	2007-05-04 18:50:16.000000000 +0200
@@ -73,7 +73,7 @@
 	[TO_DIS] = "DIS",	[TO_ASSIGN] = "ASS",
 	[TO_UNASSIGN] = "UAS",  [TO_CRYPT_ON] = "CON",
 	[TO_CRYPT_OFF] = "COF",	[TO_KEKL_SET] = "KLS",
-	[TO_KEKL_QUERY] = "KLQ",
+	[TO_KEKL_QUERY] = "KLQ",[TO_RDC] = "RDC",
 };
 
 static int
@@ -911,6 +911,7 @@
 		case TO_ASSIGN:
 		case TO_UNASSIGN:
 		case TO_READ_ATTMSG:
+		case TO_RDC:
 			if (device->tape_state == TS_INIT)
 				break;
 			if (device->tape_state == TS_UNUSED)
Index: quilt-2.6/drivers/s390/char/tape.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/char/tape.h	2007-05-04 18:50:16.000000000 +0200
@@ -103,6 +103,7 @@
 	TO_CRYPT_OFF,	/* Disable encrpytion */
 	TO_KEKL_SET,	/* Set KEK label */
 	TO_KEKL_QUERY,	/* Query KEK label */
+	TO_RDC,		/* Read device characteristics */
 	TO_SIZE,	/* #entries in tape_op_t */
 };
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
