Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C376BE7D0C4
	for <linux-s390@archiver.kernel.org>; Fri, 22 Sep 2023 02:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjIVCzS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Sep 2023 22:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjIVCzQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Sep 2023 22:55:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EB197
        for <linux-s390@vger.kernel.org>; Thu, 21 Sep 2023 19:54:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690f8e63777so418217b3a.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Sep 2023 19:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695351286; x=1695956086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=br+/C/v821nNYRFlkBHOr44NAy7oCmXwb/N/stsA46I=;
        b=iieGcXJyMSUNUOMFkMI8NGO223qUzApef48rY6IMCTl3FpfdAFBmg5wjFjgydijixc
         yUkTmPo15sAqVGkpS0PVBltlbJZBgT8FJ/X2ufRYw6f4kRGmuHxg3AiiTPtZGaNZoXa1
         787dxbAJXnJdRTESFaKdsWgYgbN3/3hZWlqxbUWPBaGbCXWxg9LbY53FVrUhWitM7iSg
         dQYjccukqgfMz4GpYXdIky1R+hNKPDgHcDcoKwiLK+lXG3maGfYtd9o17AyQpysZCZvk
         eoHqp0rWQ0qhLpdUMTjRmM+z+VQhaG6iMSMFRzabmAZu0R0aozWtjTdIhwwKkjHJ1sPh
         7AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695351286; x=1695956086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=br+/C/v821nNYRFlkBHOr44NAy7oCmXwb/N/stsA46I=;
        b=u4iIGgh5eD+U0yCR+NO9VRTktyS0cYZEuryeqZlf6Fc+No/5i3BFDcgFG/eThVYKyE
         rzpI9xNjoWDxVZPeSkq82eAiHCRnt1EKiZ55MrYpvd1pn51pR0fVrJVSCjKU8ZYivxQd
         sqPzEbsNcm31DJQxIRaS8WiiH1hEF7X6bsA8DY/1+MmLi1twylslT3jU+BPOZrbwe0Ve
         IEpqJjeAp1lhB7BsY8BJ2GWUZF2OwVP/gmCN1Hd0Rl820zOHjp2fFbBINlvQW0yB5PUJ
         q8rwxVkjztKXesQPo0rrWgKKlcatjkdhUL7INAwc8PM9JWJR2K4DqET/ksQkb0rRO2u/
         tS9A==
X-Gm-Message-State: AOJu0YxlXQAyYk/e/LF+u/BEpYZ6TLr3L1DmKMXWpqJLq+bG5xlZtu1I
        wq8K99ipT1kZNlqLkp08YK7+gQ==
X-Google-Smtp-Source: AGHT+IE6azF5uKJJ3m1Yb0ly5UPZHOK7EZhY5CJWIi1/96fWzCl6d26UEkh5dqVknV//4FTGeJthoQ==
X-Received: by 2002:a05:6a20:c1aa:b0:15c:b7ba:e9ba with SMTP id bg42-20020a056a20c1aa00b0015cb7bae9bamr6999312pzb.0.1695351285575;
        Thu, 21 Sep 2023 19:54:45 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id gp24-20020a17090adf1800b00268032f6a64sm3855746pjb.25.2023.09.21.19.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 19:54:45 -0700 (PDT)
Message-ID: <217bb956-b9f6-1057-914b-436d4c775a8b@bytedance.com>
Date:   Fri, 22 Sep 2023 10:54:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 8/8] arm64: hugetlb: Fix set_huge_pte_at() to work with
 all swap entries
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
 <20230921162007.1630149-9-ryan.roberts@arm.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230921162007.1630149-9-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Ryan,

On 2023/9/22 00:20, Ryan Roberts wrote:
> When called with a swap entry that does not embed a PFN (e.g.
> PTE_MARKER_POISONED or PTE_MARKER_UFFD_WP), the previous implementation
> of set_huge_pte_at() would either cause a BUG() to fire (if
> CONFIG_DEBUG_VM is enabled) or cause a dereference of an invalid address
> and subsequent panic.
> 
> arm64's huge pte implementation supports multiple huge page sizes, some
> of which are implemented in the page table with contiguous mappings. So
> set_huge_pte_at() needs to work out how big the logical pte is, so that
> it can also work out how many physical ptes (or pmds) need to be
> written. It does this by grabbing the folio out of the pte and querying
> its size.
> 
> However, there are cases when the pte being set is actually a swap
> entry. But this also used to work fine, because for huge ptes, we only
> ever saw migration entries and hwpoison entries. And both of these types
> of swap entries have a PFN embedded, so the code would grab that and
> everything still worked out.
> 
> But over time, more calls to set_huge_pte_at() have been added that set
> swap entry types that do not embed a PFN. And this causes the code to go
> bang. The triggering case is for the uffd poison test, commit
> 99aa77215ad0 ("selftests/mm: add uffd unit test for UFFDIO_POISON"),
> which sets a PTE_MARKER_POISONED swap entry. But review shows there are
> other places too (PTE_MARKER_UFFD_WP).
> 
> So the root cause is due to commit 18f3962953e4 ("mm: hugetlb: kill
> set_huge_swap_pte_at()"), which aimed to simplify the interface to the
> core code by removing set_huge_swap_pte_at() (which took a page size
> parameter) and replacing it with calls to set_huge_swap_pte_at() where
> the size was inferred from the folio, as descibed above. While that
> commit didn't break anything at the time, 

If it didn't break anything at that time, then shouldn't the Fixes tag
be added to this commit?

> it did break the interface
> because it couldn't handle swap entries without PFNs. And since then new
> callers have come along which rely on this working.

So the Fixes tag should be added only to the commit that introduces the
first new callers?

Other than that, LGTM.

Thanks,
Qi

> 
> Now that we have modified the set_huge_pte_at() interface to pass the
> vma, we can extract the huge page size from it and fix this issue.
> 
> I'm tagging the commit that added the uffd poison feature, since that is
> what exposed the problem, as well as the original change that broke the
> interface. Hopefully this is valuable for people doing bisect.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Fixes: 18f3962953e4 ("mm: hugetlb: kill set_huge_swap_pte_at()")
> Fixes: 8a13897fb0da ("mm: userfaultfd: support UFFDIO_POISON for hugetlbfs")
> ---
>   arch/arm64/mm/hugetlbpage.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 844832511c1e..a08601a14689 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -241,13 +241,6 @@ static void clear_flush(struct mm_struct *mm,
>   	flush_tlb_range(&vma, saddr, addr);
>   }
>   
> -static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
> -{
> -	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
> -
> -	return page_folio(pfn_to_page(swp_offset_pfn(entry)));
> -}
> -
>   void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
>   			    pte_t *ptep, pte_t pte)
>   {
> @@ -258,13 +251,10 @@ void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
>   	unsigned long pfn, dpfn;
>   	pgprot_t hugeprot;
>   
> -	if (!pte_present(pte)) {
> -		struct folio *folio;
> -
> -		folio = hugetlb_swap_entry_to_folio(pte_to_swp_entry(pte));
> -		ncontig = num_contig_ptes(folio_size(folio), &pgsize);
> +	ncontig = num_contig_ptes(huge_page_size(hstate_vma(vma)), &pgsize);
>   
> -		for (i = 0; i < ncontig; i++, ptep++)
> +	if (!pte_present(pte)) {
> +		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>   			set_pte_at(mm, addr, ptep, pte);
>   		return;
>   	}
> @@ -274,7 +264,6 @@ void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
>   		return;
>   	}
>   
> -	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
>   	pfn = pte_pfn(pte);
>   	dpfn = pgsize >> PAGE_SHIFT;
>   	hugeprot = pte_pgprot(pte);
