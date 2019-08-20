Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730384AbfHTOrB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 10:47:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEZDM2015186
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ughgk4nc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 15:46:56 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/9] s390/qeth: streamline control code for promisc mode
Date: Tue, 20 Aug 2019 16:46:41 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-8-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

We have logic to determine the desired promisc mode in _each_ code path.
Change things around so that there is a clean split between
(a) high-level code that selects the new mode, and (b) implementations
of the various mechanisms to program this mode.

This also keeps qeth_promisc_to_bridge() from polluting the debug logs
on each RX modeset.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 ++--
 drivers/s390/net/qeth_core_main.c | 15 +++----------
 drivers/s390/net/qeth_l2_main.c   | 36 +++++++++++++++----------------
 drivers/s390/net/qeth_l3_main.c   | 24 ++++++---------------
 4 files changed, 30 insertions(+), 49 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f07bb7130280..72755a025b4d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -653,6 +653,7 @@ struct qeth_card_info {
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
 	u8 open_when_online:1;
+	u8 promisc_mode:1;
 	u8 use_v1_blkt:1;
 	u8 is_vm_nic:1;
 	int mac_bits;
@@ -662,7 +663,6 @@ struct qeth_card_info {
 	int unique_id;
 	bool layer_enforced;
 	struct qeth_card_blkt blkt;
-	enum qeth_ipa_promisc_modes promisc_mode;
 	__u32 diagass_support;
 	__u32 hwtrap;
 };
@@ -1004,7 +1004,7 @@ void qeth_clear_ipacmd_list(struct qeth_card *);
 int qeth_qdio_clear_card(struct qeth_card *, int);
 void qeth_clear_working_pool_list(struct qeth_card *);
 void qeth_drain_output_queues(struct qeth_card *card);
-void qeth_setadp_promisc_mode(struct qeth_card *);
+void qeth_setadp_promisc_mode(struct qeth_card *card, bool enable);
 int qeth_setadpparms_change_macaddr(struct qeth_card *);
 void qeth_tx_timeout(struct net_device *);
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 95996ce99145..44fbaa4f7264 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4015,23 +4015,14 @@ static int qeth_setadp_promisc_mode_cb(struct qeth_card *card,
 	return (cmd->hdr.return_code) ? -EIO : 0;
 }
 
-void qeth_setadp_promisc_mode(struct qeth_card *card)
+void qeth_setadp_promisc_mode(struct qeth_card *card, bool enable)
 {
-	enum qeth_ipa_promisc_modes mode;
-	struct net_device *dev = card->dev;
+	enum qeth_ipa_promisc_modes mode = enable ? SET_PROMISC_MODE_ON :
+						    SET_PROMISC_MODE_OFF;
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
 
 	QETH_CARD_TEXT(card, 4, "setprom");
-
-	if (((dev->flags & IFF_PROMISC) &&
-	     (card->info.promisc_mode == SET_PROMISC_MODE_ON)) ||
-	    (!(dev->flags & IFF_PROMISC) &&
-	     (card->info.promisc_mode == SET_PROMISC_MODE_OFF)))
-		return;
-	mode = SET_PROMISC_MODE_OFF;
-	if (dev->flags & IFF_PROMISC)
-		mode = SET_PROMISC_MODE_ON;
 	QETH_CARD_TEXT_(card, 4, "mode:%x", mode);
 
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_PROMISC_MODE,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 1f534f489a79..662bd51f922f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -439,23 +439,14 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 	return 0;
 }
 
-static void qeth_promisc_to_bridge(struct qeth_card *card)
+static void qeth_l2_promisc_to_bridge(struct qeth_card *card, bool enable)
 {
-	struct net_device *dev = card->dev;
-	enum qeth_ipa_promisc_modes promisc_mode;
 	int role;
 	int rc;
 
 	QETH_CARD_TEXT(card, 3, "pmisc2br");
 
-	if (!card->options.sbp.reflect_promisc)
-		return;
-	promisc_mode = (dev->flags & IFF_PROMISC) ? SET_PROMISC_MODE_ON
-						: SET_PROMISC_MODE_OFF;
-	if (promisc_mode == card->info.promisc_mode)
-		return;
-
-	if (promisc_mode == SET_PROMISC_MODE_ON) {
+	if (enable) {
 		if (card->options.sbp.reflect_promisc_primary)
 			role = QETH_SBP_ROLE_PRIMARY;
 		else
@@ -464,14 +455,26 @@ static void qeth_promisc_to_bridge(struct qeth_card *card)
 		role = QETH_SBP_ROLE_NONE;
 
 	rc = qeth_bridgeport_setrole(card, role);
-	QETH_CARD_TEXT_(card, 2, "bpm%c%04x",
-			(promisc_mode == SET_PROMISC_MODE_ON) ? '+' : '-', rc);
+	QETH_CARD_TEXT_(card, 2, "bpm%c%04x", enable ? '+' : '-', rc);
 	if (!rc) {
 		card->options.sbp.role = role;
-		card->info.promisc_mode = promisc_mode;
+		card->info.promisc_mode = enable;
 	}
+}
+
+static void qeth_l2_set_promisc_mode(struct qeth_card *card)
+{
+	bool enable = card->dev->flags & IFF_PROMISC;
+
+	if (card->info.promisc_mode == enable)
+		return;
 
+	if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
+		qeth_setadp_promisc_mode(card, enable);
+	else if (card->options.sbp.reflect_promisc)
+		qeth_l2_promisc_to_bridge(card, enable);
 }
+
 /* New MAC address is added to the hash table and marked to be written on card
  * only if there is not in the hash table storage already
  *
@@ -539,10 +542,7 @@ static void qeth_l2_rx_mode_work(struct work_struct *work)
 		}
 	}
 
-	if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
-		qeth_setadp_promisc_mode(card);
-	else
-		qeth_promisc_to_bridge(card);
+	qeth_l2_set_promisc_mode(card);
 }
 
 static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2dd99f103671..54799fe6a700 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1435,27 +1435,19 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	flush_workqueue(card->event_wq);
 }
 
-/*
- * test for and Switch promiscuous mode (on or off)
- *  either for guestlan or HiperSocket Sniffer
- */
-static void
-qeth_l3_handle_promisc_mode(struct qeth_card *card)
+static void qeth_l3_set_promisc_mode(struct qeth_card *card)
 {
-	struct net_device *dev = card->dev;
+	bool enable = card->dev->flags & IFF_PROMISC;
 
-	if (((dev->flags & IFF_PROMISC) &&
-	     (card->info.promisc_mode == SET_PROMISC_MODE_ON)) ||
-	    (!(dev->flags & IFF_PROMISC) &&
-	     (card->info.promisc_mode == SET_PROMISC_MODE_OFF)))
+	if (card->info.promisc_mode == enable)
 		return;
 
 	if (IS_VM_NIC(card)) {		/* Guestlan trace */
 		if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
-			qeth_setadp_promisc_mode(card);
+			qeth_setadp_promisc_mode(card, enable);
 	} else if (card->options.sniffer &&	/* HiperSockets trace */
 		   qeth_adp_supported(card, IPA_SETADP_SET_DIAG_ASSIST)) {
-		if (dev->flags & IFF_PROMISC) {
+		if (enable) {
 			QETH_CARD_TEXT(card, 3, "+promisc");
 			qeth_diags_trace(card, QETH_DIAGS_CMD_TRACE_ENABLE);
 		} else {
@@ -1502,11 +1494,9 @@ static void qeth_l3_rx_mode_work(struct work_struct *work)
 				addr->disp_flag = QETH_DISP_ADDR_DELETE;
 			}
 		}
-
-		if (!qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
-			return;
 	}
-	qeth_l3_handle_promisc_mode(card);
+
+	qeth_l3_set_promisc_mode(card);
 }
 
 static int qeth_l3_arp_makerc(u16 rc)
-- 
2.17.1
