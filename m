Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434A42FCD8;
	Thu, 16 Jul 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213514; cv=none; b=k+oDlSftOykPOlF4K4DO20MGPHawvxM0WmIfIqMadEVYf1fwvfh2Hyx0B4h5JEnM2viJ+Jzz8OfvxLQuRDm/kBkGPO1Z95/tItyAkUw3nOkd4Q8sy7Gt81fyfky4kdVayupqnBYCPiPzEWor04wY3C0N8NHbWzp6B+OnHY+srEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213514; c=relaxed/simple;
	bh=bYbnYw4Q+fyzvXm5U8U2YE/Pwe+Ip8G+aWc9fnijAv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jc7qYYAKeuaEj8Je4C+pxq3nPpwbNUDICo0Mr2bziJFEsm0q4zYGiSRbOwdcA3eq7Bd1zMyJX86St3ncDRj88pyTIhXW6BxJxCMj50rrRfWTbK6PfzfVsVDwtkKI+YqZMSWjIq18QHA+oLsyPKUsXuj3CiVkEhgNc2HuUXPUK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycdnm1d4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycdnm1d4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826A41F00A3D;
	Thu, 16 Jul 2026 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213512;
	bh=FtMdM//r+7Y276dxFFM47VzlAtz3XaD8jlXTCfCIVcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ycdnm1d42gWDnWDTRojKBNFdh5wn8uBF05tZnLmRs8D6bCVovGm6yJMGC0t9n7AF3
	 2MtyM/yRovly8/6vZYD80pdwY+uadMTSY5PpLij+IrGFn1v+aJE3Jao1wnjh/yfcum
	 Rze8Ce6AMCBKiYFlunDDKvd/cP6840lu4/NnhUw0OzLC67qbmVK2OcRMG82XzPaD1H
	 0m9Tr402Uzow6RFwe3QIjK8mKVs+Tv52BWwGCqojl9X6n6G+K6zg/Rj2zYPQefgKRM
	 TxhfM/wy14PKNydPBDFfgEP6QAkH7f1Ly9gi4oMUOnjop13CePyZ0y1FeOEl5nnxG0
	 +6OvgNjXlXVRg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:06 +0200
Subject: [PATCH v2 07/10] x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-7-4afc76c73d61@kernel.org>
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

CONFIG_HAVE_BOOTMEM_INFO_NODE now essentially doesn't do anything.

So let's remove support for CONFIG_HAVE_BOOTMEM_INFO_NODE.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c | 26 --------------------------
 mm/Kconfig            |  1 -
 2 files changed, 27 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 1b17dcf781e66..ab4c5a02326f7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,7 +33,6 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1286,16 +1285,6 @@ void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
 
 static struct kcore_list kcore_vsyscall;
 
-static void __init register_page_bootmem_info(void)
-{
-#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)
-	int i;
-
-	for_each_online_node(i)
-		register_page_bootmem_info_node(NODE_DATA(i));
-#endif
-}
-
 /*
  * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
  * Only the level which needs to be synchronized between all page-tables is
@@ -1358,14 +1347,6 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	/*
-	 * Must be done after boot memory is put on freelist, because here we
-	 * might set fields in deferred struct pages that have not yet been
-	 * initialized, and memblock_free_all() initializes all the reserved
-	 * deferred pages for us.
-	 */
-	register_page_bootmem_info();
-
 	/* Register memory areas for /proc/kcore */
 	if (get_gate_vma(&init_mm))
 		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
@@ -1564,13 +1545,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return err;
 }
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-void register_page_bootmem_memmap(unsigned long section_nr,
-				  struct page *start_page, unsigned long nr_pages)
-{
-}
-#endif
-
 void __meminit vmemmap_populate_print_last(void)
 {
 	if (p_start) {
diff --git a/mm/Kconfig b/mm/Kconfig
index f794a341d7422..592003a258bad 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -590,7 +590,6 @@ endchoice
 
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
-	select HAVE_BOOTMEM_INFO_NODE if X86_64
 	depends on MEMORY_HOTPLUG
 	select MIGRATION
 

-- 
2.43.0

