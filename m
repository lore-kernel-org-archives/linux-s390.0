Return-Path: <linux-kernel-owner+w=401wt.eu-S1756268AbZKMPKQ@vger.kernel.org>
Message-Id: <20091113150918.461648826@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:15 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 51/52] [PATCH] cio: improve error recovery for internal I/Os
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=150-cio-internal-errors.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Improve error recovery for internal I/Os by repeating each I/O
256 times per path to cope with long-running non-permanent error
conditions. Also retry each path twice to cope with link flapping,
i.e. single paths becoming unavailable in the order in which they
are tried.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwreq.c      |    7 ++++---
 drivers/s390/cio/device_id.c   |    2 +-
 drivers/s390/cio/device_pgid.c |    2 +-
 drivers/s390/cio/io_sch.h      |    2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/ccwreq.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwreq.c	2009-11-13 16:08:19.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/ccwreq.c	2009-11-13 16:08:23.000000000 +0100
@@ -82,7 +82,7 @@
 		/* Perform start function. */
 		sch->lpm = 0xff;
 		memset(&cdev->private->irb, 0, sizeof(struct irb));
-		rc = cio_start(sch, cp, req->mask);
+		rc = cio_start(sch, cp, (u8) req->mask);
 		if (rc == 0) {
 			/* I/O started successfully. */
 			ccw_device_set_timeout(cdev, req->timeout);
@@ -116,7 +116,8 @@
 {
 	struct ccw_request *req = &cdev->private->req;
 
-	req->mask	= 0x80;
+	/* Try all paths twice to counter link flapping. */
+	req->mask	= 0x8080;
 	req->retries	= req->maxretries;
 	req->mask	= lpm_adjust(req->mask, req->lpm);
 	req->drc	= 0;
@@ -212,7 +213,7 @@
 	}  __attribute__ ((packed)) data;
 	data.dev_id	= cdev->private->dev_id;
 	data.retries	= req->retries;
-	data.lpm	= req->mask;
+	data.lpm	= (u8) req->mask;
 	data.status	= (u8) status;
 	CIO_TRACE_EVENT(2, "reqstat");
 	CIO_HEX_EVENT(2, &data, sizeof(data));
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c	2009-11-13 16:08:20.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_id.c	2009-11-13 16:08:23.000000000 +0100
@@ -21,7 +21,7 @@
 #include "device.h"
 #include "io_sch.h"
 
-#define SENSE_ID_RETRIES	5
+#define SENSE_ID_RETRIES	256
 #define SENSE_ID_TIMEOUT	(10 * HZ)
 #define SENSE_ID_MIN_LEN	4
 #define SENSE_ID_BASIC_LEN	7
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_pgid.c	2009-11-13 16:08:23.000000000 +0100
@@ -20,7 +20,7 @@
 #include "device.h"
 #include "io_sch.h"
 
-#define PGID_RETRIES	5
+#define PGID_RETRIES	256
 #define PGID_TIMEOUT	(10 * HZ)
 
 /*
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:22.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:23.000000000 +0100
@@ -109,7 +109,7 @@
 	void (*callback)(struct ccw_device *, void *, int);
 	void *data;
 	/* These fields are used internally. */
-	u8 mask;
+	u16 mask;
 	u16 retries;
 	int drc;
 	int cancel:1;
