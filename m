Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E2490C03;
	Thu,  6 Aug 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048005; cv=none; b=UgIeiPUtOOT1rIqQZka8CRPWiiXQBhBUfCPhxwPevxZQ+308x1oNtOFX71vHnE7mrxMlJKQ7vuD4YSw3kmqWjKmp8OS44WGa1z2QC4YFE0xUjjbYAAwh6IO0JFaaa4pyFdiIPJP22SWK0XIwv9Jl9bfxeq/nowJlotJLA2hxOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048005; c=relaxed/simple;
	bh=VU6CEEOG+lJfZQJv2x390tNJn50dr5hRnWobWlENiyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfRW/VHy2yemrROcMyqqhOj6OdQbWaYtm0dW/RQ6GKLL5SjHc5apF+tuO7OgISo4Ls6yg1xKw8+R//x8dJuxx+0gc6G783QuUZGBR2lkV2X8NV75q3bto06xoUOLvjQ9WyeCVksq65SbtSnngE9JoZ7q4bUbWmaog7t8HKdAPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz9YaJqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz9YaJqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A611F00A3A;
	Thu,  6 Aug 2026 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048000;
	bh=mn4YT2ApRSaopzXET2AIgz+wXZFI9xEUztyKfd8FJpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bz9YaJqmzlxB4WCv5/P0brr34RZLbO+nw7RKtFIuMtIXr1B23WLcGGfVbZws5JHDg
	 4W0kn5/MYFl5uOyKgkWovKIR5IoBwr9+SKhfM4P4019fElq3qbQSO5N9RxlRdB98Zd
	 dFccbeEQZ6D3yiweV2Uk8FBxCT7ingqNrMod9zl/Jd4+1vzyRBOi6ZHeHk/cEpObjG
	 cjTcZh6aV81dh3W646BTZoW3aNzM/uyXFcS428mV4apxTQH9uqQzr+8f6uBW3GpiPr
	 jkMDDx0NKuEkOo4Dr5IZx1YkmcvM9F7uFFuv7qetTFV0tBN0/Z0si4F93VwSRYe9lM
	 V2dwQkk8HKt8g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:38 +0100
Subject: [PATCH v4 13/20] mm/migrate: calculate large folio page index
 using PFN
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-13-ab318a350404@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=ljs@kernel.org;
 h=from:subject:message-id; bh=VU6CEEOG+lJfZQJv2x390tNJn50dr5hRnWobWlENiyQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3lwIeJB2srlfIsx5i0XEmznfF7X3dO30t4+XfDqPh
 WeebItfRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACbyj5GR4cmCVwrPdJPy3rfs
 3eN89PEFz+UFG88c4vOcMONUrdiM7BhGhnmzX6asljjyXeCF29OA97E6XqnzKu54/Lqf8L9X/c2
 fEDYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Rather than having to figure out the page index to use using
linear_page_index(), calculate it using PFN.

This is a more natural fit as the linear page index is immaterial to
determining the folio page index.

Derive the page index from the offset between migration entry PFN and folio
PFN - pvmw.pfn (set via DEFINE_FOLIO_VMA_WALK() which uses folio_pfn() to
obtain it).

Additionally remove a not so useful comment and clean the code layout up.

No functional change intended.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d08eff028483..50d0b547bca3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -356,16 +356,11 @@ static bool remove_migration_pte(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
-		pte_t old_pte;
-		pte_t pte;
+		unsigned long idx = 0;
 		softleaf_t entry;
 		struct page *new;
-		unsigned long idx = 0;
-
-		/* pgoff is invalid for ksm pages, but they are never large */
-		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
-			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;
-		new = folio_page(folio, idx);
+		pte_t old_pte;
+		pte_t pte;
 
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
 		/* PMD-mapped THP migration entry */
@@ -381,14 +376,18 @@ static bool remove_migration_pte(struct folio *folio,
 						pvmw.pte);
 		else
 			old_pte = ptep_get(pvmw.pte);
+
+		entry = softleaf_from_pte(old_pte);
+		if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+			idx = softleaf_to_pfn(entry) - pvmw.pfn;
+
 		if (rmap_walk_arg->map_unused_to_zeropage &&
 		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
 			continue;
 
 		folio_get(folio);
+		new = folio_page(folio, idx);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-
-		entry = softleaf_from_pte(old_pte);
 		if (!softleaf_is_migration_young(entry))
 			pte = pte_mkold(pte);
 		if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))

-- 
2.55.0

