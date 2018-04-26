From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/13] s390/qeth: query IPv6 assists during hardsetup
Date: Thu, 26 Apr 2018 09:42:20 +0200
Message-ID: <20180426074224.100432-10-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

For new functionality, the L2 subdriver will start using IPv6 assists.
So move the query from the L3 subdriver into the common setup path.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +++++
 drivers/s390/net/qeth_l3_main.c   | 8 --------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b90f38d78ad9..9ec1bb7f8b84 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5201,6 +5201,11 @@ int qeth_core_hardsetup_card(struct qeth_card *card)
 	rc = qeth_query_ipassists(card, QETH_PROT_IPV4);
 	if (rc == -ENOMEM)
 		goto out;
+	if (qeth_is_supported(card, IPA_IPV6)) {
+		rc = qeth_query_ipassists(card, QETH_PROT_IPV6);
+		if (rc == -ENOMEM)
+			goto out;
+	}
 	if (qeth_is_supported(card, IPA_SETADAPTERPARMS)) {
 		rc = qeth_query_setadapterparms(card);
 		if (rc < 0) {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index bc359e322ae7..9d9c743e7433 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -851,14 +851,6 @@ static int qeth_l3_softsetup_ipv6(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 3, "softipv6");
 
-	rc = qeth_query_ipassists(card, QETH_PROT_IPV6);
-	if (rc) {
-		dev_err(&card->gdev->dev,
-			"Activating IPv6 support for %s failed\n",
-			QETH_CARD_IFNAME(card));
-		return rc;
-	}
-
 	if (card->info.type == QETH_CARD_TYPE_IQD)
 		goto out;
 
-- 
2.13.5
