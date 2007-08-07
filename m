Return-Path: <linux-kernel-owner+w=401wt.eu-S1759303AbXHGLRc@vger.kernel.org>
Message-Id: <20070807111845.904170128@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/18] vmur: allocate single record buffers instead of one big data buffer
Content-Disposition: inline; filename=005-vmur-ccw.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

vmur allocates one contiguous kernel buffer to copy user data when creating
ccw programs for punch or printer. If big block sizes are used, under memory
pressure it can happen, that we do not get memory in one chunk. Now we
allocate memory for each single record to avoid high order allocations.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmur.c |   75 +++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -119,10 +119,12 @@ static void urdev_put(struct urdev *urd)
 /*
  * Low-level functions to do I/O to a ur device.
  *     alloc_chan_prog
+ *     free_chan_prog
  *     do_ur_io
  *     ur_int_handler
  *
  * alloc_chan_prog allocates and builds the channel program
+ * free_chan_prog frees memory of the channel program
  *
  * do_ur_io issues the channel program to the device and blocks waiting
  * on a completion event it publishes at urd->io_done. The function
@@ -137,6 +139,16 @@ static void urdev_put(struct urdev *urd)
  * address pointer that alloc_chan_prog returned.
  */
 
+static void free_chan_prog(struct ccw1 *cpa)
+{
+	struct ccw1 *ptr = cpa;
+
+	while (ptr->cda) {
+		kfree((void *)(addr_t) ptr->cda);
+		ptr++;
+	}
+	kfree(cpa);
+}
 
 /*
  * alloc_chan_prog
@@ -144,44 +156,45 @@ static void urdev_put(struct urdev *urd)
  * with a final NOP CCW command-chained on (which ensures that CE and DE
  * are presented together in a single interrupt instead of as separate
  * interrupts unless an incorrect length indication kicks in first). The
- * data length in each CCW is reclen. The caller must ensure that count
- * is an integral multiple of reclen.
- * The channel program pointer returned by this function must be freed
- * with kfree. The caller is responsible for checking that
- * count/reclen is not ridiculously large.
+ * data length in each CCW is reclen.
  */
-static struct ccw1 *alloc_chan_prog(char *buf, size_t count, size_t reclen)
+static struct ccw1 *alloc_chan_prog(const char __user *ubuf, int rec_count,
+				    int reclen)
 {
-	size_t num_ccws;
 	struct ccw1 *cpa;
+	void *kbuf;
 	int i;
 
-	TRACE("alloc_chan_prog(%p, %zu, %zu)\n", buf, count, reclen);
+	TRACE("alloc_chan_prog(%p, %i, %i)\n", ubuf, rec_count, reclen);
 
 	/*
 	 * We chain a NOP onto the writes to force CE+DE together.
 	 * That means we allocate room for CCWs to cover count/reclen
 	 * records plus a NOP.
 	 */
-	num_ccws = count / reclen + 1;
-	cpa = kmalloc(num_ccws * sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	cpa = kzalloc((rec_count + 1) * sizeof(struct ccw1),
+		      GFP_KERNEL | GFP_DMA);
 	if (!cpa)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; count; i++) {
+	for (i = 0; i < rec_count; i++) {
 		cpa[i].cmd_code = WRITE_CCW_CMD;
 		cpa[i].flags = CCW_FLAG_CC | CCW_FLAG_SLI;
 		cpa[i].count = reclen;
-		cpa[i].cda = __pa(buf);
-		buf += reclen;
-		count -= reclen;
+		kbuf = kmalloc(reclen, GFP_KERNEL | GFP_DMA);
+		if (!kbuf) {
+			free_chan_prog(cpa);
+			return ERR_PTR(-ENOMEM);
+		}
+		cpa[i].cda = (u32)(addr_t) kbuf;
+		if (copy_from_user(kbuf, ubuf, reclen)) {
+			free_chan_prog(cpa);
+			return ERR_PTR(-EFAULT);
+		}
+		ubuf += reclen;
 	}
 	/* The following NOP CCW forces CE+DE to be presented together */
 	cpa[i].cmd_code = CCW_CMD_NOOP;
-	cpa[i].flags = 0;
-	cpa[i].count = 0;
-	cpa[i].cda = 0;
-
 	return cpa;
 }
 
@@ -325,24 +338,11 @@ static ssize_t do_write(struct urdev *ur
 			size_t count, size_t reclen, loff_t *ppos)
 {
 	struct ccw1 *cpa;
-	char *buf;
 	int rc;
 
-	/* Data buffer must be under 2GB line for fmt1 CCWs: hence GFP_DMA */
-	buf = kmalloc(count, GFP_KERNEL | GFP_DMA);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, udata, count)) {
-		rc = -EFAULT;
-		goto fail_kfree_buf;
-	}
-
-	cpa = alloc_chan_prog(buf, count, reclen);
-	if (!cpa) {
-		rc = -ENOMEM;
-		goto fail_kfree_buf;
-	}
+	cpa = alloc_chan_prog(udata, count / reclen, reclen);
+	if (IS_ERR(cpa))
+		return PTR_ERR(cpa);
 
 	rc = do_ur_io(urd, cpa);
 	if (rc)
@@ -354,10 +354,9 @@ static ssize_t do_write(struct urdev *ur
 	}
 	*ppos += count;
 	rc = count;
+
 fail_kfree_cpa:
-	kfree(cpa);
-fail_kfree_buf:
-	kfree(buf);
+	free_chan_prog(cpa);
 	return rc;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
