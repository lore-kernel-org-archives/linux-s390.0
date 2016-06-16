From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 01/13] qeth: Include error message for "OS Mismatch"
Date: Thu, 16 Jun 2016 16:18:51 +0200
Message-ID: <1466086743-55484-2-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

Having understood the semantics of BRIDGEPORT error code 0x0010,
we can introduce a meaningful error message.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 80b1979..faab0b6 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1800,6 +1800,12 @@ static int qeth_bridgeport_makerc(struct qeth_card *card,
 			dev_err(&card->gdev->dev,
 	"The device is not configured as a Bridge Port\n");
 			break;
+		case 0x2B10:
+		case 0x0010: /* OS mismatch */
+			rc = -EPERM;
+			dev_err(&card->gdev->dev,
+	"A Bridge Port is already configured by a different operating system\n");
+			break;
 		case 0x2B14:
 		case 0x0014: /* Another device is Primary */
 			switch (setcmd) {
-- 
2.6.6
