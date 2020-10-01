Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24450 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732609AbgJARLv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:11:51 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/7] s390/qeth: de-magic the QIB parm area
Date: Thu,  1 Oct 2020 19:11:31 +0200
Message-Id: <20201001171136.46830-3-jwi@linux.ibm.com>
In-Reply-To: <20201001171136.46830-1-jwi@linux.ibm.com>
References: <20201001171136.46830-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Use a proper struct, and only program the QIB extensions for devices
where they are supported.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 11 ++++++
 drivers/s390/net/qeth_core_main.c | 65 ++++++++++++++-----------------
 2 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f1c9a694873e..1e1e7104dade 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -278,6 +278,17 @@ struct qeth_hdr {
 	} hdr;
 } __attribute__ ((packed));
 
+struct qeth_qib_parms {
+	char pcit_magic[4];
+	u32 pcit_a;
+	u32 pcit_b;
+	u32 pcit_c;
+	char blkt_magic[4];
+	u32 blkt_total;
+	u32 blkt_inter_packet;
+	u32 blkt_inter_packet_jumbo;
+};
+
 /*TCP Segmentation Offload header*/
 struct qeth_hdr_ext_tso {
 	__u16 hdr_tot_len;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b61078b27562..81f02a70680e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2743,30 +2743,26 @@ static void qeth_free_qdio_queues(struct qeth_card *card)
 	}
 }
 
-static void qeth_create_qib_param_field(struct qeth_card *card,
-		char *param_field)
-{
-
-	param_field[0] = _ascebc['P'];
-	param_field[1] = _ascebc['C'];
-	param_field[2] = _ascebc['I'];
-	param_field[3] = _ascebc['T'];
-	*((unsigned int *) (&param_field[4])) = QETH_PCI_THRESHOLD_A(card);
-	*((unsigned int *) (&param_field[8])) = QETH_PCI_THRESHOLD_B(card);
-	*((unsigned int *) (&param_field[12])) = QETH_PCI_TIMER_VALUE(card);
-}
-
-static void qeth_create_qib_param_field_blkt(struct qeth_card *card,
-		char *param_field)
-{
-	param_field[16] = _ascebc['B'];
-	param_field[17] = _ascebc['L'];
-	param_field[18] = _ascebc['K'];
-	param_field[19] = _ascebc['T'];
-	*((unsigned int *) (&param_field[20])) = card->info.blkt.time_total;
-	*((unsigned int *) (&param_field[24])) = card->info.blkt.inter_packet;
-	*((unsigned int *) (&param_field[28])) =
-		card->info.blkt.inter_packet_jumbo;
+static void qeth_fill_qib_parms(struct qeth_card *card,
+				struct qeth_qib_parms *parms)
+{
+	parms->pcit_magic[0] = 'P';
+	parms->pcit_magic[1] = 'C';
+	parms->pcit_magic[2] = 'I';
+	parms->pcit_magic[3] = 'T';
+	ASCEBC(parms->pcit_magic, sizeof(parms->pcit_magic));
+	parms->pcit_a = QETH_PCI_THRESHOLD_A(card);
+	parms->pcit_b = QETH_PCI_THRESHOLD_B(card);
+	parms->pcit_c = QETH_PCI_TIMER_VALUE(card);
+
+	parms->blkt_magic[0] = 'B';
+	parms->blkt_magic[1] = 'L';
+	parms->blkt_magic[2] = 'K';
+	parms->blkt_magic[3] = 'T';
+	ASCEBC(parms->blkt_magic, sizeof(parms->blkt_magic));
+	parms->blkt_total = card->info.blkt.time_total;
+	parms->blkt_inter_packet = card->info.blkt.inter_packet;
+	parms->blkt_inter_packet_jumbo = card->info.blkt.inter_packet_jumbo;
 }
 
 static int qeth_qdio_activate(struct qeth_card *card)
@@ -5022,21 +5018,20 @@ static int qeth_qdio_establish(struct qeth_card *card)
 {
 	struct qdio_buffer **out_sbal_ptrs[QETH_MAX_OUT_QUEUES];
 	struct qdio_buffer **in_sbal_ptrs[QETH_MAX_IN_QUEUES];
+	struct qeth_qib_parms *qib_parms = NULL;
 	struct qdio_initialize init_data;
-	char *qib_param_field;
 	unsigned int i;
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 2, "qdioest");
 
-	qib_param_field = kzalloc(sizeof_field(struct qib, parm), GFP_KERNEL);
-	if (!qib_param_field) {
-		rc =  -ENOMEM;
-		goto out_free_nothing;
-	}
+	if (!IS_IQD(card) && !IS_VM_NIC(card)) {
+		qib_parms = kzalloc(sizeof_field(struct qib, parm), GFP_KERNEL);
+		if (!qib_parms)
+			return -ENOMEM;
 
-	qeth_create_qib_param_field(card, qib_param_field);
-	qeth_create_qib_param_field_blkt(card, qib_param_field);
+		qeth_fill_qib_parms(card, qib_parms);
+	}
 
 	in_sbal_ptrs[0] = card->qdio.in_q->qdio_bufs;
 	if (card->options.cq == QETH_CQ_ENABLED)
@@ -5049,7 +5044,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	init_data.q_format		 = IS_IQD(card) ? QDIO_IQDIO_QFMT :
 							  QDIO_QETH_QFMT;
 	init_data.qib_param_field_format = 0;
-	init_data.qib_param_field        = qib_param_field;
+	init_data.qib_param_field	 = (void *)qib_parms;
 	init_data.no_input_qs            = card->qdio.no_in_queues;
 	init_data.no_output_qs           = card->qdio.no_out_queues;
 	init_data.input_handler		 = qeth_qdio_input_handler;
@@ -5086,9 +5081,9 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	default:
 		break;
 	}
+
 out:
-	kfree(qib_param_field);
-out_free_nothing:
+	kfree(qib_parms);
 	return rc;
 }
 
-- 
2.17.1
