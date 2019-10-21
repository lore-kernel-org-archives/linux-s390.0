Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728826AbfJUONa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 10:13:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDI8P003898
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vsd0ekv0c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:28 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Mon, 21 Oct 2019 15:13:26 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/8] net/smc: terminate link group without holding lgr lock
Date: Mon, 21 Oct 2019 16:13:09 +0200
In-Reply-To: <20191021141315.58969-1-kgraul@linux.ibm.com>
References: <20191021141315.58969-1-kgraul@linux.ibm.com>
Message-Id: <20191021141315.58969-3-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

When a link group is to be terminated, it is sufficient to hold
the lgr lock when unlinking the link group from its list.
Move the lock-protected link group unlinking into smc_lgr_terminate().

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4ee0e33b8c5a..b53ba8f0a833 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -182,8 +182,7 @@ static void smc_lgr_free_work(struct work_struct *work)
 		spin_unlock_bh(lgr_lock);
 		return;
 	}
-	if (!list_empty(&lgr->list))
-		list_del_init(&lgr->list); /* remove from smc_lgr_list */
+	list_del_init(&lgr->list); /* remove from smc_lgr_list */
 	spin_unlock_bh(lgr_lock);
 
 	if (!lgr->is_smcd && !lgr->terminating)	{
@@ -479,7 +478,7 @@ void smc_lgr_forget(struct smc_link_group *lgr)
 	spin_unlock_bh(lgr_lock);
 }
 
-/* terminate linkgroup abnormally */
+/* terminate link group */
 static void __smc_lgr_terminate(struct smc_link_group *lgr)
 {
 	struct smc_connection *conn;
@@ -489,8 +488,6 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
 	lgr->terminating = 1;
-	if (!list_empty(&lgr->list)) /* forget lgr */
-		list_del_init(&lgr->list);
 	if (!lgr->is_smcd)
 		smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
 
@@ -516,29 +513,41 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 	smc_lgr_schedule_free_work(lgr);
 }
 
+/* unlink and terminate link group */
 void smc_lgr_terminate(struct smc_link_group *lgr)
 {
 	spinlock_t *lgr_lock;
 
 	smc_lgr_list_head(lgr, &lgr_lock);
 	spin_lock_bh(lgr_lock);
-	__smc_lgr_terminate(lgr);
+	if (lgr->terminating) {
+		spin_unlock_bh(lgr_lock);
+		return;	/* lgr already terminating */
+	}
+	list_del_init(&lgr->list);
 	spin_unlock_bh(lgr_lock);
+	__smc_lgr_terminate(lgr);
 }
 
 /* Called when IB port is terminated */
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr, *l;
+	LIST_HEAD(lgr_free_list);
 
 	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, l, &smc_lgr_list.list, list) {
 		if (!lgr->is_smcd &&
 		    lgr->lnk[SMC_SINGLE_LINK].smcibdev == smcibdev &&
 		    lgr->lnk[SMC_SINGLE_LINK].ibport == ibport)
-			__smc_lgr_terminate(lgr);
+			list_move(&lgr->list, &lgr_free_list);
 	}
 	spin_unlock_bh(&smc_lgr_list.lock);
+
+	list_for_each_entry_safe(lgr, l, &lgr_free_list, list) {
+		list_del_init(&lgr->list);
+		__smc_lgr_terminate(lgr);
+	}
 }
 
 /* Called when SMC-D device is terminated or peer is lost */
@@ -552,7 +561,6 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
 		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
 		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
-			__smc_lgr_terminate(lgr);
 			list_move(&lgr->list, &lgr_free_list);
 		}
 	}
@@ -561,6 +569,7 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
 	/* cancel the regular free workers and actually free lgrs */
 	list_for_each_entry_safe(lgr, l, &lgr_free_list, list) {
 		list_del_init(&lgr->list);
+		__smc_lgr_terminate(lgr);
 		cancel_delayed_work_sync(&lgr->free_work);
 		if (!peer_gid && vlan == VLAN_VID_MASK) /* dev terminated? */
 			smc_ism_signal_shutdown(lgr);
-- 
2.17.1
