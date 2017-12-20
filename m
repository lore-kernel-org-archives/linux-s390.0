From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 02/15] qeth: convert qeth_reply.refcnt from atomic_t to refcount_t
Date: Wed, 20 Dec 2017 20:10:56 +0100
Message-ID: <20171220191109.90487-3-jwi@linux.vnet.ibm.com>
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

The variable qeth_reply.refcnt is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
[jwi: removed the WARN_ONs. Use CONFIG_REFCOUNT_FULL if you care.]
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 3 ++-
 drivers/s390/net/qeth_core_main.c | 8 +++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index badf42acbf95..f5ee62c98011 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -21,6 +21,7 @@
 #include <linux/ethtool.h>
 #include <linux/hashtable.h>
 #include <linux/ip.h>
+#include <linux/refcount.h>
 
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
@@ -632,7 +633,7 @@ struct qeth_reply {
 	int rc;
 	void *param;
 	struct qeth_card *card;
-	atomic_t refcnt;
+	refcount_t refcnt;
 };
 
 struct qeth_card_blkt {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6c815207f4f5..bc4e57540a9e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -564,7 +564,7 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 
 	reply = kzalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
 	if (reply) {
-		atomic_set(&reply->refcnt, 1);
+		refcount_set(&reply->refcnt, 1);
 		atomic_set(&reply->received, 0);
 		reply->card = card;
 	}
@@ -573,14 +573,12 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 
 static void qeth_get_reply(struct qeth_reply *reply)
 {
-	WARN_ON(atomic_read(&reply->refcnt) <= 0);
-	atomic_inc(&reply->refcnt);
+	refcount_inc(&reply->refcnt);
 }
 
 static void qeth_put_reply(struct qeth_reply *reply)
 {
-	WARN_ON(atomic_read(&reply->refcnt) <= 0);
-	if (atomic_dec_and_test(&reply->refcnt))
+	if (refcount_dec_and_test(&reply->refcnt))
 		kfree(reply);
 }
 
-- 
2.13.5
