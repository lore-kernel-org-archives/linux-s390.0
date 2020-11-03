Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgKCKZy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 05:25:54 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v2 04/15] net/smc: Add link counters for IB device ports
Date: Tue,  3 Nov 2020 11:25:20 +0100
Message-Id: <20201103102531.91710-5-kgraul@linux.ibm.com>
In-Reply-To: <20201103102531.91710-1-kgraul@linux.ibm.com>
References: <20201103102531.91710-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Add link counters to the structure of the smc ib device, one counter per
ib port. Increase/decrease the counters as needed in the corresponding
routines.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 3 +++
 net/smc/smc_ib.h   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 6e2077161267..da94725deb09 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -316,6 +316,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->link_idx = link_idx;
 	lnk->smcibdev = ini->ib_dev;
 	lnk->ibport = ini->ib_port;
+	atomic_inc(&ini->ib_dev->lnk_cnt_by_port[ini->ib_port - 1]);
 	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
@@ -360,6 +361,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	smc_llc_link_clear(lnk, false);
 out:
 	put_device(&ini->ib_dev->ibdev->dev);
+	atomic_dec(&ini->ib_dev->lnk_cnt_by_port[ini->ib_port - 1]);
 	memset(lnk, 0, sizeof(struct smc_link));
 	lnk->state = SMC_LNK_UNUSED;
 	if (!atomic_dec_return(&ini->ib_dev->lnk_cnt))
@@ -750,6 +752,7 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
 	smc_ib_dealloc_protection_domain(lnk);
 	smc_wr_free_link_mem(lnk);
 	put_device(&lnk->smcibdev->ibdev->dev);
+	atomic_dec(&lnk->smcibdev->lnk_cnt_by_port[lnk->ibport - 1]);
 	smcibdev = lnk->smcibdev;
 	memset(lnk, 0, sizeof(struct smc_link));
 	lnk->state = SMC_LNK_UNUSED;
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 2ce481187dd0..3e6bfeddd53b 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -53,6 +53,7 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	atomic_t		lnk_cnt;	/* number of links on ibdev */
 	wait_queue_head_t	lnks_deleted;	/* wait 4 removal of all links*/
 	struct mutex		mutex;		/* protect dev setup+cleanup */
+	atomic_t		lnk_cnt_by_port[SMC_MAX_PORTS];/*#lnk per port*/
 };
 
 struct smc_buf_desc;
-- 
2.17.1
