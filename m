Return-Path: <linux-kernel-owner+w=401wt.eu-S1755362AbYCLXsv@vger.kernel.org>
Date: Wed, 12 Mar 2008 16:43:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 09/10] Hugetlb common code update for System z.
Message-Id: <20080312164303.cac9cab5.akpm@linux-foundation.org>
In-Reply-To: <1205363937.5237.60.camel@localhost.localdomain>
References: <20080312173155.703966894@de.ibm.com>
	<20080312173218.186436562@de.ibm.com>
	<1205344286.9828.91.camel@nimitz.home.sr71.net>
	<1205363937.5237.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: gerald.schaefer@de.ibm.com
Cc: haveblue@us.ibm.com, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 13 Mar 2008 00:18:57 +0100
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> On Wed, 2008-03-12 at 10:51 -0700, Dave Hansen wrote:
> > > +#ifndef ARCH_HAS_HUGE_PTE_TYPE
> > > +#define huge_pte_none(pte)                     pte_none(pte)
> > > +#define huge_pte_wrprotect(pte)                        pte_wrprotect(pte)
> > > +#define huge_ptep_set_wrprotect(mm, addr, ptep)        \
> > > +       ptep_set_wrprotect(mm, addr, ptep)
> > > +#define huge_ptep_set_access_flags(vma, addr, ptep, pte, dirty)        \
> > > +       ptep_set_access_flags(vma, addr, ptep, pte, dirty)
> > > +#define huge_ptep_get(ptep)                    (*ptep)
> > > +#endif
> > > +
> > > +#ifndef ARCH_HAS_PREPARE_HUGEPAGE
> > 
> > Can you guys please do these defines in Kconfig instead of headers?  I
> > find them much easier to track down when I have one place to look,
> > rather than a mess of 14 other #includes in a arch-specific header. :)
> 
> There are already several ARCH_HAS_xxx defines which are being used in
> inlude/linux/hugetlb.h. All of them are defined in
> include/asm-<arch>/page.h for every architecture that needs them (with
> the exception of powerpc, where it is include/asm-powerpc/page_64.h).

Yes, but that's fugly and it would be better to put in place the
infrastructure for cleaning it up, rather than worsening it.

So...

Put this:

+#define huge_pte_none(pte)			pte_none(pte)
+#define huge_pte_wrprotect(pte)			pte_wrprotect(pte)
+#define huge_ptep_set_wrprotect(mm, addr, ptep)	\
+	ptep_set_wrprotect(mm, addr, ptep)
+#define huge_ptep_set_access_flags(vma, addr, ptep, pte, dirty)	\
+	ptep_set_access_flags(vma, addr, ptep, pte, dirty)
+#define huge_ptep_get(ptep)			(*ptep)

into include/asm-generic/hugetlb.h

then for each architecture except s390 add an include/asm-foo/hugetlb.h
which does

#include <asm-generic/hugetlb.h>

then in include/linux/hugetlb.h add

#include <asm/hugetlb.h>

and then in include/asm-s390/hugetlb.h, add your s390-specific versions of
huge_pte_none() and friends.

later, someone can hopefully use this new infrastructure to rid us of
ARCH_HAS_HUGEPAGE_ONLY_RANGE, ARCH_HAS_HUGETLB_FREE_PGD_RANGE,
ARCH_HAS_PREPARE_HUGEPAGE_RANGE, ARCH_HAS_SETCLEAR_HUGE_PTE and
ARCH_HAS_HUGETLB_PREFAULT_HOOK.
