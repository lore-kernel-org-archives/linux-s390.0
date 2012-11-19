From: frank.blaschka@de.ibm.com
Subject: [patch 3/6] [PATCH] claw: remove BUG_ONs
Date: Mon, 19 Nov 2012 13:46:47 +0100
Message-ID: <20121119124659.615539931@de.ibm.com>
References: <20121119124644.679089322@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=605-claw-bugon.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Remove BUG_ON's in claw driver, since the checked error conditions
are null pointer accesses.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/claw.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -3018,10 +3018,8 @@ claw_remove_device(struct ccwgroup_devic
 {
 	struct claw_privbk *priv;
 
-	BUG_ON(!cgdev);
 	CLAW_DBF_TEXT_(2, setup, "%s", dev_name(&cgdev->dev));
 	priv = dev_get_drvdata(&cgdev->dev);
-	BUG_ON(!priv);
 	dev_info(&cgdev->dev, " will be removed.\n");
 	if (cgdev->state == CCWGROUP_ONLINE)
 		claw_shutdown_device(cgdev);
