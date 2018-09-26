From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/15] s390/qeth: on gdev release, reset drvdata
Date: Wed, 26 Sep 2018 18:29:05 +0200
Message-ID: <20180926162916.102720-5-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_core_probe_device() sets the gdev's drvdata, but doesn't reset it
on a subsequent error. Move the (re-)setting around a bit, so that it
happens symmetrically on allocating/freeing the qeth_card struct.

This is no actual problem, as the ccwgroup core will discard the gdev
on a probe error. But from qeth's perspective the gdev is an external
resource, so it's best to manage it cleanly.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 1fed8f113f40..a6c632d36df8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1513,6 +1513,7 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
 	card->gdev = gdev;
+	dev_set_drvdata(&gdev->dev, card);
 	CARD_RDEV(card) = gdev->cdev[0];
 	CARD_WDEV(card) = gdev->cdev[1];
 	CARD_DDEV(card) = gdev->cdev[2];
@@ -1531,6 +1532,7 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 out_channel:
 	qeth_clean_channel(&card->read);
 out_ip:
+	dev_set_drvdata(&gdev->dev, NULL);
 	kfree(card);
 out:
 	return NULL;
@@ -5074,6 +5076,7 @@ static void qeth_core_free_card(struct qeth_card *card)
 	qeth_clean_channel(&card->data);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
+	dev_set_drvdata(&card->gdev->dev, NULL);
 	kfree(card);
 }
 
@@ -5788,7 +5791,6 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 			goto err_card;
 	}
 
-	dev_set_drvdata(&gdev->dev, card);
 	qeth_setup_card(card);
 	qeth_update_from_chp_desc(card);
 
@@ -5851,7 +5853,6 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 	write_unlock_irq(&qeth_core_card_list.rwlock);
 	free_netdev(card->dev);
 	qeth_core_free_card(card);
-	dev_set_drvdata(&gdev->dev, NULL);
 	put_device(&gdev->dev);
 }
 
-- 
2.16.4
