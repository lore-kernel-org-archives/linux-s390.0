Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Subject: [PATCH 2/2] s390: Remove unneeded variables
Date: Tue,  4 Aug 2015 17:11:47 +0200
Message-Id: <1438701107-30727-1-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, maier@linux.vnet.ibm.com, peter.senna@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch remove unneeded variables used to store return values.

These issues were detected with the Coccinelle script:
scripts/coccinelle/misc/returnvar.cocci

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
Tested by cross compilation only.

 drivers/s390/cio/eadm_sch.c     | 3 +--
 drivers/s390/net/qeth_l2_main.c | 5 ++---
 drivers/s390/net/qeth_l3_main.c | 5 ++---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index bee8c11..b3f44bc 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -336,7 +336,6 @@ static int eadm_subchannel_sch_event(struct subchannel *sch, int process)
 {
 	struct eadm_private *private;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(sch->lock, flags);
 	if (!device_is_registered(&sch->dev))
@@ -356,7 +355,7 @@ static int eadm_subchannel_sch_event(struct subchannel *sch, int process)
 out_unlock:
 	spin_unlock_irqrestore(sch->lock, flags);
 
-	return ret;
+	return 0;
 }
 
 static struct css_device_id eadm_subchannel_ids[] = {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2e65b98..a79d698 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -392,8 +392,6 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 
 static int qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 {
-	int rc = 0;
-
 	QETH_DBF_TEXT(SETUP , 2, "stopcard");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
@@ -427,7 +425,8 @@ static int qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 		qeth_clear_cmd_buffers(&card->read);
 		qeth_clear_cmd_buffers(&card->write);
 	}
-	return rc;
+
+	return 0;
 }
 
 static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 70eb2f6..ee5e2ac 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2160,8 +2160,6 @@ static struct qeth_card *qeth_l3_get_card_from_dev(struct net_device *dev)
 
 static int qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
 {
-	int rc = 0;
-
 	QETH_DBF_TEXT(SETUP, 2, "stopcard");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
@@ -2196,7 +2194,8 @@ static int qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
 		qeth_clear_cmd_buffers(&card->read);
 		qeth_clear_cmd_buffers(&card->write);
 	}
-	return rc;
+
+	return 0;
 }
 
 /*
-- 
2.1.0
