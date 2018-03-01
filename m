From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 08/15] KVM: s390: interface to enable AP execution mode
Date: Thu, 1 Mar 2018 10:32:12 +0100
Message-ID: <dcb6e922-6349-9932-c9be-ff8581ba0259@redhat.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a3df4d1b-05a2-38de-b4bb-76bfd3e23818@redhat.com>
 <47808b6f-9e6d-1f17-c26b-3e03d1f1e2ca@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47808b6f-9e6d-1f17-c26b-3e03d1f1e2ca@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


>>> +EXPORT_SYMBOL(kvm_ap_enable_ie_mode);
>>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>>> index 1b5621f..3142541 100644
>>> --- a/arch/s390/kvm/kvm-s390.h
>>> +++ b/arch/s390/kvm/kvm-s390.h
>>> @@ -18,6 +18,7 @@
>>>   #include <asm/facility.h>
>>>   #include <asm/processor.h>
>>>   #include <asm/sclp.h>
>>> +#include <asm/ap.h>
>>>   
>>>   /* Transactional Memory Execution related macros */
>>>   #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & ECB_TE))
>>>
>> What about VSIE?
> That is a good question. I'm beginning to think introducing AP on second 
> level guests
> ought to be postponed for now. I'm going to look into this further.
>>

Once you provide AP support to the guest, vSIE also has to be in place.

But don't worry about vSIE, I think I know what we have to do.

-- 

Thanks,

David / dhildenb
