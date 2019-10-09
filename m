Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729922AbfJIIH7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:07:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9987QOm024162
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:07:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhaxr1w5q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:07:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:07:56 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 1/5] net/smc: separate SMCD and SMCR link group lists
Date: Wed,  9 Oct 2019 10:07:43 +0200
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
Message-Id: <20191009080747.95516-2-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Currently SMCD and SMCR link groups are maintained in one list.
To facilitate abnormal termination handling they are split into
a separate list for SMCR link groups and separate lists for SMCD
link groups per SMCD device.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/net/smc.h  |  1 +
 net/smc/smc_core.c | 24 +++++++++++++++++-------
 net/smc/smc_ism.c  |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index bd9c0fb3b577..c08e8c415673 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -75,6 +75,7 @@ struct smcd_dev {
 	struct workqueue_struct *event_wq;
 	u8 pnetid[SMC_MAX_PNETID_LEN];
 	bool pnetid_by_user;
+	struct list_head lgr_list;
 };
 
 struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2d2850adc2a3..92612978d783 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -198,6 +198,7 @@ static void smc_lgr_free_work(struct work_struct *work)
 static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_link_group *lgr;
+	struct list_head *lgr_list;
 	struct smc_link *lnk;
 	u8 rndvec[3];
 	int rc = 0;
@@ -233,6 +234,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		/* SMC-D specific settings */
 		lgr->peer_gid = ini->ism_gid;
 		lgr->smcd = ini->ism_dev;
+		lgr_list = &ini->ism_dev->lgr_list;
 	} else {
 		/* SMC-R specific settings */
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
@@ -245,6 +247,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		lnk->link_id = SMC_SINGLE_LINK;
 		lnk->smcibdev = ini->ib_dev;
 		lnk->ibport = ini->ib_port;
+		lgr_list = &smc_lgr_list.list;
 		lnk->path_mtu =
 			ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 		if (!ini->ib_dev->initialized)
@@ -275,7 +278,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	}
 	smc->conn.lgr = lgr;
 	spin_lock_bh(&smc_lgr_list.lock);
-	list_add(&lgr->list, &smc_lgr_list.list);
+	list_add(&lgr->list, lgr_list);
 	spin_unlock_bh(&smc_lgr_list.lock);
 	return 0;
 
@@ -512,9 +515,8 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 
 	/* run common cleanup function and build free list */
 	spin_lock_bh(&smc_lgr_list.lock);
-	list_for_each_entry_safe(lgr, l, &smc_lgr_list.list, list) {
-		if (lgr->is_smcd && lgr->smcd == dev &&
-		    (!peer_gid || lgr->peer_gid == peer_gid) &&
+	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
+		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
 		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
 			__smc_lgr_terminate(lgr);
 			list_move(&lgr->list, &lgr_free_list);
@@ -604,10 +606,12 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_connection *conn = &smc->conn;
+	struct list_head *lgr_list;
 	struct smc_link_group *lgr;
 	enum smc_lgr_role role;
 	int rc = 0;
 
+	lgr_list = ini->is_smcd ? &ini->ism_dev->lgr_list : &smc_lgr_list.list;
 	ini->cln_first_contact = SMC_FIRST_CONTACT;
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 	if (role == SMC_CLNT && ini->srv_first_contact)
@@ -616,7 +620,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 
 	/* determine if an existing link group can be reused */
 	spin_lock_bh(&smc_lgr_list.lock);
-	list_for_each_entry(lgr, &smc_lgr_list.list, list) {
+	list_for_each_entry(lgr, lgr_list, list) {
 		write_lock_bh(&lgr->conns_lock);
 		if ((ini->is_smcd ?
 		     smcd_lgr_match(lgr, ini->ism_dev, ini->ism_gid) :
@@ -1026,11 +1030,17 @@ void smc_core_exit(void)
 {
 	struct smc_link_group *lgr, *lg;
 	LIST_HEAD(lgr_freeing_list);
+	struct smcd_dev *smcd;
 
 	spin_lock_bh(&smc_lgr_list.lock);
-	if (!list_empty(&smc_lgr_list.list))
-		list_splice_init(&smc_lgr_list.list, &lgr_freeing_list);
+	list_splice_init(&smc_lgr_list.list, &lgr_freeing_list);
 	spin_unlock_bh(&smc_lgr_list.lock);
+
+	spin_lock(&smcd_dev_list.lock);
+	list_for_each_entry(smcd, &smcd_dev_list.list, list)
+		list_splice_init(&smcd->lgr_list, &lgr_freeing_list);
+	spin_unlock(&smcd_dev_list.lock);
+
 	list_for_each_entry_safe(lgr, lg, &lgr_freeing_list, list) {
 		list_del_init(&lgr->list);
 		if (!lgr->is_smcd) {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index e89e918b88e0..674eb5ae2320 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -287,6 +287,7 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 
 	spin_lock_init(&smcd->lock);
 	INIT_LIST_HEAD(&smcd->vlan);
+	INIT_LIST_HEAD(&smcd->lgr_list);
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
 	if (!smcd->event_wq) {
-- 
2.17.1
