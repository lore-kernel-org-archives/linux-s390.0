Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8E5335A0;
	Wed,  9 Sep 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952974; cv=none; b=DVjHnZpgcbU1lk6etTyB/UTopxaqLMyrCVLwF/X5r2lgX6kKWlLh4vIJFE86jEurHKs+aVfUHbvGFd6mc2kSDXNP6nQUMS2qcfJtQp5vBG1NzcbTG5E/NWlAAMNOedPnwVuqhD+jNxvR2ezbkQACs19VD4YXINJDrPkrgzUVx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952974; c=relaxed/simple;
	bh=kinm3Lg4z5yoRj1Tro37HQhxU5KP1NYaneCQVQniSFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6B6V9xdNrkLtwX/P/w1GIzjFTaIW+c24fufVzsqER0wd6BbXu/yZmMbozTsmvNgHdfMYDMZgxvqiUiYVTBkisBpvH4NsbTAk0EGFf9z5GrZCmSt0I6yPNJBmwsq+HIpWjH0/tpZJFhHGuNYmJpEU1Fq0PiHDC+85sopHYEV/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qhguwTuN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qhguwTuN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1duw2666182;
	Wed, 9 Sep 2026 11:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/8IaYv
	CFo6fz+OwPEEmckG3lCFihAL43nD3n3f2T7Gc=; b=qhguwTuN778X3cOaWWW1OU
	aeZ7AJr5+u/cvNAs7RIOnmqYZbMjHAKojx4nXE/wh5sMGNOH6xbbXBYRV6W5CP5m
	1LfKeLsLqhxoM/rtvfSFecMgjFvQaVkTmtglAbnTNxS9dCCPH/KKlDVi1+BNFW8b
	A4InRafmKCz6Cv0j8uRLUCdygzECd2S/44yMh+FBsFGBpXzX182KSY9KbjvUJx3R
	Y9u7hnBxycqsfJ6mB5bAL8bE1MRjX8qA9TLrZaAXWBKpiTNyT5Ad1gPC1O2J0Q1o
	sK1AZgxMslVpj/H1udTip6Q7YBFvLBe6aJ93X/kYeUNT6ud7ShMMaO3pvDg3tNaA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrw4cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 11:22:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689AfLZI023073;
	Wed, 9 Sep 2026 11:22:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk1xnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 11:22:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689BM9Ka46072296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 11:22:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D56142004B;
	Wed,  9 Sep 2026 11:22:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84D262004D;
	Wed,  9 Sep 2026 11:22:09 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  9 Sep 2026 11:22:09 +0000 (GMT)
Date: Wed, 9 Sep 2026 13:22:07 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
 <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Jonathan Corbet
 <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Mark Rutland
 <mark.rutland@arm.com>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Marc
 Zyngier <maz@kernel.org>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 27/39] mm: rename is_vm_hugetlb_page() to
 vma_is_hugetlb()
Message-ID: <20260909130141.2c5d250d@p-imbrenda>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-27-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
	<20260908-b4-mmap-prepare-vma-flag-sanify-v1-27-dacf19cce22b@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa14167 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OpMjZilIJQQ69o6v8fAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEyMiBTYWx0ZWRfXySxVHdsN1ufG
 wxjpHwj2VKPdL+MdVQie3JyfabMJU/26wLQwlGWO0QZf5MNW6jvmMiP9yN+m5dAuCWYjRliYhq4
 TcA4SKzj97ajqgowLAlPjKHLqae4ogE=
X-Proofpoint-ORIG-GUID: 9hCeolFJXa7mLi7YIHynK8hgkmct4qqF
X-Proofpoint-GUID: H6kaRUBVX1M87FU8LUMUUE3VPbQB106q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEyMiBTYWx0ZWRfXwfSodi+GpBAe
 EWgvlM2SUJLuFEu9GHXrLlP2p81ohn4dYO/6vEBPnJTS7AYCF12oOwWJKBdy11FngCnfzjafrml
 x7eCREr73cwTqFnu6IA00UumMxG+FNDgYEdClHlPwbc1pNySdmscuIEFgiyEscAMb5CvqHCngH4
 9etlThpWCx68gjVkvvt+o9hbhSMj/PU4F8xWzqFViAnbRaCUuf1D7Td9B3JQ4Vtu0fpb5dCBdIH
 aSEttzOvUQ4yhnFMkS4XYCLLFCOA4y1iHeW0G8CMS66W75wzs1pMgXqxvCQixpiQnCtN4jJpwxz
 MYPEBvggS/svZxLrh5QF1aQ4q+brQniNhqPP/TzsUGdpI+461ReTNyBLe9RDMDx4OF5Tcq5JaVY
 mAc/mvm2bod5UBNrSuH+QS/D5oV2zUf4Ngzn1gtQhCitsLJX3IgoC1sGFmMRvwFXIVDA1tW6YwN
 6ze7nzFRPTPgnrVQ3SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090122

On Tue, 08 Sep 2026 21:01:31 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

[please note that I had to prune the CC list quite aggressively because
my SMTP server was not happy]

> The is_vm_hugetlb_page() predicate is badly named - the mapping can span
> more than a page and it is inconsistent with other VMA predicates that
> typically are prefixed by vma_.
> 
> Rename to vma_is_hugetlb() for consistency, and while we're here update
> some VM_BUG_ON_VMA() to VM_WARN_ON_ONCE_VMA() as to avoid unnecessary
> oopses.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

for s390:

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

but please see the comment below

> ---
>  arch/arm64/kvm/mmu.c                      |  4 ++--
>  arch/powerpc/mm/book3s64/radix_tlb.c      |  6 +++---
>  arch/powerpc/mm/nohash/e500_hugetlbpage.c |  2 +-
>  arch/powerpc/mm/nohash/tlb.c              |  2 +-
>  arch/riscv/kvm/mmu.c                      |  2 +-
>  arch/riscv/mm/tlbflush.c                  |  2 +-
>  arch/s390/mm/gmap_helpers.c               |  6 +++---
>  arch/sparc/mm/init_64.c                   |  2 +-
>  drivers/gpu/drm/drm_gpusvm.c              |  2 +-
>  fs/coredump.c                             |  2 +-
>  fs/hugetlbfs/inode.c                      |  2 +-
>  fs/proc/task_mmu.c                        |  8 ++++----
>  include/asm-generic/tlb.h                 |  2 +-
>  include/linux/hugetlb.h                   |  4 ++--
>  include/linux/mm.h                        | 19 ++++++++++++++++---
>  include/linux/rmap.h                      |  2 +-
>  kernel/events/core.c                      |  2 +-
>  kernel/sched/fair.c                       |  2 +-
>  mm/gup.c                                  |  4 ++--
>  mm/huge_memory.c                          |  2 +-
>  mm/hugetlb.c                              | 14 +++++++-------
>  mm/internal.h                             |  2 +-
>  mm/madvise.c                              |  4 ++--
>  mm/memory.c                               | 12 ++++++------
>  mm/mempolicy.c                            |  2 +-
>  mm/migrate_device.c                       |  2 +-
>  mm/mmap.c                                 |  2 +-
>  mm/mmu_gather.c                           |  2 +-
>  mm/mprotect.c                             |  2 +-
>  mm/mremap.c                               |  6 +++---
>  mm/page_vma_mapped.c                      |  4 ++--
>  mm/pagewalk.c                             |  2 +-
>  mm/swapfile.c                             |  2 +-
>  mm/userfaultfd.c                          | 26 +++++++++++++-------------
>  mm/vma.c                                  |  8 ++++----
>  mm/vmscan.c                               |  2 +-
>  tools/testing/vma/include/stubs.h         |  2 +-
>  37 files changed, 92 insertions(+), 79 deletions(-)

[...]

> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index ff63ffb1dbd2..3f6783b93e67 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
> @@ -102,7 +102,7 @@ __context_unsafe(/* pte_unmap_unlock() not instrumented */)
>  
>  	/* Find the vm address for the guest address */
>  	vma = vma_lookup(mm, vmaddr);
> -	if (!vma || is_vm_hugetlb_page(vma))
> +	if (!vma || vma_is_hugetlb(vma))
>  		return;
>  
>  	/* Get pointer to the page table entry */
> @@ -139,7 +139,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
>  		vma = find_vma_intersection(mm, vmaddr, end);
>  		if (!vma)
>  			return;
> -		if (!is_vm_hugetlb_page(vma))
> +		if (!vma_is_hugetlb(vma))
>  			zap_vma_range(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
>  		vmaddr = vma->vm_end;
>  	}
> @@ -247,7 +247,7 @@ static int __gmap_helper_unshare_zeropages(struct mm_struct *mm)
>  		 * proof to catch unexpected zeropages in other mappings and
>  		 * fail.
>  		 */
> -		if ((vma->vm_flags & VM_PFNMAP) || is_vm_hugetlb_page(vma))
> +		if ((vma->vm_flags & VM_PFNMAP) || vma_is_hugetlb(vma))

Would it be possible to replace this ^ with !vma_can_gup() ?

(obviously not in this patch, since vma_can_gup() is only introduced at
the end of the series)

>  			continue;
>  		addr = vma->vm_start;
>  

[...]
