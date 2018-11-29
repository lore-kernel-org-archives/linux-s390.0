From: Michael Mueller <mimu@linux.ibm.com>
Date: Thu, 29 Nov 2018 13:16:46 +0000
Subject: Re: [PATCH v3 09/12] KVM: s390: add functions to (un)register GISC with GISA
Message-Id: <7e015607-dd74-40f8-7cd9-cc917a5fe720@linux.ibm.com>
In-Reply-To: <20181129134622.7e3e7f4d.cohuck@redhat.com>
References: <20181129134622.7e3e7f4d.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 29.11.18 13:46, Cornelia Huck wrote:
> On Thu, 29 Nov 2018 13:35:07 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> On 29.11.18 12:48, Cornelia Huck wrote:
>>> On Thu, 29 Nov 2018 12:24:36 +0100
>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>    
>>>> On 29.11.18 11:55, Cornelia Huck wrote:
>>>>> On Wed, 28 Nov 2018 11:19:40 +0100
>>>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>>>       
>>>>>> Add the IAM (Interruption Alert Mask) to the architectue specific
>>>>>> kvm struct. This mask in the GISA is used to define for which ISC
>>>>>> a GIB alert can be issued.
>>>>>>
>>>>>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
>>>>>> are used to (un)register a GISC (guest ISC) with a virtual machine and
>>>>>> its GISA.
>>>>>>
>>>>>> Upon successful completion, kvm_s390_gisc_register() returns the
>>>>>> ISC to be used for GIB alert interruptions. A negative return code
>>>>>> indicates an error during registration.
>>>>>>
>>>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>>>>> ---
>>>>>>     arch/s390/include/asm/kvm_host.h |  6 ++++++
>>>>>>     arch/s390/kvm/interrupt.c        | 44 ++++++++++++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 50 insertions(+)
>>>>>
>>>>> I've started at this and the following patches and have not found a
>>>>> place where the functions are called... leftover from a previous
>>>>> version?
>>>>
>>>> No, these functions are required by the related driver code.
>>>>
>>>> Pls. see:
>>>>
>>>> Message ID: 1542906675-7949-4-git-send-email-pmorel@linux.ibm.com
>>>>
>>>> [v2,3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl calls
>>>>   
>>>>>       
>>>>   
>>>
>>> I guess they should go with that series, then.
>>
>> No, I don't think so. These functions are part of the
>> *GIB infrastructure* and will by consumed e.g. by VFIO AP
>> with irqs but also by PCI.
> 
> I disagree. The rest of this series lays the groundwork, this patch
> exports two unused functions, and it is much clearer how they are
> supposed to be used with an actual user. Of course PCI can use them
> later on as well :)

Then you could even argue the whole series has to go together with the
AP irq series as it has no effect unless kvm->arch.iam is assigned a
value... ;)

> 
> But in the end, your call.
> 

-- 
Mit freundlichen Gr��en / Kind regards
Michael M�ller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K�deritz
Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
