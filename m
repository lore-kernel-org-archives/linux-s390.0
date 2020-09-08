Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728786AbgIHHr5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 03:47:57 -0400
Date: Tue, 8 Sep 2020 09:46:38 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
Message-ID: <20200908074638.GA19099@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
 <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>

On Tue, Sep 08, 2020 at 07:14:38AM +0200, Christophe Leroy wrote:
> You forgot arch/powerpc/mm/book3s64/subpage_prot.c it seems.

Yes, and also two more sources :/
	arch/powerpc/mm/kasan/8xx.c
	arch/powerpc/mm/kasan/kasan_init_32.c

But these two are not quite obvious wrt pgd_addr_end() used
while traversing pmds. Could you please clarify a bit?


diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
index 2784224..89c5053 100644
--- a/arch/powerpc/mm/kasan/8xx.c
+++ b/arch/powerpc/mm/kasan/8xx.c
@@ -15,8 +15,8 @@
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd += 2, block += SZ_8M) {
 		pte_basic_t *new;
 
-		k_next = pgd_addr_end(k_cur, k_end);
-		k_next = pgd_addr_end(k_next, k_end);
+		k_next = pmd_addr_end(k_cur, k_end);
+		k_next = pmd_addr_end(k_next, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index fb29404..3f7d6dc6 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -38,7 +38,7 @@ int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_
 	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
 		pte_t *new;
 
-		k_next = pgd_addr_end(k_cur, k_end);
+		k_next = pmd_addr_end(k_cur, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
@@ -196,7 +196,7 @@ void __init kasan_early_init(void)
 	kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL);
 
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pmd_addr_end(addr, end);
 		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
 	} while (pmd++, addr = next, addr != end);
 

> Christophe
