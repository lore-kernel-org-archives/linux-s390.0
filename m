Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbgH0IRR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:17:17 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/8] s390/qeth: use to_delayed_work()
Date: Thu, 27 Aug 2020 10:16:59 +0200
Message-Id: <20200827081705.21922-3-jwi@linux.ibm.com>
In-Reply-To: <20200827081705.21922-1-jwi@linux.ibm.com>
References: <20200827081705.21922-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Avoid poking around in the delayed_work struct's internals.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bba1b54b8aa3..5742a682a193 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3549,8 +3549,9 @@ static unsigned int qeth_rx_refill_queue(struct qeth_card *card,
 
 static void qeth_buffer_reclaim_work(struct work_struct *work)
 {
-	struct qeth_card *card = container_of(work, struct qeth_card,
-		buffer_reclaim_work.work);
+	struct qeth_card *card = container_of(to_delayed_work(work),
+					      struct qeth_card,
+					      buffer_reclaim_work);
 
 	local_bh_disable();
 	napi_schedule(&card->napi);
-- 
2.17.1
