Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730252AbgIIM4d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 08:56:33 -0400
Date: Wed, 9 Sep 2020 13:16:38 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v4 00/13] mm/debug_vm_pgtable fixes
Message-ID: <20200909131638.4a95e806@thinkpad>
In-Reply-To: <87wo134h3s.fsf@linux.ibm.com>
References: <20200902114222.181353-1-aneesh.kumar@linux.ibm.com>
        <bb0f3427-e2bd-f713-3ea8-d264be0e690b@arm.com>
        <20200904172647.002113d3@thinkpad>
        <20200904180115.07ee5f00@thinkpad>
        <20200908173906.30fffaa0@thinkpad>
        <87wo134h3s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-riscv <linux-riscv@lists.infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vineet Gupta <vgupta@synopsys.com>

On Wed, 09 Sep 2020 11:38:39 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Gerald Schaefer <gerald.schaefer@linux.ibm.com> writes:
> 
> > On Fri, 4 Sep 2020 18:01:15 +0200
> > Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> >
> > [...]
> >> 
> >> BTW2, a quick test with this change (so far) made the issues on s390
> >> go away:
> >> 
> >> @@ -1069,7 +1074,7 @@ static int __init debug_vm_pgtable(void)
> >>         spin_unlock(ptl);
> >> 
> >>  #ifndef CONFIG_PPC_BOOK3S_64
> >> -       hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> >> +       hugetlb_advanced_tests(mm, vma, (pte_t *) pmdp, pmd_aligned, vaddr, prot);
> >>  #endif
> >> 
> >>         spin_lock(&mm->page_table_lock);
> >> 
> >> That would more match the "pte_t pointer" usage for hugetlb code,
> >> i.e. just cast a pmd_t pointer to it. Also changed to pmd_aligned,
> >> but I think the root cause is the pte_t pointer.
> >> 
> >> Not entirely sure though if that would really be the correct fix.
> >> I somehow lost whatever little track I had about what these tests
> >> really want to check, and if that would still be valid with that
> >> change.
> >
> > Uh oh, wasn't aware that this (or some predecessor) already went
> > upstream, and broke our debug kernel today.
> 
> Not sure i followed the above. Are you finding that s390 kernel crash
> after this patch series or the original patchset? As noted in my patch
> the hugetlb test is broken and we should fix that. A quick fix is to
> comment out that test for s390 too as i have done for PPC64.

We see it with both, it basically is broken since there is a hugetlb
test using real pte pointers. It doesn't always show, depending on
random vaddr, so it slipped through earlier testing.

I guess we also would have had one or the other chance to notice
that earlier, through better review, or better reading of previous
mails. I must admit that I neglected this a bit.
