Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 8/9] net/smc: use device link provided in qp_context
Date: Wed, 30 Jan 2019 18:51:07 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-9-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The device field of the IB event structure does not always point to the
SMC IB device. Load the pointer from the qp_context which is always
provided to smc_ib_qp_event_handler() in the priv field. And for qp
events the affected port is given in the qp structure of the ibevent,
derive it from there.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_ib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index e519ef29c0ff..76487a16934e 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -289,8 +289,8 @@ int smc_ib_create_protection_domain(struct smc_link *lnk)
 
 static void smc_ib_qp_event_handler(struct ib_event *ibevent, void *priv)
 {
-	struct smc_ib_device *smcibdev =
-		(struct smc_ib_device *)ibevent->device;
+	struct smc_link *lnk = (struct smc_link *)priv;
+	struct smc_ib_device *smcibdev = lnk->smcibdev;
 	u8 port_idx;
 
 	switch (ibevent->event) {
@@ -298,7 +298,7 @@ static void smc_ib_qp_event_handler(struct ib_event *ibevent, void *priv)
 	case IB_EVENT_GID_CHANGE:
 	case IB_EVENT_PORT_ERR:
 	case IB_EVENT_QP_ACCESS_ERR:
-		port_idx = ibevent->element.port_num - 1;
+		port_idx = ibevent->element.qp->port - 1;
 		set_bit(port_idx, &smcibdev->port_event_mask);
 		schedule_work(&smcibdev->port_event_work);
 		break;
-- 
2.16.4
