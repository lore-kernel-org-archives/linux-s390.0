Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39161 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFUoq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 15:44:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id e13so2746404qts.6
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 12:44:45 -0800 (PST)
Message-ID: <1583527481.7365.165.camel@lca.pw>
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
From: Qian Cai <cai@lca.pw>
Date: Fri, 06 Mar 2020 15:44:41 -0500
In-Reply-To: <1583452659-11801-1-git-send-email-anshuman.khandual@arm.com>
References: <1583452659-11801-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>

On Fri, 2020-03-06 at 05:27 +0530, Anshuman Khandual wrote:
> This adds tests which will validate architecture page table helpers and
> other accessors in their compliance with expected generic MM semantics.
> This will help various architectures in validating changes to existing
> page table helpers or addition of new ones.
> 
> This test covers basic page table entry transformations including but not
> limited to old, young, dirty, clean, write, write protect etc at various
> level along with populating intermediate entries with next page table page
> and validating them.
> 
> Test page table pages are allocated from system memory with required size
> and alignments. The mapped pfns at page table levels are derived from a
> real pfn representing a valid kernel text symbol. This test gets called
> inside kernel_init() right after async_synchronize_full().
> 
> This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
> architecture, which is willing to subscribe this test will need to select
> ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
> and ppc32 platforms where the test is known to build and run successfully.
> Going forward, other architectures too can subscribe the test after fixing
> any build or runtime problems with their page table helpers. Meanwhile for
> better platform coverage, the test can also be enabled with CONFIG_EXPERT
> even without ARCH_HAS_DEBUG_VM_PGTABLE.
> 
> Folks interested in making sure that a given platform's page table helpers
> conform to expected generic MM semantics should enable the above config
> which will just trigger this test during boot. Any non conformity here will
> be reported as an warning which would need to be fixed. This test will help
> catch any changes to the agreed upon semantics expected from generic MM and
> enable platforms to accommodate it thereafter.

OK, I get this working on powerpc hash MMU as well, so this?

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 64d0f9b15c49..c527d05c0459 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -22,8 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |  powerpc/32: |  ok  |
-    |  powerpc/64: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2e7eee523ba1..176930f40e07 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -116,7 +116,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
-	select ARCH_HAS_DEBUG_VM_PGTABLE if PPC32
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 96a91bda3a85..98990a515268 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -256,7 +256,8 @@ static void __init pte_clear_tests(struct mm_struct *mm,
pte_t *ptep,
 	pte_t pte = READ_ONCE(*ptep);
 
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
-	WRITE_ONCE(*ptep, pte);
+	set_pte_at(mm, vaddr, ptep, pte);
+	barrier();
 	pte_clear(mm, vaddr, ptep);
 	pte = READ_ONCE(*ptep);
 	WARN_ON(!pte_none(pte));
