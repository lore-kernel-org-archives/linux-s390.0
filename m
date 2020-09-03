Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/4] net/smc: fix toleration of fake add_link messages
Date: Thu,  3 Sep 2020 21:53:15 +0200
Message-Id: <20200903195318.39288-2-kgraul@linux.ibm.com>
In-Reply-To: <20200903195318.39288-1-kgraul@linux.ibm.com>
References: <20200903195318.39288-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Older SMCR implementations had no link failover support and used one
link only. Because the handshake protocol requires to try the
establishment of a second link the old code sent a fake add_link message
and declined any server response afterwards.
The current code supports multiple links and inspects the received fake
add_link message more closely. To tolerate the fake add_link messages
smc_llc_is_local_add_link() needs an improved check of the message to
be able to separate between locally enqueued and fake add_link messages.
And smc_llc_cli_add_link() needs to check if the provided qp_mtu size is
invalid and reject the add_link request in that case.

Fixes: c48254fa48e5 ("net/smc: move add link processing for new device into llc layer")
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index df5b0a6ea848..3ea33466ebe9 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -841,6 +841,9 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	struct smc_init_info ini;
 	int lnk_idx, rc = 0;
 
+	if (!llc->qp_mtu)
+		goto out_reject;
+
 	ini.vlan_id = lgr->vlan_id;
 	smc_pnet_find_alt_roce(lgr, &ini, link->smcibdev);
 	if (!memcmp(llc->sender_gid, link->peer_gid, SMC_GID_SIZE) &&
@@ -917,10 +920,20 @@ static void smc_llc_cli_add_link_invite(struct smc_link *link,
 	kfree(qentry);
 }
 
+static bool smc_llc_is_empty_llc_message(union smc_llc_msg *llc)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(llc->raw.data); i++)
+		if (llc->raw.data[i])
+			return false;
+	return true;
+}
+
 static bool smc_llc_is_local_add_link(union smc_llc_msg *llc)
 {
 	if (llc->raw.hdr.common.type == SMC_LLC_ADD_LINK &&
-	    !llc->add_link.qp_mtu && !llc->add_link.link_num)
+	    smc_llc_is_empty_llc_message(llc))
 		return true;
 	return false;
 }
-- 
2.17.1
