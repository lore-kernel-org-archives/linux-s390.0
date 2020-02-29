Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5035 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgB2UHC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 29 Feb 2020 15:07:02 -0500
Subject: Re: [RFC v1 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200228154322.329228-1-imbrenda@linux.ibm.com>
 <20200228154322.329228-4-imbrenda@linux.ibm.com>
 <2e3bf1a2-b672-68e0-97b6-42f08133e077@de.ibm.com>
 <ff35804f-81ef-a245-01d9-1f9b525e3410@nvidia.com>
 <20200229114919.1abcacc4@p-imbrenda>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <cc2e1664-cff1-de1e-2087-475ec7c6aa56@nvidia.com>
Date: Sat, 29 Feb 2020 12:07:01 -0800
MIME-Version: 1.0
In-Reply-To: <20200229114919.1abcacc4@p-imbrenda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>

On 2/29/20 2:49 AM, Claudio Imbrenda wrote:
>> ...
>>>> @@ -458,7 +457,6 @@ static struct page *follow_page_pte(struct
>>>> vm_area_struct *vma, }
>>>>   
>>>>   	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
>>>> -		int ret;
>>>>   		get_page(page);
>>>>   		pte_unmap_unlock(ptep, ptl);
>>>>   		lock_page(page);
>>>> @@ -475,6 +473,14 @@ static struct page *follow_page_pte(struct
>>>> vm_area_struct *vma, page = ERR_PTR(-ENOMEM);
>>>>   		goto out;
>>>>   	}
>>>> +	if (flags & FOLL_PIN) {
>>
>>
>> What about FOLL_GET? Unless your calling code has some sort of
>> BUG_ON(flags & FOLL_GET), I'm not sure it's a good idea to leave that
>> case unhandled.
> 
> if I understood the semantics of FOLL_PIN correctly, then we don't need
> to make the page accessible for FOLL_GET. FOLL_PIN indicates intent to
> access the content of the page, whereas FOLL_GET is only for the struct
> page.
> 
> if we are not touching the content of the page, there is no need to
> make it accessible
> 


OK, I hope I'm not overlooking anything, but that sounds correct to me.


thanks,
-- 
John Hubbard
NVIDIA
