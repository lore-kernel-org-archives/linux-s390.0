Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60954 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhA1L0q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:26:46 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/5] s390/qeth: clean up load/remove code for disciplines
Date: Thu, 28 Jan 2021 12:25:47 +0100
Message-Id: <20210128112551.18780-2-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
References: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

We have two usage patterns:
1. get & ->setup() a new discipline, or
2. ->remove() & put the currently loaded one.

Add corresponding helpers that hide the internals & error handling.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 +--
 drivers/s390/net/qeth_core_main.c | 45 ++++++++++++++++---------------
 drivers/s390/net/qeth_core_sys.c  | 10 ++-----
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 28f637042d44..331dcbbf3e25 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1067,8 +1067,8 @@ extern const struct device_type qeth_generic_devtype;
 
 const char *qeth_get_cardname_short(struct qeth_card *);
 int qeth_resize_buffer_pool(struct qeth_card *card, unsigned int count);
-int qeth_core_load_discipline(struct qeth_card *, enum qeth_discipline_id);
-void qeth_core_free_discipline(struct qeth_card *);
+int qeth_setup_discipline(struct qeth_card *card, enum qeth_discipline_id disc);
+void qeth_remove_discipline(struct qeth_card *card);
 
 /* exports for qeth discipline device drivers */
 extern struct kmem_cache *qeth_core_header_cache;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cf18d87da41e..0a65213ab606 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6349,9 +6349,11 @@ static int qeth_register_dbf_views(void)
 
 static DEFINE_MUTEX(qeth_mod_mutex);	/* for synchronized module loading */
 
-int qeth_core_load_discipline(struct qeth_card *card,
-		enum qeth_discipline_id discipline)
+int qeth_setup_discipline(struct qeth_card *card,
+			  enum qeth_discipline_id discipline)
 {
+	int rc;
+
 	mutex_lock(&qeth_mod_mutex);
 	switch (discipline) {
 	case QETH_DISCIPLINE_LAYER3:
@@ -6373,12 +6375,25 @@ int qeth_core_load_discipline(struct qeth_card *card,
 		return -EINVAL;
 	}
 
+	rc = card->discipline->setup(card->gdev);
+	if (rc) {
+		if (discipline == QETH_DISCIPLINE_LAYER2)
+			symbol_put(qeth_l2_discipline);
+		else
+			symbol_put(qeth_l3_discipline);
+		card->discipline = NULL;
+
+		return rc;
+	}
+
 	card->options.layer = discipline;
 	return 0;
 }
 
-void qeth_core_free_discipline(struct qeth_card *card)
+void qeth_remove_discipline(struct qeth_card *card)
 {
+	card->discipline->remove(card->gdev);
+
 	if (IS_LAYER2(card))
 		symbol_put(qeth_l2_discipline);
 	else
@@ -6586,23 +6601,18 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	default:
 		card->info.layer_enforced = true;
 		/* It's so early that we don't need the discipline_mutex yet. */
-		rc = qeth_core_load_discipline(card, enforced_disc);
+		rc = qeth_setup_discipline(card, enforced_disc);
 		if (rc)
-			goto err_load;
+			goto err_setup_disc;
 
 		gdev->dev.type = IS_OSN(card) ? &qeth_osn_devtype :
 						card->discipline->devtype;
-		rc = card->discipline->setup(card->gdev);
-		if (rc)
-			goto err_disc;
 		break;
 	}
 
 	return 0;
 
-err_disc:
-	qeth_core_free_discipline(card);
-err_load:
+err_setup_disc:
 err_chp_desc:
 	free_netdev(card->dev);
 err_card:
@@ -6619,10 +6629,8 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 	QETH_CARD_TEXT(card, 2, "removedv");
 
 	mutex_lock(&card->discipline_mutex);
-	if (card->discipline) {
-		card->discipline->remove(gdev);
-		qeth_core_free_discipline(card);
-	}
+	if (card->discipline)
+		qeth_remove_discipline(card);
 	mutex_unlock(&card->discipline_mutex);
 
 	qeth_free_qdio_queues(card);
@@ -6642,14 +6650,9 @@ static int qeth_core_set_online(struct ccwgroup_device *gdev)
 	if (!card->discipline) {
 		def_discipline = IS_IQD(card) ? QETH_DISCIPLINE_LAYER3 :
 						QETH_DISCIPLINE_LAYER2;
-		rc = qeth_core_load_discipline(card, def_discipline);
+		rc = qeth_setup_discipline(card, def_discipline);
 		if (rc)
 			goto err;
-		rc = card->discipline->setup(card->gdev);
-		if (rc) {
-			qeth_core_free_discipline(card);
-			goto err;
-		}
 	}
 
 	rc = qeth_set_online(card, card->discipline);
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index a0f777f76f66..5815114da468 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -384,19 +384,13 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 			goto out;
 		}
 
-		card->discipline->remove(card->gdev);
-		qeth_core_free_discipline(card);
+		qeth_remove_discipline(card);
 		free_netdev(card->dev);
 		card->dev = ndev;
 	}
 
-	rc = qeth_core_load_discipline(card, newdis);
-	if (rc)
-		goto out;
+	rc = qeth_setup_discipline(card, newdis);
 
-	rc = card->discipline->setup(card->gdev);
-	if (rc)
-		qeth_core_free_discipline(card);
 out:
 	mutex_unlock(&card->discipline_mutex);
 	return rc ? rc : count;
-- 
2.17.1
