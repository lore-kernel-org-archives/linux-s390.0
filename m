Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731430AbgIHQKa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 12:10:30 -0400
Date: Tue, 8 Sep 2020 16:25:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
Message-ID: <20200908142529.GB20558@oc3871087118.ibm.com>
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
[...]
> You forgot arch/powerpc/mm/book3s64/subpage_prot.c it seems.

If this one would be okay?

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 60c6ea16..3690d22 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -88,6 +88,7 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 static void subpage_prot_clear(unsigned long addr, unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
+	pmd_t *pmd = pmd_off(mm, addr);
 	struct subpage_prot_table *spt;
 	u32 **spm, *spp;
 	unsigned long i;
@@ -103,8 +104,8 @@ static void subpage_prot_clear(unsigned long addr, unsigned long len)
 	limit = addr + len;
 	if (limit > spt->maxaddr)
 		limit = spt->maxaddr;
-	for (; addr < limit; addr = next) {
-		next = pmd_addr_end(addr, limit);
+	for (; addr < limit; addr = next, pmd++) {
+		next = pmd_addr_end(*pmd, addr, limit);
 		if (addr < 0x100000000UL) {
 			spm = spt->low_prot;
 		} else {
@@ -191,6 +192,7 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
 		unsigned long, len, u32 __user *, map)
 {
 	struct mm_struct *mm = current->mm;
+	pmd_t *pmd = pmd_off(mm, addr);
 	struct subpage_prot_table *spt;
 	u32 **spm, *spp;
 	unsigned long i;
@@ -236,8 +238,8 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
 	}
 
 	subpage_mark_vma_nohuge(mm, addr, len);
-	for (limit = addr + len; addr < limit; addr = next) {
-		next = pmd_addr_end(addr, limit);
+	for (limit = addr + len; addr < limit; addr = next, pmd++) {
+		next = pmd_addr_end(*pmd, addr, limit);
 		err = -ENOMEM;
 		if (addr < 0x100000000UL) {
 			spm = spt->low_prot;

Thanks!

> Christophe
