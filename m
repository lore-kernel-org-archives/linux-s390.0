Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691997;
	b=TFasi/nEs1Bs0le3QEEF/OCQNuALh+92VMe5XWOuysCcltXKBhLXXd2NoYoNDmBvI0+6
	 Wj73xv0/F8QIpMYuiFgHxwgThWfHnNpvv2W2tC/Y7wR336cYf6O43SRfgK2RnPBAWMEoI
	 1X3WNSp9uqRuXX/CT8YNWjo+nYf3EqgNGaBg6U2nE5Is1iiwX4qXKpA7ybLJvH9Mnt/a7
	 pDcGXeP7WDv0jBI8XsEM36eJWXDIrUX9sBueksbHWxyhU/XFqvHgU6wtgcnxzKYWLhZum
	 QDd+UnyKlKjIT2h58//B3NnNb53cwieuhpzUM8rRQxOxJXW8QXEJ44uahDvhOIa+vcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691997;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=QjHPKIVW3NJ7hgK/PWATF9K0DetPjPAzIieyOSxd4IY=;
	b=FkvgGRPyjrH7yig6ntNcZNaIjTjRsyM1DQAr674DRZ8BVhWUKAdEOWuPnoIIam/3YSLu
	 y13uDdY3NX9L0G876qgMnFbLD1g8NJtA0bMaEgVpJOWFm2+p8imVkupmOu7LLvdiBZkNu
	 BQHCKru41X2WtLmakEyYUyt/q50PSetq/QYWtgRgvLsawLWsHEYz3vAtahr/uCwuCdVSA
	 A7nkZeof4jGPsUJhG3Ob+6z/2WWuYSt/NPQRCnld5cIV83G/On2Ypja7sNEjubuUYOeE9
	 iCEhRyRQlJRfswaoBEF8J6PiNIAL5393uiyPRCM8a5ptQzfrz6abUrk5P9EiQrK7sCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td7WQqa3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49868606A31C;
	Thu, 26 Nov 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Td7WQqa3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD1F1F000C0;
	Thu, 26 Nov 2026 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691996;
	bh=QjHPKIVW3NJ7hgK/PWATF9K0DetPjPAzIieyOSxd4IY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Td7WQqa3c7ClvHl+OoEBfCYgP/n9WHRuAztnd/C+dWFx/SKyzf+rot9DehsBhdEMR
	 XhXHzNONCqJnzktHcCzhsfRDZommDkcJRNBgrcK5izNOUg12XwVVEbLxKxPwcdg96C
	 Xl3Viw8y3ZSm0/uWV18pSGWunvgmjwPqYGaPkfo+V0AWmO70GciFkYKDvcqzBBfPed
	 ctZTYZalj6ONgdxp/Rpub5hd6TXezAF/ggB1Nb4/cI+LVmxeD4StvrlxIEMNlT+TVE
	 oOptv6/WnyWRCi5WfRuMwlrbjSFlyQfXsQ/Wxn6Hzybs66OymbziDAuPFND4Y1ib3g
	 lTQWRh5WHeHKQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:47 +0200
Subject: [PATCH RFC v2 34/54] LoongArch: stop pretending LoongArch supports
 set_direct_map APIs
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-34-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

LoongArch selects ARCH_HAS_SET_DIRECT_MAP and implements set_direct_map*()
APIs to allow coexistence of hibernation with KFENCE, see
commit f04de6d8f252 ("LoongArch: Add ARCH_HAS_SET_DIRECT_MAP support").

However, LoongArch does not have page tables for its direct map to begin
with. It maps the physical memory with a hardware window, so there is no
way to change the permissions of an individual page there.

Protection of KFENCE pages is handled outside the direct map: they are
mapped in the dedicated address space area and their virtual address is
explicitly set with set_page_address() to keep page_address() working for
those pages.

Selecting ARCH_HAS_SET_DIRECT_MAP enables secretmem on LoongArch, although
without the actual ability to modify the direct map, secretmem becomes a
limited memfd and does not provide the security it promises.

After the rework of the temporary mappings in the hibernation code [1],
there is no need for LoongArch to pretend it supports direct map
operations.

Remove the set_direct_map*() implementation and stop enabling
ARCH_HAS_SET_DIRECT_MAP.

Removing support for ARCH_HAS_SET_DIRECT_MAP effectively disables
secretmem, and memfd_secret() returns -ENOSYS on LoongArch.

[1] https://lore.kernel.org/all/20260917-hibernation-v1-4-7f7dfae3dbe0@kernel.org

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/loongarch/Kconfig                  |  1 -
 arch/loongarch/include/asm/set_memory.h |  4 ---
 arch/loongarch/mm/pageattr.c            | 60 ---------------------------------
 3 files changed, 65 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b5ed4881d3c0..bad699e2847f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -27,7 +27,6 @@ config LOONGARCH
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_SPECIAL if 64BIT
 	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_ARCH_DATA
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index 4bb01172fbc2..64c7f942e8ec 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -14,8 +14,4 @@ int set_memory_nx(unsigned long addr, int numpages);
 int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 
-bool kernel_page_present(struct page *page);
-int set_direct_map_default_noflush(struct page *page, unsigned int nr);
-int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
-
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index a728db40f9e0..7283059d6e1f 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -156,63 +156,3 @@ int set_memory_rw(unsigned long addr, int numpages)
 
 	return __set_memory(addr, numpages, __pgprot(_PAGE_WRITE | _PAGE_DIRTY), __pgprot(0));
 }
-
-bool kernel_page_present(struct page *page)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long addr = (unsigned long)page_address(page);
-
-	if (addr < vm_map_base)
-		return true;
-
-	pgd = pgd_offset_k(addr);
-	if (pgd_none(pgdp_get(pgd)))
-		return false;
-	if (pgd_leaf(pgdp_get(pgd)))
-		return true;
-
-	p4d = p4d_offset(pgd, addr);
-	if (p4d_none(p4dp_get(p4d)))
-		return false;
-	if (p4d_leaf(p4dp_get(p4d)))
-		return true;
-
-	pud = pud_offset(p4d, addr);
-	if (pud_none(pudp_get(pud)))
-		return false;
-	if (pud_leaf(pudp_get(pud)))
-		return true;
-
-	pmd = pmd_offset(pud, addr);
-	if (pmd_none(pmdp_get(pmd)))
-		return false;
-	if (pmd_leaf(pmdp_get(pmd)))
-		return true;
-
-	pte = pte_offset_kernel(pmd, addr);
-	return pte_present(ptep_get(pte));
-}
-
-int set_direct_map_default_noflush(struct page *page, unsigned int nr)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	if (addr < vm_map_base)
-		return 0;
-
-	return __set_memory(addr, nr, PAGE_KERNEL, __pgprot(0));
-}
-
-int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	if (addr < vm_map_base)
-		return 0;
-
-	return __set_memory(addr, nr, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
-}

-- 
2.53.0

