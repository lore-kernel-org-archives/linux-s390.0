Return-Path: <linux-kernel-owner+w=401wt.eu-S1756090AbYCLXRg@vger.kernel.org>
Subject: Re: [patch 09/10] Hugetlb common code update for System z.
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reply-To: gerald.schaefer@de.ibm.com
In-Reply-To: <1205344286.9828.91.camel@nimitz.home.sr71.net>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173218.186436562@de.ibm.com>
	 <1205344286.9828.91.camel@nimitz.home.sr71.net>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 00:18:57 +0100
Message-Id: <1205363937.5237.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 10:51 -0700, Dave Hansen wrote:
> > +#ifndef ARCH_HAS_HUGE_PTE_TYPE
> > +#define huge_pte_none(pte)                     pte_none(pte)
> > +#define huge_pte_wrprotect(pte)                        pte_wrprotect(pte)
> > +#define huge_ptep_set_wrprotect(mm, addr, ptep)        \
> > +       ptep_set_wrprotect(mm, addr, ptep)
> > +#define huge_ptep_set_access_flags(vma, addr, ptep, pte, dirty)        \
> > +       ptep_set_access_flags(vma, addr, ptep, pte, dirty)
> > +#define huge_ptep_get(ptep)                    (*ptep)
> > +#endif
> > +
> > +#ifndef ARCH_HAS_PREPARE_HUGEPAGE
> 
> Can you guys please do these defines in Kconfig instead of headers?  I
> find them much easier to track down when I have one place to look,
> rather than a mess of 14 other #includes in a arch-specific header. :)

There are already several ARCH_HAS_xxx defines which are being used in
inlude/linux/hugetlb.h. All of them are defined in
include/asm-<arch>/page.h for every architecture that needs them (with
the exception of powerpc, where it is include/asm-powerpc/page_64.h).
So there is already one place to look for them, and so we put our
defines into include/asm-s390/page.h.

> I'm also a little concerned that you just #ifdef'd in about 44 new ptep
> functions in here.  Have you carefully considered doing this in a way
> that would fit in better with the other architectures?

Other architectures should not be affected at all. Because of the
#ifdef, the new ptep functions are either a nop for them or just the
same as they were before our patch.

> > Huge ptes have a special type on s390 and cannot be handled with the
> > standard pte functions in certain cases.
> 
> Can you elaborate a bit more on that?

Large ptes are not really ptes but segment table entries (pmd entries),
in our case. This is similar to other architectures with hardware large
page support, because there simply is no page table level (and thus no
ptes) anymore. Unfortunately, the hugetlbfs common code does not
consider that discrepancy and just uses a standard pte_t and standard
pte functions, probably because it did not really make a difference on
other architectures.

On s390, a segment table entry (pmd) type is different from a pte type
mainly in the location of its invalid bit. This means that we cannot
use pte_none(), pte_wrprotect() and similar functions for large ptes,
which was the reason for the new huge_pte functions that we introduced.

--
Gerald Schaefer
