From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH RESEND net-next 04/12] s390/qeth: Allow reading hsuid in state DOWN
Date: Thu, 12 Jan 2017 15:48:35 +0100
Message-ID: <20170112144843.33463-5-ubraun@linux.vnet.ibm.com>
References: <20170112144843.33463-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170112144843.33463-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

Accessing the current hsuid via card->options.hsuid is perfectly
fine, even when the card is DOWN.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 0e00a5c..3cd4d9f 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -250,9 +250,6 @@ static ssize_t qeth_l3_dev_hsuid_show(struct device *dev,
 	if (card->info.type != QETH_CARD_TYPE_IQD)
 		return -EPERM;
 
-	if (card->state == CARD_STATE_DOWN)
-		return -EPERM;
-
 	memcpy(tmp_hsuid, card->options.hsuid, sizeof(tmp_hsuid));
 	EBCASC(tmp_hsuid, 8);
 	return sprintf(buf, "%s\n", tmp_hsuid);
-- 
2.8.4
