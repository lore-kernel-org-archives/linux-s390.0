Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbgD2PLh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 11:11:37 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 03/13] net/smc: introduce link_idx for link group array
Date: Wed, 29 Apr 2020 17:10:39 +0200
Message-Id: <20200429151049.49979-4-kgraul@linux.ibm.com>
In-Reply-To: <20200429151049.49979-1-kgraul@linux.ibm.com>
References: <20200429151049.49979-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The link_id is the index of the link in the array of the link group.
When a link in the array is reused for a new link, a different unique
link_id should be used, otherwise the index in the array could collide
with the previous link at this array position.
Use a new variable link_idx as array index, and make link_id an
increasing unique id value.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 34 +++++++++++++++++++++++++++++-----
 net/smc/smc_core.h |  2 ++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3bb45c33db22..d233112ced2a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -245,8 +245,28 @@ static void smc_lgr_terminate_work(struct work_struct *work)
 	__smc_lgr_terminate(lgr, true);
 }
 
-static int smcr_link_init(struct smc_link *lnk, u8 link_id,
-			  struct smc_init_info *ini)
+/* return next unique link id for the lgr */
+static u8 smcr_next_link_id(struct smc_link_group *lgr)
+{
+	u8 link_id;
+	int i;
+
+	while (1) {
+		link_id = ++lgr->next_link_id;
+		if (!link_id)	/* skip zero as link_id */
+			link_id = ++lgr->next_link_id;
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+			if (lgr->lnk[i].state != SMC_LNK_INACTIVE &&
+			    lgr->lnk[i].link_id == link_id)
+				continue;
+		}
+		break;
+	}
+	return link_id;
+}
+
+static int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
+			  u8 link_idx, struct smc_init_info *ini)
 {
 	u8 rndvec[3];
 	int rc;
@@ -254,7 +274,8 @@ static int smcr_link_init(struct smc_link *lnk, u8 link_id,
 	get_device(&ini->ib_dev->ibdev->dev);
 	atomic_inc(&ini->ib_dev->lnk_cnt);
 	lnk->state = SMC_LNK_ACTIVATING;
-	lnk->link_id = link_id;
+	lnk->link_id = smcr_next_link_id(lgr);
+	lnk->link_idx = link_idx;
 	lnk->smcibdev = ini->ib_dev;
 	lnk->ibport = ini->ib_port;
 	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
@@ -310,6 +331,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	struct list_head *lgr_list;
 	struct smc_link *lnk;
 	spinlock_t *lgr_lock;
+	u8 link_idx;
 	int rc = 0;
 	int i;
 
@@ -338,6 +360,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
 		INIT_LIST_HEAD(&lgr->rmbs[i]);
 	}
+	lgr->next_link_id = 0;
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
 	memcpy(&lgr->id, (u8 *)&smc_lgr_list.num, SMC_LGR_ID_SIZE);
 	INIT_DELAYED_WORK(&lgr->free_work, smc_lgr_free_work);
@@ -358,8 +381,9 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
 		       SMC_SYSTEMID_LEN);
 
-		lnk = &lgr->lnk[SMC_SINGLE_LINK];
-		rc = smcr_link_init(lnk, SMC_SINGLE_LINK, ini);
+		link_idx = SMC_SINGLE_LINK;
+		lnk = &lgr->lnk[link_idx];
+		rc = smcr_link_init(lgr, lnk, link_idx, ini);
 		if (rc)
 			goto free_lgr;
 		lgr_list = &smc_lgr_list.list;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 8041db20c753..c459b0639bf3 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -115,6 +115,7 @@ struct smc_link {
 	u8			peer_mac[ETH_ALEN];	/* = gid[8:10||13:15] */
 	u8			peer_gid[SMC_GID_SIZE];	/* gid of peer*/
 	u8			link_id;	/* unique # within link group */
+	u8			link_idx;	/* index in lgr link array */
 
 	enum smc_link_state	state;		/* state of link */
 	struct workqueue_struct *llc_wq;	/* single thread work queue */
@@ -222,6 +223,7 @@ struct smc_link_group {
 						/* remote addr/key pairs */
 			DECLARE_BITMAP(rtokens_used_mask, SMC_RMBS_PER_LGR_MAX);
 						/* used rtoken elements */
+			u8			next_link_id;
 		};
 		struct { /* SMC-D */
 			u64			peer_gid;
-- 
2.17.1
