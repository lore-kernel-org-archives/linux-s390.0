Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014930D40B;
	Thu, 16 Jul 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213485; cv=none; b=bbWavXOPfbWK+fu67COkNj37qlwsBoz2GB/H6cj9kj+zTeTdnlD5/op2W3D7CLr9TZPMaya/7HcjK4LrBam7kJDnSAvYyvDmMmKVt1Jl3Rn8NK5Xu/pdcUcTjQYoMszP4z3RtrpvpE7sN7r/3MWl81NuWuDL7PyBqUpAXoA4XrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213485; c=relaxed/simple;
	bh=7mbZY915ufrCqBy6s5DZhqSr6P34AS9jh9aPiB1YHvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxCh4AMhAlYX+eRwWmRA17Ref43k/IG3e2NBITAnKmDYrvU6GxUhujzaWzta/PR+O77c6bXawjo+Os7SWuJabuoIluGNtsZj3d3/oL/jRGDU+jtLttnjG8GVESqHneHlyxzbtQOJ2uErMTzNcrpVi8II45JBpG49Zmp5Qpj5SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df/vCrmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df/vCrmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A931F00A3A;
	Thu, 16 Jul 2026 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213484;
	bh=VRo8YFh6zUYF3ZhnWdJ55baNXlBROoBJ18GXOIHqSYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Df/vCrmpv32e4O/AWaBKoao0h77SA7q12X1pjDs5yQOB6Rx+txHPKvk4MB9UU9J1A
	 8T6TpeC8632LXGkJwMgpTRkZVl07Dq0VUK1X8TwW0Fp5lb0d9zMokxC/fSCiZqH6DE
	 aa2OsvAb7VMXwWNSoOYuYqyy3P0QOXmI/bPUhCidtijsaTgsSxaR4kiutceuSSKZ6v
	 o2xu2KUzaYFtWYMuaQNIqmCqv1x0Obr4nqOnqZQYj0qlWWqdaE2qs9vSbxWhl8FLej
	 bUuuxuqEy0soB2BgyPAjm+LyQUXQJpkM7rmaBCWAVRiY6X0Grzdq3YsBSQdGjbE1UP
	 ApPa03RhCs8lg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:00 +0200
Subject: [PATCH v2 01/10] x86/mm: drop order parameter from
 free_pagetable()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-1-4afc76c73d61@kernel.org>
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

All callers pass 0, so let's drop the parameter.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d57f29ca23a5a..69e36f02a663a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1006,22 +1006,19 @@ static void free_reserved_pages(struct page *page, unsigned long nr_pages)
 		free_reserved_page(page++);
 }
 
-static void __meminit free_pagetable(struct page *page, int order)
+static void __meminit free_pagetable(struct page *page)
 {
 	/* bootmem page has reserved flag */
 	if (PageReserved(page)) {
-		unsigned long nr_pages = 1 << order;
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 		enum bootmem_type type = bootmem_type(page);
 
-		if (type == MIX_SECTION_INFO) {
-			while (nr_pages--)
-				put_page_bootmem(page++);
-		} else {
-			free_reserved_pages(page, nr_pages);
-		}
+		if (type == MIX_SECTION_INFO)
+			put_page_bootmem(page);
+		else
+			free_reserved_page(page);
 #else
-		free_reserved_pages(page, nr_pages);
+		free_reserved_page(page);
 #endif
 	} else {
 		pagetable_free(page_ptdesc(page));
@@ -1060,7 +1057,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 	}
 
 	/* free a pte table */
-	free_pagetable(pmd_page(*pmd), 0);
+	free_pagetable(pmd_page(*pmd));
 	spin_lock(&init_mm.page_table_lock);
 	pmd_clear(pmd);
 	spin_unlock(&init_mm.page_table_lock);
@@ -1078,7 +1075,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 	}
 
 	/* free a pmd table */
-	free_pagetable(pud_page(*pud), 0);
+	free_pagetable(pud_page(*pud));
 	spin_lock(&init_mm.page_table_lock);
 	pud_clear(pud);
 	spin_unlock(&init_mm.page_table_lock);
@@ -1096,7 +1093,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 	}
 
 	/* free a pud table */
-	free_pagetable(p4d_page(*p4d), 0);
+	free_pagetable(p4d_page(*p4d));
 	spin_lock(&init_mm.page_table_lock);
 	p4d_clear(p4d);
 	spin_unlock(&init_mm.page_table_lock);

-- 
2.43.0

