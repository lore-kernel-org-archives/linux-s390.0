Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958642FCBC;
	Thu, 16 Jul 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213509; cv=none; b=OzOjhzPpMSyB4QJVRxJWM7UigQOy9OxwNpPwkbZBEm0wOqD6XNEcy430kalOqD8Lqd92DjRMAcan9NSajSGvygbuYbWzbP542/FlEarPksZgGUF5cnpYKOdNOBqTzgrsygBVPs8k35F86T3vlovkvX8uhnCcmE3il+8nZ0yxyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213509; c=relaxed/simple;
	bh=0LZvdWT+Rfx+oMptt5suErjeEC7ICsoyzDbBnYxab4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itWYYmgnNJMCOkfL3yHG1Ib13hxwpnb9GVIRTbyyUlDCOoJ3j+lB6YUYxKlavJzmZIwyKPT2RLxUaWduvqq7gSw/0Pd+VXxO6xhjdhZMYCE3zIunHuMIb5ekQH4DvNDi46+fFVrXCHI6RY8elCAtDuz8k36a0+bu9G6Yh1sR8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0SZi0x2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0SZi0x2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD141F00ACA;
	Thu, 16 Jul 2026 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213508;
	bh=KZlNFNL1P95DigwrQPayUj7ZSeB6mvVJmhz6Pdb9Szo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D0SZi0x2ewDGHd4eKA2+QySHkSYaEz8HLpB/rttMpOzGvhmU37FSYLPQ1UK9ZFIrl
	 kOxUr+0fL5BewjN/mjLpF4WwMH9z61zVTmUfwLhPsBkHROtw6i6OcaWEECVxYj0CTU
	 XLHAbhmJ5llRz7zx1Wu1WPljC1MkGN7Lk2ps7As4zzKP1PWPnnP16nH4RdmmX4TYCa
	 PCEZJ+SmdyL8S51HNX/yv5dS4ImqdWx6mIBPvVy8zMXVSX9pBQo06+cUG9PAnurR4d
	 tiBBetK5d9UFdLYb/wdboi314HiMLMGPNAgNnfeyBBQTvrCIyBHgh6Nu6yFXi4N4Wr
	 7wcSxB2Z/7PkA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:05 +0200
Subject: [PATCH v2 06/10] x86/mm: stop marking page tables as
 MIX_SECTION_INFO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-6-4afc76c73d61@kernel.org>
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

There is no good reason to mark boot page tables as MIX_SECTION_INFO: we
only free boot page tables when they are completely empty, and memory
offlining/hotunplug doesn't benefit from it in any way.

So just stop marking page tables as MIX_SECTION_INFO. In
free_pagetable(), we can now simply free reserved pages directly.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c | 59 ++-------------------------------------------------
 1 file changed, 2 insertions(+), 57 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 82bb0384b8ab0..1b17dcf781e66 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1002,21 +1002,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 static void __meminit free_pagetable(struct page *page)
 {
-	/* bootmem page has reserved flag */
-	if (PageReserved(page)) {
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-		enum bootmem_type type = bootmem_type(page);
-
-		if (type == MIX_SECTION_INFO)
-			put_page_bootmem(page);
-		else
-			free_reserved_page(page);
-#else
+	if (PageReserved(page))
 		free_reserved_page(page);
-#endif
-	} else {
+	else
 		pagetable_free(page_ptdesc(page));
-	}
 }
 
 static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
@@ -1579,50 +1568,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 void register_page_bootmem_memmap(unsigned long section_nr,
 				  struct page *start_page, unsigned long nr_pages)
 {
-	unsigned long addr = (unsigned long)start_page;
-	unsigned long end = (unsigned long)(start_page + nr_pages);
-	unsigned long next;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	for (; addr < end; addr = next) {
-		pgd = pgd_offset_k(addr);
-		if (pgd_none(*pgd)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			continue;
-		}
-		get_page_bootmem(section_nr, pgd_page(*pgd), MIX_SECTION_INFO);
-
-		p4d = p4d_offset(pgd, addr);
-		if (p4d_none(*p4d)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			continue;
-		}
-		get_page_bootmem(section_nr, p4d_page(*p4d), MIX_SECTION_INFO);
-
-		pud = pud_offset(p4d, addr);
-		if (pud_none(*pud)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			continue;
-		}
-		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
-
-		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			continue;
-		}
-
-		if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
-			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			get_page_bootmem(section_nr, pmd_page(*pmd),
-					 MIX_SECTION_INFO);
-		} else {
-			next = pmd_addr_end(addr, end);
-		}
-	}
 }
 #endif
 

-- 
2.43.0

