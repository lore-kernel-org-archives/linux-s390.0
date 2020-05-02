Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 08/13] net/smc: activate SMC server add link functions
Date: Sat,  2 May 2020 14:35:47 +0200
Message-Id: <20200502123552.17204-9-kgraul@linux.ibm.com>
In-Reply-To: <20200502123552.17204-1-kgraul@linux.ibm.com>
References: <20200502123552.17204-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Activate smc_llc_srv_add_link() in af_smc.c to start second link
establishment after the initial link of a link group was created. And
activate it in smc_llc.c to process an incoming ADD_LINK request from
an SMC client.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  | 2 +-
 net/smc/smc_llc.c | 3 ++-
 net/smc/smc_llc.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1afb6e4275f2..c67272007f41 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1067,7 +1067,7 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
 	smc_llc_link_active(link);
 
 	/* initial contact - try to establish second link */
-	/* tbd: call smc_llc_srv_add_link(link); */
+	smc_llc_srv_add_link(link);
 	return 0;
 }
 
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index e6e280a3683d..9d102c912be9 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1112,7 +1112,8 @@ static void smc_llc_add_link_work(struct work_struct *work)
 
 	if (lgr->role == SMC_CLNT)
 		smc_llc_process_cli_add_link(lgr);
-	/* tbd: call smc_llc_process_srv_add_link(lgr); */
+	else
+		smc_llc_process_srv_add_link(lgr);
 out:
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 }
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 7c314bbef8c8..1a7748d0541f 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -89,6 +89,7 @@ struct smc_llc_qentry *smc_llc_wait(struct smc_link_group *lgr,
 struct smc_llc_qentry *smc_llc_flow_qentry_clr(struct smc_llc_flow *flow);
 void smc_llc_flow_qentry_del(struct smc_llc_flow *flow);
 int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry);
+int smc_llc_srv_add_link(struct smc_link *link);
 int smc_llc_init(void) __init;
 
 #endif /* SMC_LLC_H */
-- 
2.17.1
