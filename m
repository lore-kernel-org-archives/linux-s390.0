Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgKRVmI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 16:42:08 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/2] net/smc: fix matching of existing link groups
Date: Wed, 18 Nov 2020 22:40:37 +0100
Message-Id: <20201118214038.24039-2-kgraul@linux.ibm.com>
In-Reply-To: <20201118214038.24039-1-kgraul@linux.ibm.com>
References: <20201118214038.24039-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

With the multi-subnet support of SMC-Dv2 the match for existing link
groups should not include the vlanid of the network device.
Set ini->smcd_version accordingly before the call to smc_conn_create()
and use this value in smc_conn_create() to skip the vlanid check.

Fixes: 5c21c4ccafe8 ("net/smc: determine accepted ISM devices")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c   | 3 ++-
 net/smc/smc_core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e9f487c8c6d5..5dd4faaf7d6e 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -979,7 +979,8 @@ static int __smc_connect(struct smc_sock *smc)
 
 	/* check if smc modes and versions of CLC proposal and accept match */
 	rc = smc_connect_check_aclc(ini, aclc);
-	version = aclc->hdr.version == SMC_V1 ? SMC_V1 : version;
+	version = aclc->hdr.version == SMC_V1 ? SMC_V1 : SMC_V2;
+	ini->smcd_version = version;
 	if (rc)
 		goto vlan_cleanup;
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2b19863f7171..af96f813c075 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1309,7 +1309,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 				    ini->ism_peer_gid[ini->ism_selected]) :
 		     smcr_lgr_match(lgr, ini->ib_lcl, role, ini->ib_clcqpn)) &&
 		    !lgr->sync_err &&
-		    lgr->vlan_id == ini->vlan_id &&
+		    (ini->smcd_version == SMC_V2 ||
+		     lgr->vlan_id == ini->vlan_id) &&
 		    (role == SMC_CLNT || ini->is_smcd ||
 		     lgr->conns_num < SMC_RMBS_PER_LGR_MAX)) {
 			/* link group found */
-- 
2.17.1
