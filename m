Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 3/9] net/smc: prevent races between smc_lgr_terminate() and smc_conn_free()
Date: Wed, 30 Jan 2019 18:51:02 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-4-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

To prevent races between smc_lgr_terminate() and smc_conn_free() add an
extra check of the lgr field before accessing it, and cancel a delayed
free_work when a new smc connection is created.
This fixes the problem that free_work cleared the lgr variable but
smc_lgr_terminate() or smc_conn_free() still access it in parallel.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 35c1cdc93e1c..097c798983ca 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -128,6 +128,8 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
 
+	if (!lgr)
+		return;
 	write_lock_bh(&lgr->conns_lock);
 	if (conn->alert_token_local) {
 		__smc_lgr_unregister_conn(conn);
@@ -628,6 +630,8 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 			local_contact = SMC_REUSE_CONTACT;
 			conn->lgr = lgr;
 			smc_lgr_register_conn(conn); /* add smc conn to lgr */
+			if (delayed_work_pending(&lgr->free_work))
+				cancel_delayed_work(&lgr->free_work);
 			write_unlock_bh(&lgr->conns_lock);
 			break;
 		}
-- 
2.16.4
