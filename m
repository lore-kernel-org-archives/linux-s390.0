Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24257 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgC0JHT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 05:07:19 -0400
Subject: Re: [PATCH] s390/gmap: return proper error code on ksm unsharing
References: <20200327085602.24535-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9c8b6b9f-c58c-66a7-5669-40a91cbda829@redhat.com>
Date: Fri, 27 Mar 2020 10:07:12 +0100
MIME-Version: 1.0
In-Reply-To: <20200327085602.24535-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

On 27.03.20 09:56, Christian Borntraeger wrote:
> If a signal is pending we might return -ENOMEM instead of -EINTR.
> We should propagate the proper error during KSM unsharing.
> 
> Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 27926a06df32..2bf63035a295 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2552,15 +2552,16 @@ int gmap_mark_unmergeable(void)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> +	int ret  = 0;
>  
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -				MADV_UNMERGEABLE, &vma->vm_flags)) {
> -			return -ENOMEM;
> -		}
> +		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> +				MADV_UNMERGEABLE, &vma->vm_flags);
> +		if (ret)
> +			return ret;
>  	}
>  	mm->def_flags &= ~VM_MERGEABLE;
> -	return 0;
> +	return ret;

How can this ever be !0 ?

Also, once removed, no need to initialize ret to 0.

>  }
>  EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
>  
> 


-- 
Thanks,

David / dhildenb
