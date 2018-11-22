From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 05/10] net/smc: no link delete for a never active link
Date: Thu, 22 Nov 2018 10:26:38 +0100
Message-ID: <20181122092643.26820-6-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If a link is terminated that has never reached the active state,
there is no need to trigger an LLC DELETE LINK.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4812ca30f1dc..ec7a7ed3b968 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -173,8 +173,11 @@ static void smc_lgr_free_work(struct work_struct *work)
 	spin_unlock_bh(&smc_lgr_list.lock);
 
 	if (!lgr->is_smcd && !lgr->terminating)	{
+		struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
+
 		/* try to send del link msg, on error free lgr immediately */
-		if (!smc_link_send_delete(&lgr->lnk[SMC_SINGLE_LINK])) {
+		if (lnk->state == SMC_LNK_ACTIVE &&
+		    !smc_link_send_delete(lnk)) {
 			/* reschedule in case we never receive a response */
 			smc_lgr_schedule_free_work(lgr);
 			return;
-- 
2.16.4
