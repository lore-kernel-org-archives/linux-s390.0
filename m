Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC607C433FE
	for <linux-s390@archiver.kernel.org>; Tue,  8 Mar 2022 08:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiCHIiW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344997AbiCHIiV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 03:38:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BDFE3FBC5
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 00:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646728643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjh+4BkQ3gG8RT83kzIqOaASDTboCinxDi5X/XejdlA=;
        b=B6b44PRK2T/wUkg39Yt7645KrfiMPsdH2+yvdTMRRA9zmwhc0YD4cTgg6W2tnO/390pIzd
        evoUcBjqJqwd0/A1W3lq1DWIECuNmlAeujDdx4GkjmZQPF9ljQL3CeElECwsRnd6LPCyEM
        DMdMwKWD7QbUUfAT5d7inIc7gMrO/DA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-Fz9zTkCCODSUnu0_t8MPTg-1; Tue, 08 Mar 2022 03:37:22 -0500
X-MC-Unique: Fz9zTkCCODSUnu0_t8MPTg-1
Received: by mail-wm1-f70.google.com with SMTP id l2-20020a1ced02000000b0038482a47e7eso865942wmh.5
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 00:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=sjh+4BkQ3gG8RT83kzIqOaASDTboCinxDi5X/XejdlA=;
        b=ontzvszNZmDWmraTtvXMLgUZdtfQIIM6F4fV204tC7tin6T5qSotlSrqXnxh1VbWr6
         fJ8Iv+mZbpxVw7+J6b9xEKADHruo3WYNT71VM2BM9bBsLWNyPp9RKW6Se7b5VDmVnUfD
         mIiBi8HUP/k1wbcSqWyfBL+A+sV5nl4+kXa2jXgQKGaE3f/9NXeZGV1Yty1ZikRt1faU
         +uAU0gtDlBjoGZlmsZV0thoO/J06FDgCXHRsHwiG4l/Nt3+DuhxAqGzKuJoi1OLOUgcA
         j0PwziFjd72ABNm8iN9hVtekf5IyG1GfuzSi/WDG7FHi3/6xeaa8daoVKF5z3BZZ/44u
         z5eA==
X-Gm-Message-State: AOAM531tMFPH8b9NZLOf1iltHGXO330FaXd9DjupzDGWJFCRWgNAOdJ6
        9i5pd0rAI2K+OmhYVDE8EwcNDrYhAIxhm7Py29/BY+BeOGhtwUn7BCO5e1kgRlRvDmA4diV6mfE
        MwoUzdW0E5AdPYAP4U9wRzg==
X-Received: by 2002:adf:816e:0:b0:1e4:ad2b:cb24 with SMTP id 101-20020adf816e000000b001e4ad2bcb24mr11691842wrm.521.1646728641210;
        Tue, 08 Mar 2022 00:37:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQBcKwzF57N6Un53kSGSzGI325n+/ccxVjmElkscP1Yxr8gOMMyOEXhFd7RHE7TuddTgn6PQ==
X-Received: by 2002:adf:816e:0:b0:1e4:ad2b:cb24 with SMTP id 101-20020adf816e000000b001e4ad2bcb24mr11691826wrm.521.1646728640945;
        Tue, 08 Mar 2022 00:37:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id h36-20020a05600c49a400b00382aa0b1619sm1525859wmp.45.2022.03.08.00.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:37:20 -0800 (PST)
Message-ID: <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
Date:   Tue, 8 Mar 2022 09:37:19 +0100
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
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
Organization: Red Hat
In-Reply-To: <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.03.22 09:21, David Hildenbrand wrote:
> On 08.03.22 00:18, Linus Torvalds wrote:
>> On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>>
>>> After generic_file_read_iter() returns a short or empty read, we fault
>>> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
>>> the next call to generic_file_read_iter() returns -EFAULT and we're
>>> not making any progress.
>>
>> Since this is s390-specific, I get the very strong feeling that the
>>
>>   fault_in_iov_iter_writeable ->
>>     fault_in_safe_writeable ->
>>       __get_user_pages_locked ->
>>         __get_user_pages
>>
>> path somehow successfully finds the page, despite it not being
>> properly accessible in the page tables.
> 
> As raised offline already, I suspect
> 
> shrink_active_list()
> ->page_referenced()
>  ->page_referenced_one()
>   ->ptep_clear_flush_young_notify()
>    ->ptep_clear_flush_young()
> 
> which results on s390x in:
> 
> static inline pte_t pte_mkold(pte_t pte)
> {
> 	pte_val(pte) &= ~_PAGE_YOUNG;
> 	pte_val(pte) |= _PAGE_INVALID;
> 	return pte;
> }
> 
> static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
> 					    unsigned long addr, pte_t *ptep)
> {
> 	pte_t pte = *ptep;
> 
> 	pte = ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
> 	return pte_young(pte);
> }
> 
> 
> _PAGE_INVALID is the actual HW bit, _PAGE_PRESENT is a
> pure SW bit. AFAIU, pte_present() still holds:
> 
> static inline int pte_present(pte_t pte)
> {
> 	/* Bit pattern: (pte & 0x001) == 0x001 */
> 	return (pte_val(pte) & _PAGE_PRESENT) != 0;
> }
> 
> 
> pte_mkyoung() will revert that action:
> 
> static inline pte_t pte_mkyoung(pte_t pte)
> {
> 	pte_val(pte) |= _PAGE_YOUNG;
> 	if (pte_val(pte) & _PAGE_READ)
> 		pte_val(pte) &= ~_PAGE_INVALID;
> 	return pte;
> }
> 
> 
> and pte_modify() will adjust it properly again:
> 
> /*
>  * The following pte modification functions only work if
>  * pte_present() is true. Undefined behaviour if not..
>  */
> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> {
> 	pte_val(pte) &= _PAGE_CHG_MASK;
> 	pte_val(pte) |= pgprot_val(newprot);
> 	/*
> 	 * newprot for PAGE_NONE, PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX
> 	 * has the invalid bit set, clear it again for readable, young pages
> 	 */
> 	if ((pte_val(pte) & _PAGE_YOUNG) && (pte_val(pte) & _PAGE_READ))
> 		pte_val(pte) &= ~_PAGE_INVALID;
> 	/*
> 	 * newprot for PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX has the page
> 	 * protection bit set, clear it again for writable, dirty pages
> 	 */
> 	if ((pte_val(pte) & _PAGE_DIRTY) && (pte_val(pte) & _PAGE_WRITE))
> 		pte_val(pte) &= ~_PAGE_PROTECT;
> 	return pte;
> }
> 
> 
> 
> Which leaves me wondering if there is a way in GUP whereby
> we would lookup that page and not clear _PAGE_INVALID,
> resulting in GUP succeeding but faults via the MMU still
> faulting on _PAGE_INVALID.


follow_page_pte() has this piece of code:

	if (flags & FOLL_TOUCH) {
		if ((flags & FOLL_WRITE) &&
		    !pte_dirty(pte) && !PageDirty(page))
			set_page_dirty(page);
		/*
		 * pte_mkyoung() would be more correct here, but atomic care
		 * is needed to avoid losing the dirty bit: it is easier to use
		 * mark_page_accessed().
		 */
		mark_page_accessed(page);
	}

Which at least to me suggests that, although the page is marked accessed and GUP
succeeds, that the PTE might still have _PAGE_INVALID set after we succeeded GUP.


On s390x, there is no HW dirty bit, so we might just be able to do a proper
pte_mkyoung() here instead of the mark_page_accessed().

-- 
Thanks,

David / dhildenb

