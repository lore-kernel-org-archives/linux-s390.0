Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 4 Aug 2018 19:59:03 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/qeth: use true and false for boolean values
Message-ID: <20180805005903.GA5509@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/s390/net/qeth_l3_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 1833e75..7175086 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -117,9 +117,9 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
 	int rc = 0;
 
 	if (!card->ipato.enabled)
-		return 0;
+		return false;
 	if (addr->type != QETH_IP_TYPE_NORMAL)
-		return 0;
+		return false;
 
 	qeth_l3_convert_addr_to_bits((u8 *) &addr->u, addr_bits,
 				  (addr->proto == QETH_PROT_IPV4)? 4:16);
-- 
2.7.4
