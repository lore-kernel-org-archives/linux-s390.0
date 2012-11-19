From: frank.blaschka@de.ibm.com
Subject: [patch 2/6] [PATCH] ctcm: remove BUG_ONs
Date: Mon, 19 Nov 2012 13:46:46 +0100
Message-ID: <20121119124659.511197755@de.ibm.com>
References: <20121119124644.679089322@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=604-ctcm-bugon.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Remove BUG_ON's in ctcm driver, since the checked error conditions
are null pointer accesses.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/ctcm_main.c |    2 --
 drivers/s390/net/ctcm_mpc.c  |    3 ---
 2 files changed, 5 deletions(-)

--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1691,8 +1691,6 @@ static void ctcm_remove_device(struct cc
 {
 	struct ctcm_priv *priv = dev_get_drvdata(&cgdev->dev);
 
-	BUG_ON(priv == NULL);
-
 	CTCM_DBF_TEXT_(SETUP, CTC_DBF_INFO,
 			"removing device %p, proto : %d",
 			cgdev, priv->protocol);
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -1367,7 +1367,6 @@ static void mpc_action_go_inop(fsm_insta
 	struct mpc_group *grp;
 	struct channel *wch;
 
-	BUG_ON(dev == NULL);
 	CTCM_PR_DEBUG("Enter %s: %s\n",	__func__, dev->name);
 
 	priv  = dev->ml_priv;
@@ -1472,8 +1471,6 @@ static void mpc_action_timeout(fsm_insta
 	struct channel *wch;
 	struct channel *rch;
 
-	BUG_ON(dev == NULL);
-
 	priv = dev->ml_priv;
 	grp = priv->mpcg;
 	wch = priv->channel[CTCM_WRITE];
