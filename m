Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728777AbfGWWwO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jul 2019 18:52:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NMpqD5150100
        for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2019 18:52:13 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx9g63wse-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2019 18:52:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 23 Jul 2019 23:52:10 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v2 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
Date: Wed, 24 Jul 2019 00:51:55 +0200
Message-Id: <20190723225155.3915-1-pasic@linux.ibm.com>
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
Fixes: c61e9637340e ("dma-direct: add support for allocation from ZONE_DMA and ZONE_DMA32")
---
 arch/s390/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index a4d38092530a..27470dae31d2 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -177,6 +177,8 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define ARCH_ZONE_DMA_BITS      31
+
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-- 
2.17.1
