Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH v2 net 1/3] net/smc: fix SMCD link group creation with VLAN id
Date: Thu, 10 Oct 2019 10:16:09 +0200
In-Reply-To: <20191010081611.35446-1-kgraul@linux.ibm.com>
References: <20191010081611.35446-1-kgraul@linux.ibm.com>
Message-Id: <20191010081611.35446-2-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If creation of an SMCD link group with VLAN id fails, the initial
smc_ism_get_vlan() step has to be reverted as well.

Fixes: c6ba7c9ba43d ("net/smc: add base infrastructure for SMC-D and ISM")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4ca50ddf8d16..88556f0251ab 100644
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
2.17.1
