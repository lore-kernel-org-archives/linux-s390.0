Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727991AbgKJJgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9WJ7O148412
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qhq32guk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9Y2sY157946
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/3] s390/vmem: fix possible memory overwrite
Date: Tue, 10 Nov 2020 10:36:22 +0100
Message-Id: <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
In-Reply-To: <cover.1605000280.git.agordeev@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

If for whatever reason the sub-PMD region to be used is less
than struct page size (e.g in the future), then it is possible
to overwrite beyond the region size.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 56ab9bb770f3a..d7f25884061f4 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -91,13 +91,15 @@ static void vmemmap_flush_unused_pmd(void)
 
 static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 {
+	unsigned long size = min(end - start, sizeof(struct page));
+
 	/*
 	 * As we expect to add in the same granularity as we remove, it's
 	 * sufficient to mark only some piece used to block the memmap page from
 	 * getting removed (just in case the memmap never gets initialized,
 	 * e.g., because the memory block never gets onlined).
 	 */
-	memset(__va(start), 0, sizeof(struct page));
+	memset(__va(start), 0, size);
 }
 
 static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
-- 
2.26.0
