From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 13/15] s390/qeth: fix typo in return value
Date: Mon, 17 Sep 2018 17:36:07 +0200
Message-ID: <20180917153609.94628-14-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Assuming this was just a typo, as returning an actual negative value
from a cmd callback would make no sense either.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b76e844811e1..f09bef4a49ca 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3058,7 +3058,7 @@ static int qeth_query_ipassists_cb(struct qeth_card *card,
 		QETH_DBF_TEXT(SETUP, 2, "ipaunsup");
 		card->options.ipa4.supported_funcs |= IPA_SETADAPTERPARMS;
 		card->options.ipa6.supported_funcs |= IPA_SETADAPTERPARMS;
-		return -0;
+		return 0;
 	default:
 		if (cmd->hdr.return_code) {
 			QETH_DBF_MESSAGE(1, "%s IPA_CMD_QIPASSIST: Unhandled "
-- 
2.16.4
