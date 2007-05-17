From: Christoph Hellwig <hch@lst.de>
Date: Thu, 17 May 2007 18:40:30 +0000
Subject: [PATCH] raw3270: use mutex instead of semaphore
Message-Id: <20070517184030.GA19525@lst.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/s390/char/raw3270.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/raw3270.c	2007-05-13 17:08:02.000000000 +0200
+++ linux-2.6/drivers/s390/char/raw3270.c	2007-05-13 17:09:06.000000000 +0200
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
 
