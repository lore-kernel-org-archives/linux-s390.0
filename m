Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728619AbgEAKsc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:32 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 06/13] net/smc: remember PNETID of IB device for later device matching
Date: Fri,  1 May 2020 12:48:06 +0200
Message-Id: <20200501104813.76601-7-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The PNETID is needed to find an alternate link for a link group.
Save the PNETID of the link that is used to create the link group for
later device matching.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 2 ++
 net/smc/smc_core.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4c3af05d76a5..d7ab92fc5b15 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -413,6 +413,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
 		       SMC_SYSTEMID_LEN);
+		memcpy(lgr->pnet_id, ini->ib_dev->pnetid[ini->ib_port - 1],
+		       SMC_MAX_PNETID_LEN);
 		smc_llc_lgr_init(lgr, smc);
 
 		link_idx = SMC_SINGLE_LINK;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index aa198dd0f0e4..413eaad50c7f 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -244,6 +244,8 @@ struct smc_link_group {
 			u8			next_link_id;
 			enum smc_lgr_type	type;
 						/* redundancy state */
+			u8			pnet_id[SMC_MAX_PNETID_LEN + 1];
+						/* pnet id of this lgr */
 			struct list_head	llc_event_q;
 						/* queue for llc events */
 			spinlock_t		llc_event_q_lock;
-- 
2.17.1
