From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/13] s390/qeth: convert vlan spinlock to mutex
Date: Thu, 26 Apr 2018 09:42:13 +0200
Message-ID: <20180426074224.100432-3-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

As the vid_list is only accessed from process context, there's no need to
protect it with a spinlock.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c |  2 +-
 drivers/s390/net/qeth_l2_main.c   | 15 ++++++++-------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 8469446df62c..6d7a72da71dd 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -777,9 +777,9 @@ struct qeth_card {
 	struct qeth_card_options options;
 
 	wait_queue_head_t wait_q;
-	spinlock_t vlanlock;
 	spinlock_t mclock;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	struct mutex vid_list_mutex;		/* vid_list */
 	struct list_head vid_list;
 	DECLARE_HASHTABLE(mac_htable, 4);
 	DECLARE_HASHTABLE(ip_htable, 4);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5323c675e57c..7feb50ac0a8b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1467,13 +1467,13 @@ static int qeth_setup_card(struct qeth_card *card)
 	card->lan_online = 0;
 	card->read_or_write_problem = 0;
 	card->dev = NULL;
-	spin_lock_init(&card->vlanlock);
 	spin_lock_init(&card->mclock);
 	spin_lock_init(&card->lock);
 	spin_lock_init(&card->ip_lock);
 	spin_lock_init(&card->thread_mask_lock);
 	mutex_init(&card->conf_mutex);
 	mutex_init(&card->discipline_mutex);
+	mutex_init(&card->vid_list_mutex);
 	card->thread_start_mask = 0;
 	card->thread_allowed_mask = 0;
 	card->thread_running_mask = 0;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index dc9976064181..896c919e7658 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -297,12 +297,13 @@ static int qeth_l2_send_setdelvlan(struct qeth_card *card, __u16 i,
 static void qeth_l2_process_vlans(struct qeth_card *card)
 {
 	struct qeth_vlan_vid *id;
+
 	QETH_CARD_TEXT(card, 3, "L2prcvln");
-	spin_lock_bh(&card->vlanlock);
+	mutex_lock(&card->vid_list_mutex);
 	list_for_each_entry(id, &card->vid_list, list) {
 		qeth_l2_send_setdelvlan(card, id->vid, IPA_CMD_SETVLAN);
 	}
-	spin_unlock_bh(&card->vlanlock);
+	mutex_unlock(&card->vid_list_mutex);
 }
 
 static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
@@ -319,7 +320,7 @@ static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
 		QETH_CARD_TEXT(card, 3, "aidREC");
 		return 0;
 	}
-	id = kmalloc(sizeof(struct qeth_vlan_vid), GFP_ATOMIC);
+	id = kmalloc(sizeof(*id), GFP_KERNEL);
 	if (id) {
 		id->vid = vid;
 		rc = qeth_l2_send_setdelvlan(card, vid, IPA_CMD_SETVLAN);
@@ -327,9 +328,9 @@ static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
 			kfree(id);
 			return rc;
 		}
-		spin_lock_bh(&card->vlanlock);
+		mutex_lock(&card->vid_list_mutex);
 		list_add_tail(&id->list, &card->vid_list);
-		spin_unlock_bh(&card->vlanlock);
+		mutex_unlock(&card->vid_list_mutex);
 	} else {
 		return -ENOMEM;
 	}
@@ -348,7 +349,7 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 		QETH_CARD_TEXT(card, 3, "kidREC");
 		return 0;
 	}
-	spin_lock_bh(&card->vlanlock);
+	mutex_lock(&card->vid_list_mutex);
 	list_for_each_entry(id, &card->vid_list, list) {
 		if (id->vid == vid) {
 			list_del(&id->list);
@@ -356,7 +357,7 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 			break;
 		}
 	}
-	spin_unlock_bh(&card->vlanlock);
+	mutex_unlock(&card->vid_list_mutex);
 	if (tmpid) {
 		rc = qeth_l2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
 		kfree(tmpid);
-- 
2.13.5
