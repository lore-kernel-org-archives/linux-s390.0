Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgIWIhN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 04:37:13 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/9] s390/qeth: tighten ucast IP locking
Date: Wed, 23 Sep 2020 10:36:56 +0200
Message-Id: <20200923083700.44624-6-jwi@linux.ibm.com>
In-Reply-To: <20200923083700.44624-1-jwi@linux.ibm.com>
References: <20200923083700.44624-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The programming of ucast IPs via qeth_l3_modify_ip() is driven
independently from any of our typical locking mechanisms (eg. detaching
the netdevice, or holding the conf_mutex).
So when we inspect the card state to check whether the required cmd IO
should be deferred, there is no protection against concurrent state
changes.

But by slightly re-ordering the teardown sequence, we can rely on the
ip_lock to sufficiently serialize things:

1. when running concurrently to qeth_l3_set_online(), any instance of
   qeth_l3_modify_ip() that aquires the ip_lock _after_
   qeth_l3_recover_ip() will observe the state as CARD_STATE_SOFTSETUP
   and not defer the IO.
2. when running concurrently to qeth_l3_set_offline(), any instance of
   qeth_l3_modify_ip() that aquires the ip_lock _after_
   qeth_l3_clear_ip_htable() will observe the state as CARD_STATE_DOWN
   and defer the IO.

These guarantees in mind, we can now drop the conf_mutex from the
qeth_l3_modify_rxip_vipa() wrapper.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 876a21d451f5..0815b64c9797 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -591,7 +591,6 @@ int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
 			     enum qeth_prot_versions proto)
 {
 	struct qeth_ipaddr addr;
-	int rc;
 
 	qeth_l3_init_ipaddr(&addr, type, proto);
 	if (proto == QETH_PROT_IPV4)
@@ -599,11 +598,7 @@ int qeth_l3_modify_rxip_vipa(struct qeth_card *card, bool add, const u8 *ip,
 	else
 		memcpy(&addr.u.a6.addr, ip, 16);
 
-	mutex_lock(&card->conf_mutex);
-	rc = qeth_l3_modify_ip(card, &addr, add);
-	mutex_unlock(&card->conf_mutex);
-
-	return rc;
+	return qeth_l3_modify_ip(card, &addr, add);
 }
 
 int qeth_l3_modify_hsuid(struct qeth_card *card, bool add)
@@ -1161,9 +1156,9 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 		qeth_diags_trace(card, QETH_DIAGS_CMD_TRACE_DISABLE);
 
 	if (card->state == CARD_STATE_SOFTSETUP) {
+		card->state = CARD_STATE_DOWN;
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
-		card->state = CARD_STATE_DOWN;
 	}
 
 	qeth_qdio_clear_card(card, 0);
-- 
2.17.1
