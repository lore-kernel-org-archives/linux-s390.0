Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728335AbfKTNVI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:08 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKDIMdv048014
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 08:21:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf5914u1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 08:21:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 20 Nov 2019 13:21:05 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/2] s390/qeth: fix potential deadlock on workqueue flush
Date: Wed, 20 Nov 2019 14:20:56 +0100
In-Reply-To: <20191120132057.1788-1-jwi@linux.ibm.com>
References: <20191120132057.1788-1-jwi@linux.ibm.com>
Message-Id: <20191120132057.1788-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The L2 bridgeport code uses the coarse 'conf_mutex' for guarding access
to its configuration state.
This can result in a deadlock when qeth_l2_stop_card() - called under the
conf_mutex - blocks on flush_workqueue() to wait for the completion of
pending bridgeport workers. Such workers would also need to aquire
the conf_mutex, stalling indefinitely.

Introduce a lock that specifically guards the bridgeport configuration,
so that the workers no longer need the conf_mutex.
Wrapping qeth_l2_promisc_to_bridge() in this fine-grained lock then also
fixes a theoretical race against a concurrent qeth_bridge_port_role_store()
operation.

Fixes: c0a2e4d10d93 ("s390/qeth: conclude all event processing before offlining a card")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  1 +
 drivers/s390/net/qeth_l2_main.c | 21 ++++++++++++++-------
 drivers/s390/net/qeth_l2_sys.c  | 14 +++++++++++++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index e4b55f9aa062..65e31df37b1f 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -839,6 +839,7 @@ struct qeth_card {
 	struct service_level qeth_service_level;
 	struct qdio_ssqd_desc ssqd;
 	debug_info_t *debug;
+	struct mutex sbp_lock;
 	struct mutex conf_mutex;
 	struct mutex discipline_mutex;
 	struct napi_struct napi;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index bd8143e51747..4bccdce19b5a 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -467,10 +467,14 @@ static void qeth_l2_set_promisc_mode(struct qeth_card *card)
 	if (card->info.promisc_mode == enable)
 		return;
 
-	if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
+	if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE)) {
 		qeth_setadp_promisc_mode(card, enable);
-	else if (card->options.sbp.reflect_promisc)
-		qeth_l2_promisc_to_bridge(card, enable);
+	} else {
+		mutex_lock(&card->sbp_lock);
+		if (card->options.sbp.reflect_promisc)
+			qeth_l2_promisc_to_bridge(card, enable);
+		mutex_unlock(&card->sbp_lock);
+	}
 }
 
 /* New MAC address is added to the hash table and marked to be written on card
@@ -631,6 +635,7 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	int rc;
 
 	qeth_l2_vnicc_set_defaults(card);
+	mutex_init(&card->sbp_lock);
 
 	if (gdev->dev.type == &qeth_generic_devtype) {
 		rc = qeth_l2_create_device_attributes(&gdev->dev);
@@ -804,10 +809,12 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 	} else
 		card->info.hwtrap = 0;
 
+	mutex_lock(&card->sbp_lock);
 	qeth_bridgeport_query_support(card);
 	if (card->options.sbp.supported_funcs)
 		dev_info(&card->gdev->dev,
 		"The device represents a Bridge Capable Port\n");
+	mutex_unlock(&card->sbp_lock);
 
 	qeth_l2_register_dev_addr(card);
 
@@ -1162,9 +1169,9 @@ static void qeth_bridge_state_change_worker(struct work_struct *work)
 
 	/* Role should not change by itself, but if it did, */
 	/* information from the hardware is authoritative.  */
-	mutex_lock(&data->card->conf_mutex);
+	mutex_lock(&data->card->sbp_lock);
 	data->card->options.sbp.role = entry->role;
-	mutex_unlock(&data->card->conf_mutex);
+	mutex_unlock(&data->card->sbp_lock);
 
 	snprintf(env_locrem, sizeof(env_locrem), "BRIDGEPORT=statechange");
 	snprintf(env_role, sizeof(env_role), "ROLE=%s",
@@ -1230,9 +1237,9 @@ static void qeth_bridge_host_event_worker(struct work_struct *work)
 			: (data->hostevs.lost_event_mask == 0x02)
 			? "Bridge port state change"
 			: "Unknown reason");
-		mutex_lock(&data->card->conf_mutex);
+		mutex_lock(&data->card->sbp_lock);
 		data->card->options.sbp.hostnotification = 0;
-		mutex_unlock(&data->card->conf_mutex);
+		mutex_unlock(&data->card->sbp_lock);
 		qeth_bridge_emit_host_event(data->card, anev_abort,
 			0, NULL, NULL);
 	} else
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index f2c3b127b1e4..e2bcb26105a3 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -24,6 +24,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 	if (qeth_l2_vnicc_is_in_use(card))
 		return sprintf(buf, "n/a (VNIC characteristics)\n");
 
+	mutex_lock(&card->sbp_lock);
 	if (qeth_card_hw_is_reachable(card) &&
 					card->options.sbp.supported_funcs)
 		rc = qeth_bridgeport_query_ports(card,
@@ -57,6 +58,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 		else
 			rc = sprintf(buf, "%s\n", word);
 	}
+	mutex_unlock(&card->sbp_lock);
 
 	return rc;
 }
@@ -91,6 +93,7 @@ static ssize_t qeth_bridge_port_role_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
+	mutex_lock(&card->sbp_lock);
 
 	if (qeth_l2_vnicc_is_in_use(card))
 		rc = -EBUSY;
@@ -104,6 +107,7 @@ static ssize_t qeth_bridge_port_role_store(struct device *dev,
 	} else
 		card->options.sbp.role = role;
 
+	mutex_unlock(&card->sbp_lock);
 	mutex_unlock(&card->conf_mutex);
 
 	return rc ? rc : count;
@@ -158,6 +162,7 @@ static ssize_t qeth_bridgeport_hostnotification_store(struct device *dev,
 		return rc;
 
 	mutex_lock(&card->conf_mutex);
+	mutex_lock(&card->sbp_lock);
 
 	if (qeth_l2_vnicc_is_in_use(card))
 		rc = -EBUSY;
@@ -168,6 +173,7 @@ static ssize_t qeth_bridgeport_hostnotification_store(struct device *dev,
 	} else
 		card->options.sbp.hostnotification = enable;
 
+	mutex_unlock(&card->sbp_lock);
 	mutex_unlock(&card->conf_mutex);
 
 	return rc ? rc : count;
@@ -223,6 +229,7 @@ static ssize_t qeth_bridgeport_reflect_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
+	mutex_lock(&card->sbp_lock);
 
 	if (qeth_l2_vnicc_is_in_use(card))
 		rc = -EBUSY;
@@ -234,6 +241,7 @@ static ssize_t qeth_bridgeport_reflect_store(struct device *dev,
 		rc = 0;
 	}
 
+	mutex_unlock(&card->sbp_lock);
 	mutex_unlock(&card->conf_mutex);
 
 	return rc ? rc : count;
@@ -269,6 +277,8 @@ void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
 		return;
 	if (!card->options.sbp.supported_funcs)
 		return;
+
+	mutex_lock(&card->sbp_lock);
 	if (card->options.sbp.role != QETH_SBP_ROLE_NONE) {
 		/* Conditional to avoid spurious error messages */
 		qeth_bridgeport_setrole(card, card->options.sbp.role);
@@ -280,8 +290,10 @@ void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
 		rc = qeth_bridgeport_an_set(card, 1);
 		if (rc)
 			card->options.sbp.hostnotification = 0;
-	} else
+	} else {
 		qeth_bridgeport_an_set(card, 0);
+	}
+	mutex_unlock(&card->sbp_lock);
 }
 
 /* VNIC CHARS support */
-- 
2.17.1
