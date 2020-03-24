Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727729AbgCXSZD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 14:25:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OI43OE114850
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 14:25:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewudvcb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 14:25:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 24 Mar 2020 18:24:57 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/11] s390/qeth: clean up the mac_bits
Date: Tue, 24 Mar 2020 19:24:43 +0100
In-Reply-To: <20200324182448.95362-1-jwi@linux.ibm.com>
References: <20200324182448.95362-1-jwi@linux.ibm.com>
Message-Id: <20200324182448.95362-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

We're down to a single bit flag for MAC-address related status, reflect
that in the info struct.
Also set up the flag during initialization instead of clearing it during
shutdown - one more little step towards unifying the shutdown code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  3 +--
 drivers/s390/net/qeth_l2_main.c | 13 +++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 257b7f3c5558..911dcef6adc6 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -668,18 +668,17 @@ struct qeth_card_blkt {
 
 #define QETH_BROADCAST_WITH_ECHO    0x01
 #define QETH_BROADCAST_WITHOUT_ECHO 0x02
-#define QETH_LAYER2_MAC_REGISTERED  0x02
 struct qeth_card_info {
 	unsigned short unit_addr2;
 	unsigned short cula;
 	u8 chpid;
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
+	u8 dev_addr_is_registered:1;
 	u8 open_when_online:1;
 	u8 promisc_mode:1;
 	u8 use_v1_blkt:1;
 	u8 is_vm_nic:1;
-	int mac_bits;
 	enum qeth_card_types type;
 	enum qeth_link_types link_type;
 	int broadcast_capable;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 73cb363b1fab..249b00d91d46 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -291,7 +291,6 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	qeth_qdio_clear_card(card, 0);
 	qeth_clear_working_pool_list(card);
 	flush_workqueue(card->event_wq);
-	card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 	card->info.promisc_mode = 0;
 }
 
@@ -337,14 +336,16 @@ static void qeth_l2_register_dev_addr(struct qeth_card *card)
 		qeth_l2_request_initial_mac(card);
 
 	if (!IS_OSN(card) && !qeth_l2_send_setmac(card, card->dev->dev_addr))
-		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
+		card->info.dev_addr_is_registered = 1;
+	else
+		card->info.dev_addr_is_registered = 0;
 }
 
 static int qeth_l2_validate_addr(struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
 
-	if (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED)
+	if (card->info.dev_addr_is_registered)
 		return eth_validate_addr(dev);
 
 	QETH_CARD_TEXT(card, 4, "nomacadr");
@@ -370,7 +371,7 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 
 	/* don't register the same address twice */
 	if (ether_addr_equal_64bits(dev->dev_addr, addr->sa_data) &&
-	    (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
+	    card->info.dev_addr_is_registered)
 		return 0;
 
 	/* add the new address, switch over, drop the old */
@@ -380,9 +381,9 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 	ether_addr_copy(old_addr, dev->dev_addr);
 	ether_addr_copy(dev->dev_addr, addr->sa_data);
 
-	if (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED)
+	if (card->info.dev_addr_is_registered)
 		qeth_l2_remove_mac(card, old_addr);
-	card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
+	card->info.dev_addr_is_registered = 1;
 	return 0;
 }
 
-- 
2.17.1
