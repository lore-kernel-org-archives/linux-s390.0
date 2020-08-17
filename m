Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHQIwS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 04:52:18 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 6/8] net: sched: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:21:18 +0530
Message-Id: <20200817085120.24894-6-allen.cryptic@gmail.com>
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
 net/sched/sch_atm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
index 1c281cc81f57..0a4452178d5d 100644
--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -466,10 +466,11 @@ drop: __maybe_unused
  * non-ATM interfaces.
  */
 
-static void sch_atm_dequeue(unsigned long data)
+static void sch_atm_dequeue(struct tasklet_struct *t)
 {
-	struct Qdisc *sch = (struct Qdisc *)data;
-	struct atm_qdisc_data *p = qdisc_priv(sch);
+	struct atm_qdisc_data *p = from_tasklet(p, t, task);
+	struct Qdisc *sch = (struct Qdisc *)((char *) p -
+					     QDISC_ALIGN(sizeof(struct Qdisc)));
 	struct atm_flow_data *flow;
 	struct sk_buff *skb;
 
@@ -563,7 +564,7 @@ static int atm_tc_init(struct Qdisc *sch, struct nlattr *opt,
 	if (err)
 		return err;
 
-	tasklet_init(&p->task, sch_atm_dequeue, (unsigned long)sch);
+	tasklet_setup(&p->task, sch_atm_dequeue);
 	return 0;
 }
 
-- 
2.17.1
