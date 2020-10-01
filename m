Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732867AbgJARL7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:11:59 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/7] s390/qeth: constify the disciplines
Date: Thu,  1 Oct 2020 19:11:33 +0200
Message-Id: <20201001171136.46830-5-jwi@linux.ibm.com>
In-Reply-To: <20201001171136.46830-1-jwi@linux.ibm.com>
References: <20201001171136.46830-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The discipline struct is a fixed group of function pointers.
So declare the L2 and L3 disciplines as constant.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 6 +++---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 drivers/s390/net/qeth_l3_main.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 707a1634f621..e5f47a823a11 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -858,7 +858,7 @@ struct qeth_card {
 	struct qeth_qdio_info qdio;
 	int read_or_write_problem;
 	struct qeth_osn_info osn_info;
-	struct qeth_discipline *discipline;
+	const struct qeth_discipline *discipline;
 	atomic_t force_alloc_skb;
 	struct service_level qeth_service_level;
 	struct qdio_ssqd_desc ssqd;
@@ -1051,8 +1051,8 @@ static inline int qeth_send_simple_setassparms_v6(struct qeth_card *card,
 
 int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb);
 
-extern struct qeth_discipline qeth_l2_discipline;
-extern struct qeth_discipline qeth_l3_discipline;
+extern const struct qeth_discipline qeth_l2_discipline;
+extern const struct qeth_discipline qeth_l3_discipline;
 extern const struct ethtool_ops qeth_ethtool_ops;
 extern const struct ethtool_ops qeth_osn_ethtool_ops;
 extern const struct attribute_group *qeth_generic_attr_groups[];
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c0ceeddd1549..2e9d3fea60e6 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2340,7 +2340,7 @@ static int qeth_l2_control_event(struct qeth_card *card,
 	}
 }
 
-struct qeth_discipline qeth_l2_discipline = {
+const struct qeth_discipline qeth_l2_discipline = {
 	.devtype = &qeth_l2_devtype,
 	.setup = qeth_l2_probe_device,
 	.remove = qeth_l2_remove_device,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 803ccbcf3511..4db7ded88fc8 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2073,7 +2073,7 @@ static int qeth_l3_control_event(struct qeth_card *card,
 	return 1;
 }
 
-struct qeth_discipline qeth_l3_discipline = {
+const struct qeth_discipline qeth_l3_discipline = {
 	.devtype = &qeth_l3_devtype,
 	.setup = qeth_l3_probe_device,
 	.remove = qeth_l3_remove_device,
-- 
2.17.1
