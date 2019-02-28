Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/9] s390/qeth: don't special-case HW trap during suspend
Date: Thu, 28 Feb 2019 18:59:43 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

It makes no difference whether we
1. manually disarm the HW trap and call the offline code with
   recovery_mode == 1, or
2. call the offline code with recovery_mode == 0, and let it disarm the
   HW trap for us.

So consolidate the two code paths in the suspend callback.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 8 ++------
 drivers/s390/net/qeth_l3_main.c | 8 ++------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f34fe983012c..6380d29c10f7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -988,12 +988,8 @@ static int qeth_l2_pm_suspend(struct ccwgroup_device *gdev)
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 	if (gdev->state == CCWGROUP_OFFLINE)
 		return 0;
-	if (card->state == CARD_STATE_UP) {
-		if (card->info.hwtrap)
-			qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
-		__qeth_l2_set_offline(card->gdev, 1);
-	} else
-		__qeth_l2_set_offline(card->gdev, 0);
+
+	qeth_l2_set_offline(gdev);
 	return 0;
 }
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d424a6704811..375ad03ea4c5 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2476,12 +2476,8 @@ static int qeth_l3_pm_suspend(struct ccwgroup_device *gdev)
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 	if (gdev->state == CCWGROUP_OFFLINE)
 		return 0;
-	if (card->state == CARD_STATE_UP) {
-		if (card->info.hwtrap)
-			qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
-		__qeth_l3_set_offline(card->gdev, 1);
-	} else
-		__qeth_l3_set_offline(card->gdev, 0);
+
+	qeth_l3_set_offline(gdev);
 	return 0;
 }
 
-- 
2.16.4
