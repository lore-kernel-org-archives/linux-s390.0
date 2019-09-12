Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731030AbfILLAO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 07:00:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CAwJFx175463
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 07:00:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uymh00j71-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 07:00:11 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Sep 2019 12:00:08 +0100
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
 <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
 <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
 <982f703f-73f1-30c2-031f-a430de7dc6a9@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 12 Sep 2019 13:00:03 +0200
MIME-Version: 1.0
In-Reply-To: <982f703f-73f1-30c2-031f-a430de7dc6a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <91dfd032-7529-d9f4-8239-60fa1e06977e@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 12.09.19 12:58, David Hildenbrand wrote:
> On 12.09.19 11:20, Thomas Huth wrote:
>> On 12/09/2019 11.14, David Hildenbrand wrote:
>>> On 12.09.19 11:00, Thomas Huth wrote:
>>>> When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
>>>> an interrupt, we convert them from the legacy struct kvm_s390_interrupt
>>>> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
>>>> However, this function does not take care of all types of interrupts
>>>> that we can inject into the guest later (see do_inject_vcpu()). Since we
>>>> do not clear out the s390irq values before calling s390int_to_s390irq(),
>>>> there is a chance that we copy unwanted data from the kernel stack
>>>> into the guest memory later if the interrupt data has not been properly
>>>> initialized by s390int_to_s390irq().
>>>>
>>>> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
>>>> interrupt: s390int_to_s390irq() does not handle it, but the function
>>>> __deliver_pfault_init() will later copy the uninitialized stack data
>>>> from the ext.ext_params2 into the guest memory.
>>>>
>>>> Fix it by handling that interrupt type in s390int_to_s390irq(), too.
>>>> And while we're at it, make sure that s390int_to_s390irq() now
>>>> directly returns -EINVAL for unknown interrupt types, so that we
>>>> do not run into this problem again in case we add more interrupt
>>>> types to do_inject_vcpu() sometime in the future.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  arch/s390/kvm/interrupt.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>>> index 3e7efdd9228a..165dea4c7f19 100644
>>>> --- a/arch/s390/kvm/interrupt.c
>>>> +++ b/arch/s390/kvm/interrupt.c
>>>> @@ -1960,6 +1960,16 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
>>>>  	case KVM_S390_MCHK:
>>>>  		irq->u.mchk.mcic = s390int->parm64;
>>>>  		break;
>>>> +	case KVM_S390_INT_PFAULT_INIT:
>>>> +		irq->u.ext.ext_params = s390int->parm;
>>>> +		irq->u.ext.ext_params2 = s390int->parm64;
>>>> +		break;
>>>> +	case KVM_S390_RESTART:
>>>> +	case KVM_S390_INT_CLOCK_COMP:
>>>> +	case KVM_S390_INT_CPU_TIMER:
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>>  	}
>>>>  	return 0;
>>>>  }
>>>>
>>>
>>> Wouldn't a safe fix be to initialize the struct to zero in the caller?
>>
>> That's of course possible, too. But that means that we always have to
>> zero out the whole structure, so that's a little bit more of overhead
>> (well, it likely doesn't matter for such a legacy ioctl).
> 
> I would vote for doing this as well.

Yes, lets also do the designated initializer, add more text to the patch
description (or should we not?) add cc stable and I will pick a v2. 
> 
>>
>> But the more important question: Do we then still care of fixing the
>> PFAULT_INIT interrupt here? Since it requires a parameter, the "case
>> KVM_S390_INT_PFAULT_INIT:" part would be required here anyway.
>>
> 
> That's indeed true.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
>>  Thomas
>>
> 
> 
