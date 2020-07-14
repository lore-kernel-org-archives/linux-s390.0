Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728716AbgGNOXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 10:23:24 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/10] s390/qeth: fine-tune errno when cmds are cancelled
Date: Tue, 14 Jul 2020 16:22:57 +0200
Message-Id: <20200714142305.29297-3-jwi@linux.ibm.com>
In-Reply-To: <20200714142305.29297-1-jwi@linux.ibm.com>
References: <20200714142305.29297-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

If we cancel all pending cmds (eg. when tearing down the device), don't
blame it on an IO error.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c0f551602a5a..7d51be6665cc 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -969,7 +969,7 @@ void qeth_clear_ipacmd_list(struct qeth_card *card)
 
 	spin_lock_irqsave(&card->lock, flags);
 	list_for_each_entry(iob, &card->cmd_waiter_list, list)
-		qeth_notify_cmd(iob, -EIO);
+		qeth_notify_cmd(iob, -ECANCELED);
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_ipacmd_list);
-- 
2.17.1
