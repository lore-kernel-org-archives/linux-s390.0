Return-Path: <linux-kernel-owner+w=401wt.eu-S1751901AbYCLRvx@vger.kernel.org>
Subject: Re: [patch 09/10] Hugetlb common code update for System z.
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20080312173218.186436562@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173218.186436562@de.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 10:51:26 -0700
Message-Id: <1205344286.9828.91.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Gerald Schaefer <geraldsc@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 18:32 +0100, Martin Schwidefsky wrote:
> +#ifndef ARCH_HAS_HUGE_PTE_TYPE
> +#define huge_pte_none(pte)                     pte_none(pte)
> +#define huge_pte_wrprotect(pte)                        pte_wrprotect(pte)
> +#define huge_ptep_set_wrprotect(mm, addr, ptep)        \
> +       ptep_set_wrprotect(mm, addr, ptep)
> +#define huge_ptep_set_access_flags(vma, addr, ptep, pte, dirty)        \
> +       ptep_set_access_flags(vma, addr, ptep, pte, dirty)
> +#define huge_ptep_get(ptep)                    (*ptep)
> +#endif
> +
> +#ifndef ARCH_HAS_PREPARE_HUGEPAGE

Can you guys please do these defines in Kconfig instead of headers?  I
find them much easier to track down when I have one place to look,
rather than a mess of 14 other #includes in a arch-specific header. :)

I'm also a little concerned that you just #ifdef'd in about 44 new ptep
functions in here.  Have you carefully considered doing this in a way
that would fit in better with the other architectures?

> Huge ptes have a special type on s390 and cannot be handled with the
> standard pte functions in certain cases.

Can you elaborate a bit more on that?

-- Dave
