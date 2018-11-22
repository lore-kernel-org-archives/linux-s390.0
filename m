From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 08/10] net/smc: avoid a delay by waiting for nothing
Date: Thu, 22 Nov 2018 10:26:41 +0100
Message-ID: <20181122092643.26820-9-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When a send failed then don't start to wait for a response in
smc_llc_do_confirm_rkey.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 9c916c709ca7..132c6a8e49f8 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -651,7 +651,9 @@ int smc_llc_do_confirm_rkey(struct smc_link *link,
 	int rc;
 
 	reinit_completion(&link->llc_confirm_rkey);
-	smc_llc_send_confirm_rkey(link, rmb_desc);
+	rc = smc_llc_send_confirm_rkey(link, rmb_desc);
+	if (rc)
+		return rc;
 	/* receive CONFIRM RKEY response from server over RoCE fabric */
 	rc = wait_for_completion_interruptible_timeout(&link->llc_confirm_rkey,
 						       SMC_LLC_WAIT_TIME);
-- 
2.16.4
