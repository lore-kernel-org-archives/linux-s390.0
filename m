Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 3/3] [S390] qeth: convert qeth_reply.refcnt from atomic_t to refcount_t
Date: Fri, 20 Oct 2017 10:47:50 +0300
Message-Id: <1508485670-24070-4-git-send-email-elena.reshetova@intel.com>
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

The variable qeth_reply.refcnt is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 91fcadb..49ba742 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -20,6 +20,7 @@
 #include <linux/ethtool.h>
 #include <linux/hashtable.h>
 #include <linux/ip.h>
+#include <linux/refcount.h>
 
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
@@ -645,7 +646,7 @@ struct qeth_reply {
 	int rc;
 	void *param;
 	struct qeth_card *card;
-	atomic_t refcnt;
+	refcount_t refcnt;
 };
 
 struct qeth_card_blkt {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 68e118f..86e4c5d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -559,7 +559,7 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 
 	reply = kzalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
 	if (reply) {
-		atomic_set(&reply->refcnt, 1);
+		refcount_set(&reply->refcnt, 1);
 		atomic_set(&reply->received, 0);
 		reply->card = card;
 	}
@@ -568,14 +568,14 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 
 static void qeth_get_reply(struct qeth_reply *reply)
 {
-	WARN_ON(atomic_read(&reply->refcnt) <= 0);
-	atomic_inc(&reply->refcnt);
+	WARN_ON(refcount_read(&reply->refcnt) == 0);
+	refcount_inc(&reply->refcnt);
 }
 
 static void qeth_put_reply(struct qeth_reply *reply)
 {
-	WARN_ON(atomic_read(&reply->refcnt) <= 0);
-	if (atomic_dec_and_test(&reply->refcnt))
+	WARN_ON(refcount_read(&reply->refcnt) == 0);
+	if (refcount_dec_and_test(&reply->refcnt))
 		kfree(reply);
 }
 
-- 
2.7.4
