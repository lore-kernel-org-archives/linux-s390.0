Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbfLWODi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:03:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNE3S4p009897
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21sjvkc6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:37 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:03:35 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/6] s390/qeth: lock the card while changing its hsuid
Date: Mon, 23 Dec 2019 15:03:22 +0100
In-Reply-To: <20191223140326.16488-1-jwi@linux.ibm.com>
References: <20191223140326.16488-1-jwi@linux.ibm.com>
Message-Id: <20191223140326.16488-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_l3_dev_hsuid_store() initially checks the card state, but doesn't
take the conf_mutex to ensure that the card stays in this state while
being reconfigured.

Rework the code to take this lock, and drop a redundant state check in a
helper function.

Fixes: b333293058aa ("qeth: add support for af_iucv HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  5 ----
 drivers/s390/net/qeth_l3_sys.c    | 40 +++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 324cf22f9111..c64ef55f0dff 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3425,11 +3425,6 @@ int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 			goto out;
 		}
 
-		if (card->state != CARD_STATE_DOWN) {
-			rc = -1;
-			goto out;
-		}
-
 		qeth_free_qdio_queues(card);
 		card->options.cq = cq;
 		rc = 0;
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index f9067ed6c7d3..e8c848f72c6d 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -242,21 +242,33 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
+	int rc = 0;
 	char *tmp;
-	int rc;
 
 	if (!IS_IQD(card))
 		return -EPERM;
-	if (card->state != CARD_STATE_DOWN)
-		return -EPERM;
-	if (card->options.sniffer)
-		return -EPERM;
-	if (card->options.cq == QETH_CQ_NOTAVAILABLE)
-		return -EPERM;
+
+	mutex_lock(&card->conf_mutex);
+	if (card->state != CARD_STATE_DOWN) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (card->options.sniffer) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (card->options.cq == QETH_CQ_NOTAVAILABLE) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	tmp = strsep((char **)&buf, "\n");
-	if (strlen(tmp) > 8)
-		return -EINVAL;
+	if (strlen(tmp) > 8) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	if (card->options.hsuid[0])
 		/* delete old ip address */
@@ -267,11 +279,13 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		card->options.hsuid[0] = '\0';
 		memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 		qeth_configure_cq(card, QETH_CQ_DISABLED);
-		return count;
+		goto out;
 	}
 
-	if (qeth_configure_cq(card, QETH_CQ_ENABLED))
-		return -EPERM;
+	if (qeth_configure_cq(card, QETH_CQ_ENABLED)) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	snprintf(card->options.hsuid, sizeof(card->options.hsuid),
 		 "%-8s", tmp);
@@ -280,6 +294,8 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 
 	rc = qeth_l3_modify_hsuid(card, true);
 
+out:
+	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
 
-- 
2.17.1
