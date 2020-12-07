Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgLGNNY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 08:13:24 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/6] s390/qeth: make qeth_qdio_handle_aob() more robust
Date: Mon,  7 Dec 2020 14:12:33 +0100
Message-Id: <20201207131233.90383-7-jwi@linux.ibm.com>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When qeth_qdio_handle_aob() frees dangling allocations in the notified
TX buffer, there are rare tear-down cases where
qeth_drain_output_queue() would later call qeth_clear_output_buffer()
for the same buffer - and thus end up walking the buffer a second time
to check for dangling kmem_cache allocations.

Luckily current code previously scrubs such a buffer, so
qeth_clear_output_buffer() would find buf->buffer->element[i].addr as
NULL and not do anything. But this is fragile, and we can easily improve
it by consistently clearing the ->is_header flag after freeing the
allocation.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index da27ef451d05..f4b60294a969 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -546,6 +546,7 @@ static void qeth_qdio_handle_aob(struct qeth_card *card,
 
 			if (data && buffer->is_header[i])
 				kmem_cache_free(qeth_core_header_cache, data);
+			buffer->is_header[i] = 0;
 		}
 
 		atomic_set(&buffer->state, QETH_QDIO_BUF_EMPTY);
-- 
2.17.1
