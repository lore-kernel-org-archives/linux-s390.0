Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731719AbgIHQvu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 12:51:50 -0400
Date: Tue, 8 Sep 2020 17:39:06 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v4 00/13] mm/debug_vm_pgtable fixes
Message-ID: <20200908173906.30fffaa0@thinkpad>
In-Reply-To: <20200904180115.07ee5f00@thinkpad>
References: <20200902114222.181353-1-aneesh.kumar@linux.ibm.com>
        <bb0f3427-e2bd-f713-3ea8-d264be0e690b@arm.com>
        <20200904172647.002113d3@thinkpad>
        <20200904180115.07ee5f00@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-riscv <linux-riscv@lists.infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vineet Gupta <vgupta@synopsys.com>

On Fri, 4 Sep 2020 18:01:15 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[...]
> 
> BTW2, a quick test with this change (so far) made the issues on s390
> go away:
> 
> @@ -1069,7 +1074,7 @@ static int __init debug_vm_pgtable(void)
>         spin_unlock(ptl);
> 
>  #ifndef CONFIG_PPC_BOOK3S_64
> -       hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> +       hugetlb_advanced_tests(mm, vma, (pte_t *) pmdp, pmd_aligned, vaddr, prot);
>  #endif
> 
>         spin_lock(&mm->page_table_lock);
> 
> That would more match the "pte_t pointer" usage for hugetlb code,
> i.e. just cast a pmd_t pointer to it. Also changed to pmd_aligned,
> but I think the root cause is the pte_t pointer.
> 
> Not entirely sure though if that would really be the correct fix.
> I somehow lost whatever little track I had about what these tests
> really want to check, and if that would still be valid with that
> change.

Uh oh, wasn't aware that this (or some predecessor) already went
upstream, and broke our debug kernel today.

I found out now what goes (horribly) wrong on s390, see below for
more details. In short, using hugetlb primitives with ptep pointers
that do _not_ point to a pmd or pud entry will not work on s390.
It also seems to make no sense to verify / test such a thing in general,
as it would also be a severe bug if any kernel code would do that.
After all, with hugepages, there are no pte tables, only pmd etc.
tables.

My change above would fix the issue for s390, but I can still not
completely judge if that would not break other things for your
tests. In general, for normal kernel code, much of what you do would
be very broken, but I guess your tests are doing such "special" things
because they can. E.g. because they operate on some "sandbox" mm
and page tables, and you also do not need properly populated page
tables for some exit / free cleanup, you just throw them away
explicitly with pXd_free at the end. So it might just be "the right
thing" to pass a casted pmd pointer to hugetlb_advanced_tests(),
to simulate and test (proper) usage of the hugetlb primitives.
I also see no other way to make this work for s390, than using a
proper pmd/pud pointer. If not possible, please add us to the
#ifndef.

So, for all those interested, here is what goes wrong on s390.
huge_ptep_get_and_clear() uses the "idte" instruction for the
clearing (and TLB invalidation) part. That instruction expects
a "region or segment table" origin, which is a pmd/pud/p4d/pgd,
but not a pte table. Even worse, when we calculate the table
origin from the given ptep (which *should* not point to a pte),
due to different table sizes for pte / pXd tables, we end up
at some place before the given pte table.

The "idte" instruction also gets the virtual address, and does
corresponding index addition to the given table origin. Depending
on the pmd_index we now end up either within the pte table again,
in which case we see a panic because idte complains about seeing
a pte value. If we are unlucky, then we end up outside the pte
table, and depending on the content of that memory location, idte
might succeed, effectively corrupting that memory.

That explains why we only see the panic sometimes, depending on
random vaddr, other symptoms other times, and probably completely
silent memory corruption for the rest...
