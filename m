From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Date: Thu, 14 Feb 2019 16:47:30 +0100
Message-ID: <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <20190214155441.087d2a68.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214155441.087d2a68.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 14/02/2019 15:54, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 14:51:01 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> Libudev relies on having a subsystem link for non-root devices. To
>> avoid libudev (and potentially other userspace tools) choking on the
>> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
>> bus subsytem, and make the matrix device reside within it.
> 
> How does libudev choke on this? It feels wrong to introduce a bus that
> basically does nothing...

Christian answered this in another thread, so I don't answer.

> 
>>
>> We restrict the number of allowed devices to a single one.
>>
...snip...

>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -24,8 +24,9 @@ MODULE_LICENSE("GPL v2");
>>   
>>   static struct ap_driver vfio_ap_drv;
>>   
>> -static struct device_type vfio_ap_dev_type = {
>> -	.name = VFIO_AP_DEV_TYPE_NAME,
>> +struct matrix_driver {
>> +	struct device_driver drv;
>> +	int device_count;
> 
> This counter basically ensures that at most one device may bind with
> this driver... you'd still have that device on the bus, though.

yes, this is what is wanted: this driver can only support one device.
May be another matrix driver can support one or more other devices.

I should update comment message my be.

> 
>>   };
>>   
>>   struct ap_matrix_dev *matrix_dev;

>>   
>> -	matrix_dev->device.type = &vfio_ap_dev_type;
>>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>   	matrix_dev->device.parent = root_device;
>> +	matrix_dev->device.bus = &matrix_bus;
>>   	matrix_dev->device.release = vfio_ap_matrix_dev_release;
>> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
>> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
> 
> Can't you get that structure through matrix_dev->device.driver instead
> when you need it in the function below?

Not anymore.
We have two different drivers and devices
matrix_drv <-> matrix_dev
and
vfio_ap_drv <-> ap_devices

The driver behind the matrix_dev->dev->driver is matrix_drv
what is needed here is vfio_ap_drv.

> 
>>   
>>   	ret = device_register(&matrix_dev->device);
>>   	if (ret)
>>   		goto matrix_reg_err;
>>   
>> +	ret = driver_register(&matrix_driver.drv);
>> +	if (ret)
>> +		goto matrix_drv_err;
>> +
> 
> As you already have several structures that can be registered exactly
> once (the root device, the bus, the driver, ...), you can already be
> sure that there's only one device on the bus, can't you?

hum, no I don't think so, no device can register before this module is 
loaded, but what does prevent a device to register later from another 
module?



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
