Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D626056A;
	Fri, 10 Oct 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086334; cv=none; b=VXC2iiJwISDaSJFdOUs7+aQVwwmMO+UB5/e/a1uMQVDYgUsv2r0WZ19kUKrM2EnKBOxa6xiJiUQhShSEc7PQo2tf7qlSYF5u6FbC0cGFwD/aXK0V8Pad0siqwks+6zON2aa72wR/ZlGsleaLCSsCHAPCxMMqVIEEAKbvFVOkF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086334; c=relaxed/simple;
	bh=WOaaAHuh4Fa2o9iVX+RO3xM+kBJpXm76xWCANu9mB7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlqAhLr4Ra+y2ny0yEAfMrXid0KcHZoTnyBC+rGS5+2RiH5VVCr26yK2RZecJhFvgrEz7pqhsJkkNLPKLEaCXbiWzvyLsNx3v+2ze957DYUJnZxWGpgQOD0yo3wzBezOyAy4qM16S361iZ0UoBRpIGqfOX4GjdpjEHUMa3aJ4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ATZ5ufaA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ATZ5ufaA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599KftOb006921;
	Fri, 10 Oct 2025 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IRCYsVBNlKYerMoXi
	WnkluUK6QHgLsXvSZKnJ1VkvWg=; b=ATZ5ufaAu8mKjFARwnv7Pf33KT0QIznGp
	KM9HAa2dvGwI6INiZlCSqQ/nJSfm1Z5Tvp3v1bBbsYthcLoVtuteSqOehFMTrbYN
	nwUhX6coKuZzpWVafchQPIip8QNL0KAbqtbv6ALuccwZ6cKybMShdV0soi9X8VSo
	i3VAfboHKr9eFYHiwP21KKdyvCnbkry0qJQYNTYXATLOakcnoG1U+ffV39craSLQ
	TU6PNINtxh+F3o+HuZxh3KpIpc9g2uExnOZz+lZzTmpB69uhrivH4+64e2QCcBfL
	0KGkR5QuEaU8EnKuE8mjRAZyuPre04haAnQYsFCAHHM3GO+az924A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv809qxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A7qS5B021019;
	Fri, 10 Oct 2025 08:52:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8ss0f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A8q1xs53412226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 08:52:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B18E2008C;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF932008D;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v3 1/4] s390/mm: Support removal of boot-allocated virtual memory map
Date: Fri, 10 Oct 2025 10:51:44 +0200
Message-ID: <20251010085147.2175918-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
References: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NsDcssdJ c=1 sm=1 tr=0 ts=68e8c935 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=To8m7Vbe2ZeGRMaUrlAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EvjJTogrhKAy-wVTO6WVAj-KcpNlugsU
X-Proofpoint-ORIG-GUID: EvjJTogrhKAy-wVTO6WVAj-KcpNlugsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX05UL7PserKIv
 pJeWMXvdUCvc0MaYwKJhyMFcbRAtu/xqlucvY/WxUONjJ0LYrc34AczDVL1YmFl7nEt7LAxeiIk
 IpLW6h4ATqF+NiTTxuFFIg+ivWRp6iVUzzHcHWNVErF+fcak6SGIkareC2O0+hKRbxMvETUERuK
 bE7f3AmrdG9/sIlhfdDY/IyJxQw8aBhQ/CUOmazh6KJYAVmgjqFLYhO5PRIzhorD+5QD8B2VuFk
 QpNk6gWuk5ZT9T/xoZKpEYWbTOKi8+6IIibvICPYxVfb1CfZs/4cXLopAMgkU1uCFMSj3aHHowh
 rW4t3aAgZYzWSWdh9kSMegWTMdnrWaJADYz50TjioHudoAY97EDfE6o+Jm9J/XsZHZlV5WfIsgW
 sTWpr5z6YKz72Br5GWNLFCpL3heUlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121

On s390, memory blocks are not currently removed via
arch_remove_memory(). With upcoming dynamic memory (de)configuration
support, runtime removal of memory blocks is possible. This internally
involves tearing down identity mapping, virtual memory mappings and
freeing the physical memory backing the struct pages metadata.

During early boot, physical memory used to back the struct pages
metadata in vmemmap is allocated through:

setup_arch()
  -> sparse_init()
    -> sparse_init_nid()
      -> __populate_section_memmap()
        -> vmemmap_alloc_block_buf()
          -> sparse_buffer_alloc()
            -> memblock_alloc()

Here, sparse_init_nid() sets up virtual-to-physical mapping for struct
pages backed by memblock_alloc(). This differs from runtime addition of
hotplug memory which uses the buddy allocator later.

To correctly free identity mappings, vmemmap mappings during hot-remove,
boot-time and runtime allocations must be distinguished using the
PageReserved bit:

* Boot-time memory, such as identity-mapped page tables allocated via
  boot_crst_alloc() and reserved via reserve_pgtables() is marked
  PageReserved in memmap_init_reserved_pages().

* Physical memory backing vmemmap (struct pages from memblock_alloc())
  is also marked PageReserved similarly.

During teardown, PageReserved bit is checked to distinguish between
boot-time allocation or buddy allocation.

This is similar to commit 645d5ce2f7d6 ("powerpc/mm/radix: Fix PTE/PMD
fragment count for early page table mappings")

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/mm/pgalloc.c |  2 ++
 arch/s390/mm/vmem.c    | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 626fca116cd7..7df23528c01b 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -164,6 +164,8 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
+	if (pagetable_is_reserved(ptdesc))
+		return free_reserved_ptdesc(ptdesc);
 	pagetable_dtor_free(ptdesc);
 }
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index f48ef361bc83..d96587b84e81 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/memory_hotplug.h>
+#include <linux/bootmem_info.h>
 #include <linux/cpufeature.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
@@ -39,15 +40,21 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 
 static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *altmap)
 {
+	unsigned int nr_pages = 1 << order;
+	struct page *page;
+
 	if (altmap) {
 		vmem_altmap_free(altmap, 1 << order);
 		return;
 	}
-	/* We don't expect boot memory to be removed ever. */
-	if (!slab_is_available() ||
-	    WARN_ON_ONCE(PageReserved(virt_to_page((void *)addr))))
-		return;
-	free_pages(addr, order);
+	page = virt_to_page((void *)addr);
+	if (PageReserved(page)) {
+		/* allocated from memblock */
+		while (nr_pages--)
+			free_bootmem_page(page++);
+	} else {
+		free_pages(addr, order);
+	}
 }
 
 void *vmem_crst_alloc(unsigned long val)
@@ -79,10 +86,6 @@ pte_t __ref *vmem_pte_alloc(void)
 
 static void vmem_pte_free(unsigned long *table)
 {
-	/* We don't expect boot memory to be removed ever. */
-	if (!slab_is_available() ||
-	    WARN_ON_ONCE(PageReserved(virt_to_page(table))))
-		return;
 	page_table_free(&init_mm, table);
 }
 
-- 
2.48.1

