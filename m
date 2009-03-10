Return-Path: <linux-kernel-owner+w=401wt.eu-S1754506AbZCJFOe@vger.kernel.org>
From: Stoyan Gaydarov <stoyboyker@gmail.com>
Subject: [PATCH 09/25] [s390] BUG to BUG_ON changes
Date: Tue, 10 Mar 2009 00:10:34 -0500
Message-Id: <1236661850-8237-10-git-send-email-stoyboyker@gmail.com>
In-Reply-To: <1236661850-8237-9-git-send-email-stoyboyker@gmail.com>
References: <1236661850-8237-1-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-2-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-3-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-4-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-5-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-6-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-7-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-8-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-9-git-send-email-stoyboyker@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Stoyan Gaydarov <stoyboyker@gmail.com>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>
---
 arch/s390/kernel/debug.c      |    3 +--
 arch/s390/kernel/setup.c      |    3 +--
 drivers/s390/char/tape_3590.c |    3 +--
 drivers/s390/char/tape_core.c |    6 ++----
 drivers/s390/char/tape_std.c  |    4 ++--
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index ba03fc0..39137b9 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -698,8 +698,7 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
 	if ((uid != 0) || (gid != 0))
 		pr_warning("Root becomes the owner of all s390dbf files "
 			   "in sysfs\n");
-	if (!initialized)
-		BUG();
+	BUG_ON(!initialized);
 	mutex_lock(&debug_mutex);
 
         /* create new debug_info */
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c5cfb61..bfbbd19 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -125,8 +125,7 @@ void __cpuinit cpu_init(void)
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
-        if (current->mm)
-                BUG();
+        BUG_ON(current->mm);
         enter_lazy_tlb(&init_mm, current);
 }
 
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 71605a1..cdb5222 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -661,8 +661,7 @@ tape_3590_bread(struct tape_device *device, struct request *req)
 			ccw++;
 			dst += TAPEBLOCK_HSEC_SIZE;
 		}
-		if (off > bv->bv_len)
-			BUG();
+		BUG_ON(off > bv->bv_len);
 	}
 	ccw = tape_ccw_end(ccw, NOP, 0, NULL);
 	DBF_EVENT(6, "xBREDccwg\n");
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index f9bb51f..bb04f9a 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -639,8 +639,7 @@ tape_alloc_request(int cplength, int datasize)
 {
 	struct tape_request *request;
 
-	if (datasize > PAGE_SIZE || (cplength*sizeof(struct ccw1)) > PAGE_SIZE)
-		BUG();
+	BUG_ON(datasize > PAGE_SIZE || (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	DBF_LH(6, "tape_alloc_request(%d, %d)\n", cplength, datasize);
 
@@ -797,8 +796,7 @@ static void tape_long_busy_timeout(unsigned long data)
 	device = (struct tape_device *) data;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	request = list_entry(device->req_queue.next, struct tape_request, list);
-	if (request->status != TAPE_REQUEST_LONG_BUSY)
-		BUG();
+	BUG_ON(request->status != TAPE_REQUEST_LONG_BUSY);
 	DBF_LH(6, "%08x: Long busy timeout.\n", device->cdev_id);
 	__tape_start_next_request(device);
 	device->lb_timeout.data = (unsigned long) tape_put_device(device);
diff --git a/drivers/s390/char/tape_std.c b/drivers/s390/char/tape_std.c
index 5bd573d..37c4447 100644
--- a/drivers/s390/char/tape_std.c
+++ b/drivers/s390/char/tape_std.c
@@ -39,8 +39,8 @@ tape_std_assign_timeout(unsigned long data)
 	int rc;
 
 	request = (struct tape_request *) data;
-	if ((device = request->device) == NULL)
-		BUG();
+	device = request->device;
+	BUG_ON(device == NULL);
 
 	DBF_EVENT(3, "%08x: Assignment timeout. Device busy.\n",
 			device->cdev_id);
-- 
1.6.1.3
