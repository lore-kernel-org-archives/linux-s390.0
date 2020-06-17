Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgFQOzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 10:55:04 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/2] s390/qeth: let isolation mode override HW offload restrictions
Date: Wed, 17 Jun 2020 16:54:53 +0200
Message-Id: <20200617145453.61382-3-jwi@linux.ibm.com>
In-Reply-To: <20200617145453.61382-1-jwi@linux.ibm.com>
References: <20200617145453.61382-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When a device is configured with ISOLATION_MODE_FWD, traffic never goes
through the internal switch. Don't apply the offload restrictions in
this case.

Fixes: c619e9a6f52f ("s390/qeth: don't use restricted offloads for local traffic")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9636415f810b..88e998de2d03 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6837,9 +6837,11 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features)
 {
+	struct qeth_card *card = dev->ml_priv;
+
 	/* Traffic with local next-hop is not eligible for some offloads: */
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		struct qeth_card *card = dev->ml_priv;
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    card->options.isolation != ISOLATION_MODE_FWD) {
 		netdev_features_t restricted = 0;
 
 		if (skb_is_gso(skb) && !netif_needs_gso(skb, features))
-- 
2.17.1
