Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC4364E9A;
	Sun, 23 Aug 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787485644; cv=none; b=PJZHrAuipaUu7Wobz1koSnOjG88k2f6VgT8LFDpemtPAH5sWvyjp3JmPdb+y5VDdUHsSmRjpiA6+JYnCn8DsKIM2b2HA9NWrFbUoWC9hYmGoadCQxFYuNZWLKjDcHkzdBRkEix497oUYr5T/v8d/Dfg64x4zNHLl+mzjlZPRcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787485644; c=relaxed/simple;
	bh=MNRjvTTt8IfwZwVvv6zFQE87itIn91NumGhXUwn8QgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzAiXFNeMF3OHjn5ae+2TzOxsOoxau/BWfbKCntuRsh/zoQb2YTWQQGbf7eX3lNze+RmqjGWBsInlu8OwNCvzVqdPSI4nxdV51C3+5ZSBIlZQA3A9Xl5Cqe0m80DR9pJH5BWs+xXhCQyEbSPM23EdIiVfYYS2VWzT/JX+YfIOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR+EPnx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR+EPnx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556CD1F000E9;
	Sun, 23 Aug 2026 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787485641;
	bh=rfbXl9VbJJ1Sdgb3CrdMLA7PizvK3A5LrpuhhYPyjKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GR+EPnx5JjY2y6j2cwBoRe0ZQZtjiH2t4gW4CnhBU2dF6EGQ33O3EG4r/XGhlIllJ
	 Nst1G2RRcvVnDgOs+kdrsPo+ejiCqMxSMT3q8IasWBptn0CaCORZMotXXqGrNG+dyU
	 4lt9XqVoCJW6Q53Y3KDib+kzow6QjVst9U8Sj9RsiHQw5+cRbFos337JWxSqAryu4+
	 u8qU9iTiUiyiI0D7T4HZ4fgUXdy1voMsKSF/kTKGtA5hn5O/8+OQoRG+vrG+RsA5kw
	 JqABmzemuKva4V8kAFXy8rgAovNcAraYmYYzFnwEJZTx4MnIBVew+F1qpb8B85epVg
	 bwj5C14j/M9KQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 23 Aug 2026 14:46:17 +0300
Subject: [PATCH v2 6/6] Revert "arch: introduce
 set_direct_map_valid_noflush()"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-execmem-set-vm-perms-v0-2-v2-6-b013a37d84b3@kernel.org>
References: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
In-Reply-To: <20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org>
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

Commit 0c6378a71574 ("arch: introduce set_direct_map_valid_noflush()")
added set_direct_map_valid_noflush() to allow updating the direct map
for a physically contiguous range in execmem.

As Brendan recently pointed out [1], this API is confusing because on
arm64 it means that is sets VALID bit in ptes, while on other
architectures it is an analog of set_direct_map_default_noflush().

The only user of set_direct_map_valid_noflush() was execmem's ROX cache
freeing path and it was switched to utilize VM_FLUSH_RESET_PERMS for
resetting permissions of the direct map alias.

With the last user gone and with set_direct_map_{invalid,default}_noflush()
accepting number of pages as a parameter, set_direct_map_valid_noflush()
become a copy of set_memory_valid() on arm64 and a duplicate of
set_direct_map_{invalid,default}_noflush() on other architecture, it is
safe to remove set_direct_map_valid_noflush().

Also drop a stale comment in arm64::__kernel_map_pages() that Linus
bothered to add when merging changes containing set_direct_map_valid_noflush()
to his tree.

This reverts commit 0c6378a71574daa6cd1534ad42a956e3262756c7.

[1] https://lore.kernel.org/all/DJ69RCVRBO0Y.3JCYSW50IC4RC@linux.dev

Reviewed-by: Brendan Jackman <brendan.jackman@linux.dev>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/include/asm/set_memory.h     |  1 -
 arch/arm64/mm/pageattr.c                | 16 ----------------
 arch/loongarch/include/asm/set_memory.h |  1 -
 arch/loongarch/mm/pageattr.c            | 19 -------------------
 arch/riscv/include/asm/set_memory.h     |  1 -
 arch/riscv/mm/pageattr.c                | 15 ---------------
 arch/s390/include/asm/set_memory.h      |  1 -
 arch/s390/mm/pageattr.c                 | 12 ------------
 arch/x86/include/asm/set_memory.h       |  1 -
 arch/x86/mm/pat/set_memory.c            |  8 --------
 include/linux/set_memory.h              |  6 ------
 11 files changed, 81 deletions(-)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index b07fd4e026ea..0091ba12200e 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -13,7 +13,6 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
 int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index db8d60a84d14..132938b32eb1 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -355,23 +355,7 @@ int realm_register_memory_enc_ops(void)
 	return arm64_mem_crypt_ops_register(&realm_crypt_ops);
 }
 
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	if (!can_set_direct_map())
-		return 0;
-
-	return set_memory_valid(addr, nr, valid);
-}
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
-/*
- * This is - apart from the return value - doing the same
- * thing as the new set_direct_map_valid_noflush() function.
- *
- * Unify? Explain the conceptual differences?
- */
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	if (!can_set_direct_map())
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index 563aab92896e..4bb01172fbc2 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -17,6 +17,5 @@ int set_memory_rw(unsigned long addr, int numpages);
 bool kernel_page_present(struct page *page);
 int set_direct_map_default_noflush(struct page *page, unsigned int nr);
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index 43ad2a104f19..a7dcff40f759 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -217,22 +217,3 @@ int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 
 	return __set_memory(addr, nr, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
 }
-
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-	pgprot_t set, clear;
-
-	if (addr < vm_map_base)
-		return 0;
-
-	if (valid) {
-		set = PAGE_KERNEL;
-		clear = __pgprot(0);
-	} else {
-		set = __pgprot(0);
-		clear = __pgprot(_PAGE_PRESENT | _PAGE_VALID);
-	}
-
-	return __set_memory(addr, nr, set, clear);
-}
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index db1d0ed82b69..e9f9960c1947 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -42,7 +42,6 @@ static inline int set_kernel_memory(char *startp, char *endp,
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
 int set_direct_map_default_noflush(struct page *page, unsigned int nr);
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 20ef95b1d0c3..5b3cf326455d 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -386,21 +386,6 @@ int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 			    PAGE_KERNEL, __pgprot(_PAGE_EXEC));
 }
 
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
-{
-	pgprot_t set, clear;
-
-	if (valid) {
-		set = PAGE_KERNEL;
-		clear = __pgprot(_PAGE_EXEC);
-	} else {
-		set = __pgprot(0);
-		clear = __pgprot(_PAGE_PRESENT);
-	}
-
-	return __set_memory((unsigned long)page_address(page), nr, set, clear);
-}
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
 {
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 6b0aa9147ed8..e3562bf0c1aa 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -62,7 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
 int set_direct_map_default_noflush(struct page *page, unsigned int nr);
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 #endif
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 02d992b251cb..f46a666bc5c7 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -397,18 +397,6 @@ int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 	return __set_memory((unsigned long)page_to_virt(page), nr, SET_MEMORY_DEF);
 }
 
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
-{
-	unsigned long flags;
-
-	if (valid)
-		flags = SET_MEMORY_DEF;
-	else
-		flags = SET_MEMORY_INV;
-
-	return __set_memory((unsigned long)page_to_virt(page), nr, flags);
-}
-
 bool kernel_page_present(struct page *page)
 {
 	unsigned long addr;
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 0c4235d159f4..39271a5ea925 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -88,7 +88,6 @@ int set_pages_rw(struct page *page, int numpages);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
 int set_direct_map_default_noflush(struct page *page, unsigned int nr);
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 9022354e26e9..a6b2912a4837 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2683,14 +2683,6 @@ int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 	return __set_pages_p(page, nr);
 }
 
-int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
-{
-	if (valid)
-		return __set_pages_p(page, nr);
-
-	return __set_pages_np(page, nr);
-}
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 0b77f1d7d8b9..3fe293cfed8c 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -36,12 +36,6 @@ static inline int set_direct_map_default_noflush(struct page *page,
 	return 0;
 }
 
-static inline int set_direct_map_valid_noflush(struct page *page,
-					       unsigned nr, bool valid)
-{
-	return 0;
-}
-
 static inline bool kernel_page_present(struct page *page)
 {
 	return true;

-- 
2.53.0

