Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net v2 02/10] net/smc: clear link during SMC client link down processing
Date: Sat, 18 Jul 2020 15:06:10 +0200
Message-Id: <20200718130618.16724-3-kgraul@linux.ibm.com>
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

In a link-down condition we notify the SMC server and expect that the
server will finally trigger the link clear processing on the client
side. This could fail when anything along this notification path goes
wrong. Clear the link as part of SMC client link-down processing to
prevent dangling links.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f69d205b3e11..e286b3c8c962 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1204,10 +1204,12 @@ static void smcr_link_down(struct smc_link *lnk)
 				SMC_LLC_WAIT_TIME);
 			mutex_lock(&lgr->llc_conf_mutex);
 		}
-		if (!list_empty(&lgr->list))
+		if (!list_empty(&lgr->list)) {
 			smc_llc_send_delete_link(to_lnk, del_link_id,
 						 SMC_LLC_REQ, true,
 						 SMC_LLC_DEL_LOST_PATH);
+			smcr_link_clear(lnk, true);
+		}
 		wake_up(&lgr->llc_flow_waiter);	/* wake up next waiter */
 	}
 }
-- 
2.17.1
