Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgKQQPh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:37 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/9] s390/qeth: reduce rtnl locking for switchdev events
Date: Tue, 17 Nov 2020 17:15:13 +0100
Message-Id: <20201117161520.1089-3-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

call_switchdev_notifiers() doesn't require holding the RTNL lock since
commit ff5cf100110c ("net: switchdev: Change notifier chain to be atomic").

We still need it for the "lost event" slow path, to avoid racing against
a concurrent .ndo_bridge_setlink().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 28f6dda95736..daeb837abec3 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -737,8 +737,6 @@ static void qeth_l2_dev2br_an_set_cb(void *priv,
  *
  *	On enable, emits a series of address notifications for all
  *	currently registered hosts.
- *
- *	Must be called under rtnl_lock
  */
 static int qeth_l2_dev2br_an_set(struct qeth_card *card, bool enable)
 {
@@ -1289,16 +1287,19 @@ static void qeth_l2_dev2br_worker(struct work_struct *work)
 	if (READ_ONCE(card->info.pnso_mode) == QETH_PNSO_NONE)
 		goto free;
 
-	/* Potential re-config in progress, try again later: */
-	if (!rtnl_trylock()) {
-		queue_delayed_work(card->event_wq, dwork,
-				   msecs_to_jiffies(100));
-		return;
-	}
-	if (!netif_device_present(card->dev))
-		goto out_unlock;
-
 	if (data->ac_event.lost_event_mask) {
+		/* Potential re-config in progress, try again later: */
+		if (!rtnl_trylock()) {
+			queue_delayed_work(card->event_wq, dwork,
+					   msecs_to_jiffies(100));
+			return;
+		}
+
+		if (!netif_device_present(card->dev)) {
+			rtnl_unlock();
+			goto free;
+		}
+
 		QETH_DBF_MESSAGE(3,
 				 "Address change notification overflow on device %x\n",
 				 CARD_DEVID(card));
@@ -1328,6 +1329,8 @@ static void qeth_l2_dev2br_worker(struct work_struct *work)
 					 "Address Notification resynced on device %x\n",
 					 CARD_DEVID(card));
 		}
+
+		rtnl_unlock();
 	} else {
 		for (i = 0; i < data->ac_event.num_entries; i++) {
 			struct qeth_ipacmd_addr_change_entry *entry =
@@ -1339,9 +1342,6 @@ static void qeth_l2_dev2br_worker(struct work_struct *work)
 		}
 	}
 
-out_unlock:
-	rtnl_unlock();
-
 free:
 	kfree(data);
 }
@@ -2310,11 +2310,8 @@ static void qeth_l2_set_offline(struct qeth_card *card)
 		card->state = CARD_STATE_DOWN;
 
 	qeth_l2_set_pnso_mode(card, QETH_PNSO_NONE);
-	if (priv->brport_features & BR_LEARNING_SYNC) {
-		rtnl_lock();
+	if (priv->brport_features & BR_LEARNING_SYNC)
 		qeth_l2_dev2br_fdb_flush(card);
-		rtnl_unlock();
-	}
 }
 
 /* Returns zero if the command is successfully "consumed" */
-- 
2.17.1
