Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 04/10] net/smc: protect smc ib device initialization
Date: Thu, 16 Jul 2020 17:37:40 +0200
Message-Id: <20200716153746.77303-5-kgraul@linux.ibm.com>
In-Reply-To: <20200716153746.77303-1-kgraul@linux.ibm.com>
References: <20200716153746.77303-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Before an smc ib device is used the first time for an smc link it is
lazily initialized. When there are 2 active link groups and a new ib
device is brought online then it might happen that 2 link creations run
in parallel and enter smc_ib_setup_per_ibdev(). Both allocate new send
and receive completion queues on the device, but only one set of them
keeps assigned and the other leaks.
Fix that by protecting the critical code using a mutex.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: f3c1deddb21c ("net/smc: separate function for link initialization")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c | 16 +++++++++++++---
 net/smc/smc_ib.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 7637fdebbb78..1c314dbdc7fa 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -506,6 +506,10 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 	int cqe_size_order, smc_order;
 	long rc;
 
+	mutex_lock(&smcibdev->mutex);
+	rc = 0;
+	if (smcibdev->initialized)
+		goto out;
 	/* the calculated number of cq entries fits to mlx5 cq allocation */
 	cqe_size_order = cache_line_size() == 128 ? 7 : 6;
 	smc_order = MAX_ORDER - cqe_size_order - 1;
@@ -517,7 +521,7 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 	rc = PTR_ERR_OR_ZERO(smcibdev->roce_cq_send);
 	if (IS_ERR(smcibdev->roce_cq_send)) {
 		smcibdev->roce_cq_send = NULL;
-		return rc;
+		goto out;
 	}
 	smcibdev->roce_cq_recv = ib_create_cq(smcibdev->ibdev,
 					      smc_wr_rx_cq_handler, NULL,
@@ -529,21 +533,26 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 	}
 	smc_wr_add_dev(smcibdev);
 	smcibdev->initialized = 1;
-	return rc;
+	goto out;
 
 err:
 	ib_destroy_cq(smcibdev->roce_cq_send);
+out:
+	mutex_unlock(&smcibdev->mutex);
 	return rc;
 }
 
 static void smc_ib_cleanup_per_ibdev(struct smc_ib_device *smcibdev)
 {
+	mutex_lock(&smcibdev->mutex);
 	if (!smcibdev->initialized)
-		return;
+		goto out;
 	smcibdev->initialized = 0;
 	ib_destroy_cq(smcibdev->roce_cq_recv);
 	ib_destroy_cq(smcibdev->roce_cq_send);
 	smc_wr_remove_dev(smcibdev);
+out:
+	mutex_unlock(&smcibdev->mutex);
 }
 
 static struct ib_client smc_ib_client;
@@ -566,6 +575,7 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 	INIT_WORK(&smcibdev->port_event_work, smc_ib_port_event_work);
 	atomic_set(&smcibdev->lnk_cnt, 0);
 	init_waitqueue_head(&smcibdev->lnks_deleted);
+	mutex_init(&smcibdev->mutex);
 	mutex_lock(&smc_ib_devices.mutex);
 	list_add_tail(&smcibdev->list, &smc_ib_devices.list);
 	mutex_unlock(&smc_ib_devices.mutex);
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index ae6776e1e726..afbb76622f03 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -52,6 +52,7 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	DECLARE_BITMAP(ports_going_away, SMC_MAX_PORTS);
 	atomic_t		lnk_cnt;	/* number of links on ibdev */
 	wait_queue_head_t	lnks_deleted;	/* wait 4 removal of all links*/
+	struct mutex		mutex;		/* protects smc ib device */
 };
 
 struct smc_buf_desc;
-- 
2.17.1
