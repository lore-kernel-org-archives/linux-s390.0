Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730080AbfJIIID (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:08:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9987DUU171797
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:08:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vgyqbvex6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:08:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:07:56 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/5] net/smc: separate locks for SMCD and SMCR link group lists
Date: Wed,  9 Oct 2019 10:07:44 +0200
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
Message-Id: <20191009080747.95516-3-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

This patch introduces separate locks for the split SMCD and SMCR
link group lists.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/net/smc.h  |  1 +
 net/smc/smc_core.c | 57 ++++++++++++++++++++++++++++++++++------------
 net/smc/smc_ism.c  |  1 +
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index c08e8c415673..438bb0261f45 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -76,6 +76,7 @@ struct smcd_dev {
 	u8 pnetid[SMC_MAX_PNETID_LEN];
 	bool pnetid_by_user;
 	struct list_head lgr_list;
+	spinlock_t lgr_lock;
 };
 
 struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 92612978d783..96d3150d4d1c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -42,6 +42,19 @@ static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
 			 struct smc_buf_desc *buf_desc);
 
+/* return head of link group list and its lock for a given link group */
+static inline struct list_head *smc_lgr_list_head(struct smc_link_group *lgr,
+						  spinlock_t **lgr_lock)
+{
+	if (lgr->is_smcd) {
+		*lgr_lock = &lgr->smcd->lgr_lock;
+		return &lgr->smcd->lgr_list;
+	}
+
+	*lgr_lock = &smc_lgr_list.lock;
+	return &smc_lgr_list.list;
+}
+
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
 	/* client link group creation always follows the server link group
@@ -157,19 +170,21 @@ static void smc_lgr_free_work(struct work_struct *work)
 	struct smc_link_group *lgr = container_of(to_delayed_work(work),
 						  struct smc_link_group,
 						  free_work);
+	spinlock_t *lgr_lock;
 	bool conns;
 
-	spin_lock_bh(&smc_lgr_list.lock);
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	read_lock_bh(&lgr->conns_lock);
 	conns = RB_EMPTY_ROOT(&lgr->conns_all);
 	read_unlock_bh(&lgr->conns_lock);
 	if (!conns) { /* number of lgr connections is no longer zero */
-		spin_unlock_bh(&smc_lgr_list.lock);
+		spin_unlock_bh(lgr_lock);
 		return;
 	}
 	if (!list_empty(&lgr->list))
 		list_del_init(&lgr->list); /* remove from smc_lgr_list */
-	spin_unlock_bh(&smc_lgr_list.lock);
+	spin_unlock_bh(lgr_lock);
 
 	if (!lgr->is_smcd && !lgr->terminating)	{
 		struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
@@ -200,6 +215,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	struct smc_link_group *lgr;
 	struct list_head *lgr_list;
 	struct smc_link *lnk;
+	spinlock_t *lgr_lock;
 	u8 rndvec[3];
 	int rc = 0;
 	int i;
@@ -235,6 +251,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		lgr->peer_gid = ini->ism_gid;
 		lgr->smcd = ini->ism_dev;
 		lgr_list = &ini->ism_dev->lgr_list;
+		lgr_lock = &lgr->smcd->lgr_lock;
 	} else {
 		/* SMC-R specific settings */
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
@@ -248,6 +265,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		lnk->smcibdev = ini->ib_dev;
 		lnk->ibport = ini->ib_port;
 		lgr_list = &smc_lgr_list.list;
+		lgr_lock = &smc_lgr_list.lock;
 		lnk->path_mtu =
 			ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 		if (!ini->ib_dev->initialized)
@@ -277,9 +295,9 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 			goto destroy_qp;
 	}
 	smc->conn.lgr = lgr;
-	spin_lock_bh(&smc_lgr_list.lock);
+	spin_lock_bh(lgr_lock);
 	list_add(&lgr->list, lgr_list);
-	spin_unlock_bh(&smc_lgr_list.lock);
+	spin_unlock_bh(lgr_lock);
 	return 0;
 
 destroy_qp:
@@ -442,11 +460,15 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 
 void smc_lgr_forget(struct smc_link_group *lgr)
 {
-	spin_lock_bh(&smc_lgr_list.lock);
+	struct list_head *lgr_list;
+	spinlock_t *lgr_lock;
+
+	lgr_list = smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	/* do not use this link group for new connections */
-	if (!list_empty(&lgr->list))
-		list_del_init(&lgr->list);
-	spin_unlock_bh(&smc_lgr_list.lock);
+	if (!list_empty(lgr_list))
+		list_del_init(lgr_list);
+	spin_unlock_bh(lgr_lock);
 }
 
 /* terminate linkgroup abnormally */
@@ -487,9 +509,12 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 
 void smc_lgr_terminate(struct smc_link_group *lgr)
 {
-	spin_lock_bh(&smc_lgr_list.lock);
+	spinlock_t *lgr_lock;
+
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	__smc_lgr_terminate(lgr);
-	spin_unlock_bh(&smc_lgr_list.lock);
+	spin_unlock_bh(lgr_lock);
 }
 
 /* Called when IB port is terminated */
@@ -514,7 +539,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 	LIST_HEAD(lgr_free_list);
 
 	/* run common cleanup function and build free list */
-	spin_lock_bh(&smc_lgr_list.lock);
+	spin_lock_bh(&dev->lgr_lock);
 	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
 		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
 		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
@@ -522,7 +547,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 			list_move(&lgr->list, &lgr_free_list);
 		}
 	}
-	spin_unlock_bh(&smc_lgr_list.lock);
+	spin_unlock_bh(&dev->lgr_lock);
 
 	/* cancel the regular free workers and actually free lgrs */
 	list_for_each_entry_safe(lgr, l, &lgr_free_list, list) {
@@ -609,9 +634,11 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	struct list_head *lgr_list;
 	struct smc_link_group *lgr;
 	enum smc_lgr_role role;
+	spinlock_t *lgr_lock;
 	int rc = 0;
 
 	lgr_list = ini->is_smcd ? &ini->ism_dev->lgr_list : &smc_lgr_list.list;
+	lgr_lock = ini->is_smcd ? &ini->ism_dev->lgr_lock : &smc_lgr_list.lock;
 	ini->cln_first_contact = SMC_FIRST_CONTACT;
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 	if (role == SMC_CLNT && ini->srv_first_contact)
@@ -619,7 +646,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		goto create;
 
 	/* determine if an existing link group can be reused */
-	spin_lock_bh(&smc_lgr_list.lock);
+	spin_lock_bh(lgr_lock);
 	list_for_each_entry(lgr, lgr_list, list) {
 		write_lock_bh(&lgr->conns_lock);
 		if ((ini->is_smcd ?
@@ -640,7 +667,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		}
 		write_unlock_bh(&lgr->conns_lock);
 	}
-	spin_unlock_bh(&smc_lgr_list.lock);
+	spin_unlock_bh(lgr_lock);
 
 	if (role == SMC_CLNT && !ini->srv_first_contact &&
 	    ini->cln_first_contact == SMC_FIRST_CONTACT) {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 674eb5ae2320..34dc619655e8 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -286,6 +286,7 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	smc_pnetid_by_dev_port(parent, 0, smcd->pnetid);
 
 	spin_lock_init(&smcd->lock);
+	spin_lock_init(&smcd->lgr_lock);
 	INIT_LIST_HEAD(&smcd->vlan);
 	INIT_LIST_HEAD(&smcd->lgr_list);
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
-- 
2.17.1
