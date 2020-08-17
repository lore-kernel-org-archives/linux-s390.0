Return-Path: <netdev-owner@vger.kernel.org>
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 8/8] net: xfrm: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:21:20 +0530
Message-Id: <20200817085120.24894-8-allen.cryptic@gmail.com>
In-Reply-To: <20200817085120.24894-1-allen.cryptic@gmail.com>
References: <20200817085120.24894-1-allen.cryptic@gmail.com>
Sender: netdev-owner@vger.kernel.org
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
 net/xfrm/xfrm_input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 37456d022cfa..be6351e3f3cd 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -760,9 +760,9 @@ int xfrm_input_resume(struct sk_buff *skb, int nexthdr)
 }
 EXPORT_SYMBOL(xfrm_input_resume);
 
-static void xfrm_trans_reinject(unsigned long data)
+static void xfrm_trans_reinject(struct tasklet_struct *t)
 {
-	struct xfrm_trans_tasklet *trans = (void *)data;
+	struct xfrm_trans_tasklet *trans = from_tasklet(trans, t, tasklet);
 	struct sk_buff_head queue;
 	struct sk_buff *skb;
 
@@ -818,7 +818,6 @@ void __init xfrm_input_init(void)
 
 		trans = &per_cpu(xfrm_trans_tasklet, i);
 		__skb_queue_head_init(&trans->queue);
-		tasklet_init(&trans->tasklet, xfrm_trans_reinject,
-			     (unsigned long)trans);
+		tasklet_setup(&trans->tasklet, xfrm_trans_reinject);
 	}
 }
-- 
2.17.1
