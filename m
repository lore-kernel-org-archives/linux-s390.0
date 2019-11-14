Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfKNMDB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 07:03:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEBx5Uo005848
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:03:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w94y24djc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:03:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 14 Nov 2019 12:02:57 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 4/8] net/smc: introduce bookkeeping of SMCD link groups
Date: Thu, 14 Nov 2019 13:02:43 +0100
In-Reply-To: <20191114120247.68889-1-kgraul@linux.ibm.com>
References: <20191114120247.68889-1-kgraul@linux.ibm.com>
Message-Id: <20191114120247.68889-5-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If the ism module is unloaded return control from exit routine only,
if all link groups are freed.
If an IB device is thrown away return control from device removal only,
if all link groups belonging to this device are freed.
A counters for the total number of SMCD link groups per ISM device is
introduced. ism module unloading continues only if the total number of
SMCD link groups for all ISM devices is zero. ISM device
removal continues only it the total number of SMCD link groups per ISM
device has decreased to zero.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/net/smc.h  | 2 ++
 net/smc/smc_core.c | 6 ++++++
 net/smc/smc_ism.c  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/net/smc.h b/include/net/smc.h
index 7c2082341bb3..646feb4bc75f 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -79,6 +79,8 @@ struct smcd_dev {
 	bool pnetid_by_user;
 	struct list_head lgr_list;
 	spinlock_t lgr_lock;
+	atomic_t lgr_cnt;
+	wait_queue_head_t lgrs_deleted;
 	u8 going_away : 1;
 };
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d79dd78c1cd8..30854acb846c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -276,6 +276,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		lgr_list = &ini->ism_dev->lgr_list;
 		lgr_lock = &lgr->smcd->lgr_lock;
 		lgr->peer_shutdown = 0;
+		atomic_inc(&ini->ism_dev->lgr_cnt);
 	} else {
 		/* SMC-R specific settings */
 		get_device(&ini->ib_dev->ibdev->dev);
@@ -486,6 +487,8 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 			smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
 			put_device(&lgr->smcd->dev);
 		}
+		if (!atomic_dec_return(&lgr->smcd->lgr_cnt))
+			wake_up(&lgr->smcd->lgrs_deleted);
 	} else {
 		smc_link_clear(&lgr->lnk[SMC_SINGLE_LINK]);
 		put_device(&lgr->lnk[SMC_SINGLE_LINK].smcibdev->ibdev->dev);
@@ -685,6 +688,9 @@ void smc_smcd_terminate_all(struct smcd_dev *smcd)
 		list_del_init(&lgr->list);
 		__smc_lgr_terminate(lgr, false);
 	}
+
+	if (atomic_read(&smcd->lgr_cnt))
+		wait_event(smcd->lgrs_deleted, !atomic_read(&smcd->lgr_cnt));
 }
 
 /* Determine vlan of internal TCP socket.
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 56cdab8be1fa..5c4727d5066e 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -302,6 +302,7 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	spin_lock_init(&smcd->lgr_lock);
 	INIT_LIST_HEAD(&smcd->vlan);
 	INIT_LIST_HEAD(&smcd->lgr_list);
+	init_waitqueue_head(&smcd->lgrs_deleted);
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
 	if (!smcd->event_wq) {
-- 
2.17.1
