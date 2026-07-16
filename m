Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0830D40B;
	Thu, 16 Jul 2026 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213490; cv=none; b=pJcDD3fzmHhhJpgSXAvssM08A3TPJUNZ7VbFmWfvnBbFhaA6/ryCwTMHWtqNp1SYbJYXuKdTcNmmKzqR7RonwGE0+xe+baIhha02wpe9fQWNlwWaJRIolxTMlnF9yv4Gzw/KhzR6/wlw5jDjqtCh1b/hlDuvIolllgw0fplY1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213490; c=relaxed/simple;
	bh=62fkKqSyTuU705FaaEq0TAVQAMr3fBZklafAP9Jyqn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmHrqBQIE27qN46INFhDpLMVsfz7zIp9K3cZPaPdubZmwFSiCUBqgYSCqjgeBGWnZIFiPD8yJHoVl1l7k2bFbSrheJY9rWTi4RVDYIf4V7upgfqBulGTS6fLuOUVoroGE6lA9lXywWhGelcEYSR1gTFpSp7sg+zM7oWO1KkaMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVucWdgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVucWdgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE771F00A3E;
	Thu, 16 Jul 2026 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213489;
	bh=lX1TFiP6xIbjy9evrHNZox00I5e7bkCckKcJldvVME4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MVucWdgVB3uHkthYYg4NX8x7GsFBKVscGgVa3g/uHHXEAeYf8FperTLXsPRKNBKQI
	 LS3dPrUJ+oFBauuHY6ef3I8QQjvOJTbNW8vccNpP5NVIMJy20MooRkImJnPP05FWKf
	 CIp+s3x3F1p7sEeFYDWskJJ29o/iW6cB90NVqln618zouzDsORVOkljdc0vz90fGW3
	 CNNJEW8dY782Is74iDs02CzWGU5EfZUYJUrZ5xtYYAfLnk3IkN0UhUyUzk3NF73C2T
	 wFLu1i0M9T6BMeh8DKIBHFtzPgPuMJDyhVi5QtsgC6iM6bAd3SIpxnp0onizUfxkLc
	 7YZV8IDYnrf2A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:01 +0200
Subject: [PATCH v2 02/10] mm: provide free_reserved_pages(), removing x86
 variant
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-2-4afc76c73d61@kernel.org>
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

Let's extend free_reserved_page() in page_alloc.c to free_reserved_pages(),
dropping the custom x86 variant. The common-code variant will consume an
order, so adjust the x86 callers accordingly.

Make free_reserved_pages() assume that we are freeing ordinary
high-order pages, just with the special "reserved" flavor. The target
use case for now is freeing vmemmap PMD pages.

Set the refcount directly to 0 (instead of 1) and call
__free_frozen_pages(). Set the page count to 0 before clearing
PG_reserved, so someone checking PG_reserved (and not finding it set)
to then try grabbing a ref would not suddenly have that ref be dropped.
That is arguably cleaner and safer than the old way of doing it.

Add some kerneldoc. Use a single adjust_managed_page_count() call.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c |  8 +-------
 include/linux/mm.h    |  8 ++++++--
 mm/page_alloc.c       | 33 ++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 69e36f02a663a..320e742b0bb3f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1000,12 +1000,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
 
-static void free_reserved_pages(struct page *page, unsigned long nr_pages)
-{
-	while (nr_pages--)
-		free_reserved_page(page++);
-}
-
 static void __meminit free_pagetable(struct page *page)
 {
 	/* bootmem page has reserved flag */
@@ -1038,7 +1032,7 @@ static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 			while (nr_pages--)
 				put_page_bootmem(page++);
 		} else {
-			free_reserved_pages(page, nr_pages);
+			free_reserved_pages(page, order);
 		}
 	} else {
 		__free_pages(page, order);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 113e1752548c2..62b261cccf16f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3993,8 +3993,12 @@ extern unsigned long free_reserved_area(void *start, void *end,
 
 extern void adjust_managed_page_count(struct page *page, long count);
 
-/* Free the reserved page into the buddy system, so it gets managed. */
-void free_reserved_page(struct page *page);
+void free_reserved_pages(struct page *page, unsigned int order);
+
+static inline void free_reserved_page(struct page *page)
+{
+	free_reserved_pages(page, 0);
+}
 
 static inline void mark_page_reserved(struct page *page)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a63733dac659e..2e17243ff604f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6381,15 +6381,34 @@ void adjust_managed_page_count(struct page *page, long count)
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-void free_reserved_page(struct page *page)
+/**
+ * free_reserved_pages - free reserved pages
+ * @page: First page to free.
+ * @order: The page order to free.
+ *
+ * Free pages allocated through memblock during boot, letting the buddy
+ * manage them from now on.
+ *
+ * @page must be naturally aligned to the order and the order must not
+ * exceed MAX_PAGE_ORDER. All pages must be reserved.
+ */
+void free_reserved_pages(struct page *page, unsigned int order)
 {
-	clear_page_tag_ref(page);
-	ClearPageReserved(page);
-	init_page_count(page);
-	__free_page(page);
-	adjust_managed_page_count(page, 1);
+	const unsigned long nr_pages = 1UL << order;
+	int i;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(page_to_pfn(page), nr_pages));
+	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
+
+	for (i = 0; i < nr_pages; i++) {
+		clear_page_tag_ref(page + i);
+		set_page_count(page + i, 0);
+		ClearPageReserved(page + i);
+	}
+	adjust_managed_page_count(page, nr_pages);
+	__free_frozen_pages(page, order, FPI_NONE);
 }
-EXPORT_SYMBOL(free_reserved_page);
+EXPORT_SYMBOL(free_reserved_pages);
 
 static int page_alloc_cpu_dead(unsigned int cpu)
 {

-- 
2.43.0

