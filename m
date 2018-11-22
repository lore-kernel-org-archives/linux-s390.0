From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 02/10] net/smc: make smc_lgr_free() static
Date: Thu, 22 Nov 2018 10:26:35 +0100
Message-ID: <20181122092643.26820-3-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

smc_lgr_free() is just called inside smc_core.c. Make it static.
Just cleanup, no functional change.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 4 +++-
 net/smc/smc_core.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 18daebcef181..4812ca30f1dc 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -149,6 +149,8 @@ static int smc_link_send_delete(struct smc_link *lnk)
 	return -ENOTCONN;
 }
 
+static void smc_lgr_free(struct smc_link_group *lgr);
+
 static void smc_lgr_free_work(struct work_struct *work)
 {
 	struct smc_link_group *lgr = container_of(to_delayed_work(work),
@@ -408,7 +410,7 @@ static void smc_lgr_free_bufs(struct smc_link_group *lgr)
 }
 
 /* remove a link group */
-void smc_lgr_free(struct smc_link_group *lgr)
+static void smc_lgr_free(struct smc_link_group *lgr)
 {
 	smc_lgr_free_bufs(lgr);
 	if (lgr->is_smcd)
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index c156674733c9..07364c0b41a1 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -243,7 +243,6 @@ struct smc_sock;
 struct smc_clc_msg_accept_confirm;
 struct smc_clc_msg_local;
 
-void smc_lgr_free(struct smc_link_group *lgr);
 void smc_lgr_forget(struct smc_link_group *lgr);
 void smc_lgr_terminate(struct smc_link_group *lgr);
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport);
-- 
2.16.4
