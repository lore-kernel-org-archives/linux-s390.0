Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgHQIwL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 04:52:11 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 5/8] net: rds: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:21:17 +0530
Message-Id: <20200817085120.24894-5-allen.cryptic@gmail.com>
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
 net/rds/ib_cm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index c3319ff3ee11..2e8872d51fa8 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -314,9 +314,9 @@ static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
 	}
 }
 
-static void rds_ib_tasklet_fn_send(unsigned long data)
+static void rds_ib_tasklet_fn_send(struct tasklet_struct *t)
 {
-	struct rds_ib_connection *ic = (struct rds_ib_connection *)data;
+	struct rds_ib_connection *ic = from_tasklet(ic, t, i_send_tasklet);
 	struct rds_connection *conn = ic->conn;
 
 	rds_ib_stats_inc(s_ib_tasklet_call);
@@ -354,9 +354,9 @@ static void poll_rcq(struct rds_ib_connection *ic, struct ib_cq *cq,
 	}
 }
 
-static void rds_ib_tasklet_fn_recv(unsigned long data)
+static void rds_ib_tasklet_fn_recv(struct tasklet_struct *t)
 {
-	struct rds_ib_connection *ic = (struct rds_ib_connection *)data;
+	struct rds_ib_connection *ic = from_tasklet(ic, t, i_recv_tasklet);
 	struct rds_connection *conn = ic->conn;
 	struct rds_ib_device *rds_ibdev = ic->rds_ibdev;
 	struct rds_ib_ack_state state;
@@ -1218,10 +1218,8 @@ int rds_ib_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 	}
 
 	INIT_LIST_HEAD(&ic->ib_node);
-	tasklet_init(&ic->i_send_tasklet, rds_ib_tasklet_fn_send,
-		     (unsigned long)ic);
-	tasklet_init(&ic->i_recv_tasklet, rds_ib_tasklet_fn_recv,
-		     (unsigned long)ic);
+	tasklet_setup(&ic->i_send_tasklet, rds_ib_tasklet_fn_send);
+	tasklet_setup(&ic->i_recv_tasklet, rds_ib_tasklet_fn_recv);
 	mutex_init(&ic->i_recv_mutex);
 #ifndef KERNEL_HAS_ATOMIC64
 	spin_lock_init(&ic->i_ack_lock);
-- 
2.17.1
