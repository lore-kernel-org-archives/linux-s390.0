From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Date: Fri, 15 Feb 2019 16:59:33 -0500
Message-ID: <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <20190214155441.087d2a68.cohuck@redhat.com>
 <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
 <20190214175730.4ab609ae.cohuck@redhat.com>
 <9200b1f8-874f-ffa7-bef0-19ca570d7ac1@linux.ibm.com>
 <eac03540-a499-fa0f-1a4a-b5cc99030775@linux.ibm.com>
 <20190215101118.5417d725.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215101118.5417d725.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/15/19 4:11 AM, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 13:30:59 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/14/19 12:36 PM, Pierre Morel wrote:
>>> On 14/02/2019 17:57, Cornelia Huck wrote:
>>>> On Thu, 14 Feb 2019 16:47:30 +0100 Pierre Morel
>>>> <pmorel@linux.ibm.com> wrote:
>>>>   
>>>>> On 14/02/2019 15:54, Cornelia Huck wrote:
>>>>>> On Thu, 14 Feb 2019 14:51:01 +0100 Pierre Morel
>>>>>> <pmorel@linux.ibm.com> wrote:
> 
>>>>>>> -    matrix_dev->device.type = &vfio_ap_dev_type;
>>>>>>> dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>>>>>> matrix_dev->device.parent = root_device; +
>>>>>>> matrix_dev->device.bus = &matrix_bus; matrix_dev->device.release =
>>>>>>> vfio_ap_matrix_dev_release; -
>>>>>>> matrix_dev->device.driver = &vfio_ap_drv.driver; +
>>>>>>> matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>>>>>
>>>>>> Can't you get that structure through matrix_dev->device.driver
>>>>>> instead when you need it in the function below?
>>>>>
>>>>> Not anymore. We have two different drivers and devices matrix_drv
>>>>> <-> matrix_dev and vfio_ap_drv <-> ap_devices
>>>>>
>>>>> The driver behind the matrix_dev->dev->driver is matrix_drv what is
>>>>> needed here is vfio_ap_drv.
>>>>
>>>> Wait, we had tacked a driver for ap devices unto a matrix device,
>>>> which is not on the ap bus?
>>
>> It's really a bit more complicated than that. Without going into a
>> lengthy description of the history of AP passthrough support, suffice it
>> to say that we needed a device to serve as the parent of each mediated
>> device used to configure a matrix of AP adapter IDs and domain indexes
>> identifying the devices to which a guest would be granted access. The
>> AP devices themselves are attached to the AP bus, but the matrix device
>> is an artificial (virtual?) device whose sole purpose in life is to
>> serve as an anchor for the mediated devices whose sysfs interfaces are
>> created and managed by the vfio_ap device driver. The matrix device
>> itself is created by the vfio_ap device driver - when it is initialized
>> - for that purpose. In hindsight, maybe there was a better way to
>> implement this, but neither this patch nor this discussion belongs in
>> this series. It distracts from discussion of interrupt support which is
>> the sole purpose of the patch series.
> 
> The we-need-a-parent part is fine; but whatever we're doing with that
> driver just looks wrong, so that even the new bus that basically does
> nothing looks better...

I believe there might be a much better way to handle this which is why
I objected to this patch being delivered with this series, which
provides AP interrupt support. Quite simply, this patch has no
relationship to interrupt support and should be considered as an item
unto itself. To conduct a review within the context of interrupt
support distracts focus from the pertinent subject matter.

> 
>>
>>>
>>> ...yes -(
>>>    
>>>> Maybe that's what trips libudev? >
>>>> (And reading further in the current code, it seems we clear that
>>>> structure _after_ the matrix device had been setup, so how can that
>>>> even work? Where am I confused?)
>>>
>>> On device_register there were no bus, so the core just do not look for a
>>> driver and this field was nor tested nor overwritten.
> 
> Hm... so has the callback in driver_for_each_device() in
> vfio_ap_verify_queue_reserved() ever been invoked at all? It seems this
> patch fixes more than just libudev issues...

It is this patch that rendered the driver_for_each_device() in
vfio_ap_verify_queue_reserved() erroneous. That function gets called
every time an adapter or domain is assigned to the mdev. This patch
introduced the problem with driver_for_each_device().

> 
>>>    
>>>>   
>>>>>   
>>>>>>   
>>>>>>>
>>>>>>> ret = device_register(&matrix_dev->device); if (ret) goto
>>>>>>> matrix_reg_err;
>>>>>>>
>>>>>>> +    ret = driver_register(&matrix_driver.drv); +    if (ret)
>>>>>>> +        goto
>>>>>>> matrix_drv_err; +
>>>>>>
>>>>>> As you already have several structures that can be registered
>>>>>> exactly once (the root device, the bus, the driver, ...), you can
>>>>>> already be sure that there's only one device on the bus, can't
>>>>>> you?
>>>>>
>>>>> hum, no I don't think so, no device can register before this module
>>>>> is loaded, but what does prevent a device to register later from
>>>>> another module?
>>>>
>>>> Not unless you export the interface, I guess.
>>>>   
>>>
>>> :) definitively right
>>> thanks, this will simplify the code in the next version.
>>> I will take the patch away from this series to get the way to stable as
>>> Christian requested.
> 
> Yeah, makes sense.
> 
