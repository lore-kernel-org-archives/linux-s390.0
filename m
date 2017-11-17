From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 05/19] s390/zcrypt: base implementation of AP matrix device
 driver
Date: Fri, 17 Nov 2017 16:13:45 -0500
Message-ID: <f93f8ef5-b568-20ad-3e61-2e95193e362c@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171114134040.3fcd6efd.cohuck@redhat.com>
 <06ddee4e-e1b8-ba17-5e3e-241e4dcf7cd0@linux.vnet.ibm.com>
 <c9ec3c2e-bbc5-a08e-acea-0a3030bc90a7@linux.vnet.ibm.com>
 <20171116133531.1135a093.cohuck@redhat.com>
 <f1def4fc-49d8-8662-208b-fcea22ee87b0@linux.vnet.ibm.com>
 <20171116174741.18e3f40b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171116174741.18e3f40b.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/16/2017 11:47 AM, Cornelia Huck wrote:
> On Thu, 16 Nov 2017 09:25:27 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 11/16/2017 07:35 AM, Cornelia Huck wrote:
>>> On Thu, 16 Nov 2017 13:02:26 +0100
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 14/11/2017 17:37, Tony Krowiak wrote:
>>>>> On 11/14/2017 07:40 AM, Cornelia Huck wrote:
>>>>>> On Fri, 13 Oct 2017 13:38:50 -0400
>>>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>>>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>>>>>>> index 48af970..411c19a 100644
>>>>>>> --- a/arch/s390/Kconfig
>>>>>>> +++ b/arch/s390/Kconfig
>>>>>>> @@ -722,6 +722,19 @@ config VFIO_CCW
>>>>>>>           To compile this driver as a module, choose M here: the
>>>>>>>           module will be called vfio_ccw.
>>>>>>> +config VFIO_AP_MATRIX
>>>>>>> +    def_tristate m
>>>>>>> +    prompt "Support for Adjunct Processor Matrix device interface"
>>>>>>> +    depends on ZCRYPT
>>>>>>> +    select VFIO
>>>>>>> +    select MDEV
>>>>>>> +    select VFIO_MDEV
>>>>>>> +    select VFIO_MDEV_DEVICE
>>>>>>> +    select IOMMU_API
>>>>>> I think the more common pattern is to depend on the VFIO configs
>>>>>> instead of selecting them.
>>>>> It's ironic because I originally changed from using 'depends on' and
>>>>> changed it based on review comments made
>>>>> on our internal mailing list. I'll go with 'depends on'.
>>>> Is doing like the others a sufficient good reason?
>>>> What if the first who did this did not really think about it?
>>>>
>>>> When an administrator configure the kernel what does he think?
>>>>
>>>> - I want to have AP through AP_VFIO in my guests
>>>> 	and he get implicitly VFIO
>>>> or
>>>> - I want to have VFIO
>>>> 	and he has to explicitly add AP_VFIO too
>>>>
>>>> It seems to me that the first is much more user friendly.
>>>>
>>>> Please tell me if I missed something. dependencies? collateral damages?
>>>> my logic is wrong?
>>> Using select for anything that's not a simple infrastructure dependency
>>> may lead into trouble (we've had issues in the past where options tried
>>> to enable other options but missed dependencies).
>>>
>>> If a user wants to use vfio-ap, I think it is reasonable to expect them
>>> to figure out that they need both ap and vfio for that.
>>>
>>> [And config help has gotten much better than it was years ago; it's not
>>> that hard to figure out what is actually needed.]
>> Is it sufficient to specify 'depends on ZCRYPT && VFIO_MDEV_DEVICE'
>> since 'VFIO_MDEV_DEVICE depends on VFIO && VFIO_MDEV' and 'VFIO_MDEV
>> depends on VFIO' and 'VFIO depends on IOMMU_API'?
> Perhaps ZCRYPT && VFIO_MDEV && VFIO_MDEV_DEVICE, to make it a bit more
> obvious?
Sure, why not.
>
> [Also, is IOMMU_API only needed to satisfy dependencies?]
Yes, VFIO is dependent upon it.
>
