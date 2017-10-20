Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/3] [S390] net: convert lcs_reply.refcnt from atomic_t to refcount_t
Date: Fri, 20 Oct 2017 10:47:49 +0300
Message-Id: <1508485670-24070-3-git-send-email-elena.reshetova@intel.com>
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

The variable lcs_reply.refcnt is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 drivers/s390/net/lcs.c | 10 +++++-----
 drivers/s390/net/lcs.h |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index d01b5c2..d7344be 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -769,15 +769,15 @@ lcs_get_lancmd(struct lcs_card *card, int count)
 static void
 lcs_get_reply(struct lcs_reply *reply)
 {
-	WARN_ON(atomic_read(&reply->refcnt) <= 0);
-	atomic_inc(&reply->refcnt);
+	WARN_ON(refcount_read(&reply->refcnt) == 0);
+	refcount_inc(&reply->refcnt);
 }
 
 static void
 lcs_put_reply(struct lcs_reply *reply)
 {
-        WARN_ON(atomic_read(&reply->refcnt) <= 0);
-        if (atomic_dec_and_test(&reply->refcnt)) {
+		WARN_ON(refcount_read(&reply->refcnt) == 0);
+		if (refcount_dec_and_test(&reply->refcnt)) {
 		kfree(reply);
 	}
 
@@ -793,7 +793,7 @@ lcs_alloc_reply(struct lcs_cmd *cmd)
 	reply = kzalloc(sizeof(struct lcs_reply), GFP_ATOMIC);
 	if (!reply)
 		return NULL;
-	atomic_set(&reply->refcnt,1);
+	refcount_set(&reply->refcnt,1);
 	reply->sequence_no = cmd->sequence_no;
 	reply->received = 0;
 	reply->rc = 0;
diff --git a/drivers/s390/net/lcs.h b/drivers/s390/net/lcs.h
index 150fcb4..3802f4f 100644
--- a/drivers/s390/net/lcs.h
+++ b/drivers/s390/net/lcs.h
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
+#include <linux/refcount.h>
 #include <asm/ccwdev.h>
 
 #define LCS_DBF_TEXT(level, name, text) \
@@ -270,7 +271,7 @@ struct lcs_buffer {
 struct lcs_reply {
 	struct list_head list;
 	__u16 sequence_no;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	/* Callback for completion notification. */
 	void (*callback)(struct lcs_card *, struct lcs_cmd *);
 	wait_queue_head_t wait_q;
-- 
2.7.4
