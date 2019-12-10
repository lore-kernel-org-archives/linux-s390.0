Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfLJVI3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:29 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 082/350] net/smc: increase device refcount for added link group
Date: Tue, 10 Dec 2019 16:03:07 -0500
Message-Id: <20191210210735.9077-43-sashal@kernel.org>
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit b3cb53c05f20c5b4026a36a7bbd3010d1f3e0a55 ]

SMCD link groups belong to certain ISM-devices and SMCR link group
links belong to certain IB-devices. Increase the refcount for
these devices, as long as corresponding link groups exist.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2ba97ff325a5d..0c5fcb8ed404d 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -231,10 +231,12 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->conns_all = RB_ROOT;
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
+		get_device(&ini->ism_dev->dev);
 		lgr->peer_gid = ini->ism_gid;
 		lgr->smcd = ini->ism_dev;
 	} else {
 		/* SMC-R specific settings */
+		get_device(&ini->ib_dev->ibdev->dev);
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
 		       SMC_SYSTEMID_LEN);
@@ -433,10 +435,13 @@ static void smc_lgr_free_bufs(struct smc_link_group *lgr)
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
2.20.1
