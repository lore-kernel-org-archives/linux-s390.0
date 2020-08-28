Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbgH1OEE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Aug 2020 10:04:04 -0400
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table folding
Date: Fri, 28 Aug 2020 16:03:12 +0200
Message-Id: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi,

Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
code") introduced a subtle but severe bug on s390 with gup_fast, due to
dynamic page table folding.

The question "What would it require for the generic code to work for s390"
has already been discussed here
https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
and ended with a promising approach here
https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
which in the end unfortunately didn't quite work completely.

We tried to mimic static level folding by changing pgd_offset to always
dynamically calculate top level page table offset, and do nothing in folded
pXd_offset. What has been overlooked is that PxD_SIZE/MASK and thus
pXd_addr_end do not reflect this dynamic behaviour, and still act like
static 5-level page tables.

Here is an example of what happens with gup_fast on s390, for a task with
3-levels paging, crossing a 2 GB pud boundary:

// addr = 0x1007ffff000, end = 0x10080001000
static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
                         unsigned int flags, struct page **pages, int *nr)
{
        unsigned long next;
        pud_t *pudp;

        // pud_offset returns &p4d itself (a pointer to a value on stack)
        pudp = pud_offset(&p4d, addr);
        do {
                // on second iteratation reading "random" stack value
                pud_t pud = READ_ONCE(*pudp);

                // next = 0x10080000000
                next = pud_addr_end(addr, end);
                ...
        } while (pudp++, addr = next, addr != end); // pudp++ iterating over stack

        return 1;
}

pud_addr_end = 0x10080000000 is correct, but the previous pgd/p4d_addr_end
should also have returned that limit, instead of the 5-level static
pgd/p4d limits with PUD_SIZE/MASK != PGDIR_SIZE/MASK. Then the "end"
parameter for gup_pud_range would also have been 0x10080000000, and we
would not iterate further in gup_pud_range, but rather go back and
(correctly) do it in gup_pgd_range.

So, for the second iteration in gup_pud_range, we will increase pudp,
which pointed to a stack value and not the real pud table. This new pudp
will then point to whatever lies behind the p4d stack value. In general,
this happens to be the previously read pgd, but it probably could also
be something different, depending on compiler decisions.

Most unfortunately, if it happens to be the pgd value, which is the
same as the p4d / pud due to folding, it is a valid and present entry.
So after the increment, we would still point to the same pud entry.
The addr however has been increased in the second iteration, so that we
now have different pmd/pte_index values, which will result in very wrong
behaviour for the remaining gup_pmd/pte_range calls. We will effectively
operate on an address minus 2 GB, due to missing pudp increase.

In the "good case", if nothing is mapped there, we will fall back to
the slow gup path. But if something is mapped there, and valid
for gup_fast, we will end up (silently) getting references on the wrong
pages and also add the wrong pages to the **pages result array. This
can cause data corruption.

We came up with two possible fix-ups, both will introduce some gup-specific
helper functions, which will have no effect on other archs than s390.

Patch 1 is the solution that has already been discussed in
https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
It will additionally pass along pXd pointers in gup_pXd_range, and
also introduce pXd_offset_orig for s390, which takes an additional
pXd entry value parameter. This allows correctly returning / incrementing
pointers while still preseving the READ_ONCE logic for gup_fast.

Patch 2 would instead introduce new gup_pXd_addr_end helpers, which take
an additional pXd entry value parameter, that can be used on s390
to determine the correct page table level and return corresponding
end / boundary. With that, the pointer iteration will always
happen in gup_pgd_range.

Comments / preferences are welcome. As a last resort, we might also
revert back to the s390-specific gup_fast code, if none of the options
are agreeable.

Regards,
Gerald
