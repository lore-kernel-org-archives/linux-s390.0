Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729618AbfJIIII (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:08:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x998809n106627
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:08:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhbpd850n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:08:03 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:07:57 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 4/5] net/smc: no new connections on disappearing devices
Date: Wed,  9 Oct 2019 10:07:46 +0200
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
Message-Id: <20191009080747.95516-5-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Add a "going_away" indication to ISM devices and IB ports and
avoid creation of new connections on such disappearing devices.

And do not handle ISM events if ISM device is disappearing.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/net/smc.h  |  1 +
 net/smc/smc_core.c | 23 +++++++++++++++++++++++
 net/smc/smc_ib.c   | 15 +++++++++++++--
 net/smc/smc_ib.h   |  1 +
 net/smc/smc_ism.c  |  3 +++
 net/smc/smc_pnet.c |  5 ++++-
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index 438bb0261f45..05174ae4f325 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -77,6 +77,7 @@ struct smcd_dev {
 	bool pnetid_by_user;
 	struct list_head lgr_list;
 	spinlock_t lgr_lock;
+	u8 going_away : 1;
 };
 
 struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a12ec621b54c..efe416f81342 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1057,6 +1057,27 @@ int smc_rmb_rtoken_handling(struct smc_connection *conn,
 	return 0;
 }
 
+static void smc_core_going_away(void)
+{
+	struct smc_ib_device *smcibdev;
+	struct smcd_dev *smcd;
+
+	spin_lock(&smc_ib_devices.lock);
+	list_for_each_entry(smcibdev, &smc_ib_devices.list, list) {
+		int i;
+
+		for (i = 0; i < SMC_MAX_PORTS; i++)
+			set_bit(i, smcibdev->ports_going_away);
+	}
+	spin_unlock(&smc_ib_devices.lock);
+
+	spin_lock(&smcd_dev_list.lock);
+	list_for_each_entry(smcd, &smcd_dev_list.list, list) {
+		smcd->going_away = 1;
+	}
+	spin_unlock(&smcd_dev_list.lock);
+}
+
 /* Called (from smc_exit) when module is removed */
 void smc_core_exit(void)
 {
@@ -1064,6 +1085,8 @@ void smc_core_exit(void)
 	LIST_HEAD(lgr_freeing_list);
 	struct smcd_dev *smcd;
 
+	smc_core_going_away();
+
 	spin_lock_bh(&smc_lgr_list.lock);
 	list_splice_init(&smc_lgr_list.list, &lgr_freeing_list);
 	spin_unlock_bh(&smc_lgr_list.lock);
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index d14ca4af6f94..af05daeb0538 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -242,8 +242,12 @@ static void smc_ib_port_event_work(struct work_struct *work)
 	for_each_set_bit(port_idx, &smcibdev->port_event_mask, SMC_MAX_PORTS) {
 		smc_ib_remember_port_attr(smcibdev, port_idx + 1);
 		clear_bit(port_idx, &smcibdev->port_event_mask);
-		if (!smc_ib_port_active(smcibdev, port_idx + 1))
+		if (!smc_ib_port_active(smcibdev, port_idx + 1)) {
+			set_bit(port_idx, smcibdev->ports_going_away);
 			smc_port_terminate(smcibdev, port_idx + 1);
+		} else {
+			clear_bit(port_idx, smcibdev->ports_going_away);
+		}
 	}
 }
 
@@ -259,8 +263,10 @@ static void smc_ib_global_event_handler(struct ib_event_handler *handler,
 	switch (ibevent->event) {
 	case IB_EVENT_DEVICE_FATAL:
 		/* terminate all ports on device */
-		for (port_idx = 0; port_idx < SMC_MAX_PORTS; port_idx++)
+		for (port_idx = 0; port_idx < SMC_MAX_PORTS; port_idx++) {
 			set_bit(port_idx, &smcibdev->port_event_mask);
+			set_bit(port_idx, smcibdev->ports_going_away);
+		}
 		schedule_work(&smcibdev->port_event_work);
 		break;
 	case IB_EVENT_PORT_ERR:
@@ -269,6 +275,10 @@ static void smc_ib_global_event_handler(struct ib_event_handler *handler,
 		port_idx = ibevent->element.port_num - 1;
 		if (port_idx < SMC_MAX_PORTS) {
 			set_bit(port_idx, &smcibdev->port_event_mask);
+			if (ibevent->event == IB_EVENT_PORT_ERR)
+				set_bit(port_idx, smcibdev->ports_going_away);
+			else if (ibevent->event == IB_EVENT_PORT_ACTIVE)
+				clear_bit(port_idx, smcibdev->ports_going_away);
 			schedule_work(&smcibdev->port_event_work);
 		}
 		break;
@@ -307,6 +317,7 @@ static void smc_ib_qp_event_handler(struct ib_event *ibevent, void *priv)
 		port_idx = ibevent->element.qp->port - 1;
 		if (port_idx < SMC_MAX_PORTS) {
 			set_bit(port_idx, &smcibdev->port_event_mask);
+			set_bit(port_idx, smcibdev->ports_going_away);
 			schedule_work(&smcibdev->port_event_work);
 		}
 		break;
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index da60ab9e8d70..6a0069db6cae 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -47,6 +47,7 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	u8			initialized : 1; /* ib dev CQ, evthdl done */
 	struct work_struct	port_event_work;
 	unsigned long		port_event_mask;
+	DECLARE_BITMAP(ports_going_away, SMC_MAX_PORTS);
 };
 
 struct smc_buf_desc;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 34dc619655e8..ee7340898cb4 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -315,6 +315,7 @@ void smcd_unregister_dev(struct smcd_dev *smcd)
 	spin_lock(&smcd_dev_list.lock);
 	list_del(&smcd->list);
 	spin_unlock(&smcd_dev_list.lock);
+	smcd->going_away = 1;
 	flush_workqueue(smcd->event_wq);
 	destroy_workqueue(smcd->event_wq);
 	smc_smcd_terminate(smcd, 0, VLAN_VID_MASK);
@@ -344,6 +345,8 @@ void smcd_handle_event(struct smcd_dev *smcd, struct smcd_event *event)
 {
 	struct smc_ism_event_work *wrk;
 
+	if (smcd->going_away)
+		return;
 	/* copy event to event work queue, and let it be handled there */
 	wrk = kmalloc(sizeof(*wrk), GFP_ATOMIC);
 	if (!wrk)
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index bab2da8cf17a..6b7799b3f5ca 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -781,6 +781,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
 			dev_put(ndev);
 			if (netdev == ndev &&
 			    smc_ib_port_active(ibdev, i) &&
+			    !test_bit(i - 1, ibdev->ports_going_away) &&
 			    !smc_ib_determine_gid(ibdev, i, ini->vlan_id,
 						  ini->ib_gid, NULL)) {
 				ini->ib_dev = ibdev;
@@ -820,6 +821,7 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 				continue;
 			if (smc_pnet_match(ibdev->pnetid[i - 1], ndev_pnetid) &&
 			    smc_ib_port_active(ibdev, i) &&
+			    !test_bit(i - 1, ibdev->ports_going_away) &&
 			    !smc_ib_determine_gid(ibdev, i, ini->vlan_id,
 						  ini->ib_gid, NULL)) {
 				ini->ib_dev = ibdev;
@@ -846,7 +848,8 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
 
 	spin_lock(&smcd_dev_list.lock);
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
-		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid)) {
+		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid) &&
+		    !ismdev->going_away) {
 			ini->ism_dev = ismdev;
 			break;
 		}
-- 
2.17.1
