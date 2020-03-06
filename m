Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgCFINg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 03:13:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0268A58f087960
        for <linux-s390@vger.kernel.org>; Fri, 6 Mar 2020 03:13:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj6nmgaj5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 03:13:29 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 6 Mar 2020 08:13:21 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/2] s390/qdio: add tighter controls for IRQ polling
Date: Fri,  6 Mar 2020 09:13:10 +0100
In-Reply-To: <20200306081311.50635-1-jwi@linux.ibm.com>
References: <20200306081311.50635-1-jwi@linux.ibm.com>
Message-Id: <20200306081311.50635-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Qian Cai <cai@lca.pw>

Once the call to qdio_establish() has completed, qdio is free to deliver
data IRQs to the device driver's IRQ poll handler.

For qeth (the only qdio driver that currently uses IRQ polling) this is
problematic, since the IRQs can arrive before its NAPI instance is
even registered. Calling napi_schedule() from qeth_qdio_start_poll()
then crashes in various nasty ways.

Until recently qeth checked for IFF_UP to drop such early interrupts,
but that's fragile as well since it doesn't enforce any ordering.

Fix this properly by bringing up the qdio device in IRQS_DISABLED mode,
and have the driver explicitly opt-in to receive data IRQs.
qeth does so from qeth_open(), which kick-starts a NAPI poll and then
calls qdio_start_irq() from qeth_poll().

Also add a matching qdio_stop_irq() in qeth_stop() to switch the qdio
dataplane back into a disabled state.

Fixes: 3d35dbe6224e ("s390/qeth: don't check for IFF_UP when scheduling napi")
CC: Qian Cai <cai@lca.pw>
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/cio/qdio_setup.c     | 11 +++++++++--
 drivers/s390/net/qeth_core_main.c |  5 ++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index e115623b86b2..66e4bdca9d89 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -224,8 +224,15 @@ static void setup_queues(struct qdio_irq *irq_ptr,
 		setup_queues_misc(q, irq_ptr, qdio_init->input_handler, i);
 
 		q->is_input_q = 1;
-		q->u.in.queue_start_poll = qdio_init->queue_start_poll_array ?
-				qdio_init->queue_start_poll_array[i] : NULL;
+		if (qdio_init->queue_start_poll_array &&
+		    qdio_init->queue_start_poll_array[i]) {
+			q->u.in.queue_start_poll =
+				qdio_init->queue_start_poll_array[i];
+			set_bit(QDIO_QUEUE_IRQS_DISABLED,
+				&q->u.in.queue_irq_state);
+		} else {
+			q->u.in.queue_start_poll = NULL;
+		}
 
 		setup_storage_lists(q, irq_ptr, input_sbal_array, i);
 		input_sbal_array += QDIO_MAX_BUFFERS_PER_Q;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index fdc50543ce9a..37c17ad8ee25 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6582,9 +6582,6 @@ int qeth_open(struct net_device *dev)
 
 	QETH_CARD_TEXT(card, 4, "qethopen");
 
-	if (qdio_stop_irq(CARD_DDEV(card), 0) < 0)
-		return -EIO;
-
 	card->data.state = CH_STATE_UP;
 	netif_tx_start_all_queues(dev);
 
@@ -6634,6 +6631,8 @@ int qeth_stop(struct net_device *dev)
 	}
 
 	napi_disable(&card->napi);
+	qdio_stop_irq(CARD_DDEV(card), 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qeth_stop);
-- 
2.17.1
