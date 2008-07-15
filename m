Return-Path: <linux-kernel-owner+w=401wt.eu-S1755952AbYGOIKx@vger.kernel.org>
Date: Tue, 15 Jul 2008 17:10:25 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] iucv: fix memory leak in cpu hotplug error path.
Message-ID: <20080715081025.GB22068@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Ursula Braun <ubraun@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Fix memory leak in error path in CPU_UP_PREPARE notifier.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 net/iucv/iucv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: 2.6-mmotm/net/iucv/iucv.c
===================================================================
--- 2.6-mmotm.orig/net/iucv/iucv.c
+++ 2.6-mmotm/net/iucv/iucv.c
@@ -567,8 +567,11 @@ static int __cpuinit iucv_cpu_notify(str
 			return NOTIFY_BAD;
 		iucv_param[cpu] = kmalloc_node(sizeof(union iucv_param),
 				     GFP_KERNEL|GFP_DMA, cpu_to_node(cpu));
-		if (!iucv_param[cpu])
+		if (!iucv_param[cpu]) {
+			kfree(iucv_irq_data[cpu]);
+			iucv_irq_data[cpu] = NULL;
 			return NOTIFY_BAD;
+		}
 		break;
 	case CPU_UP_CANCELED:
 	case CPU_UP_CANCELED_FROZEN:
