Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36563750AC;
	Thu,  6 Aug 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047981; cv=none; b=SdRPoRTXj6JM5vcbGW3HP3Df4fXVYWq4DNUst5dtYrq2yKwDKpJML7MZz1lNKKzCut5hb/ZxOCpDrYWXCGgW7EmXRrZDsYtnhQmUj+p4L7eVNSBPfNK9aB+jHqlqOsLtRZkn3Neev+wglbKe+sZUSheeI+5jRGLzteMwwrEP294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047981; c=relaxed/simple;
	bh=FQvfrIChtfCHHXCKi2iMmw+WlLObO/vvN/oq4qWGhM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJ9i7NMuYwjPwV9rXCvXisPVHsNbWNymwgQvKWzHzSQ+b8z1bt3/FFVbjzfc96u6mp0LHN1eZoFKS2BqKuzl1PGNpxj7sq6nphUNVXiRWypY9WpkbotUeoORVerfcdWQHKWlr+DADjAaZwEgup/VB/Oji+mIdxt5AYE/bqYP3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDrqZrNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDrqZrNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F6A1F000E9;
	Thu,  6 Aug 2026 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047979;
	bh=Yu2gHLRO/SRcmXO93obChsLu5SUfHnH/15hgrAMzxms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lDrqZrNR/iyUmRO+7Z821lHEcT77036v+dj9GNHtUzgqrvxHacNZrqPcieg2kFf43
	 5HGbiuVs1H2Ve7zRIBdILvDZkIrcpocaVff5jnMAZzWLZg2YNb+Z9a82hwrlqDC179
	 2FNHNc8gt0ohZFRtnB8QeJLOtoCkiKBc8gkwVGHzQUQa7gedN8WTtjcgwQIMcY7nkb
	 LqD9qwm5KLRniYu3UF9X2g/XBoYniq5+YbWe49I4clFRHPT238KYlH8gr9XZ+5iekV
	 3lwQaZKSn1TWM+iyon8etePZojIgXmHbpASvl5XH+XGN2VM6Q28c+jxiu8cqLD8JVS
	 na0KUcOWeR8eA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:37 +0100
Subject: [PATCH v4 12/20] mm/huge_memory: update remove_migration_pmd() to
 accept a folio
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-12-ab318a350404@kernel.org>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764; i=ljs@kernel.org;
 h=from:subject:message-id; bh=FQvfrIChtfCHHXCKi2iMmw+WlLObO/vvN/oq4qWGhM0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3lwoPfTn83L/Ct6FU6LefJ/nERIndmuDX9Mxs9Upq
 jzvj/3l6ShlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEHiszMnRONebz33Tm321v
 5aounvlauhNrJ3470nLLuK9hVaDcwypGhiPhRnsvn8m5/+K71JUYLtsNzQz8axce+Swm1FR37hj
 rDUYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This function does not need to accept a page and requiring it to is unnecessary
and misleading.

make_[writable, readable]_device_private_entry() must be passed a
PMD-aligned PFN as they immediately used to obtain a softleaf PMD entry and
the same argument applies to folio_add_[anon, file]_rmap_pmd().

While we are here, update a VM_BUG_ON() to a VM_WARN_ON_ONCE().

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/swapops.h |  6 +++---
 mm/huge_memory.c        | 16 +++++++---------
 mm/migrate.c            |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index c956bc445ee0..1f3ff3b93e16 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -325,8 +325,8 @@ struct page_vma_mapped_walk;
 extern int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page);
 
-extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
-		struct page *new);
+void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
+		struct folio *folio);
 
 extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
 
@@ -346,7 +346,7 @@ static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 }
 
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
-		struct page *new)
+		struct folio *folio)
 {
 	BUILD_BUG();
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6b0cabd45b2d..47c9c6e32eba 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -5020,9 +5020,8 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	return 0;
 }
 
-void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
+void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct folio *folio)
 {
-	struct folio *folio = page_folio(new);
 	struct vm_area_struct *vma = pvmw->vma;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address = pvmw->address;
@@ -5058,11 +5057,9 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		swp_entry_t entry;
 
 		if (pmd_write(pmde))
-			entry = make_writable_device_private_entry(
-							page_to_pfn(new));
+			entry = make_writable_device_private_entry(folio_pfn(folio));
 		else
-			entry = make_readable_device_private_entry(
-							page_to_pfn(new));
+			entry = make_readable_device_private_entry(folio_pfn(folio));
 		pmde = softleaf_to_pmd(entry);
 
 		if (pmd_swp_soft_dirty(*pvmw->pmd))
@@ -5077,11 +5074,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		if (!softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
-		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
+		folio_add_anon_rmap_pmd(folio, &folio->page, vma, haddr, rmap_flags);
 	} else {
-		folio_add_file_rmap_pmd(folio, new, vma);
+		folio_add_file_rmap_pmd(folio, &folio->page, vma);
 	}
-	VM_BUG_ON(pmd_write(pmde) && folio_test_anon(folio) && !PageAnonExclusive(new));
+	VM_WARN_ON_ONCE(pmd_write(pmde) && folio_test_anon(folio) &&
+			!PageAnonExclusive(&folio->page));
 	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
 
 	/* No need to invalidate - it was non-present before */
diff --git a/mm/migrate.c b/mm/migrate.c
index 222c8c15f782..d08eff028483 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -372,7 +372,7 @@ static bool remove_migration_pte(struct folio *folio,
 		if (!pvmw.pte) {
 			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
 					!folio_test_pmd_mappable(folio), folio);
-			remove_migration_pmd(&pvmw, new);
+			remove_migration_pmd(&pvmw, folio);
 			continue;
 		}
 #endif

-- 
2.55.0

