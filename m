Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729860AbgIIMSm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 08:18:42 -0400
Date: Wed, 9 Sep 2020 13:10:01 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v4 00/13] mm/debug_vm_pgtable fixes
Message-ID: <20200909131001.7b733b3e@thinkpad>
In-Reply-To: <ac85fd77-bca1-3318-de0e-eea40558cbbd@arm.com>
References: <20200902114222.181353-1-aneesh.kumar@linux.ibm.com>
        <bb0f3427-e2bd-f713-3ea8-d264be0e690b@arm.com>
        <20200904172647.002113d3@thinkpad>
        <20200904180115.07ee5f00@thinkpad>
        <ac85fd77-bca1-3318-de0e-eea40558cbbd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-riscv <linux-riscv@lists.infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vineet Gupta <vgupta@synopsys.com>

On Wed, 9 Sep 2020 13:45:48 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

[...]
> > 
> > That would more match the "pte_t pointer" usage for hugetlb code,
> > i.e. just cast a pmd_t pointer to it. Also changed to pmd_aligned,
> > but I think the root cause is the pte_t pointer.
> 
> Ideally, the pte_t pointer used here should be from huge_pte_alloc()
> not from pte_alloc_map_lock() as the case currently.

Ah, good point. I assumed that this would also always return casted
pmd etc. pointers, and never pte pointers. Unfortunately, that doesn't
seem to be true for all architectures, e.g. ia64, parisc, (some) powerpc,
where they really do a pte_alloc_map() for some reason.

I guess that means you cannot simply cast the pmd pointer, as suggested,
although I really do not understand how any architecture can work with
real ptes for hugepages. But that's fair, s390 also does some things that
nobody would expect or understand for other architectures...

So, for using huge_pte_alloc() you'd also need some size, maybe
iterating over hstates with for_each_hstate() could be an option,
if they are already initialized at that point. Then you have the
size(s) with huge_page_size(hstate) and can actually call the
hugetlb tests for all supported sizes, and with proper pointer
from huge_pte_alloc().
