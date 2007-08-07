Return-Path: <linux-kernel-owner+w=401wt.eu-S934006AbXHGLVR@vger.kernel.org>
Message-Id: <20070807111846.623199772@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/18] vmur: add "top of queue" sanity check for reader open
Content-Disposition: inline; filename=008-vmur-open.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

If the z/VM reader is already open, it can happen that after opening the
Linux reader device, not the topmost file is processed. According the
semantics of the Linux z/VM unit record device driver, always the topmost
file has to be processed. With this fix an error is returned if that is
not the case.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmur.c |    7 ++++++-
 drivers/s390/char/vmur.h |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -565,9 +565,14 @@ static int verify_device(struct urdev *u
 			return -ENOMEM;
 		rc = diag_read_file(urd->dev_id.devno, buf);
 		kfree(buf);
-
 		if ((rc != 0) && (rc != -ENODATA)) /* EOF does not hurt */
 			return rc;
+		/* check if the file on top of the queue is open now */
+		rc = diag_read_next_file_info(&fcb, 0);
+		if (rc)
+			return rc;
+		if (!(fcb.file_stat & FLG_IN_USE))
+			return -EMFILE;
 		return 0;
 	default:
 		return -ENOTSUPP;
Index: quilt-2.6/drivers/s390/char/vmur.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.h
+++ quilt-2.6/drivers/s390/char/vmur.h
@@ -53,6 +53,7 @@ struct file_control_block {
 #define FLG_SYSTEM_HOLD	0x04
 #define FLG_CP_DUMP	0x10
 #define FLG_USER_HOLD	0x20
+#define FLG_IN_USE	0x80
 
 /*
  * A struct urdev is created for each ur device that is made available

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
