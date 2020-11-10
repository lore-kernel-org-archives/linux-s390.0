Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbgKJJmC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:42:02 -0500
Subject: Re: [PATCH 1/3] s390/vmem: remove redundant check
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c5eb5477-595a-77b0-8088-2c9e68a25b58@redhat.com>
Date: Tue, 10 Nov 2020 10:41:56 +0100
MIME-Version: 1.0
In-Reply-To: <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>

On 10.11.20 10:36, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   arch/s390/mm/vmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b09..56ab9bb770f3a 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -223,7 +223,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
>   		if (!add) {
>   			if (pmd_none(*pmd))
>   				continue;
> -			if (pmd_large(*pmd) && !add) {
> +			if (pmd_large(*pmd)) {
>   				if (IS_ALIGNED(addr, PMD_SIZE) &&
>   				    IS_ALIGNED(next, PMD_SIZE)) {
>   					if (!direct)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
