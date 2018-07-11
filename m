From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/10] s390/qeth: clean up exported symbols
Date: Wed, 11 Jul 2018 17:42:43 +0200
Message-ID: <20180711154247.5523-7-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Remove some redundant EXPORTs. While at it, also move some L2-only
prototypes into the proper header file.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 6 ------
 drivers/s390/net/qeth_core_main.c | 8 +++-----
 drivers/s390/net/qeth_l2.h        | 5 +++++
 drivers/s390/net/qeth_l2_main.c   | 2 --
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 082c06d6380b..a932aac62d0e 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -983,7 +983,6 @@ int qeth_send_ipa_cmd(struct qeth_card *, struct qeth_cmd_buffer *,
 		  void *);
 struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *,
 			enum qeth_ipa_cmds, enum qeth_prot_versions);
-int qeth_query_setadapterparms(struct qeth_card *);
 struct sk_buff *qeth_core_get_next_skb(struct qeth_card *,
 		struct qeth_qdio_buffer *, struct qdio_buffer_element **, int *,
 		struct qeth_hdr **);
@@ -1009,10 +1008,6 @@ int qeth_query_switch_attributes(struct qeth_card *card,
 int qeth_send_control_data(struct qeth_card *, int, struct qeth_cmd_buffer *,
 	int (*reply_cb)(struct qeth_card *, struct qeth_reply*, unsigned long),
 	void *reply_param);
-int qeth_bridgeport_query_ports(struct qeth_card *card,
-	enum qeth_sbp_roles *role, enum qeth_sbp_states *state);
-int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role);
-int qeth_bridgeport_an_set(struct qeth_card *card, int enable);
 int qeth_get_elements_no(struct qeth_card *card, struct sk_buff *skb,
 			 int extra_elems, int data_offset);
 int qeth_get_elements_for_frags(struct sk_buff *);
@@ -1036,7 +1031,6 @@ int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback);
 int qeth_hdr_chk_and_bounce(struct sk_buff *, struct qeth_hdr **, int);
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
-int qeth_query_ipassists(struct qeth_card *, enum qeth_prot_versions prot);
 void qeth_trace_features(struct qeth_card *);
 void qeth_close_dev(struct qeth_card *);
 int qeth_send_setassparms(struct qeth_card *, struct qeth_cmd_buffer *, __u16,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4ba40a64907a..d80972b9bfc7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3054,7 +3054,7 @@ static struct qeth_cmd_buffer *qeth_get_adapter_cmd(struct qeth_card *card,
 	return iob;
 }
 
-int qeth_query_setadapterparms(struct qeth_card *card)
+static int qeth_query_setadapterparms(struct qeth_card *card)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -3067,7 +3067,6 @@ int qeth_query_setadapterparms(struct qeth_card *card)
 	rc = qeth_send_ipa_cmd(card, iob, qeth_query_setadapterparms_cb, NULL);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(qeth_query_setadapterparms);
 
 static int qeth_query_ipassists_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
@@ -3107,7 +3106,8 @@ static int qeth_query_ipassists_cb(struct qeth_card *card,
 	return 0;
 }
 
-int qeth_query_ipassists(struct qeth_card *card, enum qeth_prot_versions prot)
+static int qeth_query_ipassists(struct qeth_card *card,
+				enum qeth_prot_versions prot)
 {
 	int rc;
 	struct qeth_cmd_buffer *iob;
@@ -3119,7 +3119,6 @@ int qeth_query_ipassists(struct qeth_card *card, enum qeth_prot_versions prot)
 	rc = qeth_send_ipa_cmd(card, iob, qeth_query_ipassists_cb, NULL);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(qeth_query_ipassists);
 
 static int qeth_query_switch_attributes_cb(struct qeth_card *card,
 				struct qeth_reply *reply, unsigned long data)
@@ -3158,7 +3157,6 @@ int qeth_query_switch_attributes(struct qeth_card *card,
 	return qeth_send_ipa_cmd(card, iob,
 				qeth_query_switch_attributes_cb, sw_info);
 }
-EXPORT_SYMBOL_GPL(qeth_query_switch_attributes);
 
 static int qeth_query_setdiagass_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index f2130051ca11..ddc615b431a8 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -14,6 +14,11 @@ extern const struct attribute_group *qeth_l2_attr_groups[];
 int qeth_l2_create_device_attributes(struct device *);
 void qeth_l2_remove_device_attributes(struct device *);
 void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card);
+int qeth_bridgeport_query_ports(struct qeth_card *card,
+				enum qeth_sbp_roles *role,
+				enum qeth_sbp_states *state);
+int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role);
+int qeth_bridgeport_an_set(struct qeth_card *card, int enable);
 
 int qeth_l2_vnicc_set_state(struct qeth_card *card, u32 vnicc, bool state);
 int qeth_l2_vnicc_get_state(struct qeth_card *card, u32 vnicc, bool *state);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5910fd524872..8ac243de7a9e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1869,7 +1869,6 @@ int qeth_bridgeport_query_ports(struct qeth_card *card,
 		return rc;
 	return qeth_bridgeport_makerc(card, &cbctl, IPA_SBP_QUERY_BRIDGE_PORTS);
 }
-EXPORT_SYMBOL_GPL(qeth_bridgeport_query_ports);
 
 static int qeth_bridgeport_set_cb(struct qeth_card *card,
 	struct qeth_reply *reply, unsigned long data)
@@ -2017,7 +2016,6 @@ int qeth_bridgeport_an_set(struct qeth_card *card, int enable)
 		rc = qdio_pnso_brinfo(schid, 0, &response, NULL, NULL);
 	return qeth_anset_makerc(card, rc, response);
 }
-EXPORT_SYMBOL_GPL(qeth_bridgeport_an_set);
 
 static bool qeth_bridgeport_is_in_use(struct qeth_card *card)
 {
-- 
2.16.4
