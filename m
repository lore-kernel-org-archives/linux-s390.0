Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60344 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgH0ISS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:18:18 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/8] s390/qeth: copy less data from bridge state events
Date: Thu, 27 Aug 2020 10:17:03 +0200
Message-Id: <20200827081705.21922-7-jwi@linux.ibm.com>
In-Reply-To: <20200827081705.21922-1-jwi@linux.ibm.com>
References: <20200827081705.21922-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Current code copies _all_ entries from the event into a worker, when we
later only need specific data from the first entry.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5a023fc499eb..d96636369b4c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1088,15 +1088,14 @@ static void qeth_bridge_emit_host_event(struct qeth_card *card,
 struct qeth_bridge_state_data {
 	struct work_struct worker;
 	struct qeth_card *card;
-	struct qeth_sbp_state_change qports;
+	u8 role;
+	u8 state;
 };
 
 static void qeth_bridge_state_change_worker(struct work_struct *work)
 {
 	struct qeth_bridge_state_data *data =
 		container_of(work, struct qeth_bridge_state_data, worker);
-	/* We are only interested in the first entry - local port */
-	struct qeth_sbp_port_entry *entry = &data->qports.entry[0];
 	char env_locrem[32];
 	char env_role[32];
 	char env_state[32];
@@ -1109,14 +1108,14 @@ static void qeth_bridge_state_change_worker(struct work_struct *work)
 
 	snprintf(env_locrem, sizeof(env_locrem), "BRIDGEPORT=statechange");
 	snprintf(env_role, sizeof(env_role), "ROLE=%s",
-		(entry->role == QETH_SBP_ROLE_NONE) ? "none" :
-		(entry->role == QETH_SBP_ROLE_PRIMARY) ? "primary" :
-		(entry->role == QETH_SBP_ROLE_SECONDARY) ? "secondary" :
+		(data->role == QETH_SBP_ROLE_NONE) ? "none" :
+		(data->role == QETH_SBP_ROLE_PRIMARY) ? "primary" :
+		(data->role == QETH_SBP_ROLE_SECONDARY) ? "secondary" :
 		"<INVALID>");
 	snprintf(env_state, sizeof(env_state), "STATE=%s",
-		(entry->state == QETH_SBP_STATE_INACTIVE) ? "inactive" :
-		(entry->state == QETH_SBP_STATE_STANDBY) ? "standby" :
-		(entry->state == QETH_SBP_STATE_ACTIVE) ? "active" :
+		(data->state == QETH_SBP_STATE_INACTIVE) ? "inactive" :
+		(data->state == QETH_SBP_STATE_STANDBY) ? "standby" :
+		(data->state == QETH_SBP_STATE_ACTIVE) ? "active" :
 		"<INVALID>");
 	kobject_uevent_env(&data->card->gdev->dev.kobj,
 				KOBJ_CHANGE, env);
@@ -1129,7 +1128,6 @@ static void qeth_bridge_state_change(struct qeth_card *card,
 	struct qeth_sbp_state_change *qports =
 		 &cmd->data.sbp.data.state_change;
 	struct qeth_bridge_state_data *data;
-	int extrasize;
 
 	QETH_CARD_TEXT(card, 2, "brstchng");
 	if (qports->num_entries == 0) {
@@ -1140,17 +1138,18 @@ static void qeth_bridge_state_change(struct qeth_card *card,
 		QETH_CARD_TEXT_(card, 2, "BPsz%04x", qports->entry_length);
 		return;
 	}
-	extrasize = sizeof(struct qeth_sbp_port_entry) * qports->num_entries;
-	data = kzalloc(sizeof(struct qeth_bridge_state_data) + extrasize,
-		GFP_ATOMIC);
+
+	data = kzalloc(sizeof(*data), GFP_ATOMIC);
 	if (!data) {
 		QETH_CARD_TEXT(card, 2, "BPSalloc");
 		return;
 	}
 	INIT_WORK(&data->worker, qeth_bridge_state_change_worker);
 	data->card = card;
-	memcpy(&data->qports, qports,
-			sizeof(struct qeth_sbp_state_change) + extrasize);
+	/* Information for the local port: */
+	data->role = qports->entry[0].role;
+	data->state = qports->entry[0].state;
+
 	queue_work(card->event_wq, &data->worker);
 }
 
-- 
2.17.1
