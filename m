Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] net: smc: fix a NULL pointer dereference
Date: Thu, 14 Mar 2019 23:15:55 -0500
Message-Id: <20190315041555.1801-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In case alloc_ordered_workqueue fails, the fix returns NULL
to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/smc/smc_ism.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 2fff79db1a59..e89e918b88e0 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -289,6 +289,11 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	INIT_LIST_HEAD(&smcd->vlan);
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
+	if (!smcd->event_wq) {
+		kfree(smcd->conn);
+		kfree(smcd);
+		return NULL;
+	}
 	return smcd;
 }
 EXPORT_SYMBOL_GPL(smcd_alloc_dev);
-- 
2.17.1
