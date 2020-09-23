Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgIWIhL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 04:37:11 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/9] s390/qeth: relax locking for ipato config data
Date: Wed, 23 Sep 2020 10:36:53 +0200
Message-Id: <20200923083700.44624-3-jwi@linux.ibm.com>
In-Reply-To: <20200923083700.44624-1-jwi@linux.ibm.com>
References: <20200923083700.44624-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

card->ipato is currently protected by the conf_mutex. But most users
also hold the ip_lock - in particular qeth_l3_add_ip().

So slightly expand the sections under ip_lock in a few places (to
effectively cover a few error & no-op cases), and then drop the
conf_mutex where it's no longer needed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  7 +++++--
 drivers/s390/net/qeth_l3_main.c |  4 ----
 drivers/s390/net/qeth_l3_sys.c  | 22 +++++++++++-----------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 2c14012ca35d..1b3fe384dcc9 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -814,12 +814,16 @@ struct qeth_card {
 	struct workqueue_struct *event_wq;
 	struct workqueue_struct *cmd_wq;
 	wait_queue_head_t wait_q;
+
+	struct mutex ip_lock;
+	/* protected by ip_lock: */
 	DECLARE_HASHTABLE(ip_htable, 4);
+	struct qeth_ipato ipato;
+
 	DECLARE_HASHTABLE(local_addrs4, 4);
 	DECLARE_HASHTABLE(local_addrs6, 4);
 	spinlock_t local_addrs4_lock;
 	spinlock_t local_addrs6_lock;
-	struct mutex ip_lock;
 	DECLARE_HASHTABLE(rx_mode_addrs, 4);
 	struct work_struct rx_mode_work;
 	struct work_struct kernel_thread_starter;
@@ -827,7 +831,6 @@ struct qeth_card {
 	unsigned long thread_start_mask;
 	unsigned long thread_allowed_mask;
 	unsigned long thread_running_mask;
-	struct qeth_ipato ipato;
 	struct list_head cmd_waiter_list;
 	/* QDIO buffer handling */
 	struct qeth_qdio_info qdio;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 903d7b6f511f..810d65fd48b4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -536,7 +536,6 @@ int qeth_l3_add_ipato_entry(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "addipato");
 
-	mutex_lock(&card->conf_mutex);
 	mutex_lock(&card->ip_lock);
 
 	list_for_each_entry(ipatoe, &card->ipato.entries, entry) {
@@ -556,7 +555,6 @@ int qeth_l3_add_ipato_entry(struct qeth_card *card,
 	}
 
 	mutex_unlock(&card->ip_lock);
-	mutex_unlock(&card->conf_mutex);
 
 	return rc;
 }
@@ -570,7 +568,6 @@ int qeth_l3_del_ipato_entry(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "delipato");
 
-	mutex_lock(&card->conf_mutex);
 	mutex_lock(&card->ip_lock);
 
 	list_for_each_entry_safe(ipatoe, tmp, &card->ipato.entries, entry) {
@@ -587,7 +584,6 @@ int qeth_l3_del_ipato_entry(struct qeth_card *card,
 	}
 
 	mutex_unlock(&card->ip_lock);
-	mutex_unlock(&card->conf_mutex);
 
 	return rc;
 }
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index dd0b39082534..ca9c95b6bf35 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -301,19 +301,21 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 		goto out;
 	}
 
+	mutex_lock(&card->ip_lock);
 	if (sysfs_streq(buf, "toggle")) {
 		enable = !card->ipato.enabled;
 	} else if (kstrtobool(buf, &enable)) {
 		rc = -EINVAL;
-		goto out;
+		goto unlock_ip;
 	}
 
 	if (card->ipato.enabled != enable) {
 		card->ipato.enabled = enable;
-		mutex_lock(&card->ip_lock);
 		qeth_l3_update_ipato(card);
-		mutex_unlock(&card->ip_lock);
 	}
+
+unlock_ip:
+	mutex_unlock(&card->ip_lock);
 out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
@@ -339,7 +341,7 @@ static ssize_t qeth_l3_dev_ipato_invert4_store(struct device *dev,
 	bool invert;
 	int rc = 0;
 
-	mutex_lock(&card->conf_mutex);
+	mutex_lock(&card->ip_lock);
 	if (sysfs_streq(buf, "toggle")) {
 		invert = !card->ipato.invert4;
 	} else if (kstrtobool(buf, &invert)) {
@@ -349,12 +351,11 @@ static ssize_t qeth_l3_dev_ipato_invert4_store(struct device *dev,
 
 	if (card->ipato.invert4 != invert) {
 		card->ipato.invert4 = invert;
-		mutex_lock(&card->ip_lock);
 		qeth_l3_update_ipato(card);
-		mutex_unlock(&card->ip_lock);
 	}
+
 out:
-	mutex_unlock(&card->conf_mutex);
+	mutex_unlock(&card->ip_lock);
 	return rc ? rc : count;
 }
 
@@ -510,7 +511,7 @@ static ssize_t qeth_l3_dev_ipato_invert6_store(struct device *dev,
 	bool invert;
 	int rc = 0;
 
-	mutex_lock(&card->conf_mutex);
+	mutex_lock(&card->ip_lock);
 	if (sysfs_streq(buf, "toggle")) {
 		invert = !card->ipato.invert6;
 	} else if (kstrtobool(buf, &invert)) {
@@ -520,12 +521,11 @@ static ssize_t qeth_l3_dev_ipato_invert6_store(struct device *dev,
 
 	if (card->ipato.invert6 != invert) {
 		card->ipato.invert6 = invert;
-		mutex_lock(&card->ip_lock);
 		qeth_l3_update_ipato(card);
-		mutex_unlock(&card->ip_lock);
 	}
+
 out:
-	mutex_unlock(&card->conf_mutex);
+	mutex_unlock(&card->ip_lock);
 	return rc ? rc : count;
 }
 
-- 
2.17.1
