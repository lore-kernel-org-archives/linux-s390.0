Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/10] s390/qeth: limit trace to valid data of command request
Date: Tue, 12 Feb 2019 18:33:20 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

'len' specifies how much data we send to the HW, don't dump beyond this
boundary.
As of today this is no big concern - commands are built in full, zeroed
pages.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 428175e1cb5d..ae2ea0a0edce 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1991,7 +1991,7 @@ void qeth_prepare_control_data(struct qeth_card *card, int len,
 	card->seqno.pdu_hdr++;
 	memcpy(QETH_PDU_HEADER_ACK_SEQ_NO(iob->data),
 	       &card->seqno.pdu_hdr_ack, QETH_SEQ_NO_LENGTH);
-	QETH_DBF_HEX(CTRL, 2, iob->data, QETH_DBF_CTRL_LEN);
+	QETH_DBF_HEX(CTRL, 2, iob->data, min(len, QETH_DBF_CTRL_LEN));
 }
 EXPORT_SYMBOL_GPL(qeth_prepare_control_data);
 
-- 
2.16.4
