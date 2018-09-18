Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/5] net/smc: remove duplicate mutex_unlock
Date: Tue, 18 Sep 2018 15:46:35 +0200
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
Message-Id: <20180918134638.90271-3-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For a failing smc_listen_rdma_finish() smc_listen_decline() is
called. If fallback is possible, the new socket is already enqueued
to be accepted in smc_listen_decline(). Avoid enqueuing a second time
afterwards in this case, otherwise the smc_create_lgr_pending lock
is released twice:
[  373.463976] WARNING: bad unlock balance detected!
[  373.463978] 4.18.0-rc7+ #123 Tainted: G           O
[  373.463979] -------------------------------------
[  373.463980] kworker/1:1/30 is trying to release lock (smc_create_lgr_pending) at:
[  373.463990] [<000003ff801205fc>] smc_listen_work+0x22c/0x5d0 [smc]
[  373.463991] but there are no more locks to release!
[  373.463991]
other info that might help us debug this:
[  373.463993] 2 locks held by kworker/1:1/30:
[  373.463994]  #0: 00000000772cbaed ((wq_completion)"events"){+.+.}, at: process_one_work+0x1ec/0x6b0
[  373.464000]  #1: 000000003ad0894a ((work_completion)(&new_smc->smc_listen_work)){+.+.}, at: process_one_work+0x1ec/0x6b0
[  373.464003]
stack backtrace:
[  373.464005] CPU: 1 PID: 30 Comm: kworker/1:1 Kdump: loaded Tainted: G           O      4.18.0-rc7uschi+ #123
[  373.464007] Hardware name: IBM 2827 H43 738 (LPAR)
[  373.464010] Workqueue: events smc_listen_work [smc]
[  373.464011] Call Trace:
[  373.464015] ([<0000000000114100>] show_stack+0x60/0xd8)
[  373.464019]  [<0000000000a8c9bc>] dump_stack+0x9c/0xd8
[  373.464021]  [<00000000001dcaf8>] print_unlock_imbalance_bug+0xf8/0x108
[  373.464022]  [<00000000001e045c>] lock_release+0x114/0x4f8
[  373.464025]  [<0000000000aa87fa>] __mutex_unlock_slowpath+0x4a/0x300
[  373.464027]  [<000003ff801205fc>] smc_listen_work+0x22c/0x5d0 [smc]
[  373.464029]  [<0000000000197a68>] process_one_work+0x2a8/0x6b0
[  373.464030]  [<0000000000197ec2>] worker_thread+0x52/0x410
[  373.464033]  [<000000000019fd0e>] kthread+0x15e/0x178
[  373.464035]  [<0000000000aaf58a>] kernel_thread_starter+0x6/0xc
[  373.464052]  [<0000000000aaf584>] kernel_thread_starter+0x0/0xc
[  373.464054] INFO: lockdep is turned off.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9c3976bcde46..5c6d30eb4a71 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1153,9 +1153,9 @@ static int smc_listen_rdma_reg(struct smc_sock *new_smc, int local_contact)
 }
 
 /* listen worker: finish RDMA setup */
-static void smc_listen_rdma_finish(struct smc_sock *new_smc,
-				   struct smc_clc_msg_accept_confirm *cclc,
-				   int local_contact)
+static int smc_listen_rdma_finish(struct smc_sock *new_smc,
+				  struct smc_clc_msg_accept_confirm *cclc,
+				  int local_contact)
 {
 	struct smc_link *link = &new_smc->conn.lgr->lnk[SMC_SINGLE_LINK];
 	int reason_code = 0;
@@ -1178,11 +1178,12 @@ static void smc_listen_rdma_finish(struct smc_sock *new_smc,
 		if (reason_code)
 			goto decline;
 	}
-	return;
+	return 0;
 
 decline:
 	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_decline(new_smc, reason_code, local_contact);
+	return reason_code;
 }
 
 /* setup for RDMA connection of server */
@@ -1279,8 +1280,10 @@ static void smc_listen_work(struct work_struct *work)
 	}
 
 	/* finish worker */
-	if (!ism_supported)
-		smc_listen_rdma_finish(new_smc, &cclc, local_contact);
+	if (!ism_supported) {
+		if (smc_listen_rdma_finish(new_smc, &cclc, local_contact))
+			return;
+	}
 	smc_conn_save_peer_info(new_smc, &cclc);
 	mutex_unlock(&smc_create_lgr_pending);
 	smc_listen_out_connected(new_smc);
-- 
2.16.4
