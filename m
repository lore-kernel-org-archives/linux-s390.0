Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgC0I7b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 04:59:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R8pJtW046970
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 04:59:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywd2v21m2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 04:59:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 27 Mar 2020 08:59:21 -0000
Subject: Re: [PATCH] s390/gmap: return proper error code on ksm unsharing
References: <20200327085602.24535-1-borntraeger@de.ibm.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 27 Mar 2020 09:59:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200327085602.24535-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1b2c74f9-cbe3-cb0e-64cc-aff4fd73daf7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

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

extra whitespace

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
>  }
>  EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
>  
> 
