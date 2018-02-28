Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 2/3] net/smc: use link_id of server in confirm link reply
Date: Wed, 28 Feb 2018 12:44:08 +0100
In-Reply-To: <20180228114409.33645-1-ubraun@linux.vnet.ibm.com>
References: <20180228114409.33645-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180228114409.33645-3-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

The CONFIRM LINK reply message must contain the link_id sent
by the server. And set the link_id explicitly when
initializing the link.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_core.c | 1 +
 net/smc/smc_llc.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 053f0e66bec7..645dd226177b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -177,6 +177,7 @@ static int smc_lgr_create(struct smc_sock *smc, __be32 peer_in_addr,
 
 	lnk = &lgr->lnk[SMC_SINGLE_LINK];
 	/* initialize link */
+	lnk->link_id = SMC_SINGLE_LINK;
 	lnk->smcibdev = smcibdev;
 	lnk->ibport = ibport;
 	lnk->path_mtu = smcibdev->pattr[ibport - 1].active_mtu;
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 92fe4cc8c82c..b4aa4fcedb96 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -92,7 +92,7 @@ int smc_llc_send_confirm_link(struct smc_link *link, u8 mac[],
 	memcpy(confllc->sender_mac, mac, ETH_ALEN);
 	memcpy(confllc->sender_gid, gid, SMC_GID_SIZE);
 	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
-	/* confllc->link_num = SMC_SINGLE_LINK; already done by memset above */
+	confllc->link_num = link->link_id;
 	memcpy(confllc->link_uid, lgr->id, SMC_LGR_ID_SIZE);
 	confllc->max_links = SMC_LINKS_PER_LGR_MAX;
 	/* send llc message */
-- 
2.13.5
