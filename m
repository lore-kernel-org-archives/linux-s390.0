Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v5 04/14] net/smc: Add link counters for IB device ports
Date: Tue, 24 Nov 2020 18:50:37 +0100
Message-Id: <20201124175047.56949-5-kgraul@linux.ibm.com>
In-Reply-To: <20201124175047.56949-1-kgraul@linux.ibm.com>
References: <20201124175047.56949-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Add link counters to the structure of the smc ib device, one counter per
ib port. Increase/decrease the counters as needed in the corresponding
routines.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 13 +++++++++++++
 net/smc/smc_ib.h   |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 5bc8ebcd03f3..46087cec3bcd 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -63,6 +63,16 @@ static inline struct list_head *smc_lgr_list_head(struct smc_link_group *lgr,
 	return &smc_lgr_list.list;
 }
 
+static void smc_ibdev_cnt_inc(struct smc_link *lnk)
+{
+	atomic_inc(&lnk->smcibdev->lnk_cnt_by_port[lnk->ibport - 1]);
+}
+
+static void smc_ibdev_cnt_dec(struct smc_link *lnk)
+{
+	atomic_dec(&lnk->smcibdev->lnk_cnt_by_port[lnk->ibport - 1]);
+}
+
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
 	/* client link group creation always follows the server link group
@@ -316,6 +326,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->link_idx = link_idx;
 	lnk->smcibdev = ini->ib_dev;
 	lnk->ibport = ini->ib_port;
+	smc_ibdev_cnt_inc(lnk);
 	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
@@ -359,6 +370,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 clear_llc_lnk:
 	smc_llc_link_clear(lnk, false);
 out:
+	smc_ibdev_cnt_dec(lnk);
 	put_device(&ini->ib_dev->ibdev->dev);
 	memset(lnk, 0, sizeof(struct smc_link));
 	lnk->state = SMC_LNK_UNUSED;
@@ -749,6 +761,7 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
 	smc_ib_destroy_queue_pair(lnk);
 	smc_ib_dealloc_protection_domain(lnk);
 	smc_wr_free_link_mem(lnk);
+	smc_ibdev_cnt_dec(lnk);
 	put_device(&lnk->smcibdev->ibdev->dev);
 	smcibdev = lnk->smcibdev;
 	memset(lnk, 0, sizeof(struct smc_link));
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 2ce481187dd0..3b85360a473b 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -53,6 +53,8 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	atomic_t		lnk_cnt;	/* number of links on ibdev */
 	wait_queue_head_t	lnks_deleted;	/* wait 4 removal of all links*/
 	struct mutex		mutex;		/* protect dev setup+cleanup */
+	atomic_t		lnk_cnt_by_port[SMC_MAX_PORTS];
+						/* number of links per port */
 };
 
 struct smc_buf_desc;
-- 
2.17.1
