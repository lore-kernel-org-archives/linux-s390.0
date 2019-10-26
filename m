Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfJZNRl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Oct 2019 09:17:41 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 53/99] net/smc: fix SMCD link group creation with VLAN id
Date: Sat, 26 Oct 2019 09:15:14 -0400
Message-Id: <20191026131600.2507-53-sashal@kernel.org>
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit 29ee2701529e1905c0e948688f9688c68c8d4ea4 ]

If creation of an SMCD link group with VLAN id fails, the initial
smc_ism_get_vlan() step has to be reverted as well.

Fixes: c6ba7c9ba43d ("net/smc: add base infrastructure for SMC-D and ISM")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4ca50ddf8d161..88556f0251ab9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -213,7 +213,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr = kzalloc(sizeof(*lgr), GFP_KERNEL);
 	if (!lgr) {
 		rc = SMC_CLC_DECL_MEM;
-		goto out;
+		goto ism_put_vlan;
 	}
 	lgr->is_smcd = ini->is_smcd;
 	lgr->sync_err = 0;
@@ -289,6 +289,9 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	smc_llc_link_clear(lnk);
 free_lgr:
 	kfree(lgr);
+ism_put_vlan:
+	if (ini->is_smcd && ini->vlan_id)
+		smc_ism_put_vlan(ini->ism_dev, ini->vlan_id);
 out:
 	if (rc < 0) {
 		if (rc == -ENOMEM)
-- 
2.20.1
