Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfIDJPd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 05:15:33 -0400
Subject: Re: [PATCH v2 1/2] KVM: s390: Disallow invalid bits in kvm_valid_regs
 and kvm_dirty_regs
References: <20190904085200.29021-1-thuth@redhat.com>
 <20190904085200.29021-2-thuth@redhat.com>
 <b34a237f-77a5-2939-624d-0240451f2976@redhat.com>
 <8f48d9dd-1464-75aa-2011-b15adc5a4eab@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b7f51ff1-8f87-896a-0a8a-dd9a714173d0@redhat.com>
Date: Wed, 4 Sep 2019 11:15:30 +0200
MIME-Version: 1.0
In-Reply-To: <8f48d9dd-1464-75aa-2011-b15adc5a4eab@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 04.09.19 11:11, Christian Borntraeger wrote:
> 
> 
> On 04.09.19 11:05, David Hildenbrand wrote:
>> On 04.09.19 10:51, Thomas Huth wrote:
>>> If unknown bits are set in kvm_valid_regs or kvm_dirty_regs, this
>>> clearly indicates that something went wrong in the KVM userspace
>>> application. The x86 variant of KVM already contains a check for
>>> bad bits, so let's do the same on s390x now, too.
>>>
>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  arch/s390/include/uapi/asm/kvm.h | 6 ++++++
>>>  arch/s390/kvm/kvm-s390.c         | 4 ++++
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>>> index 47104e5b47fd..436ec7636927 100644
>>> --- a/arch/s390/include/uapi/asm/kvm.h
>>> +++ b/arch/s390/include/uapi/asm/kvm.h
>>> @@ -231,6 +231,12 @@ struct kvm_guest_debug_arch {
>>>  #define KVM_SYNC_GSCB   (1UL << 9)
>>>  #define KVM_SYNC_BPBC   (1UL << 10)
>>>  #define KVM_SYNC_ETOKEN (1UL << 11)
>>> +
>>> +#define KVM_SYNC_S390_VALID_FIELDS \
>>> +	(KVM_SYNC_PREFIX | KVM_SYNC_GPRS | KVM_SYNC_ACRS | KVM_SYNC_CRS | \
>>> +	 KVM_SYNC_ARCH0 | KVM_SYNC_PFAULT | KVM_SYNC_VRS | KVM_SYNC_RICCB | \
>>> +	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN)
>>> +
>>
>> We didn't care about the S390 for the actual flags, why care now?
> 
> I think it makes sense to have the interface as defined as possible. If for some
> reason userspace sets a wrong bit this would be undetected. If we at a later point
> in time use that bit this would resultin strange problems.

Not arguing about the concept of checking for valid bits. Was just
wondering if the "S390" part in the name makes sense at all. But you
guys seem to have a consent here.

-- 

Thanks,

David / dhildenb
