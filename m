Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D537A85D;
	Thu,  3 Sep 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427732; cv=none; b=MZqToGCjX+NkKHhF6tTBbRG1WA1155k0Zez7r9bWD79EdYC4yvLaEibIjPct5dH8E/ZTbhdadZXDwNR41M/Bte1Az4NQvSFCmh+jc8iHnLqx586PkI563meZPv0VjMitRN1kLwveFSi6p3RxAy3XBvH8bnvoOXZqQV7PENQf8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427732; c=relaxed/simple;
	bh=lOmqYvYDGxHIIdEFIYrBkgi7YVx2wi6bhY4Djr20l9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ct6QTSyZTqjX1Rn3oRSJakT47To3zxIfqYkvAocVPOSUCcK30Sog4EBZgALRr779iJl9HxC+A+PIPatGuCcH5dRS36XDu8/ETbuH73qiFO1yGhatz7722Gq3HICMPYG+YtzU66BV2hDtEKf93yG60qrAIhiYVrz6Gan9a03sIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuTODBPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuTODBPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF7D1F000E9;
	Thu,  3 Sep 2026 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427729;
	bh=3Sp/feZ60kwJVUNV9WpeNBe06Kdx0yFCF5oVf+tC54E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GuTODBPw9gOFHb6gn8Qoh+D2IfIfBHS5UYb0MW3ZhYRfaJIcaMeEzd8hkEanV3DFS
	 8QSCf77guM1lPZXB0nx5YPI9eeK75ZQKEt3+uzza7Z12KbnqEBWcYZt/fbZ34tgbNw
	 BPY8K7sYvwRfp0g95IGgqttbc4zXMtXVObShUu3j6tmODPJNTAU3vMzwK+Ylpy6PW8
	 XzE7FzhgujevAYz+54VZdxzYlB+Ad63q60RejjzoigygqyO9HrH0+Jt0i1PKZuyM61
	 gkDDuNpi0UHPjRo/SGzJHlA1IfnjiyF/jGrXzSmQZe2mYP0GDPg/T51p5u5zRKd47L
	 jnWIumSMJ4B8Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 03 Sep 2026 12:28:27 +0300
Subject: [PATCH v3 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org>
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 Will Deacon <will@kernel.org>, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 loongarch@lists.linux.dev
X-Mailer: b4 0.17-dev

When set_direct_map APIs were introduced by the commit d253ca0c3865
("x86/mm/cpa: Add set_direct_map_*() functions") the single page
parameter made sense because the initial callers (vmalloc and
hibernation) had sets of unsorted struct pages that required changes of
their mappings in the direct map.

Since there is an increasing demand for direct map manipulation and it
is also desirable to be able to update larger physically contiguous
mappings, for example an entire large folio, extend set_direct_map APIs
to receive number of pages parameter.

As there is still only a handful of callers, change the existing
functions directly and update all the call sites rather than adding
wrappers for single page case.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/include/asm/set_memory.h     | 4 ++--
 arch/arm64/mm/pageattr.c                | 8 ++++----
 arch/loongarch/include/asm/set_memory.h | 4 ++--
 arch/loongarch/mm/pageattr.c            | 8 ++++----
 arch/riscv/include/asm/set_memory.h     | 4 ++--
 arch/riscv/mm/pageattr.c                | 8 ++++----
 arch/s390/include/asm/set_memory.h      | 4 ++--
 arch/s390/mm/pageattr.c                 | 8 ++++----
 arch/x86/include/asm/set_memory.h       | 4 ++--
 arch/x86/mm/pat/set_memory.c            | 8 ++++----
 include/linux/set_memory.h              | 6 ++++--
 kernel/power/snapshot.c                 | 4 ++--
 mm/secretmem.c                          | 6 +++---
 mm/vmalloc.c                            | 5 +++--
 14 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 90f61b17275e1..b07fd4e026eac 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -11,8 +11,8 @@ bool can_set_direct_map(void);
 
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
+int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bbe98ac9ad8c6..db8d60a84d144 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -251,7 +251,7 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
 {
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
 	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
@@ -260,10 +260,10 @@ int set_direct_map_invalid_noflush(struct page *page)
 		return 0;
 
 	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE, set_mask, clear_mask);
+				 PAGE_SIZE * numpages, set_mask, clear_mask);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
 {
 	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
@@ -272,7 +272,7 @@ int set_direct_map_default_noflush(struct page *page)
 		return 0;
 
 	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE, set_mask, clear_mask);
+				 PAGE_SIZE * numpages, set_mask, clear_mask);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index 55dfaefd02c8a..563aab92896e9 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -15,8 +15,8 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 
 bool kernel_page_present(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
-int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_default_noflush(struct page *page, unsigned int nr);
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index 614ccc7afccbe..43ad2a104f19d 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -198,24 +198,24 @@ bool kernel_page_present(struct page *page)
 	return pte_present(ptep_get(pte));
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 {
 	unsigned long addr = (unsigned long)page_address(page);
 
 	if (addr < vm_map_base)
 		return 0;
 
-	return __set_memory(addr, 1, PAGE_KERNEL, __pgprot(0));
+	return __set_memory(addr, nr, PAGE_KERNEL, __pgprot(0));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 {
 	unsigned long addr = (unsigned long)page_address(page);
 
 	if (addr < vm_map_base)
 		return 0;
 
-	return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
+	return __set_memory(addr, nr, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
 }
 
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index ef59e1716a2cf..db1d0ed82b696 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -40,8 +40,8 @@ static inline int set_kernel_memory(char *startp, char *endp,
 }
 #endif
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
+int set_direct_map_default_noflush(struct page *page, unsigned int nr);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 3f76db3d27699..20ef95b1d0c36 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -374,15 +374,15 @@ int set_memory_nx(unsigned long addr, int numpages)
 	return __set_memory(addr, numpages, __pgprot(0), __pgprot(_PAGE_EXEC));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 {
-	return __set_memory((unsigned long)page_address(page), 1,
+	return __set_memory((unsigned long)page_address(page), nr,
 			    __pgprot(0), __pgprot(_PAGE_PRESENT));
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 {
-	return __set_memory((unsigned long)page_address(page), 1,
+	return __set_memory((unsigned long)page_address(page), nr,
 			    PAGE_KERNEL, __pgprot(_PAGE_EXEC));
 }
 
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 94092f4ae7649..6b0aa9147ed8e 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -60,8 +60,8 @@ __SET_MEMORY_FUNC(set_memory_rox, SET_MEMORY_RO | SET_MEMORY_X)
 __SET_MEMORY_FUNC(set_memory_rwnx, SET_MEMORY_RW | SET_MEMORY_NX)
 __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
+int set_direct_map_default_noflush(struct page *page, unsigned int nr);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 1e202e3d08e75..7549543d62412 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -382,14 +382,14 @@ int __set_memory(unsigned long addr, unsigned long numpages, unsigned long flags
 	return rc;
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 {
-	return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEMORY_INV);
+	return __set_memory((unsigned long)page_to_virt(page), nr, SET_MEMORY_INV);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 {
-	return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEMORY_DEF);
+	return __set_memory((unsigned long)page_to_virt(page), nr, SET_MEMORY_DEF);
 }
 
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 4362c26aa992d..0c4235d159f48 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -86,8 +86,8 @@ int set_pages_wb(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
-int set_direct_map_invalid_noflush(struct page *page);
-int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
+int set_direct_map_default_noflush(struct page *page, unsigned int nr);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c38faf39ce152..4d07a9fbc43a7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2656,14 +2656,14 @@ static int __set_pages_np(struct page *page, int numpages, unsigned int cpa_flag
 	return __change_page_attr_set_clr(&cpa, 1);
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 {
-	return __set_pages_np(page, 1, 0);
+	return __set_pages_np(page, nr, 0);
 }
 
-int set_direct_map_default_noflush(struct page *page)
+int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 {
-	return __set_pages_p(page, 1, 0);
+	return __set_pages_p(page, nr, 0);
 }
 
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 3030d9245f5ac..0b77f1d7d8b9c 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -25,11 +25,13 @@ static inline int set_memory_rox(unsigned long addr, int numpages)
 #endif
 
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
-static inline int set_direct_map_invalid_noflush(struct page *page)
+static inline int set_direct_map_invalid_noflush(struct page *page,
+						 unsigned int nr)
 {
 	return 0;
 }
-static inline int set_direct_map_default_noflush(struct page *page)
+static inline int set_direct_map_default_noflush(struct page *page,
+						 unsigned int nr)
 {
 	return 0;
 }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index b209712cb2c3a..d5dba0e50b2eb 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -88,7 +88,7 @@ static inline int hibernate_restore_unprotect_page(void *page_address) {return 0
 static inline void hibernate_map_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		int ret = set_direct_map_default_noflush(page);
+		int ret = set_direct_map_default_noflush(page, 1);
 
 		if (ret)
 			pr_warn_once("Failed to remap page\n");
@@ -101,7 +101,7 @@ static inline void hibernate_unmap_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
-		int ret  = set_direct_map_invalid_noflush(page);
+		int ret  = set_direct_map_invalid_noflush(page, 1);
 
 		if (ret)
 			pr_warn_once("Failed to remap page\n");
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 384f5cfc457f9..6cbb8efc994a4 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -139,7 +139,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 			goto out;
 		}
 
-		err = set_direct_map_invalid_noflush(folio_page(folio, 0));
+		err = set_direct_map_invalid_noflush(folio_page(folio, 0), 1);
 		if (err) {
 			secretmem_unaccount_folio(state, folio);
 			folio_put(folio);
@@ -156,7 +156,7 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
-			set_direct_map_default_noflush(folio_page(folio, 0));
+			set_direct_map_default_noflush(folio_page(folio, 0), 1);
 			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
@@ -228,7 +228,7 @@ static int secretmem_migrate_folio(struct address_space *mapping,
 
 static void secretmem_free_folio(struct folio *folio)
 {
-	set_direct_map_default_noflush(folio_page(folio, 0));
+	set_direct_map_default_noflush(folio_page(folio, 0), 1);
 	folio_zero_segment(folio, 0, folio_size(folio));
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 41aa228d045a5..0380917392e68 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3364,14 +3364,15 @@ struct vm_struct *remove_vm_area(const void *addr)
 }
 
 static inline void set_area_direct_map(const struct vm_struct *area,
-				       int (*set_direct_map)(struct page *page))
+				       int (*set_direct_map)(struct page *page,
+							     unsigned int nr))
 {
 	unsigned long i;
 
 	/* HUGE_VMALLOC passes small pages to set_direct_map */
 	for (i = 0; i < area->nr_pages; i++)
 		if (page_address(area->pages[i]))
-			set_direct_map(area->pages[i]);
+			set_direct_map(area->pages[i], 1);
 }
 
 /*

-- 
2.53.0

