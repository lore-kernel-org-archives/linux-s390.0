From: frank.blaschka@de.ibm.com
Subject: [patch 6/6] [PATCH] qeth: add wake_up on write channel
Date: Wed, 08 Feb 2012 11:19:50 +0100
Message-ID: <20120208102029.681812945@de.ibm.com>
References: <20120208101944.272235343@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=607-qeth-write-wake-up.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

To send commands on the write channel 8 buffers exist. If all 
8 buffers are used, a wait is triggered on the write channel. When
such buffer are freed, a wake_up is needed. This patch adds the
missing wake_up in qeth_release_buffer().
This fix is especially important when running Communications
Controller for Linux on System z.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---

 drivers/s390/net/qeth_core_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -678,6 +678,7 @@ void qeth_release_buffer(struct qeth_cha
 	iob->callback = qeth_send_control_data_cb;
 	iob->rc = 0;
 	spin_unlock_irqrestore(&channel->iob_lock, flags);
+	wake_up(&channel->wait_q);
 }
 EXPORT_SYMBOL_GPL(qeth_release_buffer);
 
