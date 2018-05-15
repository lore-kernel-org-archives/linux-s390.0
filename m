From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 10/10] net/smc: check for pending termination
Date: Tue, 15 May 2018 17:05:03 +0200
Message-ID: <20180515150503.47265-11-ubraun@linux.ibm.com>
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

Avoid to run the processing in smc_lgr_terminate() more than once,
remember when the link group termination is triggered.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c  | 2 +-
 net/smc/smc_core.c | 5 ++++-
 net/smc/smc_core.h | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 3a988c22f627..236cb3f12c71 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -316,7 +316,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	if (clcm->type == SMC_CLC_DECLINE) {
 		reason_code = SMC_CLC_DECL_REPLY;
 		if (((struct smc_clc_msg_decline *)buf)->hdr.flag) {
-			smc->conn.lgr->sync_err = true;
+			smc->conn.lgr->sync_err = 1;
 			smc_lgr_terminate(smc->conn.lgr);
 		}
 	}
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a48ee00b65ff..08c05cd0bbae 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -172,7 +172,7 @@ static int smc_lgr_create(struct smc_sock *smc,
 		goto out;
 	}
 	lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
-	lgr->sync_err = false;
+	lgr->sync_err = 0;
 	memcpy(lgr->peer_systemid, peer_systemid, SMC_SYSTEMID_LEN);
 	lgr->vlan_id = vlan_id;
 	rwlock_init(&lgr->sndbufs_lock);
@@ -352,6 +352,9 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 	struct smc_sock *smc;
 	struct rb_node *node;
 
+	if (lgr->terminating)
+		return;	/* lgr already terminating */
+	lgr->terminating = 1;
 	smc_lgr_forget(lgr);
 	smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d1753850684b..845dc073de13 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -166,7 +166,8 @@ struct smc_link_group {
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
-	bool			sync_err;	/* lgr no longer fits to peer */
+	u8			sync_err : 1;	/* lgr no longer fits to peer */
+	u8			terminating : 1;/* lgr is terminating */
 };
 
 /* Find the connection associated with the given alert token in the link group.
-- 
2.16.3
