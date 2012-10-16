From: frank.blaschka@de.ibm.com
Subject: [patch 1/2] [PATCH] smsgiucv: reestablish IUCV path after resume
Date: Tue, 16 Oct 2012 07:21:17 +0200
Message-ID: <20121016052331.713229633@de.ibm.com>
References: <20121016052116.210859505@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=600-smsg-path-resume.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

smsg_pm_restore_thaw() uses wrong checking before reconnecting
the IUCV path to *MSG. It is corrected with this patch.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/smsgiucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index 207b7d7..d8f990b 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -157,7 +157,7 @@ static int smsg_pm_restore_thaw(struct device *dev)
 #ifdef CONFIG_PM_DEBUG
 	printk(KERN_WARNING "smsg_pm_restore_thaw\n");
 #endif
-	if (smsg_path && iucv_path_connected) {
+	if (smsg_path && !iucv_path_connected) {
 		memset(smsg_path, 0, sizeof(*smsg_path));
 		smsg_path->msglim = 255;
 		smsg_path->flags = 0;
-- 
1.7.11.7
