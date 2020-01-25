Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbgAYPxQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 25 Jan 2020 10:53:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00PFaE0t086873
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrhuxqpwf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 25 Jan 2020 10:53:16 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sat, 25 Jan 2020 15:53:13 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/5] s390/qeth: make cmd/reply matching more flexible
Date: Sat, 25 Jan 2020 16:53:02 +0100
In-Reply-To: <20200125155303.40971-1-jwi@linux.ibm.com>
References: <20200125155303.40971-1-jwi@linux.ibm.com>
Message-Id: <20200125155303.40971-5-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When data is received on the READ channel, the matching logic for cmds
that are waiting for a reply is currently hard-coded into the channel's
main IO callback.
Move this into a per-cmd callback, so that we can apply custom matching
logic for each individual cmd.

This also allows us to remove the coarse-grained check for unexpected
non-IPA replies, since they will no longer match against _all_ pending
cmds.

Note that IDX cmds use _no_ matcher, since their reply is synchronously
received as part of the cmd's IO.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 14 ++++++++++++-
 drivers/s390/net/qeth_core_main.c | 34 ++++++++++++++++++++++---------
 drivers/s390/net/qeth_l2_main.c   |  3 ++-
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index d052a265da1c..950d01551373 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -608,6 +608,8 @@ struct qeth_cmd_buffer {
 	long timeout;
 	unsigned char *data;
 	void (*finalize)(struct qeth_card *card, struct qeth_cmd_buffer *iob);
+	bool (*match)(struct qeth_cmd_buffer *iob,
+		      struct qeth_cmd_buffer *reply);
 	void (*callback)(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			 unsigned int data_length);
 	int rc;
@@ -618,6 +620,14 @@ static inline void qeth_get_cmd(struct qeth_cmd_buffer *iob)
 	refcount_inc(&iob->ref_count);
 }
 
+static inline struct qeth_ipa_cmd *__ipa_reply(struct qeth_cmd_buffer *iob)
+{
+	if (!IS_IPA(iob->data))
+		return NULL;
+
+	return (struct qeth_ipa_cmd *) PDU_ENCAPSULATION(iob->data);
+}
+
 static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
 {
 	return (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
@@ -1023,7 +1033,9 @@ void qeth_setadp_promisc_mode(struct qeth_card *card, bool enable);
 int qeth_setadpparms_change_macaddr(struct qeth_card *);
 void qeth_tx_timeout(struct net_device *, unsigned int txqueue);
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
-			  u16 cmd_length);
+			  u16 cmd_length,
+			  bool (*match)(struct qeth_cmd_buffer *iob,
+					struct qeth_cmd_buffer *reply));
 int qeth_query_switch_attributes(struct qeth_card *card,
 				  struct qeth_switch_info *sw_info);
 int qeth_query_card_info(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d66a7433908c..0f5f36e63823 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -748,8 +748,8 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 		goto out;
 	}
 
-	if (IS_IPA(iob->data)) {
-		cmd = (struct qeth_ipa_cmd *) PDU_ENCAPSULATION(iob->data);
+	cmd = __ipa_reply(iob);
+	if (cmd) {
 		cmd = qeth_check_ipa_data(card, cmd);
 		if (!cmd)
 			goto out;
@@ -758,17 +758,12 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 			card->osn_info.assist_cb(card->dev, cmd);
 			goto out;
 		}
-	} else {
-		/* non-IPA commands should only flow during initialization */
-		if (card->state != CARD_STATE_DOWN)
-			goto out;
 	}
 
 	/* match against pending cmd requests */
 	spin_lock_irqsave(&card->lock, flags);
 	list_for_each_entry(tmp, &card->cmd_waiter_list, list) {
-		if (!IS_IPA(tmp->data) ||
-		    __ipa_cmd(tmp)->hdr.seqno == cmd->hdr.seqno) {
+		if (tmp->match && tmp->match(tmp, iob)) {
 			request = tmp;
 			/* take the object outside the lock */
 			qeth_get_cmd(request);
@@ -1688,6 +1683,13 @@ static void qeth_mpc_finalize_cmd(struct qeth_card *card,
 	iob->callback = qeth_release_buffer_cb;
 }
 
+static bool qeth_mpc_match_reply(struct qeth_cmd_buffer *iob,
+				 struct qeth_cmd_buffer *reply)
+{
+	/* MPC cmds are issued strictly in sequence. */
+	return !IS_IPA(reply->data);
+}
+
 static struct qeth_cmd_buffer *qeth_mpc_alloc_cmd(struct qeth_card *card,
 						  void *data,
 						  unsigned int data_length)
@@ -1702,6 +1704,7 @@ static struct qeth_cmd_buffer *qeth_mpc_alloc_cmd(struct qeth_card *card,
 	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, data_length,
 		       iob->data);
 	iob->finalize = qeth_mpc_finalize_cmd;
+	iob->match = qeth_mpc_match_reply;
 	return iob;
 }
 
@@ -2722,7 +2725,9 @@ static void qeth_ipa_finalize_cmd(struct qeth_card *card,
 }
 
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
-			  u16 cmd_length)
+			  u16 cmd_length,
+			  bool (*match)(struct qeth_cmd_buffer *iob,
+					struct qeth_cmd_buffer *reply))
 {
 	u8 prot_type = qeth_mpc_select_prot_type(card);
 	u16 total_length = iob->length;
@@ -2730,6 +2735,7 @@ void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, total_length,
 		       iob->data);
 	iob->finalize = qeth_ipa_finalize_cmd;
+	iob->match = match;
 
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
 	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &total_length, 2);
@@ -2742,6 +2748,14 @@ void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 }
 EXPORT_SYMBOL_GPL(qeth_prepare_ipa_cmd);
 
+static bool qeth_ipa_match_reply(struct qeth_cmd_buffer *iob,
+				 struct qeth_cmd_buffer *reply)
+{
+	struct qeth_ipa_cmd *ipa_reply = __ipa_reply(reply);
+
+	return ipa_reply && (__ipa_cmd(iob)->hdr.seqno == ipa_reply->hdr.seqno);
+}
+
 struct qeth_cmd_buffer *qeth_ipa_alloc_cmd(struct qeth_card *card,
 					   enum qeth_ipa_cmds cmd_code,
 					   enum qeth_prot_versions prot,
@@ -2757,7 +2771,7 @@ struct qeth_cmd_buffer *qeth_ipa_alloc_cmd(struct qeth_card *card,
 	if (!iob)
 		return NULL;
 
-	qeth_prepare_ipa_cmd(card, iob, data_length);
+	qeth_prepare_ipa_cmd(card, iob, data_length, qeth_ipa_match_reply);
 
 	hdr = &__ipa_cmd(iob)->hdr;
 	hdr->command = cmd_code;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c36b6c1fc33f..d5ffd40937d3 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -896,7 +896,8 @@ int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
 	if (!iob)
 		return -ENOMEM;
 
-	qeth_prepare_ipa_cmd(card, iob, (u16) data_len);
+	qeth_prepare_ipa_cmd(card, iob, (u16) data_len, NULL);
+
 	memcpy(__ipa_cmd(iob), data, data_len);
 	iob->callback = qeth_osn_assist_cb;
 	return qeth_send_ipa_cmd(card, iob, NULL, NULL);
-- 
2.17.1
