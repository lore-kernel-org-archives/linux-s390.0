Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728243AbgIGJvA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 05:51:00 -0400
Subject: Re: [PATCH 1/2] s390x: uv: Add destroy page call
References: <20200903131435.2535-1-frankja@linux.ibm.com>
 <20200903131435.2535-2-frankja@linux.ibm.com> <20200904103939.GE6075@osiris>
 <98237148-bbb4-c6d7-aba2-6fa11fb788b1@linux.ibm.com>
 <20200904121055.GF6075@osiris>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <c0be7eae-68c8-cbd2-6cbf-56708cb42770@linux.ibm.com>
Date: Mon, 7 Sep 2020 11:50:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200904121055.GF6075@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com

On 9/4/20 2:10 PM, Heiko Carstens wrote:
> On Fri, Sep 04, 2020 at 01:38:53PM +0200, Janosch Frank wrote:
>>>>   * Requests the Ultravisor to encrypt a guest page and make it
>>>>   * accessible to the host for paging (export).
>>>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>>>> index 373542ca1113..cfb0017f33a7 100644
>>>> --- a/arch/s390/mm/gmap.c
>>>> +++ b/arch/s390/mm/gmap.c
>>>> @@ -2679,7 +2679,7 @@ static int __s390_reset_acc(pte_t *ptep, unsigned long addr,
>>>>  	pte_t pte = READ_ONCE(*ptep);
>>>>  
>>>>  	if (pte_present(pte))
>>>> -		WARN_ON_ONCE(uv_convert_from_secure(pte_val(pte) & PAGE_MASK));
>>>> +		WARN_ON_ONCE(uv_destroy_page(pte_val(pte) & PAGE_MASK));
>>>
>>> Why not put the WARN_ON_ONCE() into uv_destroy_page() and make that
>>> function return void?
>>>
>> If you prefer that, I'll change the patch.
> 
> Seems to be better to me. Otherwise you start to sprinkle WARN_ONs all
> over the code, _if_ there would be more callers.

The other call sites currently don't care about the return codes which
is not optimal.

I'd prefer to leave it as is and put a debug item on the todo list which
takes care of providing more debug data on error.

> 
>> I think we'd need a proper print of the return codes of the UVC anyway,
>> the warn isn't very helpful if you want to debug after the fact.
> 
> Maybe a new debug feature? Well, but that's something that hasn't do
> anything with this code.
