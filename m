From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/7] s390/qeth: use QDIO_*_QFMT defines
Date: Wed,  5 Apr 2017 10:40:09 +0200
Message-ID: <20170405084015.35772-2-ubraun@linux.vnet.ibm.com>
References: <20170405084015.35772-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170405084015.35772-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

better use the constant definitions.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 315d8a2..3b3cb3b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4774,12 +4774,10 @@ static int qeth_query_card_info(struct qeth_card *card,
 
 static inline int qeth_get_qdio_q_format(struct qeth_card *card)
 {
-	switch (card->info.type) {
-	case QETH_CARD_TYPE_IQD:
-		return 2;
-	default:
-		return 0;
-	}
+	if (card->info.type == QETH_CARD_TYPE_IQD)
+		return QDIO_IQDIO_QFMT;
+	else
+		return QDIO_QETH_QFMT;
 }
 
 static void qeth_determine_capabilities(struct qeth_card *card)
-- 
2.10.2
