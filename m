From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 1/4] s390: convert debug_info.ref_count from atomic_t to refcount_t
Date: Mon, 20 Feb 2017 13:06:18 +0200
Message-ID: <1487588781-15123-2-git-send-email-elena.reshetova@intel.com>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-edac@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, tony.luck@intel.com, hpa@zytor.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 arch/s390/include/asm/debug.h | 3 ++-
 arch/s390/kernel/debug.c      | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 0206c80..df7b54e 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
+#include <linux/refcount.h>
 #include <uapi/asm/debug.h>
 
 #define DEBUG_MAX_LEVEL            6  /* debug levels range from 0 to 6 */
@@ -31,7 +32,7 @@ struct debug_view;
 typedef struct debug_info {	
 	struct debug_info* next;
 	struct debug_info* prev;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	spinlock_t lock;			
 	int level;
 	int nr_areas;
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 20a5a42..e4b9929 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -277,7 +277,7 @@ debug_info_alloc(const char *name, int pages_per_area, int nr_areas,
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
 	memset(rc->debugfs_entries, 0 ,DEBUG_MAX_VIEWS *
 		sizeof(struct dentry*));
-	atomic_set(&(rc->ref_count), 0);
+	refcount_set(&(rc->ref_count), 0);
 
 	return rc;
 
@@ -361,7 +361,7 @@ debug_info_create(const char *name, int pages_per_area, int nr_areas,
         debug_area_last = rc;
         rc->next = NULL;
 
-	debug_info_get(rc);
+	refcount_set(&rc->ref_count, 1);
 out:
 	return rc;
 }
@@ -416,7 +416,7 @@ static void
 debug_info_get(debug_info_t * db_info)
 {
 	if (db_info)
-		atomic_inc(&db_info->ref_count);
+		refcount_inc(&db_info->ref_count);
 }
 
 /*
@@ -431,7 +431,7 @@ debug_info_put(debug_info_t *db_info)
 
 	if (!db_info)
 		return;
-	if (atomic_dec_and_test(&db_info->ref_count)) {
+	if (refcount_dec_and_test(&db_info->ref_count)) {
 		for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
 			if (!db_info->views[i])
 				continue;
-- 
2.7.4
