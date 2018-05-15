From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 03/10] net/smc: remove unnecessary cast
Date: Tue, 15 May 2018 17:04:56 +0200
Message-ID: <20180515150503.47265-4-ubraun@linux.ibm.com>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Remove an unneeded (void *) cast from the calls to
smc_llc_send_message(). No functional changes.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index b118f80b9c41..29f59b47b559 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -451,7 +451,7 @@ static void smc_llc_rx_confirm_rkey(struct smc_link *link,
 		llc->hd.flags |= SMC_LLC_FLAG_RESP;
 		if (rc < 0)
 			llc->hd.flags |= SMC_LLC_FLAG_RKEY_NEG;
-		smc_llc_send_message(link, (void *)llc, sizeof(*llc));
+		smc_llc_send_message(link, llc, sizeof(*llc));
 	}
 }
 
@@ -463,7 +463,7 @@ static void smc_llc_rx_confirm_rkey_cont(struct smc_link *link,
 	} else {
 		/* ignore rtokens for other links, we have only one link */
 		llc->hd.flags |= SMC_LLC_FLAG_RESP;
-		smc_llc_send_message(link, (void *)llc, sizeof(*llc));
+		smc_llc_send_message(link, llc, sizeof(*llc));
 	}
 }
 
@@ -491,7 +491,7 @@ static void smc_llc_rx_delete_rkey(struct smc_link *link,
 		}
 
 		llc->hd.flags |= SMC_LLC_FLAG_RESP;
-		smc_llc_send_message(link, (void *)llc, sizeof(*llc));
+		smc_llc_send_message(link, llc, sizeof(*llc));
 	}
 }
 
-- 
2.16.3
