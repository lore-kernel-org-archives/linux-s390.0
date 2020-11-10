Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730164AbgKJJlV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:41:21 -0500
Subject: Re: [PATCH 2/3] s390/vmem: fix possible memory overwrite
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aec7d80c-a7a1-d3db-9719-1ca69fb80887@redhat.com>
Date: Tue, 10 Nov 2020 10:41:14 +0100
MIME-Version: 1.0
In-Reply-To: <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>

On 10.11.20 10:36, Alexander Gordeev wrote:
> If for whatever reason the sub-PMD region to be used is less
> than struct page size (e.g in the future), then it is possible
> to overwrite beyond the region size.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   arch/s390/mm/vmem.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 56ab9bb770f3a..d7f25884061f4 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -91,13 +91,15 @@ static void vmemmap_flush_unused_pmd(void)
>   
>   static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
>   {
> +	unsigned long size = min(end - start, sizeof(struct page));
> +
>   	/*
>   	 * As we expect to add in the same granularity as we remove, it's
>   	 * sufficient to mark only some piece used to block the memmap page from
>   	 * getting removed (just in case the memmap never gets initialized,
>   	 * e.g., because the memory block never gets onlined).
>   	 */
> -	memset(__va(start), 0, sizeof(struct page));
> +	memset(__va(start), 0, size);
>   }
>   
>   static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> 

I don't really see a need for that. Can you spell out one possible 
configuration that would trigger that in the future? It's sounds very 
unlikely and I have the feeling there might be more to change at other 
points.

-- 
Thanks,

David / dhildenb
