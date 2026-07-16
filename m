Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CA43148C;
	Thu, 16 Jul 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213519; cv=none; b=bsFx1t5fCYOqQPfVLtldssWpZq63G8/RVi00tWnkaQSFKm89Lo3iYCo0tksG19UfYrrCGQoPujWPKrSOeaVZxdEizvC0ClmTLdWrvXUinBQPIZCIlDjZjWTDfdeCb/dXF8W2ja4/lAUF5qes1Agh3YWiC2ORNnZ5bHh3oRKnopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213519; c=relaxed/simple;
	bh=VmlAeOvcpPVEyjHe7dIVhuBb8NL3rqHHrNzhpT2YkZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sp/qpd9TI+CL0QsUvJm1ygE7cJacWGz0hdYU7xY1fNVL91iuMY59Z3Tna3+sDX+DBSVSGbhWtEuFr9GGBpNvnTVLqRcTkn6gLvtg8k4OZHMxRdHpR4mslPqVaKvOLEt9XSvCViyD6HC6l+qWuB9nQBTHYhMe+zuVAL1IUTUo120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VektfMeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VektfMeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487C81F00ADE;
	Thu, 16 Jul 2026 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213517;
	bh=+jMCCNNe0KRBXDTzHHXxd61yFM5vtsC3u4DIa3uGDkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VektfMeZ/f54Pyk7l+Rh8MLEKJrztN9Du6wijZ63JuhlVjSkJ8PyC7dQ6TJiSQHxv
	 vz3bYr01qA0ZNolCN1D3xwipGpqEqxX4qjbTyGPQA43zs+DYNcsltTcmFuAZet+xFM
	 5wvuAv/dJkPFZdNO2XdtR9H/Xih2wog/sVAiB5Zd5TrK63FS/hVYAgDYZMDrXffqJo
	 OSEFFq52d933y4Hbsgjr1fiZVr57aZSlyaFLFF4Yl4zOp5RQsN/m5l3uXxenvQJQH/
	 fyW/4EGOEq3kTdVgdB3EorKK7ptbRJ1pg4abTv9momHFA6JHS3f+hpToIEzsncoujJ
	 tqbalf0C4sxhw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:07 +0200
Subject: [PATCH v2 08/10] mm/hugetlb_vmemmap: remove bootmem_info leftovers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-8-4afc76c73d61@kernel.org>
References: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
In-Reply-To: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2

We never set CONFIG_HAVE_BOOTMEM_INFO_NODE, so we can just switch to
free_reserved_page() and drop the register_page_bootmem_memmap() call.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb_vmemmap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1430a5aa2de57..917db0984143c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -12,7 +12,6 @@
 
 #include <linux/pgtable.h>
 #include <linux/moduleparam.h>
-#include <linux/bootmem_info.h>
 #include <linux/mmdebug.h>
 #include <linux/pagewalk.h>
 #include <linux/pgalloc.h>
@@ -177,13 +176,13 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
  * Free a vmemmap page. A vmemmap page can be allocated from the memblock
  * allocator or buddy allocator. If the PG_reserved flag is set, it means
  * that it allocated from the memblock allocator, just free it via the
- * free_bootmem_page(). Otherwise, use __free_page().
+ * free_reserved_page(). Otherwise, use __free_page().
  */
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
 		memmap_boot_pages_add(-1);
-		free_bootmem_page(page);
+		free_reserved_page(page);
 	} else {
 		memmap_pages_add(-1);
 		__free_page(page);
@@ -641,9 +640,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
-					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_PAGES);
 			continue;
 		}
 

-- 
2.43.0

