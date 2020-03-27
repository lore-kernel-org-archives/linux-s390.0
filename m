Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgC0JIt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 05:08:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R93pjV089256
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 05:08:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywd8gqbcm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 05:08:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 27 Mar 2020 09:08:39 -0000
Subject: Re: [PATCH] s390/gmap: return proper error code on ksm unsharing
References: <20200327085602.24535-1-borntraeger@de.ibm.com>
 <9c8b6b9f-c58c-66a7-5669-40a91cbda829@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 27 Mar 2020 10:08:41 +0100
MIME-Version: 1.0
In-Reply-To: <9c8b6b9f-c58c-66a7-5669-40a91cbda829@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0511389e-fc59-7666-4ad2-cd06f2882bbe@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>



On 27.03.20 10:07, David Hildenbrand wrote:
> On 27.03.20 09:56, Christian Borntraeger wrote:
>> If a signal is pending we might return -ENOMEM instead of -EINTR.
>> We should propagate the proper error during KSM unsharing.
>>
>> Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/mm/gmap.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 27926a06df32..2bf63035a295 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2552,15 +2552,16 @@ int gmap_mark_unmergeable(void)
>>  {
>>  	struct mm_struct *mm = current->mm;
>>  	struct vm_area_struct *vma;
>> +	int ret  = 0;
>>  
>>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>> -		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
>> -				MADV_UNMERGEABLE, &vma->vm_flags)) {
>> -			return -ENOMEM;
>> -		}
>> +		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
>> +				MADV_UNMERGEABLE, &vma->vm_flags);
>> +		if (ret)
>> +			return ret;
>>  	}
>>  	mm->def_flags &= ~VM_MERGEABLE;
>> -	return 0;
>> +	return ret;
> 
> How can this ever be !0 ?
> 
> Also, once removed, no need to initialize ret to 0.

Right, I can make the patch smaller by keeping the return 0;

> 
>>  }
>>  EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
>>  
>>
> 
> 
