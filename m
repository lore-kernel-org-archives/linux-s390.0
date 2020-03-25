Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727558AbgCYJfT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9XX12130844
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:17 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywet4p96t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:17 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:12 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 10/11] s390/qeth: keep track of fixed prio-queue configuration
Date: Wed, 25 Mar 2020 10:35:06 +0100
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Message-Id: <20200325093507.20831-11-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When a device is configured in prio-queue mode to pin all traffic onto
a specific HW queue, treat this as a distinct variant of prio-queueing
instead of QETH_NO_PRIO_QUEUEING.

This corrects an error message from qeth_osa_set_output_queues() for
devices configured in such a mode.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 +
 drivers/s390/net/qeth_core_main.c | 2 ++
 drivers/s390/net/qeth_core_sys.c  | 8 ++++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index a6553e78af08..5f85617bdce3 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -211,6 +211,7 @@ struct qeth_vnicc_info {
 #define QETH_PRIO_Q_ING_TOS   2
 #define QETH_PRIO_Q_ING_SKB   3
 #define QETH_PRIO_Q_ING_VLAN  4
+#define QETH_PRIO_Q_ING_FIXED 5
 
 /* Packing */
 #define QETH_LOW_WATERMARK_PACK  2
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0c9f1464a778..8713f1b821c1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3646,6 +3646,8 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb)
 			return ~ntohs(veth->h_vlan_TCI) >>
 			       (VLAN_PRIO_SHIFT + 1) & 3;
 		break;
+	case QETH_PRIO_Q_ING_FIXED:
+		return card->qdio.default_out_queue;
 	default:
 		break;
 	}
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 533a7f26dbe1..d7e429f6631e 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -211,16 +211,16 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_VLAN;
 		card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 	} else if (sysfs_streq(buf, "no_prio_queueing:0")) {
-		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
+		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_FIXED;
 		card->qdio.default_out_queue = 0;
 	} else if (sysfs_streq(buf, "no_prio_queueing:1")) {
-		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
+		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_FIXED;
 		card->qdio.default_out_queue = 1;
 	} else if (sysfs_streq(buf, "no_prio_queueing:2")) {
-		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
+		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_FIXED;
 		card->qdio.default_out_queue = 2;
 	} else if (sysfs_streq(buf, "no_prio_queueing:3")) {
-		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
+		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_FIXED;
 		card->qdio.default_out_queue = 3;
 	} else if (sysfs_streq(buf, "no_prio_queueing")) {
 		card->qdio.do_prio_queueing = QETH_NO_PRIO_QUEUEING;
-- 
2.17.1
