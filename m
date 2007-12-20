Return-Path: <linux-kernel-owner+w=401wt.eu-S936093AbXLTPcE@vger.kernel.org>
Message-Id: <20071220152113.078998892@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:11 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 46/47] dasd: add hyper PAV support to DASD device driver, part 2
Content-Disposition: inline; filename=145-hyperpav-2.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c | 1661 +++++++++++++++++++++++++---------------------
 1 file changed, 938 insertions(+), 723 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c
+++ quilt-2.6/drivers/s390/block/dasd.c
@@ -48,13 +48,15 @@ MODULE_LICENSE("GPL");
 /*
  * SECTION: prototypes for static functions of dasd.c
  */
-static int  dasd_alloc_queue(struct dasd_device * device);
-static void dasd_setup_queue(struct dasd_device * device);
-static void dasd_free_queue(struct dasd_device * device);
-static void dasd_flush_request_queue(struct dasd_device *);
-static int dasd_flush_ccw_queue(struct dasd_device *, int);
-static void dasd_tasklet(struct dasd_device *);
+static int  dasd_alloc_queue(struct dasd_block *);
+static void dasd_setup_queue(struct dasd_block *);
+static void dasd_free_queue(struct dasd_block *);
+static void dasd_flush_request_queue(struct dasd_block *);
+static int dasd_flush_block_queue(struct dasd_block *);
+static void dasd_device_tasklet(struct dasd_device *);
+static void dasd_block_tasklet(struct dasd_block *);
 static void do_kick_device(struct work_struct *);
+static void dasd_return_cqr_cb(struct dasd_ccw_req *, void *);
 
 /*
  * SECTION: Operations on the device structure.
@@ -65,16 +67,13 @@ static wait_queue_head_t dasd_flush_wq;
 /*
  * Allocate memory for a new device structure.
  */
-struct dasd_device *
-dasd_alloc_device(void)
+struct dasd_device *dasd_alloc_device(void)
 {
 	struct dasd_device *device;
 
-	device = kzalloc(sizeof (struct dasd_device), GFP_ATOMIC);
+	device = kzalloc(sizeof(struct dasd_device), GFP_ATOMIC);
 	if (device == NULL)
 		return ERR_PTR(-ENOMEM);
-	/* open_count = 0 means device online but not in use */
-	atomic_set(&device->open_count, -1);
 
 	/* Get two pages for normal block device operations. */
 	device->ccw_mem = (void *) __get_free_pages(GFP_ATOMIC | GFP_DMA, 1);
@@ -93,10 +92,9 @@ dasd_alloc_device(void)
 	dasd_init_chunklist(&device->ccw_chunks, device->ccw_mem, PAGE_SIZE*2);
 	dasd_init_chunklist(&device->erp_chunks, device->erp_mem, PAGE_SIZE);
 	spin_lock_init(&device->mem_lock);
-	spin_lock_init(&device->request_queue_lock);
-	atomic_set (&device->tasklet_scheduled, 0);
+	atomic_set(&device->tasklet_scheduled, 0);
 	tasklet_init(&device->tasklet,
-		     (void (*)(unsigned long)) dasd_tasklet,
+		     (void (*)(unsigned long)) dasd_device_tasklet,
 		     (unsigned long) device);
 	INIT_LIST_HEAD(&device->ccw_queue);
 	init_timer(&device->timer);
@@ -110,8 +108,7 @@ dasd_alloc_device(void)
 /*
  * Free memory of a device structure.
  */
-void
-dasd_free_device(struct dasd_device *device)
+void dasd_free_device(struct dasd_device *device)
 {
 	kfree(device->private);
 	free_page((unsigned long) device->erp_mem);
@@ -120,10 +117,42 @@ dasd_free_device(struct dasd_device *dev
 }
 
 /*
+ * Allocate memory for a new device structure.
+ */
+struct dasd_block *dasd_alloc_block(void)
+{
+	struct dasd_block *block;
+
+	block = kzalloc(sizeof(*block), GFP_ATOMIC);
+	if (block == NULL)
+		return ERR_PTR(-ENOMEM);
+	/* open_count = 0 means device online but not in use */
+	atomic_set(&block->open_count, -1);
+
+	spin_lock_init(&block->request_queue_lock);
+	atomic_set (&block->tasklet_scheduled, 0);
+	tasklet_init(&block->tasklet,
+		     (void (*)(unsigned long)) dasd_block_tasklet,
+		     (unsigned long) block);
+	INIT_LIST_HEAD(&block->ccw_queue);
+	spin_lock_init(&block->queue_lock);
+	init_timer(&block->timer);
+
+	return block;
+}
+
+/*
+ * Free memory of a device structure.
+ */
+void dasd_free_block(struct dasd_block *block)
+{
+	kfree(block);
+}
+
+/*
  * Make a new device known to the system.
  */
-static int
-dasd_state_new_to_known(struct dasd_device *device)
+static int dasd_state_new_to_known(struct dasd_device *device)
 {
 	int rc;
 
@@ -133,12 +162,13 @@ dasd_state_new_to_known(struct dasd_devi
 	 */
 	dasd_get_device(device);
 
-	rc = dasd_alloc_queue(device);
-	if (rc) {
-		dasd_put_device(device);
-		return rc;
+	if (device->block) {
+		rc = dasd_alloc_queue(device->block);
+		if (rc) {
+			dasd_put_device(device);
+			return rc;
+		}
 	}
-
 	device->state = DASD_STATE_KNOWN;
 	return 0;
 }
@@ -146,21 +176,24 @@ dasd_state_new_to_known(struct dasd_devi
 /*
  * Let the system forget about a device.
  */
-static int
-dasd_state_known_to_new(struct dasd_device * device)
+static int dasd_state_known_to_new(struct dasd_device *device)
 {
 	/* Disable extended error reporting for this device. */
 	dasd_eer_disable(device);
 	/* Forget the discipline information. */
-	if (device->discipline)
+	if (device->discipline) {
+		if (device->discipline->uncheck_device)
+			device->discipline->uncheck_device(device);
 		module_put(device->discipline->owner);
+	}
 	device->discipline = NULL;
 	if (device->base_discipline)
 		module_put(device->base_discipline->owner);
 	device->base_discipline = NULL;
 	device->state = DASD_STATE_NEW;
 
-	dasd_free_queue(device);
+	if (device->block)
+		dasd_free_queue(device->block);
 
 	/* Give up reference we took in dasd_state_new_to_known. */
 	dasd_put_device(device);
@@ -170,19 +203,19 @@ dasd_state_known_to_new(struct dasd_devi
 /*
  * Request the irq line for the device.
  */
-static int
-dasd_state_known_to_basic(struct dasd_device * device)
+static int dasd_state_known_to_basic(struct dasd_device *device)
 {
 	int rc;
 
 	/* Allocate and register gendisk structure. */
-	rc = dasd_gendisk_alloc(device);
-	if (rc)
-		return rc;
-
+	if (device->block) {
+		rc = dasd_gendisk_alloc(device->block);
+		if (rc)
+			return rc;
+	}
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
 	device->debug_area = debug_register(device->cdev->dev.bus_id, 1, 2,
-					    8 * sizeof (long));
+					    8 * sizeof(long));
 	debug_register_view(device->debug_area, &debug_sprintf_view);
 	debug_set_level(device->debug_area, DBF_WARNING);
 	DBF_DEV_EVENT(DBF_EMERG, device, "%s", "debug area created");
@@ -194,16 +227,17 @@ dasd_state_known_to_basic(struct dasd_de
 /*
  * Release the irq line for the device. Terminate any running i/o.
  */
-static int
-dasd_state_basic_to_known(struct dasd_device * device)
+static int dasd_state_basic_to_known(struct dasd_device *device)
 {
 	int rc;
-
-	dasd_gendisk_free(device);
-	rc = dasd_flush_ccw_queue(device, 1);
+	if (device->block) {
+		dasd_gendisk_free(device->block);
+		dasd_block_clear_timer(device->block);
+	}
+	rc = dasd_flush_device_queue(device);
 	if (rc)
 		return rc;
-	dasd_clear_timer(device);
+	dasd_device_clear_timer(device);
 
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
 	if (device->debug_area != NULL) {
@@ -228,26 +262,32 @@ dasd_state_basic_to_known(struct dasd_de
  * In case the analysis returns an error, the device setup is stopped
  * (a fake disk was already added to allow formatting).
  */
-static int
-dasd_state_basic_to_ready(struct dasd_device * device)
+static int dasd_state_basic_to_ready(struct dasd_device *device)
 {
 	int rc;
+	struct dasd_block *block;
 
 	rc = 0;
-	if (device->discipline->do_analysis != NULL)
-		rc = device->discipline->do_analysis(device);
-	if (rc) {
-		if (rc != -EAGAIN)
-			device->state = DASD_STATE_UNFMT;
-		return rc;
-	}
+	block = device->block;
 	/* make disk known with correct capacity */
-	dasd_setup_queue(device);
-	set_capacity(device->gdp, device->blocks << device->s2b_shift);
-	device->state = DASD_STATE_READY;
-	rc = dasd_scan_partitions(device);
-	if (rc)
-		device->state = DASD_STATE_BASIC;
+	if (block) {
+		if (block->base->discipline->do_analysis != NULL)
+			rc = block->base->discipline->do_analysis(block);
+		if (rc) {
+			if (rc != -EAGAIN)
+				device->state = DASD_STATE_UNFMT;
+			return rc;
+		}
+		dasd_setup_queue(block);
+		set_capacity(block->gdp,
+			     block->blocks << block->s2b_shift);
+		device->state = DASD_STATE_READY;
+		rc = dasd_scan_partitions(block);
+		if (rc)
+			device->state = DASD_STATE_BASIC;
+	} else {
+		device->state = DASD_STATE_READY;
+	}
 	return rc;
 }
 
@@ -256,28 +296,31 @@ dasd_state_basic_to_ready(struct dasd_de
  * Forget format information. Check if the target level is basic
  * and if it is create fake disk for formatting.
  */
-static int
-dasd_state_ready_to_basic(struct dasd_device * device)
+static int dasd_state_ready_to_basic(struct dasd_device *device)
 {
 	int rc;
 
-	rc = dasd_flush_ccw_queue(device, 0);
-	if (rc)
-		return rc;
-	dasd_destroy_partitions(device);
-	dasd_flush_request_queue(device);
-	device->blocks = 0;
-	device->bp_block = 0;
-	device->s2b_shift = 0;
 	device->state = DASD_STATE_BASIC;
+	if (device->block) {
+		struct dasd_block *block = device->block;
+		rc = dasd_flush_block_queue(block);
+		if (rc) {
+			device->state = DASD_STATE_READY;
+			return rc;
+		}
+		dasd_destroy_partitions(block);
+		dasd_flush_request_queue(block);
+		block->blocks = 0;
+		block->bp_block = 0;
+		block->s2b_shift = 0;
+	}
 	return 0;
 }
 
 /*
  * Back to basic.
  */
-static int
-dasd_state_unfmt_to_basic(struct dasd_device * device)
+static int dasd_state_unfmt_to_basic(struct dasd_device *device)
 {
 	device->state = DASD_STATE_BASIC;
 	return 0;
@@ -291,17 +334,31 @@ dasd_state_unfmt_to_basic(struct dasd_de
 static int
 dasd_state_ready_to_online(struct dasd_device * device)
 {
+	int rc;
+
+	if (device->discipline->ready_to_online) {
+		rc = device->discipline->ready_to_online(device);
+		if (rc)
+			return rc;
+	}
 	device->state = DASD_STATE_ONLINE;
-	dasd_schedule_bh(device);
+	if (device->block)
+		dasd_schedule_block_bh(device->block);
 	return 0;
 }
 
 /*
  * Stop the requeueing of requests again.
  */
-static int
-dasd_state_online_to_ready(struct dasd_device * device)
+static int dasd_state_online_to_ready(struct dasd_device *device)
 {
+	int rc;
+
+	if (device->discipline->online_to_ready) {
+		rc = device->discipline->online_to_ready(device);
+		if (rc)
+			return rc;
+	}
 	device->state = DASD_STATE_READY;
 	return 0;
 }
@@ -309,8 +366,7 @@ dasd_state_online_to_ready(struct dasd_d
 /*
  * Device startup state changes.
  */
-static int
-dasd_increase_state(struct dasd_device *device)
+static int dasd_increase_state(struct dasd_device *device)
 {
 	int rc;
 
@@ -345,8 +401,7 @@ dasd_increase_state(struct dasd_device *
 /*
  * Device shutdown state changes.
  */
-static int
-dasd_decrease_state(struct dasd_device *device)
+static int dasd_decrease_state(struct dasd_device *device)
 {
 	int rc;
 
@@ -381,8 +436,7 @@ dasd_decrease_state(struct dasd_device *
 /*
  * This is the main startup/shutdown routine.
  */
-static void
-dasd_change_state(struct dasd_device *device)
+static void dasd_change_state(struct dasd_device *device)
 {
         int rc;
 
@@ -409,17 +463,15 @@ dasd_change_state(struct dasd_device *de
  * dasd_kick_device will schedule a call do do_kick_device to the kernel
  * event daemon.
  */
-static void
-do_kick_device(struct work_struct *work)
+static void do_kick_device(struct work_struct *work)
 {
 	struct dasd_device *device = container_of(work, struct dasd_device, kick_work);
 	dasd_change_state(device);
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 	dasd_put_device(device);
 }
 
-void
-dasd_kick_device(struct dasd_device *device)
+void dasd_kick_device(struct dasd_device *device)
 {
 	dasd_get_device(device);
 	/* queue call to dasd_kick_device to the kernel event daemon. */
@@ -429,8 +481,7 @@ dasd_kick_device(struct dasd_device *dev
 /*
  * Set the target state for a device and starts the state change.
  */
-void
-dasd_set_target_state(struct dasd_device *device, int target)
+void dasd_set_target_state(struct dasd_device *device, int target)
 {
 	/* If we are in probeonly mode stop at DASD_STATE_READY. */
 	if (dasd_probeonly && target > DASD_STATE_READY)
@@ -447,14 +498,12 @@ dasd_set_target_state(struct dasd_device
 /*
  * Enable devices with device numbers in [from..to].
  */
-static inline int
-_wait_for_device(struct dasd_device *device)
+static inline int _wait_for_device(struct dasd_device *device)
 {
 	return (device->state == device->target);
 }
 
-void
-dasd_enable_device(struct dasd_device *device)
+void dasd_enable_device(struct dasd_device *device)
 {
 	dasd_set_target_state(device, DASD_STATE_ONLINE);
 	if (device->state <= DASD_STATE_KNOWN)
@@ -475,20 +524,20 @@ unsigned int dasd_profile_level = DASD_P
 /*
  * Increments counter in global and local profiling structures.
  */
-#define dasd_profile_counter(value, counter, device) \
+#define dasd_profile_counter(value, counter, block) \
 { \
 	int index; \
 	for (index = 0; index < 31 && value >> (2+index); index++); \
 	dasd_global_profile.counter[index]++; \
-	device->profile.counter[index]++; \
+	block->profile.counter[index]++; \
 }
 
 /*
  * Add profiling information for cqr before execution.
  */
-static void
-dasd_profile_start(struct dasd_device *device, struct dasd_ccw_req * cqr,
-		   struct request *req)
+static void dasd_profile_start(struct dasd_block *block,
+			       struct dasd_ccw_req *cqr,
+			       struct request *req)
 {
 	struct list_head *l;
 	unsigned int counter;
@@ -498,19 +547,19 @@ dasd_profile_start(struct dasd_device *d
 
 	/* count the length of the chanq for statistics */
 	counter = 0;
-	list_for_each(l, &device->ccw_queue)
+	list_for_each(l, &block->ccw_queue)
 		if (++counter >= 31)
 			break;
 	dasd_global_profile.dasd_io_nr_req[counter]++;
-	device->profile.dasd_io_nr_req[counter]++;
+	block->profile.dasd_io_nr_req[counter]++;
 }
 
 /*
  * Add profiling information for cqr after execution.
  */
-static void
-dasd_profile_end(struct dasd_device *device, struct dasd_ccw_req * cqr,
-		 struct request *req)
+static void dasd_profile_end(struct dasd_block *block,
+			     struct dasd_ccw_req *cqr,
+			     struct request *req)
 {
 	long strtime, irqtime, endtime, tottime;	/* in microseconds */
 	long tottimeps, sectors;
@@ -532,27 +581,27 @@ dasd_profile_end(struct dasd_device *dev
 
 	if (!dasd_global_profile.dasd_io_reqs)
 		memset(&dasd_global_profile, 0,
-		       sizeof (struct dasd_profile_info_t));
+		       sizeof(struct dasd_profile_info_t));
 	dasd_global_profile.dasd_io_reqs++;
 	dasd_global_profile.dasd_io_sects += sectors;
 
-	if (!device->profile.dasd_io_reqs)
-		memset(&device->profile, 0,
-		       sizeof (struct dasd_profile_info_t));
-	device->profile.dasd_io_reqs++;
-	device->profile.dasd_io_sects += sectors;
-
-	dasd_profile_counter(sectors, dasd_io_secs, device);
-	dasd_profile_counter(tottime, dasd_io_times, device);
-	dasd_profile_counter(tottimeps, dasd_io_timps, device);
-	dasd_profile_counter(strtime, dasd_io_time1, device);
-	dasd_profile_counter(irqtime, dasd_io_time2, device);
-	dasd_profile_counter(irqtime / sectors, dasd_io_time2ps, device);
-	dasd_profile_counter(endtime, dasd_io_time3, device);
+	if (!block->profile.dasd_io_reqs)
+		memset(&block->profile, 0,
+		       sizeof(struct dasd_profile_info_t));
+	block->profile.dasd_io_reqs++;
+	block->profile.dasd_io_sects += sectors;
+
+	dasd_profile_counter(sectors, dasd_io_secs, block);
+	dasd_profile_counter(tottime, dasd_io_times, block);
+	dasd_profile_counter(tottimeps, dasd_io_timps, block);
+	dasd_profile_counter(strtime, dasd_io_time1, block);
+	dasd_profile_counter(irqtime, dasd_io_time2, block);
+	dasd_profile_counter(irqtime / sectors, dasd_io_time2ps, block);
+	dasd_profile_counter(endtime, dasd_io_time3, block);
 }
 #else
-#define dasd_profile_start(device, cqr, req) do {} while (0)
-#define dasd_profile_end(device, cqr, req) do {} while (0)
+#define dasd_profile_start(block, cqr, req) do {} while (0)
+#define dasd_profile_end(block, cqr, req) do {} while (0)
 #endif				/* CONFIG_DASD_PROFILE */
 
 /*
@@ -562,9 +611,9 @@ dasd_profile_end(struct dasd_device *dev
  * memory and 2) dasd_smalloc_request uses the static ccw memory
  * that gets allocated for each device.
  */
-struct dasd_ccw_req *
-dasd_kmalloc_request(char *magic, int cplength, int datasize,
-		   struct dasd_device * device)
+struct dasd_ccw_req *dasd_kmalloc_request(char *magic, int cplength,
+					  int datasize,
+					  struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
 
@@ -600,9 +649,9 @@ dasd_kmalloc_request(char *magic, int cp
 	return cqr;
 }
 
-struct dasd_ccw_req *
-dasd_smalloc_request(char *magic, int cplength, int datasize,
-		   struct dasd_device * device)
+struct dasd_ccw_req *dasd_smalloc_request(char *magic, int cplength,
+					  int datasize,
+					  struct dasd_device *device)
 {
 	unsigned long flags;
 	struct dasd_ccw_req *cqr;
@@ -649,8 +698,7 @@ dasd_smalloc_request(char *magic, int cp
  * idal lists that might have been created by dasd_set_cda and the
  * struct dasd_ccw_req itself.
  */
-void
-dasd_kfree_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
+void dasd_kfree_request(struct dasd_ccw_req *cqr, struct dasd_device *device)
 {
 #ifdef CONFIG_64BIT
 	struct ccw1 *ccw;
@@ -667,8 +715,7 @@ dasd_kfree_request(struct dasd_ccw_req *
 	dasd_put_device(device);
 }
 
-void
-dasd_sfree_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
+void dasd_sfree_request(struct dasd_ccw_req *cqr, struct dasd_device *device)
 {
 	unsigned long flags;
 
@@ -681,14 +728,13 @@ dasd_sfree_request(struct dasd_ccw_req *
 /*
  * Check discipline magic in cqr.
  */
-static inline int
-dasd_check_cqr(struct dasd_ccw_req *cqr)
+static inline int dasd_check_cqr(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 
 	if (cqr == NULL)
 		return -EINVAL;
-	device = cqr->device;
+	device = cqr->startdev;
 	if (strncmp((char *) &cqr->magic, device->discipline->ebcname, 4)) {
 		DEV_MESSAGE(KERN_WARNING, device,
 			    " dasd_ccw_req 0x%08x magic doesn't match"
@@ -706,8 +752,7 @@ dasd_check_cqr(struct dasd_ccw_req *cqr)
  * ccw_device_clear can fail if the i/o subsystem
  * is in a bad mood.
  */
-int
-dasd_term_IO(struct dasd_ccw_req * cqr)
+int dasd_term_IO(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int retries, rc;
@@ -717,13 +762,13 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
 	if (rc)
 		return rc;
 	retries = 0;
-	device = (struct dasd_device *) cqr->device;
+	device = (struct dasd_device *) cqr->startdev;
 	while ((retries < 5) && (cqr->status == DASD_CQR_IN_IO)) {
 		rc = ccw_device_clear(device->cdev, (long) cqr);
 		switch (rc) {
 		case 0:	/* termination successful */
 			cqr->retries--;
-			cqr->status = DASD_CQR_CLEAR;
+			cqr->status = DASD_CQR_CLEAR_PENDING;
 			cqr->stopclk = get_clock();
 			cqr->starttime = 0;
 			DBF_DEV_EVENT(DBF_DEBUG, device,
@@ -753,7 +798,7 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
 		}
 		retries++;
 	}
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 	return rc;
 }
 
@@ -761,8 +806,7 @@ dasd_term_IO(struct dasd_ccw_req * cqr)
  * Start the i/o. This start_IO can fail if the channel is really busy.
  * In that case set up a timer to start the request later.
  */
-int
-dasd_start_IO(struct dasd_ccw_req * cqr)
+int dasd_start_IO(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
@@ -771,12 +815,12 @@ dasd_start_IO(struct dasd_ccw_req * cqr)
 	rc = dasd_check_cqr(cqr);
 	if (rc)
 		return rc;
-	device = (struct dasd_device *) cqr->device;
+	device = (struct dasd_device *) cqr->startdev;
 	if (cqr->retries < 0) {
 		DEV_MESSAGE(KERN_DEBUG, device,
 			    "start_IO: request %p (%02x/%i) - no retry left.",
 			    cqr, cqr->status, cqr->retries);
-		cqr->status = DASD_CQR_FAILED;
+		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
 	cqr->startclk = get_clock();
@@ -833,8 +877,7 @@ dasd_start_IO(struct dasd_ccw_req * cqr)
  * The head of the ccw queue will have status DASD_CQR_IN_IO for 1),
  * DASD_CQR_QUEUED for 2) and 3).
  */
-static void
-dasd_timeout_device(unsigned long ptr)
+static void dasd_device_timeout(unsigned long ptr)
 {
 	unsigned long flags;
 	struct dasd_device *device;
@@ -844,14 +887,13 @@ dasd_timeout_device(unsigned long ptr)
 	/* re-activate request queue */
         device->stopped &= ~DASD_STOPPED_PENDING;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 }
 
 /*
  * Setup timeout for a device in jiffies.
  */
-void
-dasd_set_timer(struct dasd_device *device, int expires)
+void dasd_device_set_timer(struct dasd_device *device, int expires)
 {
 	if (expires == 0) {
 		if (timer_pending(&device->timer))
@@ -862,7 +904,7 @@ dasd_set_timer(struct dasd_device *devic
 		if (mod_timer(&device->timer, jiffies + expires))
 			return;
 	}
-	device->timer.function = dasd_timeout_device;
+	device->timer.function = dasd_device_timeout;
 	device->timer.data = (unsigned long) device;
 	device->timer.expires = jiffies + expires;
 	add_timer(&device->timer);
@@ -871,15 +913,14 @@ dasd_set_timer(struct dasd_device *devic
 /*
  * Clear timeout for a device.
  */
-void
-dasd_clear_timer(struct dasd_device *device)
+void dasd_device_clear_timer(struct dasd_device *device)
 {
 	if (timer_pending(&device->timer))
 		del_timer(&device->timer);
 }
 
-static void
-dasd_handle_killed_request(struct ccw_device *cdev, unsigned long intparm)
+static void dasd_handle_killed_request(struct ccw_device *cdev,
+				       unsigned long intparm)
 {
 	struct dasd_ccw_req *cqr;
 	struct dasd_device *device;
@@ -893,7 +934,7 @@ dasd_handle_killed_request(struct ccw_de
 		return;
 	}
 
-	device = (struct dasd_device *) cqr->device;
+	device = (struct dasd_device *) cqr->startdev;
 	if (device == NULL ||
 	    device != dasd_device_from_cdev_locked(cdev) ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
@@ -905,13 +946,12 @@ dasd_handle_killed_request(struct ccw_de
 	/* Schedule request to be retried. */
 	cqr->status = DASD_CQR_QUEUED;
 
-	dasd_clear_timer(device);
-	dasd_schedule_bh(device);
+	dasd_device_clear_timer(device);
+	dasd_schedule_device_bh(device);
 	dasd_put_device(device);
 }
 
-static void
-dasd_handle_state_change_pending(struct dasd_device *device)
+void dasd_generic_handle_state_change(struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
 	struct list_head *l, *n;
@@ -923,28 +963,27 @@ dasd_handle_state_change_pending(struct 
 
         /* restart all 'running' IO on queue */
 	list_for_each_safe(l, n, &device->ccw_queue) {
-		cqr = list_entry(l, struct dasd_ccw_req, list);
+		cqr = list_entry(l, struct dasd_ccw_req, devlist);
                 if (cqr->status == DASD_CQR_IN_IO) {
                         cqr->status = DASD_CQR_QUEUED;
 		}
         }
-	dasd_clear_timer(device);
-	dasd_schedule_bh(device);
+	dasd_device_clear_timer(device);
+	dasd_schedule_device_bh(device);
+	if (device->block)
+		dasd_schedule_block_bh(device->block);
 }
 
 /*
  * Interrupt handler for "normal" ssch-io based dasd devices.
  */
-void
-dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
-		 struct irb *irb)
+void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
+		      struct irb *irb)
 {
 	struct dasd_ccw_req *cqr, *next;
 	struct dasd_device *device;
 	unsigned long long now;
 	int expires;
-	dasd_era_t era;
-	char mask;
 
 	if (IS_ERR(irb)) {
 		switch (PTR_ERR(irb)) {
@@ -969,28 +1008,19 @@ dasd_int_handler(struct ccw_device *cdev
 		  cdev->dev.bus_id, ((irb->scsw.cstat<<8)|irb->scsw.dstat),
 		  (unsigned int) intparm);
 
-	/* first of all check for state change pending interrupt */
-	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
-	if ((irb->scsw.dstat & mask) == mask) {
+	/* check for unsolicited interrupts */
+	cqr = (struct dasd_ccw_req *) intparm;
+	if (cqr == NULL) {
 		device = dasd_device_from_cdev_locked(cdev);
 		if (!IS_ERR(device)) {
-			dasd_handle_state_change_pending(device);
+			device->discipline->handle_unsolicited_interrupt(device,
+									 irb);
 			dasd_put_device(device);
 		}
 		return;
 	}
 
-	cqr = (struct dasd_ccw_req *) intparm;
-
-	/* check for unsolicited interrupts */
-	if (cqr == NULL) {
-		MESSAGE(KERN_DEBUG,
-			"unsolicited interrupt received: bus_id %s",
-			cdev->dev.bus_id);
-		return;
-	}
-
-	device = (struct dasd_device *) cqr->device;
+	device = (struct dasd_device *) cqr->startdev;
 	if (device == NULL ||
 	    strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		MESSAGE(KERN_DEBUG, "invalid device in request: bus_id %s",
@@ -999,12 +1029,12 @@ dasd_int_handler(struct ccw_device *cdev
 	}
 
 	/* Check for clear pending */
-	if (cqr->status == DASD_CQR_CLEAR &&
+	if (cqr->status == DASD_CQR_CLEAR_PENDING &&
 	    irb->scsw.fctl & SCSW_FCTL_CLEAR_FUNC) {
-		cqr->status = DASD_CQR_QUEUED;
-		dasd_clear_timer(device);
+		cqr->status = DASD_CQR_CLEARED;
+		dasd_device_clear_timer(device);
 		wake_up(&dasd_flush_wq);
-		dasd_schedule_bh(device);
+		dasd_schedule_device_bh(device);
 		return;
 	}
 
@@ -1017,272 +1047,164 @@ dasd_int_handler(struct ccw_device *cdev
 	}
 	DBF_DEV_EVENT(DBF_DEBUG, device, "Int: CS/DS 0x%04x for cqr %p",
 		      ((irb->scsw.cstat << 8) | irb->scsw.dstat), cqr);
-
- 	/* Find out the appropriate era_action. */
-	if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC)
-		era = dasd_era_fatal;
-	else if (irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
-		 irb->scsw.cstat == 0 &&
-		 !irb->esw.esw0.erw.cons)
-		era = dasd_era_none;
-	else if (irb->esw.esw0.erw.cons)
-		era = device->discipline->examine_error(cqr, irb);
-	else
-		era = dasd_era_recover;
-
-	DBF_DEV_EVENT(DBF_DEBUG, device, "era_code %d", era);
+	next = NULL;
 	expires = 0;
-	if (era == dasd_era_none) {
-		cqr->status = DASD_CQR_DONE;
+	if (irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
+	    irb->scsw.cstat == 0 && !irb->esw.esw0.erw.cons) {
+		/* request was completed successfully */
+		cqr->status = DASD_CQR_SUCCESS;
 		cqr->stopclk = now;
 		/* Start first request on queue if possible -> fast_io. */
-		if (cqr->list.next != &device->ccw_queue) {
-			next = list_entry(cqr->list.next,
-					  struct dasd_ccw_req, list);
-			if ((next->status == DASD_CQR_QUEUED) &&
-			    (!device->stopped)) {
-				if (device->discipline->start_IO(next) == 0)
-					expires = next->expires;
-				else
-					DEV_MESSAGE(KERN_DEBUG, device, "%s",
-						    "Interrupt fastpath "
-						    "failed!");
-			}
+		if (cqr->devlist.next != &device->ccw_queue) {
+			next = list_entry(cqr->devlist.next,
+					  struct dasd_ccw_req, devlist);
 		}
-	} else {		/* error */
-		memcpy(&cqr->irb, irb, sizeof (struct irb));
+	} else {  /* error */
+		memcpy(&cqr->irb, irb, sizeof(struct irb));
 		if (device->features & DASD_FEATURE_ERPLOG) {
-			/* dump sense data */
 			dasd_log_sense(cqr, irb);
 		}
-		switch (era) {
-		case dasd_era_fatal:
-			cqr->status = DASD_CQR_FAILED;
-			cqr->stopclk = now;
-			break;
-		case dasd_era_recover:
+		/* If we have no sense data, or we just don't want complex ERP
+		 * for this request, but if we have retries left, then just
+		 * reset this request and retry it in the fastpath
+		 */
+		if (!(cqr->irb.esw.esw0.erw.cons &&
+		      test_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags)) &&
+		    cqr->retries > 0) {
+			DEV_MESSAGE(KERN_DEBUG, device,
+				    "default ERP in fastpath (%i retries left)",
+				    cqr->retries);
+			cqr->lpm    = LPM_ANYPATH;
+			cqr->status = DASD_CQR_QUEUED;
+			next = cqr;
+		} else
 			cqr->status = DASD_CQR_ERROR;
-			break;
-		default:
-			BUG();
-		}
+	}
+	if (next && (next->status == DASD_CQR_QUEUED) &&
+	    (!device->stopped)) {
+		if (device->discipline->start_IO(next) == 0)
+			expires = next->expires;
+		else
+			DEV_MESSAGE(KERN_DEBUG, device, "%s",
+				    "Interrupt fastpath "
+				    "failed!");
 	}
 	if (expires != 0)
-		dasd_set_timer(device, expires);
+		dasd_device_set_timer(device, expires);
 	else
-		dasd_clear_timer(device);
-	dasd_schedule_bh(device);
+		dasd_device_clear_timer(device);
+	dasd_schedule_device_bh(device);
 }
 
 /*
- * posts the buffer_cache about a finalized request
+ * If we have an error on a dasd_block layer request then we cancel
+ * and return all further requests from the same dasd_block as well.
  */
-static inline void
-dasd_end_request(struct request *req, int uptodate)
+static void __dasd_device_recovery(struct dasd_device *device,
+				   struct dasd_ccw_req *ref_cqr)
 {
-	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
-		BUG();
-	add_disk_randomness(req->rq_disk);
-	end_that_request_last(req, uptodate);
-}
+	struct list_head *l, *n;
+	struct dasd_ccw_req *cqr;
 
-/*
- * Process finished error recovery ccw.
- */
-static inline void
-__dasd_process_erp(struct dasd_device *device, struct dasd_ccw_req *cqr)
-{
-	dasd_erp_fn_t erp_fn;
+	/*
+	 * only requeue request that came from the dasd_block layer
+	 */
+	if (!ref_cqr->block)
+		return;
 
-	if (cqr->status == DASD_CQR_DONE)
-		DBF_DEV_EVENT(DBF_NOTICE, device, "%s", "ERP successful");
-	else
-		DEV_MESSAGE(KERN_ERR, device, "%s", "ERP unsuccessful");
-	erp_fn = device->discipline->erp_postaction(cqr);
-	erp_fn(cqr);
-}
+	list_for_each_safe(l, n, &device->ccw_queue) {
+		cqr = list_entry(l, struct dasd_ccw_req, devlist);
+		if (cqr->status == DASD_CQR_QUEUED &&
+		    ref_cqr->block == cqr->block) {
+			cqr->status = DASD_CQR_CLEARED;
+		}
+	}
+};
 
 /*
- * Process ccw request queue.
+ * Remove those ccw requests from the queue that need to be returned
+ * to the upper layer.
  */
-static void
-__dasd_process_ccw_queue(struct dasd_device * device,
-			 struct list_head *final_queue)
+static void __dasd_device_process_ccw_queue(struct dasd_device *device,
+					    struct list_head *final_queue)
 {
 	struct list_head *l, *n;
 	struct dasd_ccw_req *cqr;
-	dasd_erp_fn_t erp_fn;
 
-restart:
 	/* Process request with final status. */
 	list_for_each_safe(l, n, &device->ccw_queue) {
-		cqr = list_entry(l, struct dasd_ccw_req, list);
+		cqr = list_entry(l, struct dasd_ccw_req, devlist);
+
 		/* Stop list processing at the first non-final request. */
-		if (cqr->status != DASD_CQR_DONE &&
-		    cqr->status != DASD_CQR_FAILED &&
-		    cqr->status != DASD_CQR_ERROR)
+		if (cqr->status == DASD_CQR_QUEUED ||
+		    cqr->status == DASD_CQR_IN_IO ||
+		    cqr->status == DASD_CQR_CLEAR_PENDING)
 			break;
-		/*  Process requests with DASD_CQR_ERROR */
 		if (cqr->status == DASD_CQR_ERROR) {
-			if (cqr->irb.scsw.fctl & SCSW_FCTL_HALT_FUNC) {
-				cqr->status = DASD_CQR_FAILED;
-				cqr->stopclk = get_clock();
-			} else {
-				if (cqr->irb.esw.esw0.erw.cons &&
-				    test_bit(DASD_CQR_FLAGS_USE_ERP,
-					     &cqr->flags)) {
-					erp_fn = device->discipline->
-						erp_action(cqr);
-					erp_fn(cqr);
-				} else
-					dasd_default_erp_action(cqr);
-			}
-			goto restart;
-		}
-
-		/* First of all call extended error reporting. */
-		if (dasd_eer_enabled(device) &&
-		    cqr->status == DASD_CQR_FAILED) {
-			dasd_eer_write(device, cqr, DASD_EER_FATALERROR);
-
-			/* restart request  */
-			cqr->status = DASD_CQR_QUEUED;
-			cqr->retries = 255;
-			device->stopped |= DASD_STOPPED_QUIESCE;
-			goto restart;
-		}
-
-		/* Process finished ERP request. */
-		if (cqr->refers) {
-			__dasd_process_erp(device, cqr);
-			goto restart;
+			__dasd_device_recovery(device, cqr);
 		}
-
 		/* Rechain finished requests to final queue */
-		cqr->endclk = get_clock();
-		list_move_tail(&cqr->list, final_queue);
+		list_move_tail(&cqr->devlist, final_queue);
 	}
 }
 
-static void
-dasd_end_request_cb(struct dasd_ccw_req * cqr, void *data)
-{
-	struct request *req;
-	struct dasd_device *device;
-	int status;
-
-	req = (struct request *) data;
-	device = cqr->device;
-	dasd_profile_end(device, cqr, req);
-	status = cqr->device->discipline->free_cp(cqr,req);
-	spin_lock_irq(&device->request_queue_lock);
-	dasd_end_request(req, status);
-	spin_unlock_irq(&device->request_queue_lock);
-}
-
-
 /*
- * Fetch requests from the block device queue.
+ * the cqrs from the final queue are returned to the upper layer
+ * by setting a dasd_block state and calling the callback function
  */
-static void
-__dasd_process_blk_queue(struct dasd_device * device)
+static void __dasd_device_process_final_queue(struct dasd_device *device,
+					      struct list_head *final_queue)
 {
-	struct request_queue *queue;
-	struct request *req;
+	struct list_head *l, *n;
 	struct dasd_ccw_req *cqr;
-	int nr_queued;
-
-	queue = device->request_queue;
-	/* No queue ? Then there is nothing to do. */
-	if (queue == NULL)
-		return;
-
-	/*
-	 * We requeue request from the block device queue to the ccw
-	 * queue only in two states. In state DASD_STATE_READY the
-	 * partition detection is done and we need to requeue requests
-	 * for that. State DASD_STATE_ONLINE is normal block device
-	 * operation.
-	 */
-	if (device->state != DASD_STATE_READY &&
-	    device->state != DASD_STATE_ONLINE)
-		return;
-	nr_queued = 0;
-	/* Now we try to fetch requests from the request queue */
-	list_for_each_entry(cqr, &device->ccw_queue, list)
-		if (cqr->status == DASD_CQR_QUEUED)
-			nr_queued++;
-	while (!blk_queue_plugged(queue) &&
-	       elv_next_request(queue) &&
-		nr_queued < DASD_CHANQ_MAX_SIZE) {
-		req = elv_next_request(queue);
 
-		if (device->features & DASD_FEATURE_READONLY &&
-		    rq_data_dir(req) == WRITE) {
-			DBF_DEV_EVENT(DBF_ERR, device,
-				      "Rejecting write request %p",
-				      req);
-			blkdev_dequeue_request(req);
-			dasd_end_request(req, 0);
-			continue;
-		}
-		if (device->stopped & DASD_STOPPED_DC_EIO) {
-			blkdev_dequeue_request(req);
-			dasd_end_request(req, 0);
-			continue;
-		}
-		cqr = device->discipline->build_cp(device, req);
-		if (IS_ERR(cqr)) {
-			if (PTR_ERR(cqr) == -ENOMEM)
-				break;	/* terminate request queue loop */
-			if (PTR_ERR(cqr) == -EAGAIN) {
-				/*
-				 * The current request cannot be build right
-				 * now, we have to try later. If this request
-				 * is the head-of-queue we stop the device
-				 * for 1/2 second.
-				 */
-				if (!list_empty(&device->ccw_queue))
-					break;
-				device->stopped |= DASD_STOPPED_PENDING;
-				dasd_set_timer(device, HZ/2);
-				break;
-			}
-			DBF_DEV_EVENT(DBF_ERR, device,
-				      "CCW creation failed (rc=%ld) "
-				      "on request %p",
-				      PTR_ERR(cqr), req);
-			blkdev_dequeue_request(req);
-			dasd_end_request(req, 0);
-			continue;
+	list_for_each_safe(l, n, final_queue) {
+		cqr = list_entry(l, struct dasd_ccw_req, devlist);
+		list_del_init(&cqr->devlist);
+		if (cqr->block)
+			spin_lock_bh(&cqr->block->queue_lock);
+		switch (cqr->status) {
+		case DASD_CQR_SUCCESS:
+			cqr->status = DASD_CQR_DONE;
+			break;
+		case DASD_CQR_ERROR:
+			cqr->status = DASD_CQR_NEED_ERP;
+			break;
+		case DASD_CQR_CLEARED:
+			cqr->status = DASD_CQR_TERMINATED;
+			break;
+		default:
+			DEV_MESSAGE(KERN_ERR, device,
+				    "wrong cqr status in __dasd_process_final_queue "
+				    "for cqr %p, status %x",
+				    cqr, cqr->status);
+			BUG();
 		}
-		cqr->callback = dasd_end_request_cb;
-		cqr->callback_data = (void *) req;
-		cqr->status = DASD_CQR_QUEUED;
-		blkdev_dequeue_request(req);
-		list_add_tail(&cqr->list, &device->ccw_queue);
-		dasd_profile_start(device, cqr, req);
-		nr_queued++;
+		if (cqr->block)
+			spin_unlock_bh(&cqr->block->queue_lock);
+		if (cqr->callback != NULL)
+			(cqr->callback)(cqr, cqr->callback_data);
 	}
 }
 
+
+
 /*
  * Take a look at the first request on the ccw queue and check
  * if it reached its expire time. If so, terminate the IO.
  */
-static void
-__dasd_check_expire(struct dasd_device * device)
+static void __dasd_device_check_expire(struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
 
 	if (list_empty(&device->ccw_queue))
 		return;
-	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
+	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, devlist);
 	if ((cqr->status == DASD_CQR_IN_IO && cqr->expires != 0) &&
 	    (time_after_eq(jiffies, cqr->expires + cqr->starttime))) {
 		if (device->discipline->term_IO(cqr) != 0) {
 			/* Hmpf, try again in 5 sec */
-			dasd_set_timer(device, 5*HZ);
+			dasd_device_set_timer(device, 5*HZ);
 			DEV_MESSAGE(KERN_ERR, device,
 				    "internal error - timeout (%is) expired "
 				    "for cqr %p, termination failed, "
@@ -1301,77 +1223,53 @@ __dasd_check_expire(struct dasd_device *
  * Take a look at the first request on the ccw queue and check
  * if it needs to be started.
  */
-static void
-__dasd_start_head(struct dasd_device * device)
+static void __dasd_device_start_head(struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
 	int rc;
 
 	if (list_empty(&device->ccw_queue))
 		return;
-	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
+	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, devlist);
 	if (cqr->status != DASD_CQR_QUEUED)
 		return;
-	/* Non-temporary stop condition will trigger fail fast */
-	if (device->stopped & ~DASD_STOPPED_PENDING &&
-	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-	    (!dasd_eer_enabled(device))) {
-		cqr->status = DASD_CQR_FAILED;
-		dasd_schedule_bh(device);
+	/* when device is stopped, return request to previous layer */
+	if (device->stopped) {
+		cqr->status = DASD_CQR_CLEARED;
+		dasd_schedule_device_bh(device);
 		return;
 	}
-	/* Don't try to start requests if device is stopped */
-	if (device->stopped)
-		return;
 
 	rc = device->discipline->start_IO(cqr);
 	if (rc == 0)
-		dasd_set_timer(device, cqr->expires);
+		dasd_device_set_timer(device, cqr->expires);
 	else if (rc == -EACCES) {
-		dasd_schedule_bh(device);
+		dasd_schedule_device_bh(device);
 	} else
 		/* Hmpf, try again in 1/2 sec */
-		dasd_set_timer(device, 50);
-}
-
-static inline int
-_wait_for_clear(struct dasd_ccw_req *cqr)
-{
-	return (cqr->status == DASD_CQR_QUEUED);
+		dasd_device_set_timer(device, 50);
 }
 
 /*
- * Remove all requests from the ccw queue (all = '1') or only block device
- * requests in case all = '0'.
- * Take care of the erp-chain (chained via cqr->refers) and remove either
- * the whole erp-chain or none of the erp-requests.
- * If a request is currently running, term_IO is called and the request
- * is re-queued. Prior to removing the terminated request we need to wait
- * for the clear-interrupt.
- * In case termination is not possible we stop processing and just finishing
- * the already moved requests.
+ * Go through all request on the dasd_device request queue,
+ * terminate them on the cdev if necessary, and return them to the
+ * submitting layer via callback.
+ * Note:
+ * Make sure that all 'submitting layers' still exist when
+ * this function is called!. In other words, when 'device' is a base
+ * device then all block layer requests must have been removed before
+ * via dasd_flush_block_queue.
  */
-static int
-dasd_flush_ccw_queue(struct dasd_device * device, int all)
+int dasd_flush_device_queue(struct dasd_device *device)
 {
-	struct dasd_ccw_req *cqr, *orig, *n;
-	int rc, i;
-
+	struct dasd_ccw_req *cqr, *n;
+	int rc;
 	struct list_head flush_queue;
 
 	INIT_LIST_HEAD(&flush_queue);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	rc = 0;
-restart:
-	list_for_each_entry_safe(cqr, n, &device->ccw_queue, list) {
-		/* get original request of erp request-chain */
-		for (orig = cqr; orig->refers != NULL; orig = orig->refers);
-
-		/* Flush all request or only block device requests? */
-		if (all == 0 && cqr->callback != dasd_end_request_cb &&
-		    orig->callback != dasd_end_request_cb) {
-			continue;
-		}
+	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
 		/* Check status and move request to flush_queue */
 		switch (cqr->status) {
 		case DASD_CQR_IN_IO:
@@ -1387,90 +1285,60 @@ restart:
 			}
 			break;
 		case DASD_CQR_QUEUED:
-		case DASD_CQR_ERROR:
-			/* set request to FAILED */
 			cqr->stopclk = get_clock();
-			cqr->status = DASD_CQR_FAILED;
+			cqr->status = DASD_CQR_CLEARED;
 			break;
-		default: /* do not touch the others */
+		default: /* no need to modify the others */
 			break;
 		}
-		/* Rechain request (including erp chain) */
-		for (i = 0; cqr != NULL; cqr = cqr->refers, i++) {
-			cqr->endclk = get_clock();
-			list_move_tail(&cqr->list, &flush_queue);
-		}
-		if (i > 1)
-			/* moved more than one request - need to restart */
-			goto restart;
+		list_move_tail(&cqr->devlist, &flush_queue);
 	}
-
 finished:
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	/* Now call the callback function of flushed requests */
-restart_cb:
-	list_for_each_entry_safe(cqr, n, &flush_queue, list) {
-		if (cqr->status == DASD_CQR_CLEAR) {
-			/* wait for clear interrupt! */
-			wait_event(dasd_flush_wq, _wait_for_clear(cqr));
-			cqr->status = DASD_CQR_FAILED;
-		}
-		/* Process finished ERP request. */
-		if (cqr->refers) {
-			__dasd_process_erp(device, cqr);
-			/* restart list_for_xx loop since dasd_process_erp
-			 * might remove multiple elements */
-			goto restart_cb;
-		}
-		/* call the callback function */
-		cqr->endclk = get_clock();
-		if (cqr->callback != NULL)
-			(cqr->callback)(cqr, cqr->callback_data);
-	}
+	/*
+	 * After this point all requests must be in state CLEAR_PENDING,
+	 * CLEARED, SUCCESS or ERROR. Now wait for CLEAR_PENDING to become
+	 * one of the others.
+	 */
+	list_for_each_entry_safe(cqr, n, &flush_queue, devlist)
+		wait_event(dasd_flush_wq,
+			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+	/*
+	 * Now set each request back to TERMINATED, DONE or NEED_ERP
+	 * and call the callback function of flushed requests
+	 */
+	__dasd_device_process_final_queue(device, &flush_queue);
 	return rc;
 }
 
 /*
  * Acquire the device lock and process queues for the device.
  */
-static void
-dasd_tasklet(struct dasd_device * device)
+static void dasd_device_tasklet(struct dasd_device *device)
 {
 	struct list_head final_queue;
-	struct list_head *l, *n;
-	struct dasd_ccw_req *cqr;
 
 	atomic_set (&device->tasklet_scheduled, 0);
 	INIT_LIST_HEAD(&final_queue);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Check expire time of first request on the ccw queue. */
-	__dasd_check_expire(device);
-	/* Finish off requests on ccw queue */
-	__dasd_process_ccw_queue(device, &final_queue);
+	__dasd_device_check_expire(device);
+	/* find final requests on ccw queue */
+	__dasd_device_process_ccw_queue(device, &final_queue);
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	/* Now call the callback function of requests with final status */
-	list_for_each_safe(l, n, &final_queue) {
-		cqr = list_entry(l, struct dasd_ccw_req, list);
-		list_del_init(&cqr->list);
-		if (cqr->callback != NULL)
-			(cqr->callback)(cqr, cqr->callback_data);
-	}
-	spin_lock_irq(&device->request_queue_lock);
-	spin_lock(get_ccwdev_lock(device->cdev));
-	/* Get new request from the block device request queue */
-	__dasd_process_blk_queue(device);
+	__dasd_device_process_final_queue(device, &final_queue);
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	/* Now check if the head of the ccw queue needs to be started. */
-	__dasd_start_head(device);
-	spin_unlock(get_ccwdev_lock(device->cdev));
-	spin_unlock_irq(&device->request_queue_lock);
+	__dasd_device_start_head(device);
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	dasd_put_device(device);
 }
 
 /*
  * Schedules a call to dasd_tasklet over the device tasklet.
  */
-void
-dasd_schedule_bh(struct dasd_device * device)
+void dasd_schedule_device_bh(struct dasd_device *device)
 {
 	/* Protect against rescheduling. */
 	if (atomic_cmpxchg (&device->tasklet_scheduled, 0, 1) != 0)
@@ -1480,160 +1348,109 @@ dasd_schedule_bh(struct dasd_device * de
 }
 
 /*
- * Queue a request to the head of the ccw_queue. Start the I/O if
- * possible.
+ * Queue a request to the head of the device ccw_queue.
+ * Start the I/O if possible.
  */
-void
-dasd_add_request_head(struct dasd_ccw_req *req)
+void dasd_add_request_head(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	unsigned long flags;
 
-	device = req->device;
+	device = cqr->startdev;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	req->status = DASD_CQR_QUEUED;
-	req->device = device;
-	list_add(&req->list, &device->ccw_queue);
+	cqr->status = DASD_CQR_QUEUED;
+	list_add(&cqr->devlist, &device->ccw_queue);
 	/* let the bh start the request to keep them in order */
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 }
 
 /*
- * Queue a request to the tail of the ccw_queue. Start the I/O if
- * possible.
+ * Queue a request to the tail of the device ccw_queue.
+ * Start the I/O if possible.
  */
-void
-dasd_add_request_tail(struct dasd_ccw_req *req)
+void dasd_add_request_tail(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	unsigned long flags;
 
-	device = req->device;
+	device = cqr->startdev;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
-	req->status = DASD_CQR_QUEUED;
-	req->device = device;
-	list_add_tail(&req->list, &device->ccw_queue);
+	cqr->status = DASD_CQR_QUEUED;
+	list_add_tail(&cqr->devlist, &device->ccw_queue);
 	/* let the bh start the request to keep them in order */
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 }
 
 /*
- * Wakeup callback.
+ * Wakeup helper for the 'sleep_on' functions.
  */
-static void
-dasd_wakeup_cb(struct dasd_ccw_req *cqr, void *data)
+static void dasd_wakeup_cb(struct dasd_ccw_req *cqr, void *data)
 {
 	wake_up((wait_queue_head_t *) data);
 }
 
-static inline int
-_wait_for_wakeup(struct dasd_ccw_req *cqr)
+static inline int _wait_for_wakeup(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 	int rc;
 
-	device = cqr->device;
+	device = cqr->startdev;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	rc = ((cqr->status == DASD_CQR_DONE ||
-	       cqr->status == DASD_CQR_FAILED) &&
-	      list_empty(&cqr->list));
+	       cqr->status == DASD_CQR_NEED_ERP ||
+	       cqr->status == DASD_CQR_TERMINATED) &&
+	      list_empty(&cqr->devlist));
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	return rc;
 }
 
 /*
- * Attempts to start a special ccw queue and waits for its completion.
+ * Queue a request to the tail of the device ccw_queue and wait for
+ * it's completion.
  */
-int
-dasd_sleep_on(struct dasd_ccw_req * cqr)
+int dasd_sleep_on(struct dasd_ccw_req *cqr)
 {
 	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
-	device = cqr->device;
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	device = cqr->startdev;
 
 	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
 	cqr->callback_data = (void *) &wait_q;
-	cqr->status = DASD_CQR_QUEUED;
-	list_add_tail(&cqr->list, &device->ccw_queue);
-
-	/* let the bh start the request to keep them in order */
-	dasd_schedule_bh(device);
-
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
+	dasd_add_request_tail(cqr);
 	wait_event(wait_q, _wait_for_wakeup(cqr));
 
 	/* Request status is either done or failed. */
-	rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
+	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 	return rc;
 }
 
 /*
- * Attempts to start a special ccw queue and wait interruptible
- * for its completion.
+ * Queue a request to the tail of the device ccw_queue and wait
+ * interruptible for it's completion.
  */
-int
-dasd_sleep_on_interruptible(struct dasd_ccw_req * cqr)
+int dasd_sleep_on_interruptible(struct dasd_ccw_req *cqr)
 {
 	wait_queue_head_t wait_q;
 	struct dasd_device *device;
-	int rc, finished;
-
-	device = cqr->device;
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	int rc;
 
+	device = cqr->startdev;
 	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
 	cqr->callback_data = (void *) &wait_q;
-	cqr->status = DASD_CQR_QUEUED;
-	list_add_tail(&cqr->list, &device->ccw_queue);
-
-	/* let the bh start the request to keep them in order */
-	dasd_schedule_bh(device);
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	finished = 0;
-	while (!finished) {
-		rc = wait_event_interruptible(wait_q, _wait_for_wakeup(cqr));
-		if (rc != -ERESTARTSYS) {
-			/* Request is final (done or failed) */
-			rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
-			break;
-		}
-		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		switch (cqr->status) {
-		case DASD_CQR_IN_IO:
-                        /* terminate runnig cqr */
-			if (device->discipline->term_IO) {
-				cqr->retries = -1;
-				device->discipline->term_IO(cqr);
-				/* wait (non-interruptible) for final status
-				 * because signal ist still pending */
-				spin_unlock_irq(get_ccwdev_lock(device->cdev));
-				wait_event(wait_q, _wait_for_wakeup(cqr));
-				spin_lock_irq(get_ccwdev_lock(device->cdev));
-				rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
-				finished = 1;
-			}
-			break;
-		case DASD_CQR_QUEUED:
-			/* request  */
-			list_del_init(&cqr->list);
-			rc = -EIO;
-			finished = 1;
-			break;
-		default:
-			/* cqr with 'non-interruptable' status - just wait */
-			break;
-		}
-		spin_unlock_irq(get_ccwdev_lock(device->cdev));
+	dasd_add_request_tail(cqr);
+	rc = wait_event_interruptible(wait_q, _wait_for_wakeup(cqr));
+	if (rc == -ERESTARTSYS) {
+		dasd_cancel_req(cqr);
+		/* wait (non-interruptible) for final status */
+		wait_event(wait_q, _wait_for_wakeup(cqr));
 	}
+	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 	return rc;
 }
 
@@ -1643,25 +1460,23 @@ dasd_sleep_on_interruptible(struct dasd_
  * and be put back to status queued, before the special request is added
  * to the head of the queue. Then the special request is waited on normally.
  */
-static inline int
-_dasd_term_running_cqr(struct dasd_device *device)
+static inline int _dasd_term_running_cqr(struct dasd_device *device)
 {
 	struct dasd_ccw_req *cqr;
 
 	if (list_empty(&device->ccw_queue))
 		return 0;
-	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
+	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, devlist);
 	return device->discipline->term_IO(cqr);
 }
 
-int
-dasd_sleep_on_immediatly(struct dasd_ccw_req * cqr)
+int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 {
 	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
 
-	device = cqr->device;
+	device = cqr->startdev;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	rc = _dasd_term_running_cqr(device);
 	if (rc) {
@@ -1673,17 +1488,17 @@ dasd_sleep_on_immediatly(struct dasd_ccw
 	cqr->callback = dasd_wakeup_cb;
 	cqr->callback_data = (void *) &wait_q;
 	cqr->status = DASD_CQR_QUEUED;
-	list_add(&cqr->list, &device->ccw_queue);
+	list_add(&cqr->devlist, &device->ccw_queue);
 
 	/* let the bh start the request to keep them in order */
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
 	wait_event(wait_q, _wait_for_wakeup(cqr));
 
 	/* Request status is either done or failed. */
-	rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
+	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 	return rc;
 }
 
@@ -1692,11 +1507,14 @@ dasd_sleep_on_immediatly(struct dasd_ccw
  * This is useful to timeout requests. The request will be
  * terminated if it is currently in i/o.
  * Returns 1 if the request has been terminated.
+ *	   0 if there was no need to terminate the request (not started yet)
+ *	   negative error code if termination failed
+ * Cancellation of a request is an asynchronous operation! The calling
+ * function has to wait until the request is properly returned via callback.
  */
-int
-dasd_cancel_req(struct dasd_ccw_req *cqr)
+int dasd_cancel_req(struct dasd_ccw_req *cqr)
 {
-	struct dasd_device *device = cqr->device;
+	struct dasd_device *device = cqr->startdev;
 	unsigned long flags;
 	int rc;
 
@@ -1704,74 +1522,453 @@ dasd_cancel_req(struct dasd_ccw_req *cqr
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	switch (cqr->status) {
 	case DASD_CQR_QUEUED:
-		/* request was not started - just set to failed */
-		cqr->status = DASD_CQR_FAILED;
+		/* request was not started - just set to cleared */
+		cqr->status = DASD_CQR_CLEARED;
 		break;
 	case DASD_CQR_IN_IO:
 		/* request in IO - terminate IO and release again */
-		if (device->discipline->term_IO(cqr) != 0)
-			/* what to do if unable to terminate ??????
-			   e.g. not _IN_IO */
-			cqr->status = DASD_CQR_FAILED;
-		cqr->stopclk = get_clock();
-		rc = 1;
+		rc = device->discipline->term_IO(cqr);
+		if (rc) {
+			DEV_MESSAGE(KERN_ERR, device,
+				    "dasd_cancel_req is unable "
+				    " to terminate request %p, rc = %d",
+				    cqr, rc);
+		} else {
+			cqr->stopclk = get_clock();
+			rc = 1;
+		}
 		break;
-	case DASD_CQR_DONE:
-	case DASD_CQR_FAILED:
-		/* already finished - do nothing */
+	default: /* already finished or clear pending - do nothing */
 		break;
-	default:
-		DEV_MESSAGE(KERN_ALERT, device,
-			    "invalid status %02x in request",
-			    cqr->status);
+	}
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	dasd_schedule_device_bh(device);
+	return rc;
+}
+
+
+/*
+ * SECTION: Operations of the dasd_block layer.
+ */
+
+/*
+ * Timeout function for dasd_block. This is used when the block layer
+ * is waiting for something that may not come reliably, (e.g. a state
+ * change interrupt)
+ */
+static void dasd_block_timeout(unsigned long ptr)
+{
+	unsigned long flags;
+	struct dasd_block *block;
+
+	block = (struct dasd_block *) ptr;
+	spin_lock_irqsave(get_ccwdev_lock(block->base->cdev), flags);
+	/* re-activate request queue */
+	block->base->stopped &= ~DASD_STOPPED_PENDING;
+	spin_unlock_irqrestore(get_ccwdev_lock(block->base->cdev), flags);
+	dasd_schedule_block_bh(block);
+}
+
+/*
+ * Setup timeout for a dasd_block in jiffies.
+ */
+void dasd_block_set_timer(struct dasd_block *block, int expires)
+{
+	if (expires == 0) {
+		if (timer_pending(&block->timer))
+			del_timer(&block->timer);
+		return;
+	}
+	if (timer_pending(&block->timer)) {
+		if (mod_timer(&block->timer, jiffies + expires))
+			return;
+	}
+	block->timer.function = dasd_block_timeout;
+	block->timer.data = (unsigned long) block;
+	block->timer.expires = jiffies + expires;
+	add_timer(&block->timer);
+}
+
+/*
+ * Clear timeout for a dasd_block.
+ */
+void dasd_block_clear_timer(struct dasd_block *block)
+{
+	if (timer_pending(&block->timer))
+		del_timer(&block->timer);
+}
+
+/*
+ * posts the buffer_cache about a finalized request
+ */
+static inline void dasd_end_request(struct request *req, int uptodate)
+{
+	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
+	add_disk_randomness(req->rq_disk);
+	end_that_request_last(req, uptodate);
+}
+
+/*
+ * Process finished error recovery ccw.
+ */
+static inline void __dasd_block_process_erp(struct dasd_block *block,
+					    struct dasd_ccw_req *cqr)
+{
+	dasd_erp_fn_t erp_fn;
+	struct dasd_device *device = block->base;
+
+	if (cqr->status == DASD_CQR_DONE)
+		DBF_DEV_EVENT(DBF_NOTICE, device, "%s", "ERP successful");
+	else
+		DEV_MESSAGE(KERN_ERR, device, "%s", "ERP unsuccessful");
+	erp_fn = device->discipline->erp_postaction(cqr);
+	erp_fn(cqr);
+}
+
+/*
+ * Fetch requests from the block device queue.
+ */
+static void __dasd_process_request_queue(struct dasd_block *block)
+{
+	struct request_queue *queue;
+	struct request *req;
+	struct dasd_ccw_req *cqr;
+	struct dasd_device *basedev;
+	unsigned long flags;
+	queue = block->request_queue;
+	basedev = block->base;
+	/* No queue ? Then there is nothing to do. */
+	if (queue == NULL)
+		return;
+
+	/*
+	 * We requeue request from the block device queue to the ccw
+	 * queue only in two states. In state DASD_STATE_READY the
+	 * partition detection is done and we need to requeue requests
+	 * for that. State DASD_STATE_ONLINE is normal block device
+	 * operation.
+	 */
+	if (basedev->state < DASD_STATE_READY)
+		return;
+	/* Now we try to fetch requests from the request queue */
+	while (!blk_queue_plugged(queue) &&
+	       elv_next_request(queue)) {
+
+		req = elv_next_request(queue);
+
+		if (basedev->features & DASD_FEATURE_READONLY &&
+		    rq_data_dir(req) == WRITE) {
+			DBF_DEV_EVENT(DBF_ERR, basedev,
+				      "Rejecting write request %p",
+				      req);
+			blkdev_dequeue_request(req);
+			dasd_end_request(req, 0);
+			continue;
+		}
+		cqr = basedev->discipline->build_cp(basedev, block, req);
+		if (IS_ERR(cqr)) {
+			if (PTR_ERR(cqr) == -EBUSY)
+				break;	/* normal end condition */
+			if (PTR_ERR(cqr) == -ENOMEM)
+				break;	/* terminate request queue loop */
+			if (PTR_ERR(cqr) == -EAGAIN) {
+				/*
+				 * The current request cannot be build right
+				 * now, we have to try later. If this request
+				 * is the head-of-queue we stop the device
+				 * for 1/2 second.
+				 */
+				if (!list_empty(&block->ccw_queue))
+					break;
+				spin_lock_irqsave(get_ccwdev_lock(basedev->cdev), flags);
+				basedev->stopped |= DASD_STOPPED_PENDING;
+				spin_unlock_irqrestore(get_ccwdev_lock(basedev->cdev), flags);
+				dasd_block_set_timer(block, HZ/2);
+				break;
+			}
+			DBF_DEV_EVENT(DBF_ERR, basedev,
+				      "CCW creation failed (rc=%ld) "
+				      "on request %p",
+				      PTR_ERR(cqr), req);
+			blkdev_dequeue_request(req);
+			dasd_end_request(req, 0);
+			continue;
+		}
+		/*
+		 *  Note: callback is set to dasd_return_cqr_cb in
+		 * __dasd_block_start_head to cover erp requests as well
+		 */
+		cqr->callback_data = (void *) req;
+		cqr->status = DASD_CQR_FILLED;
+		blkdev_dequeue_request(req);
+		list_add_tail(&cqr->blocklist, &block->ccw_queue);
+		dasd_profile_start(block, cqr, req);
+	}
+}
+
+static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
+{
+	struct request *req;
+	int status;
+
+	req = (struct request *) cqr->callback_data;
+	dasd_profile_end(cqr->block, cqr, req);
+	status = cqr->memdev->discipline->free_cp(cqr, req);
+	dasd_end_request(req, status);
+}
+
+/*
+ * Process ccw request queue.
+ */
+static void __dasd_process_block_ccw_queue(struct dasd_block *block,
+					   struct list_head *final_queue)
+{
+	struct list_head *l, *n;
+	struct dasd_ccw_req *cqr;
+	dasd_erp_fn_t erp_fn;
+	unsigned long flags;
+	struct dasd_device *base = block->base;
+
+restart:
+	/* Process request with final status. */
+	list_for_each_safe(l, n, &block->ccw_queue) {
+		cqr = list_entry(l, struct dasd_ccw_req, blocklist);
+		if (cqr->status != DASD_CQR_DONE &&
+		    cqr->status != DASD_CQR_FAILED &&
+		    cqr->status != DASD_CQR_NEED_ERP &&
+		    cqr->status != DASD_CQR_TERMINATED)
+			continue;
+
+		if (cqr->status == DASD_CQR_TERMINATED) {
+			base->discipline->handle_terminated_request(cqr);
+			goto restart;
+		}
+
+		/*  Process requests that may be recovered */
+		if (cqr->status == DASD_CQR_NEED_ERP) {
+			if (cqr->irb.esw.esw0.erw.cons &&
+			    test_bit(DASD_CQR_FLAGS_USE_ERP,
+				     &cqr->flags)) {
+				erp_fn = base->discipline->erp_action(cqr);
+				erp_fn(cqr);
+			}
+			goto restart;
+		}
+
+		/* First of all call extended error reporting. */
+		if (dasd_eer_enabled(base) &&
+		    cqr->status == DASD_CQR_FAILED) {
+			dasd_eer_write(base, cqr, DASD_EER_FATALERROR);
+
+			/* restart request  */
+			cqr->status = DASD_CQR_FILLED;
+			cqr->retries = 255;
+			spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+			base->stopped |= DASD_STOPPED_QUIESCE;
+			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
+					       flags);
+			goto restart;
+		}
 
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			__dasd_block_process_erp(block, cqr);
+			goto restart;
+		}
+
+		/* Rechain finished requests to final queue */
+		cqr->endclk = get_clock();
+		list_move_tail(&cqr->blocklist, final_queue);
+	}
+}
+
+static void dasd_return_cqr_cb(struct dasd_ccw_req *cqr, void *data)
+{
+	dasd_schedule_block_bh(cqr->block);
+}
+
+static void __dasd_block_start_head(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr;
+
+	if (list_empty(&block->ccw_queue))
+		return;
+	/* We allways begin with the first requests on the queue, as some
+	 * of previously started requests have to be enqueued on a
+	 * dasd_device again for error recovery.
+	 */
+	list_for_each_entry(cqr, &block->ccw_queue, blocklist) {
+		if (cqr->status != DASD_CQR_FILLED)
+			continue;
+		/* Non-temporary stop condition will trigger fail fast */
+		if (block->base->stopped & ~DASD_STOPPED_PENDING &&
+		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
+		    (!dasd_eer_enabled(block->base))) {
+			cqr->status = DASD_CQR_FAILED;
+			dasd_schedule_block_bh(block);
+			continue;
+		}
+		/* Don't try to start requests if device is stopped */
+		if (block->base->stopped)
+			return;
+
+		/* just a fail safe check, should not happen */
+		if (!cqr->startdev)
+			cqr->startdev = block->base;
+
+		/* make sure that the requests we submit find their way back */
+		cqr->callback = dasd_return_cqr_cb;
+
+		dasd_add_request_tail(cqr);
+	}
+}
+
+/*
+ * Central dasd_block layer routine. Takes requests from the generic
+ * block layer request queue, creates ccw requests, enqueues them on
+ * a dasd_device and processes ccw requests that have been returned.
+ */
+static void dasd_block_tasklet(struct dasd_block *block)
+{
+	struct list_head final_queue;
+	struct list_head *l, *n;
+	struct dasd_ccw_req *cqr;
+
+	atomic_set(&block->tasklet_scheduled, 0);
+	INIT_LIST_HEAD(&final_queue);
+	spin_lock(&block->queue_lock);
+	/* Finish off requests on ccw queue */
+	__dasd_process_block_ccw_queue(block, &final_queue);
+	spin_unlock(&block->queue_lock);
+	/* Now call the callback function of requests with final status */
+	spin_lock_irq(&block->request_queue_lock);
+	list_for_each_safe(l, n, &final_queue) {
+		cqr = list_entry(l, struct dasd_ccw_req, blocklist);
+		list_del_init(&cqr->blocklist);
+		__dasd_cleanup_cqr(cqr);
+	}
+	spin_lock(&block->queue_lock);
+	/* Get new request from the block device request queue */
+	__dasd_process_request_queue(block);
+	/* Now check if the head of the ccw queue needs to be started. */
+	__dasd_block_start_head(block);
+	spin_unlock(&block->queue_lock);
+	spin_unlock_irq(&block->request_queue_lock);
+	dasd_put_device(block->base);
+}
+
+static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
+{
+	wake_up(&dasd_flush_wq);
+}
+
+/*
+ * Go through all request on the dasd_block request queue, cancel them
+ * on the respective dasd_device, and return them to the generic
+ * block layer.
+ */
+static int dasd_flush_block_queue(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr, *n;
+	int rc, i;
+	struct list_head flush_queue;
+
+	INIT_LIST_HEAD(&flush_queue);
+	spin_lock_bh(&block->queue_lock);
+	rc = 0;
+restart:
+	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
+		/* if this request currently owned by a dasd_device cancel it */
+		if (cqr->status >= DASD_CQR_QUEUED)
+			rc = dasd_cancel_req(cqr);
+		if (rc < 0)
+			break;
+		/* Rechain request (including erp chain) so it won't be
+		 * touched by the dasd_block_tasklet anymore.
+		 * Replace the callback so we notice when the request
+		 * is returned from the dasd_device layer.
+		 */
+		cqr->callback = _dasd_wake_block_flush_cb;
+		for (i = 0; cqr != NULL; cqr = cqr->refers, i++)
+			list_move_tail(&cqr->blocklist, &flush_queue);
+		if (i > 1)
+			/* moved more than one request - need to restart */
+			goto restart;
+	}
+	spin_unlock_bh(&block->queue_lock);
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &flush_queue, blocklist) {
+		wait_event(dasd_flush_wq, (cqr->status < DASD_CQR_QUEUED));
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			__dasd_block_process_erp(block, cqr);
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements */
+			goto restart_cb;
+		}
+		/* call the callback function */
+		cqr->endclk = get_clock();
+		list_del_init(&cqr->blocklist);
+		__dasd_cleanup_cqr(cqr);
 	}
-	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
-	dasd_schedule_bh(device);
 	return rc;
 }
 
 /*
- * SECTION: Block device operations (request queue, partitions, open, release).
+ * Schedules a call to dasd_tasklet over the device tasklet.
+ */
+void dasd_schedule_block_bh(struct dasd_block *block)
+{
+	/* Protect against rescheduling. */
+	if (atomic_cmpxchg(&block->tasklet_scheduled, 0, 1) != 0)
+		return;
+	/* life cycle of block is bound to it's base device */
+	dasd_get_device(block->base);
+	tasklet_hi_schedule(&block->tasklet);
+}
+
+
+/*
+ * SECTION: external block device operations
+ * (request queue handling, open, release, etc.)
  */
 
 /*
  * Dasd request queue function. Called from ll_rw_blk.c
  */
-static void
-do_dasd_request(struct request_queue * queue)
+static void do_dasd_request(struct request_queue *queue)
 {
-	struct dasd_device *device;
+	struct dasd_block *block;
 
-	device = (struct dasd_device *) queue->queuedata;
-	spin_lock(get_ccwdev_lock(device->cdev));
+	block = queue->queuedata;
+	spin_lock(&block->queue_lock);
 	/* Get new request from the block device request queue */
-	__dasd_process_blk_queue(device);
+	__dasd_process_request_queue(block);
 	/* Now check if the head of the ccw queue needs to be started. */
-	__dasd_start_head(device);
-	spin_unlock(get_ccwdev_lock(device->cdev));
+	__dasd_block_start_head(block);
+	spin_unlock(&block->queue_lock);
 }
 
 /*
  * Allocate and initialize request queue and default I/O scheduler.
  */
-static int
-dasd_alloc_queue(struct dasd_device * device)
+static int dasd_alloc_queue(struct dasd_block *block)
 {
 	int rc;
 
-	device->request_queue = blk_init_queue(do_dasd_request,
-					       &device->request_queue_lock);
-	if (device->request_queue == NULL)
+	block->request_queue = blk_init_queue(do_dasd_request,
+					       &block->request_queue_lock);
+	if (block->request_queue == NULL)
 		return -ENOMEM;
 
-	device->request_queue->queuedata = device;
+	block->request_queue->queuedata = block;
 
-	elevator_exit(device->request_queue->elevator);
-	rc = elevator_init(device->request_queue, "deadline");
+	elevator_exit(block->request_queue->elevator);
+	rc = elevator_init(block->request_queue, "deadline");
 	if (rc) {
-		blk_cleanup_queue(device->request_queue);
+		blk_cleanup_queue(block->request_queue);
 		return rc;
 	}
 	return 0;
@@ -1780,79 +1977,76 @@ dasd_alloc_queue(struct dasd_device * de
 /*
  * Allocate and initialize request queue.
  */
-static void
-dasd_setup_queue(struct dasd_device * device)
+static void dasd_setup_queue(struct dasd_block *block)
 {
 	int max;
 
-	blk_queue_hardsect_size(device->request_queue, device->bp_block);
-	max = device->discipline->max_blocks << device->s2b_shift;
-	blk_queue_max_sectors(device->request_queue, max);
-	blk_queue_max_phys_segments(device->request_queue, -1L);
-	blk_queue_max_hw_segments(device->request_queue, -1L);
-	blk_queue_max_segment_size(device->request_queue, -1L);
-	blk_queue_segment_boundary(device->request_queue, -1L);
-	blk_queue_ordered(device->request_queue, QUEUE_ORDERED_TAG, NULL);
+	blk_queue_hardsect_size(block->request_queue, block->bp_block);
+	max = block->base->discipline->max_blocks << block->s2b_shift;
+	blk_queue_max_sectors(block->request_queue, max);
+	blk_queue_max_phys_segments(block->request_queue, -1L);
+	blk_queue_max_hw_segments(block->request_queue, -1L);
+	blk_queue_max_segment_size(block->request_queue, -1L);
+	blk_queue_segment_boundary(block->request_queue, -1L);
+	blk_queue_ordered(block->request_queue, QUEUE_ORDERED_DRAIN, NULL);
 }
 
 /*
  * Deactivate and free request queue.
  */
-static void
-dasd_free_queue(struct dasd_device * device)
+static void dasd_free_queue(struct dasd_block *block)
 {
-	if (device->request_queue) {
-		blk_cleanup_queue(device->request_queue);
-		device->request_queue = NULL;
+	if (block->request_queue) {
+		blk_cleanup_queue(block->request_queue);
+		block->request_queue = NULL;
 	}
 }
 
 /*
  * Flush request on the request queue.
  */
-static void
-dasd_flush_request_queue(struct dasd_device * device)
+static void dasd_flush_request_queue(struct dasd_block *block)
 {
 	struct request *req;
 
-	if (!device->request_queue)
+	if (!block->request_queue)
 		return;
 
-	spin_lock_irq(&device->request_queue_lock);
-	while ((req = elv_next_request(device->request_queue))) {
+	spin_lock_irq(&block->request_queue_lock);
+	while ((req = elv_next_request(block->request_queue))) {
 		blkdev_dequeue_request(req);
 		dasd_end_request(req, 0);
 	}
-	spin_unlock_irq(&device->request_queue_lock);
+	spin_unlock_irq(&block->request_queue_lock);
 }
 
-static int
-dasd_open(struct inode *inp, struct file *filp)
+static int dasd_open(struct inode *inp, struct file *filp)
 {
 	struct gendisk *disk = inp->i_bdev->bd_disk;
-	struct dasd_device *device = disk->private_data;
+	struct dasd_block *block = disk->private_data;
+	struct dasd_device *base = block->base;
 	int rc;
 
-        atomic_inc(&device->open_count);
-	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
+	atomic_inc(&block->open_count);
+	if (test_bit(DASD_FLAG_OFFLINE, &base->flags)) {
 		rc = -ENODEV;
 		goto unlock;
 	}
 
-	if (!try_module_get(device->discipline->owner)) {
+	if (!try_module_get(base->discipline->owner)) {
 		rc = -EINVAL;
 		goto unlock;
 	}
 
 	if (dasd_probeonly) {
-		DEV_MESSAGE(KERN_INFO, device, "%s",
+		DEV_MESSAGE(KERN_INFO, base, "%s",
 			    "No access to device due to probeonly mode");
 		rc = -EPERM;
 		goto out;
 	}
 
-	if (device->state <= DASD_STATE_BASIC) {
-		DBF_DEV_EVENT(DBF_ERR, device, " %s",
+	if (base->state <= DASD_STATE_BASIC) {
+		DBF_DEV_EVENT(DBF_ERR, base, " %s",
 			      " Cannot open unrecognized device");
 		rc = -ENODEV;
 		goto out;
@@ -1861,41 +2055,41 @@ dasd_open(struct inode *inp, struct file
 	return 0;
 
 out:
-	module_put(device->discipline->owner);
+	module_put(base->discipline->owner);
 unlock:
-	atomic_dec(&device->open_count);
+	atomic_dec(&block->open_count);
 	return rc;
 }
 
-static int
-dasd_release(struct inode *inp, struct file *filp)
+static int dasd_release(struct inode *inp, struct file *filp)
 {
 	struct gendisk *disk = inp->i_bdev->bd_disk;
-	struct dasd_device *device = disk->private_data;
+	struct dasd_block *block = disk->private_data;
 
-	atomic_dec(&device->open_count);
-	module_put(device->discipline->owner);
+	atomic_dec(&block->open_count);
+	module_put(block->base->discipline->owner);
 	return 0;
 }
 
 /*
  * Return disk geometry.
  */
-static int
-dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+static int dasd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
-	struct dasd_device *device;
+	struct dasd_block *block;
+	struct dasd_device *base;
 
-	device = bdev->bd_disk->private_data;
-	if (!device)
+	block = bdev->bd_disk->private_data;
+	base = block->base;
+	if (!block)
 		return -ENODEV;
 
-	if (!device->discipline ||
-	    !device->discipline->fill_geometry)
+	if (!base->discipline ||
+	    !base->discipline->fill_geometry)
 		return -EINVAL;
 
-	device->discipline->fill_geometry(device, geo);
-	geo->start = get_start_sect(bdev) >> device->s2b_shift;
+	base->discipline->fill_geometry(block, geo);
+	geo->start = get_start_sect(bdev) >> block->s2b_shift;
 	return 0;
 }
 
@@ -1909,6 +2103,9 @@ dasd_device_operations = {
 	.getgeo		= dasd_getgeo,
 };
 
+/*******************************************************************************
+ * end of block device operations
+ */
 
 static void
 dasd_exit(void)
@@ -1937,9 +2134,8 @@ dasd_exit(void)
  * Initial attempt at a probe function. this can be simplified once
  * the other detection code is gone.
  */
-int
-dasd_generic_probe (struct ccw_device *cdev,
-		    struct dasd_discipline *discipline)
+int dasd_generic_probe(struct ccw_device *cdev,
+		       struct dasd_discipline *discipline)
 {
 	int ret;
 
@@ -1979,10 +2175,10 @@ dasd_generic_probe (struct ccw_device *c
  * This will one day be called from a global not_oper handler.
  * It is also used by driver_unregister during module unload.
  */
-void
-dasd_generic_remove (struct ccw_device *cdev)
+void dasd_generic_remove(struct ccw_device *cdev)
 {
 	struct dasd_device *device;
+	struct dasd_block *block;
 
 	cdev->handler = NULL;
 
@@ -2002,7 +2198,15 @@ dasd_generic_remove (struct ccw_device *
 	 */
 	dasd_set_target_state(device, DASD_STATE_NEW);
 	/* dasd_delete_device destroys the device reference. */
+	block = device->block;
+	device->block = NULL;
 	dasd_delete_device(device);
+	/*
+	 * life cycle of block is bound to device, so delete it after
+	 * device was safely removed
+	 */
+	if (block)
+		dasd_free_block(block);
 }
 
 /*
@@ -2010,10 +2214,8 @@ dasd_generic_remove (struct ccw_device *
  * the device is detected for the first time and is supposed to be used
  * or the user has started activation through sysfs.
  */
-int
-dasd_generic_set_online (struct ccw_device *cdev,
-			 struct dasd_discipline *base_discipline)
-
+int dasd_generic_set_online(struct ccw_device *cdev,
+			    struct dasd_discipline *base_discipline)
 {
 	struct dasd_discipline *discipline;
 	struct dasd_device *device;
@@ -2049,6 +2251,7 @@ dasd_generic_set_online (struct ccw_devi
 	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
+	/* check_device will allocate block device if necessary */
 	rc = discipline->check_device(device);
 	if (rc) {
 		printk (KERN_WARNING
@@ -2068,6 +2271,8 @@ dasd_generic_set_online (struct ccw_devi
 			cdev->dev.bus_id);
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
+		if (device->block)
+			dasd_free_block(device->block);
 		dasd_delete_device(device);
 	} else
 		pr_debug("dasd_generic device %s found\n",
@@ -2082,10 +2287,10 @@ dasd_generic_set_online (struct ccw_devi
 	return rc;
 }
 
-int
-dasd_generic_set_offline (struct ccw_device *cdev)
+int dasd_generic_set_offline(struct ccw_device *cdev)
 {
 	struct dasd_device *device;
+	struct dasd_block *block;
 	int max_count, open_count;
 
 	device = dasd_device_from_cdev(cdev);
@@ -2102,30 +2307,39 @@ dasd_generic_set_offline (struct ccw_dev
 	 * the blkdev_get in dasd_scan_partitions. We are only interested
 	 * in the other openers.
 	 */
-	max_count = device->bdev ? 0 : -1;
-	open_count = (int) atomic_read(&device->open_count);
-	if (open_count > max_count) {
-		if (open_count > 0)
-			printk (KERN_WARNING "Can't offline dasd device with "
-				"open count = %i.\n",
-				open_count);
-		else
-			printk (KERN_WARNING "%s",
-				"Can't offline dasd device due to internal "
-				"use\n");
-		clear_bit(DASD_FLAG_OFFLINE, &device->flags);
-		dasd_put_device(device);
-		return -EBUSY;
+	if (device->block) {
+		struct dasd_block *block = device->block;
+		max_count = block->bdev ? 0 : -1;
+		open_count = (int) atomic_read(&block->open_count);
+		if (open_count > max_count) {
+			if (open_count > 0)
+				printk(KERN_WARNING "Can't offline dasd "
+				       "device with open count = %i.\n",
+				       open_count);
+			else
+				printk(KERN_WARNING "%s",
+				       "Can't offline dasd device due "
+				       "to internal use\n");
+			clear_bit(DASD_FLAG_OFFLINE, &device->flags);
+			dasd_put_device(device);
+			return -EBUSY;
+		}
 	}
 	dasd_set_target_state(device, DASD_STATE_NEW);
 	/* dasd_delete_device destroys the device reference. */
+	block = device->block;
+	device->block = NULL;
 	dasd_delete_device(device);
-
+	/*
+	 * life cycle of block is bound to device, so delete it after
+	 * device was safely removed
+	 */
+	if (block)
+		dasd_free_block(block);
 	return 0;
 }
 
-int
-dasd_generic_notify(struct ccw_device *cdev, int event)
+int dasd_generic_notify(struct ccw_device *cdev, int event)
 {
 	struct dasd_device *device;
 	struct dasd_ccw_req *cqr;
@@ -2146,27 +2360,22 @@ dasd_generic_notify(struct ccw_device *c
 		if (device->state < DASD_STATE_BASIC)
 			break;
 		/* Device is active. We want to keep it. */
-		if (test_bit(DASD_FLAG_DSC_ERROR, &device->flags)) {
-			list_for_each_entry(cqr, &device->ccw_queue, list)
-				if (cqr->status == DASD_CQR_IN_IO)
-					cqr->status = DASD_CQR_FAILED;
-			device->stopped |= DASD_STOPPED_DC_EIO;
-		} else {
-			list_for_each_entry(cqr, &device->ccw_queue, list)
-				if (cqr->status == DASD_CQR_IN_IO) {
-					cqr->status = DASD_CQR_QUEUED;
-					cqr->retries++;
-				}
-			device->stopped |= DASD_STOPPED_DC_WAIT;
-			dasd_set_timer(device, 0);
-		}
-		dasd_schedule_bh(device);
+		list_for_each_entry(cqr, &device->ccw_queue, devlist)
+			if (cqr->status == DASD_CQR_IN_IO) {
+				cqr->status = DASD_CQR_QUEUED;
+				cqr->retries++;
+			}
+		device->stopped |= DASD_STOPPED_DC_WAIT;
+		dasd_device_clear_timer(device);
+		dasd_schedule_device_bh(device);
 		ret = 1;
 		break;
 	case CIO_OPER:
 		/* FIXME: add a sanity check. */
-		device->stopped &= ~(DASD_STOPPED_DC_WAIT|DASD_STOPPED_DC_EIO);
-		dasd_schedule_bh(device);
+		device->stopped &= ~DASD_STOPPED_DC_WAIT;
+		dasd_schedule_device_bh(device);
+		if (device->block)
+			dasd_schedule_block_bh(device->block);
 		ret = 1;
 		break;
 	}
@@ -2196,7 +2405,8 @@ static struct dasd_ccw_req *dasd_generic
 	ccw->cda = (__u32)(addr_t)rdc_buffer;
 	ccw->count = rdc_buffer_size;
 
-	cqr->device = device;
+	cqr->startdev = device;
+	cqr->memdev = device;
 	cqr->expires = 10*HZ;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	cqr->retries = 2;
@@ -2218,13 +2428,12 @@ int dasd_generic_read_dev_chars(struct d
 		return PTR_ERR(cqr);
 
 	ret = dasd_sleep_on(cqr);
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dasd_generic_read_dev_chars);
 
-static int __init
-dasd_init(void)
+static int __init dasd_init(void)
 {
 	int rc;
 
@@ -2232,7 +2441,7 @@ dasd_init(void)
 	init_waitqueue_head(&dasd_flush_wq);
 
 	/* register 'common' DASD debug area, used for all DBF_XXX calls */
-	dasd_debug_area = debug_register("dasd", 1, 2, 8 * sizeof (long));
+	dasd_debug_area = debug_register("dasd", 1, 2, 8 * sizeof(long));
 	if (dasd_debug_area == NULL) {
 		rc = -ENOMEM;
 		goto failed;
@@ -2278,15 +2487,18 @@ EXPORT_SYMBOL(dasd_diag_discipline_point
 EXPORT_SYMBOL(dasd_add_request_head);
 EXPORT_SYMBOL(dasd_add_request_tail);
 EXPORT_SYMBOL(dasd_cancel_req);
-EXPORT_SYMBOL(dasd_clear_timer);
+EXPORT_SYMBOL(dasd_device_clear_timer);
+EXPORT_SYMBOL(dasd_block_clear_timer);
 EXPORT_SYMBOL(dasd_enable_device);
 EXPORT_SYMBOL(dasd_int_handler);
 EXPORT_SYMBOL(dasd_kfree_request);
 EXPORT_SYMBOL(dasd_kick_device);
 EXPORT_SYMBOL(dasd_kmalloc_request);
-EXPORT_SYMBOL(dasd_schedule_bh);
+EXPORT_SYMBOL(dasd_schedule_device_bh);
+EXPORT_SYMBOL(dasd_schedule_block_bh);
 EXPORT_SYMBOL(dasd_set_target_state);
-EXPORT_SYMBOL(dasd_set_timer);
+EXPORT_SYMBOL(dasd_device_set_timer);
+EXPORT_SYMBOL(dasd_block_set_timer);
 EXPORT_SYMBOL(dasd_sfree_request);
 EXPORT_SYMBOL(dasd_sleep_on);
 EXPORT_SYMBOL(dasd_sleep_on_immediatly);
@@ -2300,4 +2512,7 @@ EXPORT_SYMBOL_GPL(dasd_generic_remove);
 EXPORT_SYMBOL_GPL(dasd_generic_notify);
 EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
-
+EXPORT_SYMBOL_GPL(dasd_generic_handle_state_change);
+EXPORT_SYMBOL_GPL(dasd_flush_device_queue);
+EXPORT_SYMBOL_GPL(dasd_alloc_block);
+EXPORT_SYMBOL_GPL(dasd_free_block);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
