From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/15] s390/qeth: use DEFINE_MUTEX for qeth_mod_mutex
Date: Wed, 26 Sep 2018 18:29:03 +0200
Message-ID: <20180926162916.102720-3-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Consolidate declaration and initialization of a static variable.
While at it reduce its scope in qeth_core_load_discipline(), and simplify
the return logic accordingly.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4fd9bdc2d0ae..c3068f680f67 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -62,7 +62,6 @@ static struct kmem_cache *qeth_qdio_outbuf_cache;
 
 static struct device *qeth_core_root_dev;
 static struct lock_class_key qdio_out_skb_queue_key;
-static struct mutex qeth_mod_mutex;
 
 static void qeth_send_control_data_cb(struct qeth_channel *,
 			struct qeth_cmd_buffer *);
@@ -5589,11 +5588,11 @@ static int qeth_register_dbf_views(void)
 	return 0;
 }
 
+static DEFINE_MUTEX(qeth_mod_mutex);	/* for synchronized module loading */
+
 int qeth_core_load_discipline(struct qeth_card *card,
 		enum qeth_discipline_id discipline)
 {
-	int rc = 0;
-
 	mutex_lock(&qeth_mod_mutex);
 	switch (discipline) {
 	case QETH_DISCIPLINE_LAYER3:
@@ -5607,14 +5606,15 @@ int qeth_core_load_discipline(struct qeth_card *card,
 	default:
 		break;
 	}
+	mutex_unlock(&qeth_mod_mutex);
 
 	if (!card->discipline) {
 		dev_err(&card->gdev->dev, "There is no kernel module to "
 			"support discipline %d\n", discipline);
-		rc = -EINVAL;
+		return -EINVAL;
 	}
-	mutex_unlock(&qeth_mod_mutex);
-	return rc;
+
+	return 0;
 }
 
 void qeth_core_free_discipline(struct qeth_card *card)
@@ -6623,7 +6623,6 @@ static int __init qeth_core_init(void)
 	INIT_LIST_HEAD(&qeth_core_card_list.list);
 	INIT_LIST_HEAD(&qeth_dbf_list);
 	rwlock_init(&qeth_core_card_list.rwlock);
-	mutex_init(&qeth_mod_mutex);
 
 	qeth_wq = create_singlethread_workqueue("qeth_wq");
 	if (!qeth_wq) {
-- 
2.16.4
