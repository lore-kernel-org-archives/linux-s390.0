Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 9/9] s390/lcs: don't use intparm for channel IO
Date: Tue, 20 Aug 2019 16:46:43 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-10-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

lcs passes an intparm when calling ccw_device_*(), even though lcs_irq()
later makes no use of this.

To reduce the confusion, consistently pass 0 as intparm instead.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/s390/net/lcs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 2d9fe7e4ee40..8f08b0a2917c 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -504,7 +504,7 @@ lcs_clear_channel(struct lcs_channel *channel)
 	LCS_DBF_TEXT(4,trace,"clearch");
 	LCS_DBF_TEXT_(4, trace, "%s", dev_name(&channel->ccwdev->dev));
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_clear(channel->ccwdev, (addr_t) channel);
+	rc = ccw_device_clear(channel->ccwdev, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
 		LCS_DBF_TEXT_(4, trace, "ecsc%s",
@@ -532,7 +532,7 @@ lcs_stop_channel(struct lcs_channel *channel)
 	LCS_DBF_TEXT_(4, trace, "%s", dev_name(&channel->ccwdev->dev));
 	channel->state = LCS_CH_STATE_INIT;
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_halt(channel->ccwdev, (addr_t) channel);
+	rc = ccw_device_halt(channel->ccwdev, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
 		LCS_DBF_TEXT_(4, trace, "ehsc%s",
@@ -1427,7 +1427,7 @@ lcs_irq(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 		channel->state = LCS_CH_STATE_SUSPENDED;
 	if (irb->scsw.cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		if (irb->scsw.cmd.cc != 0) {
-			ccw_device_halt(channel->ccwdev, (addr_t) channel);
+			ccw_device_halt(channel->ccwdev, 0);
 			return;
 		}
 		/* The channel has been stopped by halt_IO. */
-- 
2.17.1
