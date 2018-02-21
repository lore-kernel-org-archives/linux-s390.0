From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 21 Feb 2018 08:37:33 +0000
Subject: Re: [PATCH 1/2] KVM: s390: Refactor host cmma and pfmfi interpretation controls
Message-Id: <5450c61b-9cbe-974e-2f42-61803c5a2ca4@de.ibm.com>
In-Reply-To: <7ead7a90-2e0b-c2ba-6d76-5e7c27288c08@linux.vnet.ibm.com>
References: <7ead7a90-2e0b-c2ba-6d76-5e7c27288c08@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/20/2018 04:04 PM, Janosch Frank wrote:
> On 19.02.2018 12:22, Christian Borntraeger wrote:
>> On 02/16/2018 12:16 PM, Janosch Frank wrote:
>>> use_cmma in kvm_arch means that the vm is allowed to use cmma, whereas
>> what about                          ^^^^^ s/vm/KVM hypervisor/
>>
>> ?                     
> 
> Yes, that would be more correct, will integrate.

I will just fixup when applying.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> 
>>
>>> use_cmma in the mm context means cmm has been used before. Let's
>>> rename the context one to uses_cmm, as the vm does use collaborative
>>> memory management but the host uses the cmm assist (interpretation
>>> facility).
>>>
>>> Also let's introduce use_pfmfi, so we can remove the pfmfi disablement
>>> when we activate cmma and rather not activate it in the first place.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>
> 
> 
