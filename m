Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721142FCAD;
	Thu, 16 Jul 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213504; cv=none; b=Qd9YFXg/HYNmXAmgty+WC18Adk26V8JC7+y+QnhwaUpqWY31ozSkSgaJwLDWpvDzFv95ud2rklQJehvw5gnVgoWIy6vWpCRYrPh3/g8BhTrM/uEwmTmEn+cQzVgIxLMvIuU7MekV75O2mO/v5qNvJohy1oYGblJjeKZ2WSPf34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213504; c=relaxed/simple;
	bh=n3tvgN/k4UYuQ2JhAdxrtV0BlqhciU7/a8t2Zbfyzq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3qfn7QLPuD9UPsE1A0W0WQY13ilhZFkAWcxO/+h7cYbt6mJDW+s/J7cVpZ7brgFf02W3CQSikjytHqOgezaOyI01OsE9Vt9bTSt4XJq2aiXdjQHJzdKkjzgQqXQfo1qqLW5l5Xxmp8uCp2VnBG1b/m9Ez9ByKRK1sJc44KhL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8J8pa/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8J8pa/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017BF1F00A3D;
	Thu, 16 Jul 2026 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213503;
	bh=Ka6zYOXsuhzx77WYU+YoIUZ4Wz6My9SyyjFFnIK2/ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G8J8pa/1nRI8j8oUQnulySCu96Q8xq00a5h/GkJWgx7G0Lor9V+49krSS4vZNMTpl
	 BjpBYfElp1gxBB+nFV7YEEbbFPxfd4VelehBfIC4A9Dn+mkA4B6RQsTbcFe+Gpb/CV
	 EvHE5iBlPYmRMjoMrHC246WyHB1iEwkmpkLuJWUZp1Hwo6LO1xNbVMg5mVP67XtRln
	 O+iLPelLLhHSUZbEreJXf8p7v9RlVBMtWuwuvrPsQYAQDhUfooYBBPfaolthnAojYJ
	 ZRqXakJe0kFVulTi95mGCbNQPOBmHFlsmyWIDt8VUMs/Gt1Z23gbOtjFTJNhAsgYCf
	 rKLUWk3nOUTiQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:04 +0200
Subject: [PATCH v2 05/10] x86/mm: stop marking vmemmap as SECTION_INFO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-5-4afc76c73d61@kernel.org>
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

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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

