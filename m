Return-Path: <SRS0=wH8C=SN=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/5] net/smc: fix a NULL pointer dereference
Date: Thu, 11 Apr 2019 11:17:31 +0200
In-Reply-To: <20190411091734.4263-1-ubraun@linux.ibm.com>
References: <20190411091734.4263-1-ubraun@linux.ibm.com>
Message-Id: <20190411091734.4263-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Kangjie Lu <kjlu@umn.edu>

In case alloc_ordered_workqueue fails, the fix returns NULL
to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
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
2.16.4
