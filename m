Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387893AbgJBPJl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 11:09:41 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 1/2] net/smc: send ISM devices with unique chid in CLC proposal
Date: Fri,  2 Oct 2020 17:09:26 +0200
Message-Id: <20201002150927.72261-2-kgraul@linux.ibm.com>
In-Reply-To: <20201002150927.72261-1-kgraul@linux.ibm.com>
References: <20201002150927.72261-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When building a CLC proposal message then the list of ISM devices does
not need to contain multiple devices that have the same chid value,
all these devices use the same function at the end.
Improve smc_find_ism_v2_device_clnt() to collect only ISM devices that
have unique chid values.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e874d0e6267f..670e802a73cb 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -599,6 +599,18 @@ static int smc_find_ism_device(struct smc_sock *smc, struct smc_init_info *ini)
 	return 0;
 }
 
+/* is chid unique for the ism devices that are already determined? */
+static bool smc_find_ism_v2_is_unique_chid(u16 chid, struct smc_init_info *ini,
+					   int cnt)
+{
+	int i = (!ini->ism_dev[0]) ? 1 : 0;
+
+	for (; i < cnt; i++)
+		if (ini->ism_chid[i] == chid)
+			return false;
+	return true;
+}
+
 /* determine possible V2 ISM devices (either without PNETID or with PNETID plus
  * PNETID matching net_device)
  */
@@ -608,6 +620,7 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 	int rc = SMC_CLC_DECL_NOSMCDDEV;
 	struct smcd_dev *smcd;
 	int i = 1;
+	u16 chid;
 
 	if (smcd_indicated(ini->smc_type_v1))
 		rc = 0;		/* already initialized for V1 */
@@ -615,10 +628,13 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 	list_for_each_entry(smcd, &smcd_dev_list.list, list) {
 		if (smcd->going_away || smcd == ini->ism_dev[0])
 			continue;
+		chid = smc_ism_get_chid(smcd);
+		if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
+			continue;
 		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
 		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
 			ini->ism_dev[i] = smcd;
-			ini->ism_chid[i] = smc_ism_get_chid(ini->ism_dev[i]);
+			ini->ism_chid[i] = chid;
 			ini->is_smcd = true;
 			rc = 0;
 			i++;
-- 
2.17.1
