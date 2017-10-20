Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 1/3] [S390] vmur: convert urdev.ref_count from atomic_t to refcount_t
Date: Fri, 20 Oct 2017 10:47:48 +0300
Message-Id: <1508485670-24070-2-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
References: <1508485670-24070-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, peterz@infradead.org, keescook@chromium.org, Elena Reshetova <elena.reshetova@intel.com>
List-ID: <linux-s390.vger.kernel.org>

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable urdev.ref_count is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 drivers/s390/char/vmur.c | 8 ++++----
 drivers/s390/char/vmur.h | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index 04aceb6..ced8151 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -110,7 +110,7 @@ static struct urdev *urdev_alloc(struct ccw_device *cdev)
 	mutex_init(&urd->io_mutex);
 	init_waitqueue_head(&urd->wait);
 	spin_lock_init(&urd->open_lock);
-	atomic_set(&urd->ref_count,  1);
+	refcount_set(&urd->ref_count,  1);
 	urd->cdev = cdev;
 	get_device(&cdev->dev);
 	return urd;
@@ -126,7 +126,7 @@ static void urdev_free(struct urdev *urd)
 
 static void urdev_get(struct urdev *urd)
 {
-	atomic_inc(&urd->ref_count);
+	refcount_inc(&urd->ref_count);
 }
 
 static struct urdev *urdev_get_from_cdev(struct ccw_device *cdev)
@@ -159,7 +159,7 @@ static struct urdev *urdev_get_from_devno(u16 devno)
 
 static void urdev_put(struct urdev *urd)
 {
-	if (atomic_dec_and_test(&urd->ref_count))
+	if (refcount_dec_and_test(&urd->ref_count))
 		urdev_free(urd);
 }
 
@@ -946,7 +946,7 @@ static int ur_set_offline_force(struct ccw_device *cdev, int force)
 		rc = -EBUSY;
 		goto fail_urdev_put;
 	}
-	if (!force && (atomic_read(&urd->ref_count) > 2)) {
+	if (!force && (refcount_read(&urd->ref_count) > 2)) {
 		/* There is still a user of urd (e.g. ur_open) */
 		TRACE("ur_set_offline: BUSY\n");
 		rc = -EBUSY;
diff --git a/drivers/s390/char/vmur.h b/drivers/s390/char/vmur.h
index fa320ad..35ea9d1 100644
--- a/drivers/s390/char/vmur.h
+++ b/drivers/s390/char/vmur.h
@@ -11,6 +11,8 @@
 #ifndef _VMUR_H_
 #define _VMUR_H_
 
+#include <linux/refcount.h>
+
 #define DEV_CLASS_UR_I 0x20 /* diag210 unit record input device class */
 #define DEV_CLASS_UR_O 0x10 /* diag210 unit record output device class */
 /*
@@ -69,7 +71,7 @@ struct urdev {
 	size_t reclen;			/* Record length for *write* CCWs */
 	int class;			/* VM device class */
 	int io_request_rc;		/* return code from I/O request */
-	atomic_t ref_count;		/* reference counter */
+	refcount_t ref_count;		/* reference counter */
 	wait_queue_head_t wait;		/* wait queue to serialize open */
 	int open_flag;			/* "urdev is open" flag */
 	spinlock_t open_lock;		/* serialize critical sections */
-- 
2.7.4
