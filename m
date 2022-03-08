Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B629C41535
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349044AbiCHRYj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349950AbiCHRYG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 12:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D8704D27C
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 09:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646760188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehpQ55FPqLbh+bqZZzZISzAZpDG5XN0glN4zhHthyoE=;
        b=b8A6T3RTXbiaEsEYF2w72UKMnh5wMl8IyBap55Xy1uebD5vzgXTZ48409aIa+YcAEi0Z0h
        hrsNq04Y/+ooBMCF0l1tWXQWb9b9mg/BMAGyiTv8xvNxb/xbqFC3P4QSV+jI4jnnBTQtY6
        u265EU9NZ4KEmdrlKuLkzYuVrp7pHHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-lzs_tUqvNXud5_7CM89qsA-1; Tue, 08 Mar 2022 12:23:07 -0500
X-MC-Unique: lzs_tUqvNXud5_7CM89qsA-1
Received: by mail-wm1-f69.google.com with SMTP id n62-20020a1ca441000000b0038124c99ebcso6692810wme.9
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 09:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=ehpQ55FPqLbh+bqZZzZISzAZpDG5XN0glN4zhHthyoE=;
        b=UtcGwOTMmkhy6qhhBwsP397rnOV9hqM2t5ETZTe9APJvpXeD8DfNuMD1iZ97xrTq2M
         LTKcT+5SUt0FgH5afIRJ4IQcdu0wsWMloa2P3osI7XrV+c/Npis+iXMFTHL3bNM+PbiU
         WiCHWlNDvcRkdUIwATUl6IUVxPLSGCDiueKPT5OQ/cUzQq8G5G+37u8pzLP6XMEc9fGK
         DY82ClwmMlXKCe6vWR+IJMEfRbix2wbHJr2nZhi2ylzQOqRAErbscL30QX8uuZKmiFVs
         Le5V1y4AR329WUeTfoV7mBwccCGL8JhaQbokj6k3h4FS/hbDUOIx0VvWGD57FmgYtGyY
         nBgA==
X-Gm-Message-State: AOAM530ipCwRpbLM+rUxXooEcICAMkISnpHonwwyI139hhQfsq0DreK+
        az1Hh3Mei35jSJ/w+fz7/X6NT3Zo5smzy67JUS9UrAB4Xyvhw8RQOqGF+vfq1Mao0myAJtdQyU8
        mpALMT4Xuk/VuxHJfmRnp2A==
X-Received: by 2002:adf:e983:0:b0:1f1:f52b:8328 with SMTP id h3-20020adfe983000000b001f1f52b8328mr9205635wrm.513.1646760185912;
        Tue, 08 Mar 2022 09:23:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUF6hS4tVv9SdXDAhNxe/nXaZ+S9wcf2zLRYF6vCBHQfFYvGiWDAh/y1wO+/+4wt/l5tlMYg==
X-Received: by 2002:adf:e983:0:b0:1f1:f52b:8328 with SMTP id h3-20020adfe983000000b001f1f52b8328mr9205602wrm.513.1646760185590;
        Tue, 08 Mar 2022 09:23:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm2929838wml.29.2022.03.08.09.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:23:05 -0800 (PST)
Message-ID: <c44ff283-acf2-bbfe-b3b4-c87a9e180f46@redhat.com>
Date:   Tue, 8 Mar 2022 18:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
 <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
 <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
Organization: Red Hat
In-Reply-To: <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.03.22 13:24, David Hildenbrand wrote:
> On 08.03.22 13:11, David Hildenbrand wrote:
>> On 08.03.22 09:37, David Hildenbrand wrote:
>>> On 08.03.22 09:21, David Hildenbrand wrote:
>>>> On 08.03.22 00:18, Linus Torvalds wrote:
>>>>> On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>>>>>
>>>>>> After generic_file_read_iter() returns a short or empty read, we fault
>>>>>> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
>>>>>> the next call to generic_file_read_iter() returns -EFAULT and we're
>>>>>> not making any progress.
>>>>>
>>>>> Since this is s390-specific, I get the very strong feeling that the
>>>>>
>>>>>   fault_in_iov_iter_writeable ->
>>>>>     fault_in_safe_writeable ->
>>>>>       __get_user_pages_locked ->
>>>>>         __get_user_pages
>>>>>
>>>>> path somehow successfully finds the page, despite it not being
>>>>> properly accessible in the page tables.
>>>>
>>>> As raised offline already, I suspect
>>>>
>>>> shrink_active_list()
>>>> ->page_referenced()
>>>>  ->page_referenced_one()
>>>>   ->ptep_clear_flush_young_notify()
>>>>    ->ptep_clear_flush_young()
>>>>
>>>> which results on s390x in:
>>>>
>>>> static inline pte_t pte_mkold(pte_t pte)
>>>> {
>>>> 	pte_val(pte) &= ~_PAGE_YOUNG;
>>>> 	pte_val(pte) |= _PAGE_INVALID;
>>>> 	return pte;
>>>> }
>>>>
>>>> static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>> 					    unsigned long addr, pte_t *ptep)
>>>> {
>>>> 	pte_t pte = *ptep;
>>>>
>>>> 	pte = ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
>>>> 	return pte_young(pte);
>>>> }
>>>>
>>>>
>>>> _PAGE_INVALID is the actual HW bit, _PAGE_PRESENT is a
>>>> pure SW bit. AFAIU, pte_present() still holds:
>>>>
>>>> static inline int pte_present(pte_t pte)
>>>> {
>>>> 	/* Bit pattern: (pte & 0x001) == 0x001 */
>>>> 	return (pte_val(pte) & _PAGE_PRESENT) != 0;
>>>> }
>>>>
>>>>
>>>> pte_mkyoung() will revert that action:
>>>>
>>>> static inline pte_t pte_mkyoung(pte_t pte)
>>>> {
>>>> 	pte_val(pte) |= _PAGE_YOUNG;
>>>> 	if (pte_val(pte) & _PAGE_READ)
>>>> 		pte_val(pte) &= ~_PAGE_INVALID;
>>>> 	return pte;
>>>> }
>>>>
>>>>
>>>> and pte_modify() will adjust it properly again:
>>>>
>>>> /*
>>>>  * The following pte modification functions only work if
>>>>  * pte_present() is true. Undefined behaviour if not..
>>>>  */
>>>> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>>> {
>>>> 	pte_val(pte) &= _PAGE_CHG_MASK;
>>>> 	pte_val(pte) |= pgprot_val(newprot);
>>>> 	/*
>>>> 	 * newprot for PAGE_NONE, PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX
>>>> 	 * has the invalid bit set, clear it again for readable, young pages
>>>> 	 */
>>>> 	if ((pte_val(pte) & _PAGE_YOUNG) && (pte_val(pte) & _PAGE_READ))
>>>> 		pte_val(pte) &= ~_PAGE_INVALID;
>>>> 	/*
>>>> 	 * newprot for PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX has the page
>>>> 	 * protection bit set, clear it again for writable, dirty pages
>>>> 	 */
>>>> 	if ((pte_val(pte) & _PAGE_DIRTY) && (pte_val(pte) & _PAGE_WRITE))
>>>> 		pte_val(pte) &= ~_PAGE_PROTECT;
>>>> 	return pte;
>>>> }
>>>>
>>>>
>>>>
>>>> Which leaves me wondering if there is a way in GUP whereby
>>>> we would lookup that page and not clear _PAGE_INVALID,
>>>> resulting in GUP succeeding but faults via the MMU still
>>>> faulting on _PAGE_INVALID.
>>>
>>>
>>> follow_page_pte() has this piece of code:
>>>
>>> 	if (flags & FOLL_TOUCH) {
>>> 		if ((flags & FOLL_WRITE) &&
>>> 		    !pte_dirty(pte) && !PageDirty(page))
>>> 			set_page_dirty(page);
>>> 		/*
>>> 		 * pte_mkyoung() would be more correct here, but atomic care
>>> 		 * is needed to avoid losing the dirty bit: it is easier to use
>>> 		 * mark_page_accessed().
>>> 		 */
>>> 		mark_page_accessed(page);
>>> 	}
>>>
>>> Which at least to me suggests that, although the page is marked accessed and GUP
>>> succeeds, that the PTE might still have _PAGE_INVALID set after we succeeded GUP.
>>>
>>>
>>> On s390x, there is no HW dirty bit, so we might just be able to do a proper
>>> pte_mkyoung() here instead of the mark_page_accessed().
>>>
>>
>> Something hacky like this should be able to show if what I suspect is the case.
>> It compiles, but I didn't actually test it.
> That would be the alternative that also takes the mkdirty into account:
> 
> 
> From 1e51e8a93894f87c0a4d0e908391e0628ae56afe Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 8 Mar 2022 12:51:26 +0100
> Subject: [PATCH] mm/gup: fix buffered I/O on s390x with pagefaults disabled
> 
> On s390x, we actually need a pte_mkyoung() / pte_mkdirty() instead of
> going via the page and leaving the PTE unmodified. E.g., if we only
> mark the page accessed via mark_page_accessed() when doing a FOLL_TOUCH,
> we'll miss to clear the HW invalid bit in the pte and subsequent accesses
> via the MMU would still require a pagefault.
> 
> Otherwise, buffered I/O will loop forever because it will keep stumling
> over the set HW invalid bit, requiring a page fault.
> 
> Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a9d4d724aef7..de3311feb377 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -587,15 +587,33 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		}
>  	}
>  	if (flags & FOLL_TOUCH) {
> -		if ((flags & FOLL_WRITE) &&
> -		    !pte_dirty(pte) && !PageDirty(page))
> -			set_page_dirty(page);
>  		/*
> -		 * pte_mkyoung() would be more correct here, but atomic care
> -		 * is needed to avoid losing the dirty bit: it is easier to use
> -		 * mark_page_accessed().
> +		 * We have to be careful with updating the PTE on architectures
> +		 * that have a HW dirty bit: while updating the PTE we might
> +		 * lose that bit again and we'd need an atomic update: it is
> +		 * easier to leave the PTE untouched for these architectures.
> +		 *
> +		 * s390x doesn't have a hw referenced / dirty bit and e.g., sets
> +		 * the hw invalid bit in pte_mkold(), to catch further
> +		 * references. We have to update the PTE here to e.g., clear the
> +		 * invalid bit; otherwise, callers that rely on not requiring
> +		 * an MMU fault once GUP(FOLL_TOUCH) succeeded will loop forever
> +		 * because the page won't actually be accessible via the MMU.
>  		 */
> -		mark_page_accessed(page);
> +		if (IS_ENABLED(CONFIG_S390)) {
> +			pte = pte_mkyoung(pte);
> +			if (flags & FOLL_WRITE)
> +				pte = pte_mkdirty(pte);
> +			if (!pte_same(pte, *ptep)) {
> +				set_pte_at(vma->vm_mm, address, ptep, pte);
> +				update_mmu_cache(vma, address, ptep);

I just reproduced without this fix and then tried to reproduce with this
fix (however, replacing pte_same() + set_pte_at() by a
ptep_set_access_flags()).

Seems to do the trick for me. I'll figure out the best way to handle
IS_ENABLED(CONFIG_S390) before posting an official fix.


-- 
Thanks,

David / dhildenb

