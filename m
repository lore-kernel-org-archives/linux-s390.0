From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 5/5] qeth: Remove unneeded structure member
Date: Fri, 16 Jan 2015 14:05:49 +0100
Message-ID: <1421413549-56937-6-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1421413549-56937-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1421413549-56937-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

The member irq_tasklet in the qeth_channel structure
is not referenced anymore and is removed from the
structure.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/qeth_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 7a8bb9f..3abac02 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -596,7 +596,6 @@ struct qeth_channel {
 	struct ccw1 ccw;
 	spinlock_t iob_lock;
 	wait_queue_head_t wait_q;
-	struct tasklet_struct irq_tasklet;
 	struct ccw_device *ccwdev;
 /*command buffer for control data*/
 	struct qeth_cmd_buffer iob[QETH_CMD_BUFFER_NO];
-- 
2.1.4
