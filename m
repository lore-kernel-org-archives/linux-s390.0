Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgHQIw0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 04:52:26 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 7/8] net: smc: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:21:19 +0530
Message-Id: <20200817085120.24894-7-allen.cryptic@gmail.com>
In-Reply-To: <20200817085120.24894-1-allen.cryptic@gmail.com>
References: <20200817085120.24894-1-allen.cryptic@gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: gerrit@erg.abdn.ac.uk, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, johannes@sipsolutions.net, alex.aring@gmail.com, stefan@datenfreihafen.org, santosh.shilimkar@oracle.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: keescook@chromium.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>, Romain Perier <romain.perier@gmail.com>

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 net/smc/smc_cdc.c |  6 +++---
 net/smc/smc_wr.c  | 14 ++++++--------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index ce468ff62a19..5db2166197d3 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -389,9 +389,9 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
  * Context:
  * - tasklet context
  */
-static void smcd_cdc_rx_tsklet(unsigned long data)
+static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
 {
-	struct smc_connection *conn = (struct smc_connection *)data;
+	struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
 	struct smcd_cdc_msg *data_cdc;
 	struct smcd_cdc_msg cdc;
 	struct smc_sock *smc;
@@ -411,7 +411,7 @@ static void smcd_cdc_rx_tsklet(unsigned long data)
  */
 void smcd_cdc_rx_init(struct smc_connection *conn)
 {
-	tasklet_init(&conn->rx_tsklet, smcd_cdc_rx_tsklet, (unsigned long)conn);
+	tasklet_setup(&conn->rx_tsklet, smcd_cdc_rx_tsklet);
 }
 
 /***************************** init, exit, misc ******************************/
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 1e23cdd41eb1..cbc73a7e4d59 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -131,9 +131,9 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 	wake_up(&link->wr_tx_wait);
 }
 
-static void smc_wr_tx_tasklet_fn(unsigned long data)
+static void smc_wr_tx_tasklet_fn(struct tasklet_struct *t)
 {
-	struct smc_ib_device *dev = (struct smc_ib_device *)data;
+	struct smc_ib_device *dev = from_tasklet(dev, t, send_tasklet);
 	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
 	int i = 0, rc;
 	int polled = 0;
@@ -435,9 +435,9 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
 	}
 }
 
-static void smc_wr_rx_tasklet_fn(unsigned long data)
+static void smc_wr_rx_tasklet_fn(struct tasklet_struct *t)
 {
-	struct smc_ib_device *dev = (struct smc_ib_device *)data;
+	struct smc_ib_device *dev = from_tasklet(dev, t, recv_tasklet);
 	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
 	int polled = 0;
 	int rc;
@@ -698,10 +698,8 @@ void smc_wr_remove_dev(struct smc_ib_device *smcibdev)
 
 void smc_wr_add_dev(struct smc_ib_device *smcibdev)
 {
-	tasklet_init(&smcibdev->recv_tasklet, smc_wr_rx_tasklet_fn,
-		     (unsigned long)smcibdev);
-	tasklet_init(&smcibdev->send_tasklet, smc_wr_tx_tasklet_fn,
-		     (unsigned long)smcibdev);
+	tasklet_setup(&smcibdev->recv_tasklet, smc_wr_rx_tasklet_fn);
+	tasklet_setup(&smcibdev->send_tasklet, smc_wr_tx_tasklet_fn);
 }
 
 int smc_wr_create_link(struct smc_link *lnk)
-- 
2.17.1
