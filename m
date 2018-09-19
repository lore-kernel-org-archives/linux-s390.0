From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Sep 2018 11:13:55 +0000
Subject: Re: [RFC 14/14] KVM: s390: Allow the VSIE to be used with huge pages
Message-Id: <056b2c79-bfb7-220c-1c01-57aa4ef41dad@de.ibm.com>
In-Reply-To: <7973f4ff-ed87-9aa1-3990-33c7ee41a459@linux.ibm.com>
References: <7973f4ff-ed87-9aa1-3990-33c7ee41a459@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 09/19/2018 11:50 AM, Janosch Frank wrote:
> On 9/19/18 10:56 AM, David Hildenbrand wrote:
>> Am 19.09.18 um 10:48 schrieb Janosch Frank:
>>> Now that we have VSIE support for VMs with huge memory backing, let's
>>> make both features usable at the same time.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  Documentation/virtual/kvm/api.txt |  7 +++----
>>>  arch/s390/kvm/kvm-s390.c          | 14 ++------------
>>>  arch/s390/mm/gmap.c               |  1 -
>>>  3 files changed, 5 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>>> index 8d8a372c8340..9ec6d23f41d5 100644
>>> --- a/Documentation/virtual/kvm/api.txt
>>> +++ b/Documentation/virtual/kvm/api.txt
>>> @@ -4509,15 +4509,14 @@ Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
>>>  
>>>  Architectures: s390
>>>  Parameters: none
>>> -Returns: 0 on success, -EINVAL if hpage module parameter was not set
>>> -	 or cmma is enabled, or the VM has the KVM_VM_S390_UCONTROL
>>> +Returns: 0 on success, -EINVAL if cmma is enabled, or the VM has the KVM_VM_S390_UCONTROL
>>>  	 flag set
>>>  
>>>  With this capability the KVM support for memory backing with 1m pages
>>>  through hugetlbfs can be enabled for a VM. After the capability is
>>>  enabled, cmma can't be enabled anymore and pfmfi and the storage key
>>> -interpretation are disabled. If cmma has already been enabled or the
>>> -hpage module parameter is not set to 1, -EINVAL is returned.
>>> +interpretation are disabled. If cmma has already been enabled, -EINVAL
>>> +is returned.
>>>  
>>>  While it is generally possible to create a huge page backed VM without
>>>  this capability, the VM will not be able to run.
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index ac5da6b0b862..59f53b7c72d6 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -172,11 +172,6 @@ static int nested;
>>>  module_param(nested, int, S_IRUGO);
>>>  MODULE_PARM_DESC(nested, "Nested virtualization support");
>>>  
>>> -/* allow 1m huge page guest backing, if !nested */
>>> -static int hpage;
>>> -module_param(hpage, int, 0444);
>>> -MODULE_PARM_DESC(hpage, "1m huge page backing support");
>>> -
>>
>>
>> Do we want to keep the parameter for now?
>>
>> This would allow admins to disable it system-wide as long as it is in
>> its early stage? (just like nested). We can allow co-existence, though.
> 
> Both options are fine with me and considering the fixes needed for the
> enablement this might be the better option.

I think keeping the hpage parameter is fine, but we can consider changing
the default to 1. 
