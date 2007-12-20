Return-Path: <linux-kernel-owner+w=401wt.eu-S936090AbXLTPe7@vger.kernel.org>
Message-Id: <20071220152111.370679364@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 38/47] vmemmap: allocate struct pages before 1:1 mapping
Content-Disposition: inline; filename=137-vmalloc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We have seen an oops in an OOM situation, where show_mem tried to
access the struct page of a dcss segment. The vmemmap code has 
already created the 1:1 mapping but failed allocating the struct 
pages. In the OOM case, show_mem now walks the memory. It uses
pfn_valid to detect if it may access the struct page. In the case
described above, the mapping was established and pfn_valid returned
true. As the struct pages were not allocated, the kernel oopsed. 

We have to ensure that we have created the struct pages, before we
add a mapping pointing to the pages.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/vmem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -236,10 +236,10 @@ static int vmem_add_mem(unsigned long st
 {
 	int ret;
 
-	ret = vmem_add_range(start, size);
+	ret = vmem_add_mem_map(start, size);
 	if (ret)
 		return ret;
-	return vmem_add_mem_map(start, size);
+	return vmem_add_range(start, size);
 }
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
