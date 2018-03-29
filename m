From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 01/14] KVM: s390: refactor crypto initialization
Date: Thu, 29 Mar 2018 14:57:22 -0400
Message-ID: <5c659a5e-1933-366b-65fc-6e9eabe504d5@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f87a6adb-8982-c194-7925-0c88060ebef2@linux.vnet.ibm.com>
 <d0b44d6e-8b98-f8ca-7cf5-dfcdf38c79f6@linux.vnet.ibm.com>
 <3227b02e-4a16-295d-9a01-043702cf149d@linux.vnet.ibm.com>
 <20180326104455.7773be7b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180326104455.7773be7b.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03/26/2018 04:44 AM, Cornelia Huck wrote:
> On Thu, 15 Mar 2018 15:55:39 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 15/03/2018 15:48, Tony Krowiak wrote:
>>> On 03/15/2018 08:26 AM, Pierre Morel wrote:
>>>> On 14/03/2018 19:25, Tony Krowiak wrote:
>>>>> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
>>>>> index a3dbd45..4ca9077 100644
>>>>> --- a/arch/s390/kvm/Kconfig
>>>>> +++ b/arch/s390/kvm/Kconfig
>>>>> @@ -33,6 +33,7 @@ config KVM
>>>>>        select HAVE_KVM_INVALID_WAKEUPS
>>>>>        select SRCU
>>>>>        select KVM_VFIO
>>>>> +    select ZCRYPT
>>>> I do not think it is a good solution to *always* enable ZCRYPT
>>>> when we have KVM.
>>> If CONFIG_ZCRYPT is not selected, then the kvm_ap_apxa_installed()
>>> function will not compile
>>> because it calls a zcrypt interface. How would you suggest we make
>>> sure zcrypt interfaces
>>> used in KVM are built if CONFIG_ZCRYPT is not selected?
>> if zcrypt is not configured, I suppose that the KVM code initializaing CRYCB
>> has no use but the function will be called from KVM.
>> So I would do something like:
>>
>> #ifdef ZCRYPT
>> external definitions.
>> #else
>> stubs returning error -ENOZCRYPT (or whatever)
>> #endif
> The kvm code used some kind of detection for crycb before (IIRC it was
> for the key-wrapping stuff). I assume that usage is independent of
> zcrypt driver usage in the host?
A function in kvm-s390.c was replaced with a call to the function in
ap_bus.c that was externalized in patch 2/14. This was done to remove
duplicate code. Since zcrypt is built into the kernel, I didn't think
it would be a problem, but apparently because of the way zcrypt is
configured, it is still possible to remove it from the kernel build.
>
> So, I think that apxa detection function should be used to s390
> architecture base code and not be conditional on anything.
I am convinced that the original function from kvm_s390.c should be
restored.
>
