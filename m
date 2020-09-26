Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbgIZKow (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 06:44:52 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 01/14] net/smc: remove constant and introduce helper to check for a pnet id
Date: Sat, 26 Sep 2020 12:44:19 +0200
Message-Id: <20200926104432.74293-2-kgraul@linux.ibm.com>
In-Reply-To: <20200926104432.74293-1-kgraul@linux.ibm.com>
References: <20200926104432.74293-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Use the existing symbol _S instead of SMC_ASCII_BLANK, and introduce a
helper to check if a pnetid is set. No functional change.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_pnet.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 70684c49510e..0af5b4acca30 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -29,8 +29,6 @@
 #include "smc_ism.h"
 #include "smc_core.h"
 
-#define SMC_ASCII_BLANK 32
-
 static struct net_device *pnet_find_base_ndev(struct net_device *ndev);
 
 static const struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
@@ -73,14 +71,22 @@ struct smc_pnetentry {
 	};
 };
 
+/* Check if the pnetid is set */
+static bool smc_pnet_is_pnetid_set(u8 *pnetid)
+{
+	if (pnetid[0] == 0 || pnetid[0] == _S)
+		return false;
+	return true;
+}
+
 /* Check if two given pnetids match */
 static bool smc_pnet_match(u8 *pnetid1, u8 *pnetid2)
 {
 	int i;
 
 	for (i = 0; i < SMC_MAX_PNETID_LEN; i++) {
-		if ((pnetid1[i] == 0 || pnetid1[i] == SMC_ASCII_BLANK) &&
-		    (pnetid2[i] == 0 || pnetid2[i] == SMC_ASCII_BLANK))
+		if ((pnetid1[i] == 0 || pnetid1[i] == _S) &&
+		    (pnetid2[i] == 0 || pnetid2[i] == _S))
 			break;
 		if (pnetid1[i] != pnetid2[i])
 			return false;
@@ -238,11 +244,10 @@ static int smc_pnet_remove_by_ndev(struct net_device *ndev)
 static bool smc_pnet_apply_ib(struct smc_ib_device *ib_dev, u8 ib_port,
 			      char *pnet_name)
 {
-	u8 pnet_null[SMC_MAX_PNETID_LEN] = {0};
 	bool applied = false;
 
 	mutex_lock(&smc_ib_devices.mutex);
-	if (smc_pnet_match(ib_dev->pnetid[ib_port - 1], pnet_null)) {
+	if (!smc_pnet_is_pnetid_set(ib_dev->pnetid[ib_port - 1])) {
 		memcpy(ib_dev->pnetid[ib_port - 1], pnet_name,
 		       SMC_MAX_PNETID_LEN);
 		ib_dev->pnetid_by_user[ib_port - 1] = true;
@@ -256,11 +261,10 @@ static bool smc_pnet_apply_ib(struct smc_ib_device *ib_dev, u8 ib_port,
  */
 static bool smc_pnet_apply_smcd(struct smcd_dev *smcd_dev, char *pnet_name)
 {
-	u8 pnet_null[SMC_MAX_PNETID_LEN] = {0};
 	bool applied = false;
 
 	mutex_lock(&smcd_dev_list.mutex);
-	if (smc_pnet_match(smcd_dev->pnetid, pnet_null)) {
+	if (!smc_pnet_is_pnetid_set(smcd_dev->pnetid)) {
 		memcpy(smcd_dev->pnetid, pnet_name, SMC_MAX_PNETID_LEN);
 		smcd_dev->pnetid_by_user = true;
 		applied = true;
-- 
2.17.1
