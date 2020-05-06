Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728714AbgEFIKB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 04:10:01 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 07/10] s390/qeth: indicate contiguous TX buffer elements
Date: Wed,  6 May 2020 10:09:46 +0200
Message-Id: <20200506080949.3915-8-jwi@linux.ibm.com>
In-Reply-To: <20200506080949.3915-1-jwi@linux.ibm.com>
References: <20200506080949.3915-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The TX path usually maps the full content of a page into a buffer
element. But there's specific skb layouts (ie. linearized TSO skbs)
where the HW header (1) requires a separate buffer element, and (2) is
page-contiguous with the packet data that's mapped into the next buffer
element.
Flag such buffer elements accordingly, so that HW can optimize its data
access for them.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9c9a6edb5384..4d1d053eebb7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4110,8 +4110,16 @@ static unsigned int qeth_fill_buffer(struct qeth_qdio_out_buffer *buf,
 		buffer->element[element].addr = virt_to_phys(hdr);
 		buffer->element[element].length = hd_len;
 		buffer->element[element].eflags = SBAL_EFLAGS_FIRST_FRAG;
-		/* remember to free cache-allocated HW header: */
-		buf->is_header[element] = ((void *)hdr != skb->data);
+
+		/* HW header is allocated from cache: */
+		if ((void *)hdr != skb->data)
+			buf->is_header[element] = 1;
+		/* HW header was pushed and is contiguous with linear part: */
+		else if (length > 0 && !PAGE_ALIGNED(data) &&
+			 (data == (char *)hdr + hd_len))
+			buffer->element[element].eflags |=
+				SBAL_EFLAGS_CONTIGUOUS;
+
 		element++;
 	}
 
-- 
2.17.1
