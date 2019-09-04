Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727544AbfIDUQe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 16:16:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84KBrUA082029
        for <linux-s390@vger.kernel.org>; Wed, 4 Sep 2019 16:16:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utjwhjkds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 16:16:33 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 4 Sep 2019 21:16:30 +0100
Date: Wed, 4 Sep 2019 22:16:18 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 1/1] mm/pgtable/debug: Add test validating architecture
 page table helpers
In-Reply-To: <1567497706-8649-2-git-send-email-anshuman.khandual@arm.com>
References: <1567497706-8649-1-git-send-email-anshuman.khandual@arm.com>
        <1567497706-8649-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190904221618.1b624a98@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 13:31:46 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This adds a test module which will validate architecture page table helpers
> and accessors regarding compliance with generic MM semantics expectations.
> This will help various architectures in validating changes to the existing
> page table helpers or addition of new ones.
> 
> Test page table and memory pages creating it's entries at various level are
> all allocated from system memory with required alignments. If memory pages
> with required size and alignment could not be allocated, then all depending
> individual tests are skipped.

This looks very useful, thanks. Of course, s390 is quite special and does
not work nicely with this patch (yet), mostly because of our dynamic page
table levels/folding. Still need to figure out what can be fixed in the arch
code and what would need to be changed in the test module. See below for some
generic comments/questions.

At least one real bug in the s390 code was already revealed by this, which
is very nice. In pmd/pud_bad(), we also check large pmds/puds for sanity,
instead of reporting them as bad, which is apparently not how it is expected.

[...]
> +/*
> + * Basic operations
> + *
> + * mkold(entry)			= An old and not a young entry
> + * mkyoung(entry)		= A young and not an old entry
> + * mkdirty(entry)		= A dirty and not a clean entry
> + * mkclean(entry)		= A clean and not a dirty entry
> + * mkwrite(entry)		= A write and not a write protected entry
> + * wrprotect(entry)		= A write protected and not a write entry
> + * pxx_bad(entry)		= A mapped and non-table entry
> + * pxx_same(entry1, entry2)	= Both entries hold the exact same value
> + */
> +#define VADDR_TEST	(PGDIR_SIZE + PUD_SIZE + PMD_SIZE + PAGE_SIZE)

Why is P4D_SIZE missing in the VADDR_TEST calculation?

[...]
> +
> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
> +static void pud_clear_tests(pud_t *pudp)
> +{
> +	memset(pudp, RANDOM_NZVALUE, sizeof(pud_t));
> +	pud_clear(pudp);
> +	WARN_ON(!pud_none(READ_ONCE(*pudp)));
> +}

For pgd/p4d/pud_clear(), we only clear if the page table level is present
and not folded. The memset() here overwrites the table type bits, so
pud_clear() will not clear anything on s390 and the pud_none() check will
fail.
Would it be possible to OR a (larger) random value into the table, so that
the lower 12 bits would be preserved?

> +
> +static void pud_populate_tests(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
> +{
> +	/*
> +	 * This entry points to next level page table page.
> +	 * Hence this must not qualify as pud_bad().
> +	 */
> +	pmd_clear(pmdp);
> +	pud_clear(pudp);
> +	pud_populate(mm, pudp, pmdp);
> +	WARN_ON(pud_bad(READ_ONCE(*pudp)));
> +}

This will populate the pud with a pmd pointer that does not point to the
beginning of the pmd table, but to the second entry (because of how
VADDR_TEST is constructed). This will result in failing pud_bad() check
on s390. Not sure why/how it works on other archs, but would it be possible
to align pmdp down to the beginning of the pmd table (and similar for the
other pxd_populate_tests)?

[...]
> +
> +	p4d_free(mm, saved_p4dp);
> +	pud_free(mm, saved_pudp);
> +	pmd_free(mm, saved_pmdp);
> +	pte_free(mm, (pgtable_t) virt_to_page(saved_ptep));

pgtable_t is arch-specific, and on s390 it is not a struct page pointer,
but a pte pointer. So this will go wrong, also on all other archs (if any)
where pgtable_t is not struct page.
Would it be possible to use pte_free_kernel() instead, and just pass
saved_ptep directly?

Regards,
Gerald
