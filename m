Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8ABC4321E
	for <linux-s390@archiver.kernel.org>; Mon, 28 Nov 2022 07:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiK1Hnz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Nov 2022 02:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiK1Hny (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Nov 2022 02:43:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA6B313D2B;
        Sun, 27 Nov 2022 23:43:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF3D2D6E;
        Sun, 27 Nov 2022 23:43:57 -0800 (PST)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 547753F73B;
        Sun, 27 Nov 2022 23:43:48 -0800 (PST)
Message-ID: <28b976dd-3d12-3f2c-9b70-a5423255943e@arm.com>
Date:   Mon, 28 Nov 2022 13:13:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] s390/mm: Use pmd_pgtable_page() helper in
 __gmap_segment_gaddr()
Content-Language: en-US
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-mm@kvack.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125034502.1559986-1-anshuman.khandual@arm.com>
 <Y4IvaRNLmASfRJiZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <d3bcb8e1-cbf0-e820-47cf-f455128c597a@arm.com>
 <Y4Rflp1Z48hp/OAb@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y4Rflp1Z48hp/OAb@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 11/28/22 12:43, Alexander Gordeev wrote:
> On Mon, Nov 28, 2022 at 12:01:06PM +0530, Anshuman Khandual wrote:
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index e9e387caffac..5ead9e997510 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -2403,7 +2403,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
>>>>  
>>>>  #if USE_SPLIT_PMD_PTLOCKS
>>>>  
>>>> -static struct page *pmd_pgtable_page(pmd_t *pmd)
>>>> +static inline struct page *pmd_pgtable_page(pmd_t *pmd)
>>>>  {
>>>>  	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
>>>>  	return virt_to_page((void *)((unsigned long) pmd & mask));
>>>
>>> This chunk does not appear to belong to this patch.
>>
>> Should not this helper be made a 'static inline' before using it else where ?
> 
> Probably yes, but it is not kvm s390-specific change.

Right, just that the s390 change here is the first instance where this helper
is being used outside the header, hence kept them together.

> 
> I guess, you wanted to make it together or as a follow-up to this one?
> https://lore.kernel.org/all/20221124131641.1523772-1-anshuman.khandual@arm.com/
> 
Unless too much trouble, could we just keep it here as proposed.
