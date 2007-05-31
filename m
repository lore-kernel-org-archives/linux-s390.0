Return-Path: <linux-kernel-owner+w=401wt.eu-S1758612AbXEaPf3@vger.kernel.org>
Message-Id: <20070531153437.419319599@de.ibm.com>
References: <20070531142024.011160634@de.ibm.com>
Date: Thu, 31 May 2007 16:20:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/7] raw3270: use mutex instead of semaphore
Content-Disposition: inline; filename=004-3270-mutex.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/raw3270.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -487,7 +487,7 @@ struct raw3270_ua {	/* Query Reply struc
 } __attribute__ ((packed));
 
 static struct diag210 raw3270_init_diag210;
-static DECLARE_MUTEX(raw3270_init_sem);
+static DEFINE_MUTEX(raw3270_init_mutex);
 
 static int
 raw3270_init_irq(struct raw3270_view *view, struct raw3270_request *rq,
@@ -713,7 +713,7 @@ raw3270_size_device(struct raw3270 *rp)
 {
 	int rc;
 
-	down(&raw3270_init_sem);
+	mutex_lock(&raw3270_init_mutex);
 	rp->view = &raw3270_init_view;
 	raw3270_init_view.dev = rp;
 	if (MACHINE_IS_VM)
@@ -722,7 +722,7 @@ raw3270_size_device(struct raw3270 *rp)
 		rc = __raw3270_size_device(rp);
 	raw3270_init_view.dev = NULL;
 	rp->view = NULL;
-	up(&raw3270_init_sem);
+	mutex_unlock(&raw3270_init_mutex);
 	if (rc == 0) {	/* Found something. */
 		/* Try to find a model. */
 		rp->model = 0;
@@ -749,7 +749,7 @@ raw3270_reset_device(struct raw3270 *rp)
 {
 	int rc;
 
-	down(&raw3270_init_sem);
+	mutex_lock(&raw3270_init_mutex);
 	memset(&rp->init_request, 0, sizeof(rp->init_request));
 	memset(&rp->init_data, 0, sizeof(rp->init_data));
 	/* Store reset data stream to init_data/init_request */
@@ -764,7 +764,7 @@ raw3270_reset_device(struct raw3270 *rp)
 	rc = raw3270_start_init(rp, &raw3270_init_view, &rp->init_request);
 	raw3270_init_view.dev = NULL;
 	rp->view = NULL;
-	up(&raw3270_init_sem);
+	mutex_unlock(&raw3270_init_mutex);
 	return rc;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
