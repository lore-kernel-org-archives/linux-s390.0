Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/7] net/smc: no delay for free tx buffer wait
Date: Tue, 12 Feb 2019 16:29:52 +0100
In-Reply-To: <20190212152956.71041-1-ubraun@linux.ibm.com>
References: <20190212152956.71041-1-ubraun@linux.ibm.com>
Message-Id: <20190212152956.71041-4-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When no free transfer buffers are available then a work to call
smc_tx_work() is scheduled. Set the schedule delay to zero, because for
the out-of-buffers condition the work can start immediately and will
block in the called function smc_wr_tx_get_free_slot(), waiting for free
buffers.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index dd10a913b38e..a3bff08ff8c8 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -28,7 +28,7 @@
 #include "smc_ism.h"
 #include "smc_tx.h"
 
-#define SMC_TX_WORK_DELAY	HZ
+#define SMC_TX_WORK_DELAY	0
 #define SMC_TX_CORK_DELAY	(HZ >> 2)	/* 250 ms */
 
 /***************************** sndbuf producer *******************************/
-- 
2.16.4
