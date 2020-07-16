Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729027AbgGPPiH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 11:38:07 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 03/10] net/smc: fix link lookup for new rdma connections
Date: Thu, 16 Jul 2020 17:37:39 +0200
Message-Id: <20200716153746.77303-4-kgraul@linux.ibm.com>
In-Reply-To: <20200716153746.77303-1-kgraul@linux.ibm.com>
References: <20200716153746.77303-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

For new rdma connections the SMC server assigns the link and sends the
link data in the clc accept message. To match the correct link use not
only the qp_num but also the gid and the mac of the links. If there are
equal qp_nums for different links the wrong link would be chosen.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 903321543838..f80591567a3d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -632,7 +632,9 @@ static int smc_connect_rdma(struct smc_sock *smc,
 		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 			struct smc_link *l = &smc->conn.lgr->lnk[i];
 
-			if (l->peer_qpn == ntoh24(aclc->qpn)) {
+			if (l->peer_qpn == ntoh24(aclc->qpn) &&
+			    !memcmp(l->peer_gid, &aclc->lcl.gid, SMC_GID_SIZE) &&
+			    !memcmp(l->peer_mac, &aclc->lcl.mac, sizeof(l->peer_mac))) {
 				link = l;
 				break;
 			}
-- 
2.17.1
