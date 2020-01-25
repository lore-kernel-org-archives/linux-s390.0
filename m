Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgAYPxN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 25 Jan 2020 10:53:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PFcYU3117493
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjq4esf6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sat, 25 Jan 2020 15:53:10 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/5] s390/qeth: shift some bridgeport code around
Date: Sat, 25 Jan 2020 16:52:59 +0100
In-Reply-To: <20200125155303.40971-1-jwi@linux.ibm.com>
References: <20200125155303.40971-1-jwi@linux.ibm.com>
Message-Id: <20200125155303.40971-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_l2_setup_bridgeport_attrs() is entirely unrelated to sysfs
functionality, move it where it belongs.
While at it merge all the bridgeport-specific code in the set-online
path together.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2.h      |  1 -
 drivers/s390/net/qeth_l2_main.c | 26 +++++++++++++++++++++----
 drivers/s390/net/qeth_l2_sys.c  | 34 ---------------------------------
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index ddc615b431a8..adf25c9fd2b3 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -13,7 +13,6 @@ extern const struct attribute_group *qeth_l2_attr_groups[];
 
 int qeth_l2_create_device_attributes(struct device *);
 void qeth_l2_remove_device_attributes(struct device *);
-void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card);
 int qeth_bridgeport_query_ports(struct qeth_card *card,
 				enum qeth_sbp_roles *role,
 				enum qeth_sbp_states *state);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7175b5d8a23c..7da306e267c9 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -728,6 +728,24 @@ static void qeth_l2_trace_features(struct qeth_card *card)
 		      sizeof(card->options.vnicc.sup_chars));
 }
 
+static void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
+{
+	if (!card->options.sbp.reflect_promisc &&
+	    card->options.sbp.role != QETH_SBP_ROLE_NONE) {
+		/* Conditional to avoid spurious error messages */
+		qeth_bridgeport_setrole(card, card->options.sbp.role);
+		/* Let the callback function refresh the stored role value. */
+		qeth_bridgeport_query_ports(card, &card->options.sbp.role,
+					    NULL);
+	}
+	if (card->options.sbp.hostnotification) {
+		if (qeth_bridgeport_an_set(card, 1))
+			card->options.sbp.hostnotification = 0;
+	} else {
+		qeth_bridgeport_an_set(card, 0);
+	}
+}
+
 static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
@@ -748,9 +766,11 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 
 	mutex_lock(&card->sbp_lock);
 	qeth_bridgeport_query_support(card);
-	if (card->options.sbp.supported_funcs)
+	if (card->options.sbp.supported_funcs) {
+		qeth_l2_setup_bridgeport_attrs(card);
 		dev_info(&card->gdev->dev,
-		"The device represents a Bridge Capable Port\n");
+			 "The device represents a Bridge Capable Port\n");
+	}
 	mutex_unlock(&card->sbp_lock);
 
 	qeth_l2_register_dev_addr(card);
@@ -761,8 +781,6 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 	qeth_trace_features(card);
 	qeth_l2_trace_features(card);
 
-	qeth_l2_setup_bridgeport_attrs(card);
-
 	card->state = CARD_STATE_HARDSETUP;
 	qeth_print_status_message(card);
 
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 7fa325cf6f8d..86bcae992f72 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -246,40 +246,6 @@ static struct attribute_group qeth_l2_bridgeport_attr_group = {
 	.attrs = qeth_l2_bridgeport_attrs,
 };
 
-/**
- * qeth_l2_setup_bridgeport_attrs() - set/restore attrs when turning online.
- * @card:			      qeth_card structure pointer
- *
- * Note: this function is called with conf_mutex held by the caller
- */
-void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
-{
-	int rc;
-
-	if (!card)
-		return;
-	if (!card->options.sbp.supported_funcs)
-		return;
-
-	mutex_lock(&card->sbp_lock);
-	if (!card->options.sbp.reflect_promisc &&
-	    card->options.sbp.role != QETH_SBP_ROLE_NONE) {
-		/* Conditional to avoid spurious error messages */
-		qeth_bridgeport_setrole(card, card->options.sbp.role);
-		/* Let the callback function refresh the stored role value. */
-		qeth_bridgeport_query_ports(card,
-			&card->options.sbp.role, NULL);
-	}
-	if (card->options.sbp.hostnotification) {
-		rc = qeth_bridgeport_an_set(card, 1);
-		if (rc)
-			card->options.sbp.hostnotification = 0;
-	} else {
-		qeth_bridgeport_an_set(card, 0);
-	}
-	mutex_unlock(&card->sbp_lock);
-}
-
 /* VNIC CHARS support */
 
 /* convert sysfs attr name to VNIC characteristic */
-- 
2.17.1
