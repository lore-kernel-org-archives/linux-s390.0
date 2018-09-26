From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/15] s390/qeth: fix discipline unload after setup error
Date: Wed, 26 Sep 2018 18:29:04 +0200
Message-ID: <20180926162916.102720-4-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Device initialization code usually first loads a subdriver
(via qeth_core_load_discipline()), and then runs its setup() callback.
If this fails, it rolls back the load via qeth_core_free_discipline().

qeth_core_free_discipline() expects the options.layer attribute to be
initialized, but on error in setup() that's currently not the case.
Resulting in misbalanced symbol_put() calls.

Fix this by setting options.layer when loading the subdriver.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 ++
 drivers/s390/net/qeth_core_sys.c  | 2 --
 drivers/s390/net/qeth_l2_main.c   | 1 -
 drivers/s390/net/qeth_l3_main.c   | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c3068f680f67..1fed8f113f40 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5614,6 +5614,7 @@ int qeth_core_load_discipline(struct qeth_card *card,
 		return -EINVAL;
 	}
 
+	card->options.layer = discipline;
 	return 0;
 }
 
@@ -5623,6 +5624,7 @@ void qeth_core_free_discipline(struct qeth_card *card)
 		symbol_put(qeth_l2_discipline);
 	else
 		symbol_put(qeth_l3_discipline);
+	card->options.layer = QETH_DISCIPLINE_UNDETERMINED;
 	card->discipline = NULL;
 }
 
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index fdb67af811f4..970f6c71a66e 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -432,8 +432,6 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 
 		card->discipline->remove(card->gdev);
 		qeth_core_free_discipline(card);
-		card->options.layer = QETH_DISCIPLINE_UNDETERMINED;
-
 		free_netdev(card->dev);
 		card->dev = ndev;
 	}
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index afa7a005b21e..02566af7e23d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -806,7 +806,6 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	}
 	INIT_LIST_HEAD(&card->vid_list);
 	hash_init(card->mac_htable);
-	card->options.layer = QETH_DISCIPLINE_LAYER2;
 	card->info.hwtrap = 0;
 	qeth_l2_vnicc_set_defaults(card);
 	return 0;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 552bfad20f85..2756795f7708 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2489,7 +2489,6 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	}
 	hash_init(card->ip_htable);
 	hash_init(card->ip_mc_htable);
-	card->options.layer = QETH_DISCIPLINE_LAYER3;
 	card->info.hwtrap = 0;
 	return 0;
 }
-- 
2.16.4
