Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Jun 2018 19:40:05 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [GIT PULL] two more s390 bug fixes for 4.17
In-Reply-To: <alpine.LFD.2.21.1805301425580.1717@schleppi>
References: <20180530075920.1f73275a@mschwideX1> <20180530074130.GA6927@infradead.org> <alpine.LFD.2.21.1805301425580.1717@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1806081921190.1720@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello,

On Wed, 30 May 2018, Sebastian Ott wrote:
> On Wed, 30 May 2018, Christoph Hellwig wrote:
> > > -	req->completion_data = cqr;
> > > +	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
> > > +
> > 
> > Please don't play such tricks.  In general your driver structure
> > should have struct request embedded.

OK. I did that. Executive summary:

@@ -3077,7 +3078,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
        unsigned long flags;
        int rc = 0;
 
-       cqr = *((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req));
+       cqr = blk_mq_rq_to_pdu(req);
        if (!cqr)
                return BLK_EH_NOT_HANDLED;
 
@@ -3179,7 +3180,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
        int rc;
 
        block->tag_set.ops = &dasd_mq_ops;
-       block->tag_set.cmd_size = sizeof(struct dasd_ccw_req *);
+       block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);


If you agree with this I'll prepare that one for inclusion via Martins
tree.

Regards,
Sebastian

------->8

From 72470aaf8721e3cff9aac9f1095c22c66164eb7f Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott@linux.ibm.com>
Date: Mon, 4 Jun 2018 19:07:39 +0200
Subject: [PATCH] s390/dasd: move dasd_ccw_req to per request data

Let the block layer allocate per request data to store
struct dasd_ccw_req. We still need extra preallocated
memory for usage by ccw programs (which vary in length)
and for requests which don't originate from the block
layer.

Link: https://lkml.kernel.org/r/20180530074130.GA6927@infradead.org
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 46 ++++++++++++++++++++++--------------------
 drivers/s390/block/dasd_diag.c |  3 ++-
 drivers/s390/block/dasd_eckd.c | 46 +++++++++++++++++++++++-------------------
 drivers/s390/block/dasd_fba.c  |  6 ++++--
 drivers/s390/block/dasd_int.h  |  3 ++-
 5 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ed039ab..a8ffbac 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1267,35 +1267,37 @@ struct dasd_ccw_req *dasd_kmalloc_request(int magic, int cplength,
 }
 EXPORT_SYMBOL(dasd_kmalloc_request);
 
-struct dasd_ccw_req *dasd_smalloc_request(int magic, int cplength,
-					  int datasize,
-					  struct dasd_device *device)
+struct dasd_ccw_req *dasd_smalloc_request(int magic, int cplength, int datasize,
+					  struct dasd_device *device,
+					  struct dasd_ccw_req *cqr)
 {
 	unsigned long flags;
-	struct dasd_ccw_req *cqr;
-	char *data;
-	int size;
+	char *data, *chunk;
+	int size = 0;
 
-	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
 		size += cplength * sizeof(struct ccw1);
 	if (datasize > 0)
 		size += datasize;
+	if (!cqr)
+		size += (sizeof(*cqr) + 7L) & -8L;
+
 	spin_lock_irqsave(&device->mem_lock, flags);
-	cqr = (struct dasd_ccw_req *)
-		dasd_alloc_chunk(&device->ccw_chunks, size);
+	data = chunk = dasd_alloc_chunk(&device->ccw_chunks, size);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
-	if (cqr == NULL)
+	if (!chunk)
 		return ERR_PTR(-ENOMEM);
-	memset(cqr, 0, sizeof(struct dasd_ccw_req));
-	data = (char *) cqr + ((sizeof(struct dasd_ccw_req) + 7L) & -8L);
-	cqr->cpaddr = NULL;
+	if (!cqr) {
+		cqr = (void *) data;
+		data += (sizeof(*cqr) + 7L) & -8L;
+	}
+	memset(cqr, 0, sizeof(*cqr));
+	cqr->mem_chunk = chunk;
 	if (cplength > 0) {
-		cqr->cpaddr = (struct ccw1 *) data;
-		data += cplength*sizeof(struct ccw1);
-		memset(cqr->cpaddr, 0, cplength*sizeof(struct ccw1));
+		cqr->cpaddr = data;
+		data += cplength * sizeof(struct ccw1);
+		memset(cqr->cpaddr, 0, cplength * sizeof(struct ccw1));
 	}
-	cqr->data = NULL;
 	if (datasize > 0) {
 		cqr->data = data;
  		memset(cqr->data, 0, datasize);
@@ -1333,7 +1335,7 @@ void dasd_sfree_request(struct dasd_ccw_req *cqr, struct dasd_device *device)
 	unsigned long flags;
 
 	spin_lock_irqsave(&device->mem_lock, flags);
-	dasd_free_chunk(&device->ccw_chunks, cqr);
+	dasd_free_chunk(&device->ccw_chunks, cqr->mem_chunk);
 	spin_unlock_irqrestore(&device->mem_lock, flags);
 	dasd_put_device(device);
 }
@@ -3046,7 +3048,6 @@ static blk_status_t do_dasd_request(struct blk_mq_hw_ctx *hctx,
 	cqr->callback_data = req;
 	cqr->status = DASD_CQR_FILLED;
 	cqr->dq = dq;
-	*((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req)) = cqr;
 
 	blk_mq_start_request(req);
 	spin_lock(&block->queue_lock);
@@ -3077,7 +3078,7 @@ enum blk_eh_timer_return dasd_times_out(struct request *req, bool reserved)
 	unsigned long flags;
 	int rc = 0;
 
-	cqr = *((struct dasd_ccw_req **) blk_mq_rq_to_pdu(req));
+	cqr = blk_mq_rq_to_pdu(req);
 	if (!cqr)
 		return BLK_EH_NOT_HANDLED;
 
@@ -3179,7 +3180,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
 	int rc;
 
 	block->tag_set.ops = &dasd_mq_ops;
-	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req *);
+	block->tag_set.cmd_size = sizeof(struct dasd_ccw_req);
 	block->tag_set.nr_hw_queues = DASD_NR_HW_QUEUES;
 	block->tag_set.queue_depth = DASD_MAX_LCU_DEV * DASD_REQ_PER_DEV;
 	block->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
@@ -4043,7 +4044,8 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 	struct ccw1 *ccw;
 	unsigned long *idaw;
 
-	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device);
+	cqr = dasd_smalloc_request(magic, 1 /* RDC */, rdc_buffer_size, device,
+				   NULL);
 
 	if (IS_ERR(cqr)) {
 		/* internal error 13 - Allocating the RDC request failed*/
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 131f198..e1fe024 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -536,7 +536,8 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	/* Build the request */
 	datasize = sizeof(struct dasd_diag_req) +
 		count*sizeof(struct dasd_diag_bio);
-	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index be208e7..bbf95b7 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -886,7 +886,7 @@ static int dasd_eckd_read_conf_lpm(struct dasd_device *device,
 	}
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* RCD */,
 				   0, /* use rcd_buf as data ara */
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			      "Could not allocate RCD request");
@@ -1442,7 +1442,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_features)),
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s", "Could not "
 				"allocate initialization request");
@@ -1504,7 +1504,7 @@ static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */ ,
 				  sizeof(struct dasd_psf_ssc_data),
-				  device);
+				   device, NULL);
 
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
@@ -1815,7 +1815,8 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 
 	cplength = 8;
 	datasize = sizeof(struct DE_eckd_data) + 2*sizeof(struct LO_eckd_data);
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize, device,
+				   NULL);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -2092,7 +2093,8 @@ dasd_eckd_build_check_tcw(struct dasd_device *base, struct format_data_t *fdata,
 	 */
 	itcw_size = itcw_calc_size(0, count, 0);
 
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev,
+				   NULL);
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -2186,7 +2188,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 	cplength += count;
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
-				  startdev);
+				   startdev, NULL);
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -2332,7 +2334,7 @@ dasd_eckd_build_format(struct dasd_device *base,
 	}
 	/* Allocate the format ccw request. */
 	fcp = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength,
-				   datasize, startdev);
+				   datasize, startdev, NULL);
 	if (IS_ERR(fcp))
 		return fcp;
 
@@ -3103,7 +3105,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 	}
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
-				   startdev);
+				   startdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -3262,7 +3264,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength, datasize,
-				   startdev);
+				   startdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
@@ -3595,7 +3597,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 
 	/* Allocate the ccw request. */
 	itcw_size = itcw_calc_size(0, ctidaw, 0);
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -3862,7 +3865,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength,
-				   datasize, startdev);
+				   datasize, startdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -4102,7 +4105,7 @@ dasd_eckd_release(struct dasd_device *device)
 		return -EACCES;
 
 	useglobal = 0;
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device, NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4157,7 +4160,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 		return -EACCES;
 
 	useglobal = 0;
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device, NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4211,7 +4214,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 		return -EACCES;
 
 	useglobal = 0;
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1, 32, device, NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4271,7 +4274,8 @@ static int dasd_eckd_snid(struct dasd_device *device,
 
 	useglobal = 0;
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1,
-				   sizeof(struct dasd_snid_data), device);
+				   sizeof(struct dasd_snid_data), device,
+				   NULL);
 	if (IS_ERR(cqr)) {
 		mutex_lock(&dasd_reserve_mutex);
 		useglobal = 1;
@@ -4331,7 +4335,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */  + 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_perf_stats_t)),
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			    "Could not allocate initialization request");
@@ -4477,7 +4481,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	psf1 = psf_data[1];
 
 	/* setup CCWs for PSF + RSSD */
-	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 2 , 0, device);
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 2, 0, device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			"Could not allocate initialization request");
@@ -5037,7 +5041,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   (sizeof(struct dasd_psf_prssd_data) +
 				    sizeof(struct dasd_rssd_messages)),
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
 				"Could not allocate read message buffer request");
@@ -5126,7 +5130,7 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
 				   sizeof(struct dasd_psf_prssd_data) + 1,
-				   device);
+				   device, NULL);
 	if (IS_ERR(cqr)) {
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
 				"Could not allocate read message buffer request");
@@ -5284,8 +5288,8 @@ dasd_eckd_psf_cuir_response(struct dasd_device *device, int response,
 	int rc;
 
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */ ,
-				  sizeof(struct dasd_psf_cuir_response),
-				  device);
+				   sizeof(struct dasd_psf_cuir_response),
+				   device, NULL);
 
 	if (IS_ERR(cqr)) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index a6b132f..56007a3 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -356,7 +356,8 @@ static struct dasd_ccw_req *dasd_fba_build_cp_discard(
 	datasize = sizeof(struct DE_fba_data) +
 		nr_ccws * (sizeof(struct LO_fba_data) + sizeof(struct ccw1));
 
-	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -490,7 +491,8 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 		datasize += (count - 1)*sizeof(struct LO_fba_data);
 	}
 	/* Allocate the ccw request. */
-	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev);
+	cqr = dasd_smalloc_request(DASD_FBA_MAGIC, cplength, datasize, memdev,
+				   blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 96709b1..0844e5e 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -184,6 +184,7 @@ struct dasd_ccw_req {
 	struct irb irb;			/* device status in case of an error */
 	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
 	void *function; 		/* originating ERP action */
+	void *mem_chunk;
 
 	/* these are for statistics only */
 	unsigned long buildclk;		/* TOD-clock of request generation */
@@ -716,7 +717,7 @@ extern struct kmem_cache *dasd_page_cache;
 struct dasd_ccw_req *
 dasd_kmalloc_request(int , int, int, struct dasd_device *);
 struct dasd_ccw_req *
-dasd_smalloc_request(int , int, int, struct dasd_device *);
+dasd_smalloc_request(int, int, int, struct dasd_device *, struct dasd_ccw_req *);
 void dasd_kfree_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_sfree_request(struct dasd_ccw_req *, struct dasd_device *);
 void dasd_wakeup_cb(struct dasd_ccw_req *, void *);
-- 
2.7.4
