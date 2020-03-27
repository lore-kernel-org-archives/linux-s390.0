Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgC0KTr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:19:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RA1WTk042124
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:19:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywd8gs4r3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:19:46 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 27 Mar 2020 10:19:39 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/3] s390/qeth: remove fake_broadcast attribute
Date: Fri, 27 Mar 2020 11:19:32 +0100
In-Reply-To: <20200327101934.31040-1-jwi@linux.ibm.com>
References: <20200327101934.31040-1-jwi@linux.ibm.com>
Message-Id: <20200327101934.31040-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Ever since commit 4a71df50047f ("qeth: new qeth device driver") introduced
this attribute, it can be read & written but has no actual effect.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h   |  1 -
 drivers/s390/net/qeth_l3_sys.c | 35 ----------------------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 5f85617bdce3..acda230323d5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -710,7 +710,6 @@ struct qeth_card_options {
 	struct qeth_ipa_caps adp; /* Adapter parameters */
 	struct qeth_sbp_info sbp; /* SETBRIDGEPORT options */
 	struct qeth_vnicc_info vnicc; /* VNICC options */
-	int fake_broadcast;
 	enum qeth_discipline_id layer;
 	enum qeth_ipa_isolation_modes isolation;
 	enum qeth_ipa_isolation_modes prev_isolation;
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index a3d1c3bdfadb..dd0b39082534 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -133,40 +133,6 @@ static ssize_t qeth_l3_dev_route6_store(struct device *dev,
 static DEVICE_ATTR(route6, 0644, qeth_l3_dev_route6_show,
 			qeth_l3_dev_route6_store);
 
-static ssize_t qeth_l3_dev_fake_broadcast_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct qeth_card *card = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%i\n", card->options.fake_broadcast? 1:0);
-}
-
-static ssize_t qeth_l3_dev_fake_broadcast_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct qeth_card *card = dev_get_drvdata(dev);
-	char *tmp;
-	int i, rc = 0;
-
-	mutex_lock(&card->conf_mutex);
-	if (card->state != CARD_STATE_DOWN) {
-		rc = -EPERM;
-		goto out;
-	}
-
-	i = simple_strtoul(buf, &tmp, 16);
-	if ((i == 0) || (i == 1))
-		card->options.fake_broadcast = i;
-	else
-		rc = -EINVAL;
-out:
-	mutex_unlock(&card->conf_mutex);
-	return rc ? rc : count;
-}
-
-static DEVICE_ATTR(fake_broadcast, 0644, qeth_l3_dev_fake_broadcast_show,
-		   qeth_l3_dev_fake_broadcast_store);
-
 static ssize_t qeth_l3_dev_sniffer_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -305,7 +271,6 @@ static DEVICE_ATTR(hsuid, 0644, qeth_l3_dev_hsuid_show,
 static struct attribute *qeth_l3_device_attrs[] = {
 	&dev_attr_route4.attr,
 	&dev_attr_route6.attr,
-	&dev_attr_fake_broadcast.attr,
 	&dev_attr_sniffer.attr,
 	&dev_attr_hsuid.attr,
 	NULL,
-- 
2.17.1
