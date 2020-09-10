Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 05/10] net/smc: improve server ISM device determination
Date: Thu, 10 Sep 2020 18:48:24 +0200
Message-Id: <20200910164829.65426-6-kgraul@linux.ibm.com>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Move check whether peer can be reached into smc_pnet_find_ism_by_pnetid().
Thus searching continues for another ism device, if check fails.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c   | 17 +++--------------
 net/smc/smc_clc.h  |  1 -
 net/smc/smc_pnet.c |  5 ++++-
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index fa97144690e0..f27a596b2624 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1188,26 +1188,12 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
 			       struct smc_clc_msg_proposal *pclc,
 			       struct smc_init_info *ini)
 {
-	struct smc_clc_msg_smcd *pclc_smcd;
 	int rc;
 
-	pclc_smcd = smc_get_clc_msg_smcd(pclc);
-	ini->ism_peer_gid = pclc_smcd->gid;
 	rc = smc_conn_create(new_smc, ini);
 	if (rc)
 		return rc;
 
-	/* Check if peer can be reached via ISM device */
-	if (smc_ism_cantalk(new_smc->conn.lgr->peer_gid,
-			    new_smc->conn.lgr->vlan_id,
-			    new_smc->conn.lgr->smcd)) {
-		if (ini->first_contact_local)
-			smc_lgr_cleanup_early(&new_smc->conn);
-		else
-			smc_conn_free(&new_smc->conn);
-		return SMC_CLC_DECL_SMCDNOTALK;
-	}
-
 	/* Create send and receive buffers */
 	rc = smc_buf_create(new_smc, true);
 	if (rc) {
@@ -1338,7 +1324,10 @@ static void smc_listen_work(struct work_struct *work)
 
 	/* check if ISM is available */
 	if (pclc->hdr.path == SMC_TYPE_D || pclc->hdr.path == SMC_TYPE_B) {
+		struct smc_clc_msg_smcd *pclc_smcd = smc_get_clc_msg_smcd(pclc);
+
 		ini.is_smcd = true; /* prepare ISM check */
+		ini.ism_peer_gid = pclc_smcd->gid;
 		rc = smc_find_ism_device(new_smc, &ini);
 		if (!rc)
 			rc = smc_listen_ism_init(new_smc, pclc, &ini);
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index fda474e91f95..fcd8521c7737 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -37,7 +37,6 @@
 #define SMC_CLC_DECL_NOSMCDEV	0x03030000  /* no SMC device found (R or D)   */
 #define SMC_CLC_DECL_NOSMCDDEV	0x03030001  /* no SMC-D device found	      */
 #define SMC_CLC_DECL_NOSMCRDEV	0x03030002  /* no SMC-R device found	      */
-#define SMC_CLC_DECL_SMCDNOTALK	0x03030003  /* SMC-D dev can't talk to peer   */
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 30e5fac7034e..70684c49510e 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -928,7 +928,10 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
 		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid) &&
-		    !ismdev->going_away) {
+		    !ismdev->going_away &&
+		    (!ini->ism_peer_gid ||
+		     !smc_ism_cantalk(ini->ism_peer_gid, ini->vlan_id,
+				      ismdev))) {
 			ini->ism_dev = ismdev;
 			break;
 		}
-- 
2.17.1
