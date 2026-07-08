Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21744D6A1;
	Wed,  8 Jul 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519906; cv=none; b=Jd/mvIE3Ag0e9qUKSFBFPaB383i9//X8AU7/AwcDieb9ERU4eKxHPy5Ma04fFSqxstbevAm6Sz09dOzSoBHaU77zMPUWMW2kleWyix9o84Dp+V3EqQz8MBVfRuNBYJRmAurjdxamGOrUhF6IVhvHklvB3tJUHRXSpDLkzccFFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519906; c=relaxed/simple;
	bh=SI2aU5vWJbW7h3ZSnVN4Wo2j2P1wCFN7nOo/BaPKiLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKvrZ+phPCPNqUbIyVuE+BhJKISrDeeErmMGfHg+o5OFEJDJb6mRIYBNzfOAj8ZbS5KkrIh5IfX1P8jTDD90JRNd+1+qwgOXphKHA7Ny2nWXfRVOPrjG7zLK1u0LTTG8Af5dbDfOz99YD6dDG2EZswSugcqY+iHRKdlrStoBCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBLjf+wa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBLjf+wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963751F000E9;
	Wed,  8 Jul 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519905;
	bh=rZRvbw2JUgsEelPf8rfkDW48yS2gO+Tmg3Nh4V4fAkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VBLjf+wa2OzNu5u4Ouq9WRGo6jVxPejabnf1+hTy75aECQTrHWjVDKmvO8aRlNRk3
	 maPwPVjACLBBkfBychafQYGctLEBU7dCgvneGdl4q4gEKDM/CX8RA5E/1s52WjfUhp
	 F+jYgsyetSLlcpq9NKYS7jtKgEiG0zN9mXdj2NHpiI1O/gyKDnpGVYE62bkzbxT56w
	 Ty6ehkE3DGA5x8bvPMe/eW9Lb2RUYBJuSdW1wW6mFpwel1+U5gD8CWXSReHTqnxgPQ
	 4C0OKpc3MrAdgZtaAsUdvxpJWeNj8twHDMbro/m24VcXgZRXjCEy7WLdrXJXCKUqrt
	 Lpijs2Gda3S7Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:11:00 +0200
Subject: [PATCH 05/10] x86/mm: stop marking vmemmap as SECTION_INFO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-5-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
In-Reply-To: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
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

We added the whole bootmem registration machinery in commit 04753278769f
("memory hotplug: register section/node id to free").

The main use case was to remember to which memory section memmap pages
belonged, so the memmap could be handled accordingly when freeing
memory.

However, all that machinery is not required anymore: a memory section
can only get offlined if *all* pages can get offlined; and it can only
get unplugged once offline. If some of these pages are unmovable memmap
pages: bad luck, doesn't work. Offlining will fail.

Further, a lot of this machinery was required for pre-vmemmap support.
Now we only support the vmemmap with memory hotplug.

So the whole machinery is useless today. Let's start by removing the
last pieces by first stopping to mark vmemmap pages as SECTION_INFO.
In free_vmemmap_pages(), we can now always just free the reserved pages
directly.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 320e742b0bb3f..82bb0384b8ab0 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1024,19 +1024,12 @@ static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 {
 	unsigned long nr_pages = 1u << order;
 
-	if (altmap) {
+	if (altmap)
 		vmem_altmap_free(altmap, nr_pages);
-	} else if (PageReserved(page)) {
-		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
-		    bootmem_type(page) == SECTION_INFO) {
-			while (nr_pages--)
-				put_page_bootmem(page++);
-		} else {
-			free_reserved_pages(page, order);
-		}
-	} else {
+	else if (PageReserved(page))
+		free_reserved_pages(page, order);
+	else
 		__free_pages(page, order);
-	}
 }
 
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
@@ -1593,12 +1586,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	unsigned int nr_pmd_pages;
-	struct page *page;
 
 	for (; addr < end; addr = next) {
-		pte_t *pte = NULL;
-
 		pgd = pgd_offset_k(addr);
 		if (pgd_none(*pgd)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
@@ -1630,19 +1619,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			get_page_bootmem(section_nr, pmd_page(*pmd),
 					 MIX_SECTION_INFO);
-
-			pte = pte_offset_kernel(pmd, addr);
-			if (pte_none(*pte))
-				continue;
-			get_page_bootmem(section_nr, pte_page(*pte),
-					 SECTION_INFO);
 		} else {
 			next = pmd_addr_end(addr, end);
-			nr_pmd_pages = (next - addr) >> PAGE_SHIFT;
-			page = pmd_page(*pmd);
-			while (nr_pmd_pages--)
-				get_page_bootmem(section_nr, page++,
-						 SECTION_INFO);
 		}
 	}
 }

-- 
2.43.0

