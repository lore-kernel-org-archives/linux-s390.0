Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730086AbfJIIID (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:08:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9987DcB171782
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:08:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vgyqbvey3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:08:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:07:57 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 3/5] net/smc: increase device refcount for added link group
Date: Wed,  9 Oct 2019 10:07:45 +0200
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
Message-Id: <20191009080747.95516-4-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

SMCD link groups belong to certain ISM-devices and SMCR link group
links belong to certain IB-devices. Increase the refcount for
these devices, as long as corresponding link groups exist.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 96d3150d4d1c..a12ec621b54c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -248,12 +248,14 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->conns_all = RB_ROOT;
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
+		get_device(&ini->ism_dev->dev);
 		lgr->peer_gid = ini->ism_gid;
 		lgr->smcd = ini->ism_dev;
 		lgr_list = &ini->ism_dev->lgr_list;
 		lgr_lock = &lgr->smcd->lgr_lock;
 	} else {
 		/* SMC-R specific settings */
+		get_device(&ini->ib_dev->ibdev->dev);
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
 		       SMC_SYSTEMID_LEN);
@@ -451,10 +453,13 @@ static void smc_lgr_free_bufs(struct smc_link_group *lgr)
 static void smc_lgr_free(struct smc_link_group *lgr)
 {
 	smc_lgr_free_bufs(lgr);
-	if (lgr->is_smcd)
+	if (lgr->is_smcd) {
 		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-	else
+		put_device(&lgr->smcd->dev);
+	} else {
 		smc_link_clear(&lgr->lnk[SMC_SINGLE_LINK]);
+		put_device(&lgr->lnk[SMC_SINGLE_LINK].smcibdev->ibdev->dev);
+	}
 	kfree(lgr);
 }
 
-- 
2.17.1
