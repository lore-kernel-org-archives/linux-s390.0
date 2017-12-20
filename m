From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 01/15] net: convert lcs_reply.refcnt from atomic_t to refcount_t
Date: Wed, 20 Dec 2017 20:10:55 +0100
Message-ID: <20171220191109.90487-2-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Elena Reshetova <elena.reshetova@intel.com>

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
[jwi: removed the WARN_ONs. Use CONFIG_REFCOUNT_FULL if you care.]
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/lcs.c | 10 +++-------
 drivers/s390/net/lcs.h |  3 ++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 92ae84a927fc..0ee8f33efb54 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -756,18 +756,14 @@ lcs_get_lancmd(struct lcs_card *card, int count)
 static void
 lcs_get_reply(struct lcs_reply *reply)
 {
-	WARN_ON(atomic_read(&reply->refcnt) <= 0);
-	atomic_inc(&reply->refcnt);
+	refcount_inc(&reply->refcnt);
 }
 
 static void
 lcs_put_reply(struct lcs_reply *reply)
 {
-        WARN_ON(atomic_read(&reply->refcnt) <= 0);
-        if (atomic_dec_and_test(&reply->refcnt)) {
+	if (refcount_dec_and_test(&reply->refcnt))
 		kfree(reply);
-	}
-
 }
 
 static struct lcs_reply *
@@ -780,7 +776,7 @@ lcs_alloc_reply(struct lcs_cmd *cmd)
 	reply = kzalloc(sizeof(struct lcs_reply), GFP_ATOMIC);
 	if (!reply)
 		return NULL;
-	atomic_set(&reply->refcnt,1);
+	refcount_set(&reply->refcnt, 1);
 	reply->sequence_no = cmd->sequence_no;
 	reply->received = 0;
 	reply->rc = 0;
diff --git a/drivers/s390/net/lcs.h b/drivers/s390/net/lcs.h
index fbc8b90b1f85..bd52caa3b11b 100644
--- a/drivers/s390/net/lcs.h
+++ b/drivers/s390/net/lcs.h
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/workqueue.h>
+#include <linux/refcount.h>
 #include <asm/ccwdev.h>
 
 #define LCS_DBF_TEXT(level, name, text) \
@@ -271,7 +272,7 @@ struct lcs_buffer {
 struct lcs_reply {
 	struct list_head list;
 	__u16 sequence_no;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	/* Callback for completion notification. */
 	void (*callback)(struct lcs_card *, struct lcs_cmd *);
 	wait_queue_head_t wait_q;
-- 
2.13.5
