Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net v2 01/10] net/smc: handle unexpected response types for confirm link
Date: Sat, 18 Jul 2020 15:06:09 +0200
Message-Id: <20200718130618.16724-2-kgraul@linux.ibm.com>
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

A delete link could arrive during confirm link processing. Handle this
situation directly in smc_llc_srv_conf_link() rather than using the
logic in smc_llc_wait() to avoid the unexpected message handling there.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 1551c95b6124 ("net/smc: final part of add link processing as SMC server")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index c1a038689c63..58f4da2e0cc7 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1051,12 +1051,14 @@ static int smc_llc_srv_conf_link(struct smc_link *link,
 	if (rc)
 		return -ENOLINK;
 	/* receive CONFIRM LINK response over the RoCE fabric */
-	qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_FIRST_TIME,
-			      SMC_LLC_CONFIRM_LINK);
-	if (!qentry) {
+	qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_FIRST_TIME, 0);
+	if (!qentry ||
+	    qentry->msg.raw.hdr.common.type != SMC_LLC_CONFIRM_LINK) {
 		/* send DELETE LINK */
 		smc_llc_send_delete_link(link, link_new->link_id, SMC_LLC_REQ,
 					 false, SMC_LLC_DEL_LOST_PATH);
+		if (qentry)
+			smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 		return -ENOLINK;
 	}
 	smc_llc_save_peer_uid(qentry);
-- 
2.17.1
