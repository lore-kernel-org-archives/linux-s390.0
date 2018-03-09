Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 02/12] s390/qeth: remove outdated portname debug msg
Date: Fri,  9 Mar 2018 18:12:53 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-3-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The 'portname' attribute is deprecated and setting it has no effect.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d4cb0eea06b6..d884b399f92a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -708,11 +708,8 @@ static int qeth_check_idx_response(struct qeth_card *card,
 
 	QETH_DBF_HEX(CTRL, 2, buffer, QETH_DBF_CTRL_LEN);
 	if ((buffer[2] & 0xc0) == 0xc0) {
-		QETH_DBF_MESSAGE(2, "received an IDX TERMINATE "
-			   "with cause code 0x%02x%s\n",
-			   buffer[4],
-			   ((buffer[4] == 0x22) ?
-			    " -- try another portname" : ""));
+		QETH_DBF_MESSAGE(2, "received an IDX TERMINATE with cause code %#02x\n",
+				 buffer[4]);
 		QETH_CARD_TEXT(card, 2, "ckidxres");
 		QETH_CARD_TEXT(card, 2, " idxterm");
 		QETH_CARD_TEXT_(card, 2, "  rc%d", -EIO);
-- 
2.13.5
