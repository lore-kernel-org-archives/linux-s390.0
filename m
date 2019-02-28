Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 50/64] s390/qeth: cancel close_dev work before removing a card
Date: Thu, 28 Feb 2019 10:10:51 -0500
Message-Id: <20190228151105.11277-50-sashal@kernel.org>
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit c2780c1a3fb724560b1d44f7976e0de17bf153c7 ]

A card's close_dev work is scheduled on a driver-wide workqueue. If the
card is removed and freed while the work is still active, this causes a
use-after-free.
So make sure that the work is completed before freeing the card.

Fixes: 0f54761d167f ("qeth: Support VEPA mode")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h    | 1 +
 drivers/s390/net/qeth_l2_main.c | 2 ++
 drivers/s390/net/qeth_l3_main.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 970654fcc48d2..2d1f6a583641b 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -22,6 +22,7 @@
 #include <linux/hashtable.h>
 #include <linux/ip.h>
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 76b2fba5fba22..b7513c5848cf9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -854,6 +854,8 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l2_set_offline(cgdev);
+
+	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
 }
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b7f6a8384543c..7f71ca0d08e7f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2611,6 +2611,7 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	if (cgdev->state == CCWGROUP_ONLINE)
 		qeth_l3_set_offline(cgdev);
 
+	cancel_work_sync(&card->close_dev_work);
 	if (qeth_netdev_is_registered(card->dev))
 		unregister_netdev(card->dev);
 	qeth_l3_clear_ip_htable(card, 0);
-- 
2.19.1
