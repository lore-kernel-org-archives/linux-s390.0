Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgEAKsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:31 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 07/13] net/smc: add smcr_port_add() and smcr_link_up() processing
Date: Fri,  1 May 2020 12:48:07 +0200
Message-Id: <20200501104813.76601-8-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Call smcr_port_add() when an IB event reports a new active IB device.
smcr_port_add() will start a work which either triggers the local
ADD_LINK processing, or send an ADD_LINK LLC message to the SMC server
to initiate the processing.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_core.h |  1 +
 net/smc/smc_ib.c   |  1 +
 3 files changed, 88 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d7ab92fc5b15..20bc9e46bf52 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -44,10 +44,19 @@ static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 static atomic_t lgr_cnt = ATOMIC_INIT(0); /* number of existing link groups */
 static DECLARE_WAIT_QUEUE_HEAD(lgrs_deleted);
 
+struct smc_ib_up_work {
+	struct work_struct	work;
+	struct smc_link_group	*lgr;
+	struct smc_ib_device	*smcibdev;
+	u8			ibport;
+};
+
 static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
 			 struct smc_buf_desc *buf_desc);
 static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft);
 
+static void smc_link_up_work(struct work_struct *work);
+
 /* return head of link group list and its lock for a given link group */
 static inline struct list_head *smc_lgr_list_head(struct smc_link_group *lgr,
 						  spinlock_t **lgr_lock)
@@ -928,6 +937,83 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 	}
 }
 
+/* link is up - establish alternate link if applicable */
+static void smcr_link_up(struct smc_link_group *lgr,
+			 struct smc_ib_device *smcibdev, u8 ibport)
+{
+	struct smc_link *link = NULL;
+
+	if (list_empty(&lgr->list) ||
+	    lgr->type == SMC_LGR_SYMMETRIC ||
+	    lgr->type == SMC_LGR_ASYMMETRIC_PEER)
+		return;
+
+	if (lgr->role == SMC_SERV) {
+		/* trigger local add link processing */
+		link = smc_llc_usable_link(lgr);
+		if (!link)
+			return;
+		/* tbd: call smc_llc_srv_add_link_local(link); */
+	} else {
+		/* invite server to start add link processing */
+		u8 gid[SMC_GID_SIZE];
+
+		if (smc_ib_determine_gid(smcibdev, ibport, lgr->vlan_id, gid,
+					 NULL))
+			return;
+		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
+			/* some other llc task is ongoing */
+			wait_event_interruptible_timeout(lgr->llc_waiter,
+				(lgr->llc_flow_lcl.type == SMC_LLC_FLOW_NONE),
+				SMC_LLC_WAIT_TIME);
+		}
+		if (list_empty(&lgr->list) ||
+		    !smc_ib_port_active(smcibdev, ibport))
+			return; /* lgr or device no longer active */
+		link = smc_llc_usable_link(lgr);
+		if (!link)
+			return;
+		smc_llc_send_add_link(link, smcibdev->mac[ibport - 1], gid,
+				      NULL, SMC_LLC_REQ);
+	}
+}
+
+void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
+{
+	struct smc_ib_up_work *ib_work;
+	struct smc_link_group *lgr, *n;
+
+	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
+		if (strncmp(smcibdev->pnetid[ibport - 1], lgr->pnet_id,
+			    SMC_MAX_PNETID_LEN) ||
+		    lgr->type == SMC_LGR_SYMMETRIC ||
+		    lgr->type == SMC_LGR_ASYMMETRIC_PEER)
+			continue;
+		ib_work = kmalloc(sizeof(*ib_work), GFP_KERNEL);
+		if (!ib_work)
+			continue;
+		INIT_WORK(&ib_work->work, smc_link_up_work);
+		ib_work->lgr = lgr;
+		ib_work->smcibdev = smcibdev;
+		ib_work->ibport = ibport;
+		schedule_work(&ib_work->work);
+	}
+}
+
+static void smc_link_up_work(struct work_struct *work)
+{
+	struct smc_ib_up_work *ib_work = container_of(work,
+						      struct smc_ib_up_work,
+						      work);
+	struct smc_link_group *lgr = ib_work->lgr;
+
+	if (list_empty(&lgr->list))
+		goto out;
+	smcr_link_up(lgr, ib_work->smcibdev, ib_work->ibport);
+out:
+	kfree(ib_work);
+}
+
 /* Determine vlan of internal TCP socket.
  * @vlan_id: address to store the determined vlan id into
  */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 413eaad50c7f..86453ad83491 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -345,6 +345,7 @@ void smc_lgr_forget(struct smc_link_group *lgr);
 void smc_lgr_cleanup_early(struct smc_connection *conn);
 void smc_lgr_terminate_sched(struct smc_link_group *lgr);
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport);
+void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport);
 void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
 			unsigned short vlan);
 void smc_smcd_terminate_all(struct smcd_dev *dev);
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index c090678a3e5a..545fb0bc3714 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -252,6 +252,7 @@ static void smc_ib_port_event_work(struct work_struct *work)
 			smc_port_terminate(smcibdev, port_idx + 1);
 		} else {
 			clear_bit(port_idx, smcibdev->ports_going_away);
+			smcr_port_add(smcibdev, port_idx + 1);
 		}
 	}
 }
-- 
2.17.1
