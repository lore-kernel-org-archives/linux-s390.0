Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgHQIwD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 04:52:03 -0400
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 4/8] net: mac802154: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:21:16 +0530
Message-Id: <20200817085120.24894-4-allen.cryptic@gmail.com>
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
 net/mac802154/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 06ea0f8bfd5c..520cedc594e1 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -20,9 +20,9 @@
 #include "ieee802154_i.h"
 #include "cfg.h"
 
-static void ieee802154_tasklet_handler(unsigned long data)
+static void ieee802154_tasklet_handler(struct tasklet_struct *t)
 {
-	struct ieee802154_local *local = (struct ieee802154_local *)data;
+	struct ieee802154_local *local = from_tasklet(local, t, tasklet);
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&local->skb_queue))) {
@@ -91,9 +91,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_LIST_HEAD(&local->interfaces);
 	mutex_init(&local->iflist_mtx);
 
-	tasklet_init(&local->tasklet,
-		     ieee802154_tasklet_handler,
-		     (unsigned long)local);
+	tasklet_setup(&local->tasklet, ieee802154_tasklet_handler);
 
 	skb_queue_head_init(&local->skb_queue);
 
-- 
2.17.1
