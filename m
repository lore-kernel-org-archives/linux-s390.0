Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgLGNNY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 08:13:24 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/6] s390/qeth: remove QETH_QDIO_BUF_HANDLED_DELAYED state
Date: Mon,  7 Dec 2020 14:12:32 +0100
Message-Id: <20201207131233.90383-6-jwi@linux.ibm.com>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Reuse the QETH_QDIO_BUF_EMPTY state to indicate that a TX buffer has
been completed with a QAOB notification, and may be cleaned up by
qeth_cleanup_handled_pending().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 2 --
 drivers/s390/net/qeth_core_main.c | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index d150da95d073..6f5ddc3eab8c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -424,8 +424,6 @@ enum qeth_qdio_out_buffer_state {
 	/* Received QAOB notification on CQ: */
 	QETH_QDIO_BUF_QAOB_OK,
 	QETH_QDIO_BUF_QAOB_ERROR,
-	/* Handled via transfer pending / completion queue. */
-	QETH_QDIO_BUF_HANDLED_DELAYED,
 };
 
 struct qeth_qdio_out_buffer {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 869694217450..da27ef451d05 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -477,8 +477,7 @@ static void qeth_cleanup_handled_pending(struct qeth_qdio_out_q *q, int bidx,
 
 		while (c) {
 			if (forced_cleanup ||
-			    atomic_read(&c->state) ==
-			      QETH_QDIO_BUF_HANDLED_DELAYED) {
+			    atomic_read(&c->state) == QETH_QDIO_BUF_EMPTY) {
 				struct qeth_qdio_out_buffer *f = c;
 
 				QETH_CARD_TEXT(f->q->card, 5, "fp");
@@ -549,7 +548,7 @@ static void qeth_qdio_handle_aob(struct qeth_card *card,
 				kmem_cache_free(qeth_core_header_cache, data);
 		}
 
-		atomic_set(&buffer->state, QETH_QDIO_BUF_HANDLED_DELAYED);
+		atomic_set(&buffer->state, QETH_QDIO_BUF_EMPTY);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.17.1
