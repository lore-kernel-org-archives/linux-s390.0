From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 9/9] s390/qeth: tidy up parameter naming for qeth_do_send_packet()
Date: Mon, 18 Sep 2017 21:18:22 +0200
Message-ID: <20170918191822.65142-10-jwi@linux.vnet.ibm.com>
References: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Remus <jremus@linux.vnet.ibm.com>

Cppcheck reports the following for drivers/s390/net/qeth_core.h:

    warning - line 1560 - Function 'qeth_do_send_packet' argument order
    different:
    declaration 'card, queue, skb, hdr, hd_len, offset, elements'
    definition  'card, queue, skb, hdr, offset, hd_len, elements_needed'.

Match the naming in the function's declaration against its definition.

Signed-off-by: Jens Remus <jremus@linux.vnet.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index b7e8531625aa..91fcadbede80 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -967,7 +967,8 @@ int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue, struct sk_buff *skb,
 			     unsigned int hd_len);
 int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			struct sk_buff *skb, struct qeth_hdr *hdr,
-			unsigned int hd_len, unsigned int offset, int elements);
+			unsigned int offset, unsigned int hd_len,
+			int elements_needed);
 int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 int qeth_core_get_sset_count(struct net_device *, int);
 void qeth_core_get_ethtool_stats(struct net_device *,
-- 
2.13.5
