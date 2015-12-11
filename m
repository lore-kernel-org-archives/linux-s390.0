From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/8] s390-ctcm: Delete unnecessary checks before the function call "channel_remove"
Date: Fri, 11 Dec 2015 12:27:53 +0100
Message-ID: <1449833277-69012-5-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1449833277-69012-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1449833277-69012-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: ubraunu@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>

The channel_remove() function tests whether its argument is NULL
and then returns immediately. Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 05c37d6..c3e2252 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1677,11 +1677,8 @@ static int ctcm_shutdown_device(struct ccwgroup_device *cgdev)
 
 	ccw_device_set_offline(cgdev->cdev[1]);
 	ccw_device_set_offline(cgdev->cdev[0]);
-
-	if (priv->channel[CTCM_READ])
-		channel_remove(priv->channel[CTCM_READ]);
-	if (priv->channel[CTCM_WRITE])
-		channel_remove(priv->channel[CTCM_WRITE]);
+	channel_remove(priv->channel[CTCM_READ]);
+	channel_remove(priv->channel[CTCM_WRITE]);
 	priv->channel[CTCM_READ] = priv->channel[CTCM_WRITE] = NULL;
 
 	return 0;
-- 
2.3.9
