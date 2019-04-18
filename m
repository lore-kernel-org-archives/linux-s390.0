Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 18 Apr 2019 16:47:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.1-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190418164733.798aa386@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 9936328b41ce4bce8f20269dcac8cb476c8d0820:

  Merge tag 'pci-v5.1-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2019-03-28 13:29:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-3

for you to fetch changes up to 35af0d469c6694c05f06e75c5d75caee9be66122:

  s390: correct some inline assembly constraints (2019-04-17 10:40:57 +0200)

----------------------------------------------------------------
s390 update with bug fixes for 5.1-rc6

 - Fix overwrite of the initial ramdisk due to misuse of IS_ENABLED

 - Fix integer overflow in the dasd driver resulting in incorrect number
   of blocks for large devices

 - Fix a lockdep false positive in the 3270 driver

 - Fix a deadlock in the zcrypt driver

 - Fix incorrect debug feature entries in the pkey api

 - Fix inline assembly constraints fallout with CONFIG_KASAN=y

----------------------------------------------------------------
Harald Freudenberger (2):
      s390/zcrypt: fix possible deadlock situation on ap queue remove
      s390/pkey: add one more argument space for debug feature entry

Joe Perches (1):
      s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)

Martin Schwidefsky (1):
      s390/3270: fix lockdep false positive on view->lock

Peter Oberparleiter (1):
      s390/dasd: Fix capacity calculation for large volumes

Vasily Gorbik (1):
      s390: correct some inline assembly constraints

 arch/s390/boot/mem_detect.c    | 2 +-
 arch/s390/kernel/fpu.c         | 2 +-
 arch/s390/kernel/vtime.c       | 8 ++++----
 drivers/s390/block/dasd_eckd.c | 6 +++---
 drivers/s390/char/con3270.c    | 2 +-
 drivers/s390/char/fs3270.c     | 3 ++-
 drivers/s390/char/raw3270.c    | 3 ++-
 drivers/s390/char/raw3270.h    | 4 +++-
 drivers/s390/char/tty3270.c    | 3 ++-
 drivers/s390/crypto/ap_queue.c | 2 +-
 drivers/s390/crypto/pkey_api.c | 3 ++-
 11 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/s390/boot/mem_detect.c b/arch/s390/boot/mem_detect.c
index 4cb771b..5d316fe 100644
--- a/arch/s390/boot/mem_detect.c
+++ b/arch/s390/boot/mem_detect.c
@@ -25,7 +25,7 @@ static void *mem_detect_alloc_extended(void)
 {
 	unsigned long offset = ALIGN(mem_safe_offset(), sizeof(u64));
 
-	if (IS_ENABLED(BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
 	    INITRD_START < offset + ENTRIES_EXTENDED_MAX)
 		offset = ALIGN(INITRD_START + INITRD_SIZE, sizeof(u64));
 
diff --git a/arch/s390/kernel/fpu.c b/arch/s390/kernel/fpu.c
index 594464f..0da378e 100644
--- a/arch/s390/kernel/fpu.c
+++ b/arch/s390/kernel/fpu.c
@@ -23,7 +23,7 @@ void __kernel_fpu_begin(struct kernel_fpu *state, u32 flags)
 
 	if (flags & KERNEL_FPC)
 		/* Save floating point control */
-		asm volatile("stfpc %0" : "=m" (state->fpc));
+		asm volatile("stfpc %0" : "=Q" (state->fpc));
 
 	if (!MACHINE_HAS_VX) {
 		if (flags & KERNEL_VXR_V0V7) {
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index a69a091..c475ca4 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -37,7 +37,7 @@ static inline u64 get_vtimer(void)
 {
 	u64 timer;
 
-	asm volatile("stpt %0" : "=m" (timer));
+	asm volatile("stpt %0" : "=Q" (timer));
 	return timer;
 }
 
@@ -48,7 +48,7 @@ static inline void set_vtimer(u64 expires)
 	asm volatile(
 		"	stpt	%0\n"	/* Store current cpu timer value */
 		"	spt	%1"	/* Set new value imm. afterwards */
-		: "=m" (timer) : "m" (expires));
+		: "=Q" (timer) : "Q" (expires));
 	S390_lowcore.system_timer += S390_lowcore.last_update_timer - timer;
 	S390_lowcore.last_update_timer = expires;
 }
@@ -135,8 +135,8 @@ static int do_account_vtime(struct task_struct *tsk)
 #else
 		"	stck	%1"	/* Store current tod clock value */
 #endif
-		: "=m" (S390_lowcore.last_update_timer),
-		  "=m" (S390_lowcore.last_update_clock));
+		: "=Q" (S390_lowcore.last_update_timer),
+		  "=Q" (S390_lowcore.last_update_clock));
 	clock = S390_lowcore.last_update_clock - clock;
 	timer -= S390_lowcore.last_update_timer;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 6e294b4..f89f9d0 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2004,14 +2004,14 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	blk_per_trk = recs_per_track(&private->rdc_data, 0, block->bp_block);
 
 raw:
-	block->blocks = (private->real_cyl *
+	block->blocks = ((unsigned long) private->real_cyl *
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
 	dev_info(&device->cdev->dev,
-		 "DASD with %d KB/block, %d KB total size, %d KB/track, "
+		 "DASD with %u KB/block, %lu KB total size, %u KB/track, "
 		 "%s\n", (block->bp_block >> 10),
-		 ((private->real_cyl *
+		 (((unsigned long) private->real_cyl *
 		   private->rdc_data.trk_per_cyl *
 		   blk_per_trk * (block->bp_block >> 9)) >> 1),
 		 ((blk_per_trk * block->bp_block) >> 10),
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index fd2146b..e17364e 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -629,7 +629,7 @@ con3270_init(void)
 		     (void (*)(unsigned long)) con3270_read_tasklet,
 		     (unsigned long) condev->read);
 
-	raw3270_add_view(&condev->view, &con3270_fn, 1);
+	raw3270_add_view(&condev->view, &con3270_fn, 1, RAW3270_VIEW_LOCK_IRQ);
 
 	INIT_LIST_HEAD(&condev->freemem);
 	for (i = 0; i < CON3270_STRING_PAGES; i++) {
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 8f3a2ee..8b48ba9 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -463,7 +463,8 @@ fs3270_open(struct inode *inode, struct file *filp)
 
 	init_waitqueue_head(&fp->wait);
 	fp->fs_pid = get_pid(task_pid(current));
-	rc = raw3270_add_view(&fp->view, &fs3270_fn, minor);
+	rc = raw3270_add_view(&fp->view, &fs3270_fn, minor,
+			      RAW3270_VIEW_LOCK_BH);
 	if (rc) {
 		fs3270_free_view(&fp->view);
 		goto out;
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index f8cd293..63a41b1 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -920,7 +920,7 @@ raw3270_deactivate_view(struct raw3270_view *view)
  * Add view to device with minor "minor".
  */
 int
-raw3270_add_view(struct raw3270_view *view, struct raw3270_fn *fn, int minor)
+raw3270_add_view(struct raw3270_view *view, struct raw3270_fn *fn, int minor, int subclass)
 {
 	unsigned long flags;
 	struct raw3270 *rp;
@@ -942,6 +942,7 @@ raw3270_add_view(struct raw3270_view *view, struct raw3270_fn *fn, int minor)
 		view->cols = rp->cols;
 		view->ascebc = rp->ascebc;
 		spin_lock_init(&view->lock);
+		lockdep_set_subclass(&view->lock, subclass);
 		list_add(&view->list, &rp->view_list);
 		rc = 0;
 		spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
diff --git a/drivers/s390/char/raw3270.h b/drivers/s390/char/raw3270.h
index 114ca7c..3afaa35 100644
--- a/drivers/s390/char/raw3270.h
+++ b/drivers/s390/char/raw3270.h
@@ -150,6 +150,8 @@ struct raw3270_fn {
 struct raw3270_view {
 	struct list_head list;
 	spinlock_t lock;
+#define RAW3270_VIEW_LOCK_IRQ	0
+#define RAW3270_VIEW_LOCK_BH	1
 	atomic_t ref_count;
 	struct raw3270 *dev;
 	struct raw3270_fn *fn;
@@ -158,7 +160,7 @@ struct raw3270_view {
 	unsigned char *ascebc;		/* ascii -> ebcdic table */
 };
 
-int raw3270_add_view(struct raw3270_view *, struct raw3270_fn *, int);
+int raw3270_add_view(struct raw3270_view *, struct raw3270_fn *, int, int);
 int raw3270_activate_view(struct raw3270_view *);
 void raw3270_del_view(struct raw3270_view *);
 void raw3270_deactivate_view(struct raw3270_view *);
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 2b0c36c2..98d7fc1 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -980,7 +980,8 @@ static int tty3270_install(struct tty_driver *driver, struct tty_struct *tty)
 		return PTR_ERR(tp);
 
 	rc = raw3270_add_view(&tp->view, &tty3270_fn,
-			      tty->index + RAW3270_FIRSTMINOR);
+			      tty->index + RAW3270_FIRSTMINOR,
+			      RAW3270_VIEW_LOCK_BH);
 	if (rc) {
 		tty3270_free_view(tp);
 		return rc;
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 6a340f2..5ea83dc 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -751,8 +751,8 @@ void ap_queue_prepare_remove(struct ap_queue *aq)
 	__ap_flush_queue(aq);
 	/* set REMOVE state to prevent new messages are queued in */
 	aq->state = AP_STATE_REMOVE;
-	del_timer_sync(&aq->timeout);
 	spin_unlock_bh(&aq->lock);
+	del_timer_sync(&aq->timeout);
 }
 
 void ap_queue_remove(struct ap_queue *aq)
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 3e85d66..45eb0c1 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -51,7 +51,8 @@ static debug_info_t *debug_info;
 
 static void __init pkey_debug_init(void)
 {
-	debug_info = debug_register("pkey", 1, 1, 4 * sizeof(long));
+	/* 5 arguments per dbf entry (including the format string ptr) */
+	debug_info = debug_register("pkey", 1, 1, 5 * sizeof(long));
 	debug_register_view(debug_info, &debug_sprintf_view);
 	debug_set_level(debug_info, 3);
 }
