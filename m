Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbfGRRVe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 13:21:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IHIu8Q027278
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 13:21:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttuv4u31j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 13:21:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 18:21:31 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
Date: Thu, 18 Jul 2019 19:21:20 +0200
Message-Id: <20190718172120.69947-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On s390 ZONE_DMA is up to 2G, i.e. ARCH_ZONE_DMA_BITS should be 31 bits.
The current value is 24 and makes __dma_direct_alloc_pages() take a
wrong turn first (but __dma_direct_alloc_pages() recovers then).

Let's correct ARCH_ZONE_DMA_BITS value and avoid wrong turns.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Petr Tesarik <ptesarik@suse.cz>
Fixes: c61e9637340e ("dma-direct: add support for allocation from
ZONE_DMA and ZONE_DMA32")
---
 arch/s390/include/asm/dma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
index 6f26f35d4a71..3b0329665b13 100644
--- a/arch/s390/include/asm/dma.h
+++ b/arch/s390/include/asm/dma.h
@@ -10,6 +10,7 @@
  * by the 31 bit heritage.
  */
 #define MAX_DMA_ADDRESS         0x80000000
+#define ARCH_ZONE_DMA_BITS      31
 
 #ifdef CONFIG_PCI
 extern int isa_dma_bridge_buggy;
-- 
2.17.1
