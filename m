Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
 <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
 <6cc5b478-4678-9a82-b902-cc9aed22becf@linux.ibm.com>
 <20190220102731.4fca4f91.cohuck@redhat.com>
 <20190220135108.49f8f891@oc2783563651>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 21 Feb 2019 13:10:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190220135108.49f8f891@oc2783563651>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <fd574b7b-7c2f-eeea-1d53-caadcd2fed48@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 20/02/2019 13:51, Halil Pasic wrote:
> On Wed, 20 Feb 2019 10:27:31 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 19 Feb 2019 22:31:17 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 19/02/2019 19:52, Tony Krowiak wrote:
>>>> On 2/18/19 1:08 PM, Pierre Morel wrote:
>>>>> Libudev relies on having a subsystem link for non-root devices. To

...snip...

>>>>> +
>>>>> +static struct device_driver matrix_driver = {
>>>>> +    .name = "vfio_ap",
>>>>
>>>> This is the same name used for the original device driver. I think
>>>> this driver ought to have a different name to avoid confusion.
>>>> How about vfio_ap_matrix or some other name to differentiate the
>>>> two.
>>>
>>> I would like too, but changing this will change the path to the mediated
>>> device supported type.
>>
>> Yes, we don't want to change that.
>>
> 
> Nod.

However if I cannot change the driver name, I can change the bus name to 
matrix.
At least one less "vfio_ap" name

> 
>>>
>>>
>>>>    
>>>>> +    .bus = &matrix_bus,
>>>>> +    .probe = matrix_probe,
>>>>
>>>> I would add:
>>>>       .suppress_bind_attrs = true;
>>>>
>>>> This will remove the sysfs bind/unbind interfaces. Since there is only
>>>> one matrix device and it's lifecycle is controlled herein, there is no
>>>> sense in allowing a root user to bind/unbind it.
>>>>    
>>>
>>> OTOH bind/unbind has no impact.
>>> If no one else ask for this I will not change what has already been
>>> reviewed by Conny and Christian.
>>
>> As we only have one driver, it does not really make sense anyway.
>>
> 
> I see this as a reason to suppress_bind_attrs. It is much easier than to
> think about what should happen when one unbinds the matrix device from
> the vfio_ap driver on the vfio_ap bus. With the code as is it seems to
> just keep working as if nothing happened.
> And /sys/devices/vfio_ap/matrix/mdev_supported_types/ referencing the
> name of the driver that is already gone sounds a bit weird.
> 
> Regards,
> Halil
> 

If there is no objection I will do this,
It seems more logical to me too.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
