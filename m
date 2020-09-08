Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730833AbgIHPvu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 11:51:50 -0400
Date: Tue, 8 Sep 2020 17:48:59 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline
 functions
Message-ID: <20200908154859.GA11583@oc3871087118.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
 <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>

On Tue, Sep 08, 2020 at 07:19:38AM +0200, Christophe Leroy wrote:

[...]

> >diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >index 67ebc22cf83d..d9e7d16c2263 100644
> >--- a/include/linux/pgtable.h
> >+++ b/include/linux/pgtable.h
> >@@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
> >   */
> >  #ifndef pgd_addr_end
> >-#define pgd_addr_end(pgd, addr, end)					\
> >-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
> >-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> >-})
> >+#define pgd_addr_end pgd_addr_end
> 
> I think that #define is pointless, usually there is no such #define
> for the default case.

Default pgd_addr_end() gets overriden on s390 (arch/s390/include/asm/pgtable.h):

#define pgd_addr_end pgd_addr_end
static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
{
	return rste_addr_end_folded(pgd_val(pgd), addr, end);
}

> >+static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
> >+{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
> >+	return (__boundary - 1 < end - 1) ? __boundary : end;
> >+}
