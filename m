Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbfKNMDD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 07:03:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEBv7A7138347
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:03:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9571km4g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:03:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 14 Nov 2019 12:02:59 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 8/8] net/smc: immediate termination for SMCR link groups
Date: Thu, 14 Nov 2019 13:02:47 +0100
In-Reply-To: <20191114120247.68889-1-kgraul@linux.ibm.com>
References: <20191114120247.68889-1-kgraul@linux.ibm.com>
Message-Id: <20191114120247.68889-9-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If the SMC module is unloaded or an IB device is thrown away, the
immediate link group freeing introduced for SMCD is exploited for SMCR
as well. That means SMCR-specifics are added to smc_conn_kill().

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 58 +++++++++++++++++++++++++++++++---------------
 net/smc/smc_core.h |  3 ++-
 net/smc/smc_ib.c   |  3 ++-
 net/smc/smc_llc.c  |  4 +++-
 4 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 0755bd4b587c..97e9d21c4d1e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -566,6 +566,10 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 		struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
 
 		wake_up(&lnk->wr_reg_wait);
+		if (lnk->state != SMC_LNK_INACTIVE) {
+			smc_link_send_delete(lnk, false);
+			smc_llc_link_inactive(lnk);
+		}
 	}
 }
 
@@ -638,14 +642,16 @@ void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport)
 	list_for_each_entry_safe(lgr, l, &smc_lgr_list.list, list) {
 		if (!lgr->is_smcd &&
 		    lgr->lnk[SMC_SINGLE_LINK].smcibdev == smcibdev &&
-		    lgr->lnk[SMC_SINGLE_LINK].ibport == ibport)
+		    lgr->lnk[SMC_SINGLE_LINK].ibport == ibport) {
 			list_move(&lgr->list, &lgr_free_list);
+			lgr->freeing = 1;
+		}
 	}
 	spin_unlock_bh(&smc_lgr_list.lock);
 
 	list_for_each_entry_safe(lgr, l, &lgr_free_list, list) {
 		list_del_init(&lgr->list);
-		__smc_lgr_terminate(lgr, true);
+		__smc_lgr_terminate(lgr, false);
 	}
 }
 
@@ -695,6 +701,36 @@ void smc_smcd_terminate_all(struct smcd_dev *smcd)
 		wait_event(smcd->lgrs_deleted, !atomic_read(&smcd->lgr_cnt));
 }
 
+/* Called when an SMCR device is removed or the smc module is unloaded.
+ * If smcibdev is given, all SMCR link groups using this device are terminated.
+ * If smcibdev is NULL, all SMCR link groups are terminated.
+ */
+void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
+{
+	struct smc_link_group *lgr, *lg;
+	LIST_HEAD(lgr_free_list);
+
+	spin_lock_bh(&smc_lgr_list.lock);
+	if (!smcibdev) {
+		list_splice_init(&smc_lgr_list.list, &lgr_free_list);
+		list_for_each_entry(lgr, &lgr_free_list, list)
+			lgr->freeing = 1;
+	} else {
+		list_for_each_entry_safe(lgr, lg, &smc_lgr_list.list, list) {
+			if (lgr->lnk[SMC_SINGLE_LINK].smcibdev == smcibdev) {
+				list_move(&lgr->list, &lgr_free_list);
+				lgr->freeing = 1;
+			}
+		}
+	}
+	spin_unlock_bh(&smc_lgr_list.lock);
+
+	list_for_each_entry_safe(lgr, lg, &lgr_free_list, list) {
+		list_del_init(&lgr->list);
+		__smc_lgr_terminate(lgr, false);
+	}
+}
+
 /* Determine vlan of internal TCP socket.
  * @vlan_id: address to store the determined vlan id into
  */
@@ -1215,32 +1251,16 @@ static void smc_core_going_away(void)
 /* Clean up all SMC link groups */
 static void smc_lgrs_shutdown(void)
 {
-	struct smc_link_group *lgr, *lg;
-	LIST_HEAD(lgr_freeing_list);
 	struct smcd_dev *smcd;
 
 	smc_core_going_away();
 
-	spin_lock_bh(&smc_lgr_list.lock);
-	list_splice_init(&smc_lgr_list.list, &lgr_freeing_list);
-	spin_unlock_bh(&smc_lgr_list.lock);
+	smc_smcr_terminate_all(NULL);
 
 	spin_lock(&smcd_dev_list.lock);
 	list_for_each_entry(smcd, &smcd_dev_list.list, list)
 		smc_smcd_terminate_all(smcd);
 	spin_unlock(&smcd_dev_list.lock);
-
-	list_for_each_entry_safe(lgr, lg, &lgr_freeing_list, list) {
-		list_del_init(&lgr->list);
-		if (!lgr->is_smcd) {
-			struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
-
-			smc_link_send_delete(&lgr->lnk[SMC_SINGLE_LINK], false);
-			smc_llc_link_inactive(lnk);
-		}
-		cancel_delayed_work_sync(&lgr->free_work);
-		smc_lgr_free(lgr); /* free link group */
-	}
 }
 
 /* Called (from smc_exit) when module is removed */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 7f34f4d5a514..a428db6cd2e2 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -287,7 +287,7 @@ static inline struct smc_connection *smc_lgr_find_conn(
 
 static inline void smc_lgr_terminate_sched(struct smc_link_group *lgr)
 {
-	if (!lgr->terminating)
+	if (!lgr->terminating && !lgr->freeing)
 		schedule_work(&lgr->terminate_work);
 }
 
@@ -301,6 +301,7 @@ void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport);
 void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
 			unsigned short vlan);
 void smc_smcd_terminate_all(struct smcd_dev *dev);
+void smc_smcr_terminate_all(struct smc_ib_device *smcibdev);
 int smc_buf_create(struct smc_sock *smc, bool is_smcd);
 int smc_uncompress_bufsize(u8 compressed);
 int smc_rmb_rtoken_handling(struct smc_connection *conn,
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index c15dcd08dc74..0ab122e66328 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -565,7 +565,7 @@ static void smc_ib_add_dev(struct ib_device *ibdev)
 	schedule_work(&smcibdev->port_event_work);
 }
 
-/* callback function for ib_register_client() */
+/* callback function for ib_unregister_client() */
 static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 {
 	struct smc_ib_device *smcibdev;
@@ -575,6 +575,7 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 	spin_lock(&smc_ib_devices.lock);
 	list_del_init(&smcibdev->list); /* remove from smc_ib_devices */
 	spin_unlock(&smc_ib_devices.lock);
+	smc_smcr_terminate_all(smcibdev);
 	smc_ib_cleanup_per_ibdev(smcibdev);
 	ib_unregister_event_handler(&smcibdev->event_handler);
 	kfree(smcibdev);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 8d1b076021ed..a9f6431dd69a 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -698,9 +698,11 @@ int smc_llc_do_confirm_rkey(struct smc_link *link,
 int smc_llc_do_delete_rkey(struct smc_link *link,
 			   struct smc_buf_desc *rmb_desc)
 {
-	int rc;
+	int rc = 0;
 
 	mutex_lock(&link->llc_delete_rkey_mutex);
+	if (link->state != SMC_LNK_ACTIVE)
+		goto out;
 	reinit_completion(&link->llc_delete_rkey);
 	rc = smc_llc_send_delete_rkey(link, rmb_desc);
 	if (rc)
-- 
2.17.1
