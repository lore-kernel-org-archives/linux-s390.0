Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/11] s390/qeth: add SW timestamping support for IQD devices
Date: Wed, 18 Mar 2020 13:54:51 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

This adds support for SOF_TIMESTAMPING_TX_SOFTWARE.
No support for non-IQD devices, since they orphan the skb in their xmit
path.

To play nice with TX bulking, set the timestamp when the buffer that
contains the skb(s) is actually flushed out to HW.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  6 +++++-
 drivers/s390/net/qeth_ethtool.c   | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e1d984c29e1f..33796fe80a63 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3355,6 +3355,7 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 
 	for (i = index; i < index + count; ++i) {
 		unsigned int bidx = QDIO_BUFNR(i);
+		struct sk_buff *skb;
 
 		buf = queue->bufs[bidx];
 		buf->buffer->element[buf->next_element_to_fill - 1].eflags |=
@@ -3363,8 +3364,11 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 		if (queue->bufstates)
 			queue->bufstates[bidx].user = buf;
 
-		if (IS_IQD(queue->card))
+		if (IS_IQD(card)) {
+			skb_queue_walk(&buf->skb_list, skb)
+				skb_tx_timestamp(skb);
 			continue;
+		}
 
 		if (!queue->do_pack) {
 			if ((atomic_read(&queue->used_buffers) >=
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 079b695032ef..5cfa371b7426 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -204,6 +204,17 @@ static int qeth_set_channels(struct net_device *dev,
 	return qeth_set_real_num_tx_queues(card, channels->tx_count);
 }
 
+static int qeth_get_ts_info(struct net_device *dev,
+			    struct ethtool_ts_info *info)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	if (!IS_IQD(card))
+		return -EOPNOTSUPP;
+
+	return ethtool_op_get_ts_info(dev, info);
+}
+
 static int qeth_get_tunable(struct net_device *dev,
 			    const struct ethtool_tunable *tuna, void *data)
 {
@@ -440,6 +451,7 @@ const struct ethtool_ops qeth_ethtool_ops = {
 	.get_drvinfo = qeth_get_drvinfo,
 	.get_channels = qeth_get_channels,
 	.set_channels = qeth_set_channels,
+	.get_ts_info = qeth_get_ts_info,
 	.get_tunable = qeth_get_tunable,
 	.set_tunable = qeth_set_tunable,
 	.get_link_ksettings = qeth_get_link_ksettings,
-- 
2.17.1
