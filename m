From: frank.blaschka@de.ibm.com
Subject: [patch 2/4] qeth: make qeth_query_card_info_cb() static
Date: Wed, 19 Mar 2014 07:58:00 +0100
Message-ID: <20140319065813.402896940@de.ibm.com>
References: <20140319065758.841490297@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=601-qeth-static-fns.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a0aff2e..22470a3 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4610,8 +4610,8 @@ out:
 }
 EXPORT_SYMBOL_GPL(qeth_query_oat_command);
 
-int qeth_query_card_info_cb(struct qeth_card *card,
-			struct qeth_reply *reply, unsigned long data)
+static int qeth_query_card_info_cb(struct qeth_card *card,
+				   struct qeth_reply *reply, unsigned long data)
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_query_card_info *card_info;
