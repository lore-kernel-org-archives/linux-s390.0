Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88758431A43;
	Thu, 16 Jul 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213528; cv=none; b=igEH+mWF43Z5MV1agRNlNv0nKde+7Rouo1mjv5FV0rMuhhO9g+px1deaADv0gRqktdPBoDny2NI0Cw3gD2WIARZQZQJIjmh5kISZKmkvRYWBAopjhQWSPXfi4xxnpjajt0OorxvlrMFOm5RP1L4nPQXSWhDkbdvIovVMANHqVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213528; c=relaxed/simple;
	bh=JjZ/T2Oin3Bgacc5wSY/00mnCsFvQ2RtfjzOLUmyXco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UyLXhFEvkDL+KhW6ZlMap711wrTM35ujQuudH34/9d7U8TS3foJXsNPtNrYSsIgDiThcVeRi1nE9AUHGcL4v+NI8eO6TJeqiPY4jSB6HHx44mUU+3lS3a/NwaBaY2yB9B1bPDtIElzFjp1XMg3PJmZDmXBaUn+VXQwf1mFFwyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaMrdrUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaMrdrUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1711F00A3E;
	Thu, 16 Jul 2026 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213527;
	bh=tbCxj31fTIebgYa+mqqrVgf086GoCNJGRtKDlCIEv+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UaMrdrUWy3G9h8W138mbxDTjLhKljYComAtLwyWn7DB7CBKuy+9ZqtTDHvHzaSKHB
	 xcnjHtvdSuhxXASY+xBBaaHvA/32ILqO1E9STq9p/xGC7PSsYVeuAyzca/upojynWX
	 jk+XPSTwDttKoTx/lkxSGnT7W86RQNJoOVOt0QMFtEHjdw+zKZPaR3xgzvU9kSuOX+
	 WnQPWZEmYAsbxB1PnhStHe3k9Hup2yE3reimdVygRDIeDeI9luq3aApqcwbNT2hc1i
	 IJ/5VQKXbCGkylui3d3sFbS4CG5MztNJUb/xlvLXK3RhK0dLO1mW5bU08QzWXnZRvw
	 P9OnfMIV6ICfA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:09 +0200
Subject: [PATCH v2 10/10] mm/bootmem_info: remove
 CONFIG_HAVE_BOOTMEM_INFO_NODE
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-10-4afc76c73d61@kernel.org>
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

The whole infrastructure is unused now. Let's remove the config option
along with mm/bootmem_info. + include/linux/bootmem_info.h.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 MAINTAINERS                  |  1 -
 include/linux/bootmem_info.h | 89 --------------------------------------------
 mm/Kconfig                   |  7 ----
 mm/Makefile                  |  1 -
 mm/bootmem_info.c            | 72 -----------------------------------
 5 files changed, 170 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d19822d574fd4..9a67ae0f7865e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16877,7 +16877,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
 F:	Documentation/core-api/boot-time-mm.rst
 F:	include/linux/kho/abi/memblock.h
 F:	include/linux/memblock.h
-F:	mm/bootmem_info.c
 F:	mm/memblock.c
 F:	mm/memtest.c
 F:	mm/mm_init.c
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
deleted file mode 100644
index 486acc6127039..0000000000000
--- a/include/linux/bootmem_info.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_BOOTMEM_INFO_H
-#define __LINUX_BOOTMEM_INFO_H
-
-#include <linux/mm.h>
-#include <linux/kmemleak.h>
-
-/*
- * Types for free bootmem stored in the low bits of page->private.
- */
-enum bootmem_type {
-	MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE = 1,
-	SECTION_INFO = MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE,
-	MIX_SECTION_INFO,
-	NODE_INFO,
-	MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE = NODE_INFO,
-};
-
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
-void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
-				  unsigned long nr_pages);
-
-void get_page_bootmem(unsigned long info, struct page *page,
-		enum bootmem_type type);
-void put_page_bootmem(struct page *page);
-
-static inline enum bootmem_type bootmem_type(const struct page *page)
-{
-	return (unsigned long)page->private & 0xf;
-}
-
-static inline unsigned long bootmem_info(const struct page *page)
-{
-	return (unsigned long)page->private >> 4;
-}
-
-/*
- * Any memory allocated via the memblock allocator and not via the
- * buddy will be marked reserved already in the memmap. For those
- * pages, we can call this function to free it to buddy allocator.
- */
-static inline void free_bootmem_page(struct page *page)
-{
-	enum bootmem_type type = bootmem_type(page);
-
-	if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
-		VM_WARN_ON_PAGE(page_ref_count(page) != 2, page);
-		put_page_bootmem(page);
-	} else {
-		free_reserved_page(page);
-	}
-}
-#else
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-
-static inline void register_page_bootmem_memmap(unsigned long section_nr,
-		struct page *map, unsigned long nr_pages)
-{
-}
-
-static inline void put_page_bootmem(struct page *page)
-{
-}
-
-static inline enum bootmem_type bootmem_type(const struct page *page)
-{
-	return SECTION_INFO;
-}
-
-static inline unsigned long bootmem_info(const struct page *page)
-{
-	return 0;
-}
-
-static inline void get_page_bootmem(unsigned long info, struct page *page,
-				    enum bootmem_type type)
-{
-}
-
-static inline void free_bootmem_page(struct page *page)
-{
-	free_reserved_page(page);
-}
-#endif
-
-#endif /* __LINUX_BOOTMEM_INFO_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 592003a258bad..169a3ba12a255 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -509,13 +509,6 @@ config EXCLUSIVE_SYSTEM_RAM
 	def_bool y
 	depends on !DEVMEM || STRICT_DEVMEM
 
-#
-# Only be set on architectures that have completely implemented memory hotplug
-# feature. If you are not sure, don't touch it.
-#
-config HAVE_BOOTMEM_INFO_NODE
-	def_bool n
-
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index 4fc713867b9bd..52428a3d3ae14 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -141,7 +141,6 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
deleted file mode 100644
index 0fa78db7fbc0b..0000000000000
--- a/mm/bootmem_info.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Bootmem core functions.
- *
- * Copyright (c) 2020, Bytedance.
- *
- *     Author: Muchun Song <songmuchun@bytedance.com>
- *
- */
-#include <linux/mm.h>
-#include <linux/compiler.h>
-#include <linux/memblock.h>
-#include <linux/bootmem_info.h>
-#include <linux/memory_hotplug.h>
-#include <linux/kmemleak.h>
-
-void get_page_bootmem(unsigned long info, struct page *page,
-		enum bootmem_type type)
-{
-	BUG_ON(type > 0xf);
-	BUG_ON(info > (ULONG_MAX >> 4));
-	set_page_private(page, info << 4 | type);
-	page_ref_inc(page);
-}
-
-void put_page_bootmem(struct page *page)
-{
-	enum bootmem_type type = bootmem_type(page);
-
-	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
-	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
-
-	if (page_ref_dec_return(page) == 1) {
-		set_page_private(page, 0);
-		free_reserved_page(page);
-	}
-}
-
-static void __init register_page_bootmem_info_section(unsigned long start_pfn)
-{
-	unsigned long section_nr;
-	struct mem_section *ms;
-
-	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
-	section_nr = pfn_to_section_nr(start_pfn);
-	ms = __nr_to_section(section_nr);
-
-	if (!preinited_vmemmap_section(ms))
-		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
-					     PAGES_PER_SECTION);
-}
-
-void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-	unsigned long pfn, end_pfn;
-	int node = pgdat->node_id;
-
-	pfn = pgdat->node_start_pfn;
-	end_pfn = pgdat_end_pfn(pgdat);
-
-	/* register section info */
-	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		/*
-		 * Some platforms can assign the same pfn to multiple nodes - on
-		 * node0 as well as nodeN.  To avoid registering a pfn against
-		 * multiple nodes we check that this pfn does not already
-		 * reside in some other nodes.
-		 */
-		if (pfn_valid(pfn) && (early_pfn_to_nid(pfn) == node))
-			register_page_bootmem_info_section(pfn);
-	}
-}

-- 
2.43.0

