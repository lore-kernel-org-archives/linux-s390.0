Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403920AbfJ1Q4F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Oct 2019 12:56:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SGqkta008680
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 12:56:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vx2xmb9c9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 12:56:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 28 Oct 2019 16:56:02 -0000
From: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
Date: Mon, 28 Oct 2019 17:55:49 +0100
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191028165549.14478-1-iii@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>

Building the kernel on s390 with -Og produces the following warning:

WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from the function populate_section_memmap() to the function .meminit.text:__populate_section_memmap()
The function populate_section_memmap() references
the function __meminit __populate_section_memmap().
This is often because populate_section_memmap lacks a __meminit
annotation or the annotation of __populate_section_memmap is wrong.

While -Og is not supported, in theory this might still happen with
another compiler or on another architecture. So fix this by using the
correct section annotations.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/sparse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index f6891c1992b1..0f1f36443a96 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
 
-struct page __init *__populate_section_memmap(unsigned long pfn,
+struct page __meminit *__populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long size = section_map_size();
@@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static struct page *populate_section_memmap(unsigned long pfn,
+static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
@@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
 	vmemmap_free(start, end, NULL);
 }
 #else
-struct page *populate_section_memmap(unsigned long pfn,
+struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	struct page *page, *ret;
-- 
2.23.0
