Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
 <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
 <f07b6209-bca2-22fe-310e-1e384c8974d9@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 21 Feb 2019 08:37:59 +0100
MIME-Version: 1.0
In-Reply-To: <f07b6209-bca2-22fe-310e-1e384c8974d9@linux.ibm.com>
Content-Language: en-US
Message-Id: <3c3a90ca-f7ea-7800-453d-31e6d273e82f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 20.02.2019 14:12, Harald Freudenberger wrote:
> On 18.02.19 19:08, Pierre Morel wrote:
>> Libudev relies on having a subsystem link for non-root devices. To
>> avoid libudev (and potentially other userspace tools) choking on the
>> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
>> bus subsytem, and make the matrix device reside within it.
>>
>> Doing this we need to suppress the forced link from the matrix device to
>> the vfio_ap driver and we suppress the device_type we do not need
>> anymore.
>>
>> Since the associated matrix driver is not the vfio_ap driver any more,
>> we have to change the search for the devices on the vfio_ap driver in
>> the function vfio_ap_verify_queue_reserved.
>>
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/vfio_ap_drv.c     | 48 +++++++++++++++++++++++++++++------
>>  drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>>  drivers/s390/crypto/vfio_ap_private.h |  1 +
>>  3 files changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 31c6c84..8e45559 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -24,10 +24,6 @@ MODULE_LICENSE("GPL v2");
>>  
>>  static struct ap_driver vfio_ap_drv;
>>  
>> -static struct device_type vfio_ap_dev_type = {
>> -	.name = VFIO_AP_DEV_TYPE_NAME,
>> -};
>> -
>>  struct ap_matrix_dev *matrix_dev;
>>  
>>  /* Only type 10 adapters (CEX4 and later) are supported
>> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>>  	kfree(matrix_dev);
>>  }
>>  
>> +static int matrix_bus_match(struct device *dev, struct device_driver *drv)
>> +{
>> +	return 1;
>> +}
>> +
>> +static struct bus_type matrix_bus = {
>> +	.name = "vfio_ap",
>> +	.match = &matrix_bus_match,
>> +};
>> +
>> +static int matrix_probe(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct device_driver matrix_driver = {
>> +	.name = "vfio_ap",
>> +	.bus = &matrix_bus,
>> +	.probe = matrix_probe,
>> +};
>> +
>>  static int vfio_ap_matrix_dev_create(void)
>>  {
>>  	int ret;
>> @@ -71,6 +88,10 @@ static int vfio_ap_matrix_dev_create(void)
>>  	if (IS_ERR(root_device))
>>  		return PTR_ERR(root_device);
>>  
>> +	ret = bus_register(&matrix_bus);
>> +	if (ret)
>> +		goto bus_register_err;
>> +
>>  	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
>>  	if (!matrix_dev) {
>>  		ret = -ENOMEM;
>> @@ -87,30 +108,41 @@ static int vfio_ap_matrix_dev_create(void)
>>  	mutex_init(&matrix_dev->lock);
>>  	INIT_LIST_HEAD(&matrix_dev->mdev_list);
>>  
>> -	matrix_dev->device.type = &vfio_ap_dev_type;
>>  	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>  	matrix_dev->device.parent = root_device;
>> +	matrix_dev->device.bus = &matrix_bus;
>>  	matrix_dev->device.release = vfio_ap_matrix_dev_release;
>> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
>> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>  
>>  	ret = device_register(&matrix_dev->device);
>>  	if (ret)
>>  		goto matrix_reg_err;
>>  
>> +	ret = driver_register(&matrix_driver);
>> +	if (ret)
>> +		goto matrix_drv_err;
>> +
>>  	return 0;
>>  
>> +matrix_drv_err:
>> +	device_unregister(&matrix_dev->device);
>>  matrix_reg_err:
>>  	put_device(&matrix_dev->device);
>>  matrix_alloc_err:
>> +	bus_unregister(&matrix_bus);
>> +bus_register_err:
>>  	root_device_unregister(root_device);
>> -
>>  	return ret;
>>  }
>>  
>>  static void vfio_ap_matrix_dev_destroy(void)
>>  {
>> +	struct device *root_device = matrix_dev->device.parent;
>> +
>> +	driver_unregister(&matrix_driver);
>>  	device_unregister(&matrix_dev->device);
>> -	root_device_unregister(matrix_dev->device.parent);
>> +	bus_unregister(&matrix_bus);
>> +	root_device_unregister(root_device);
>>  }
>>  
>>  static int __init vfio_ap_init(void)
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 272ef42..900b9cf 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>>  	qres.apqi = apqi;
>>  	qres.reserved = false;
>>  
>> -	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
>> -				     vfio_ap_has_queue);
>> +	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> +				     &qres, vfio_ap_has_queue);
>>  	if (ret)
>>  		return ret;
>>  
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 5675492..76b7f98 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -40,6 +40,7 @@ struct ap_matrix_dev {
>>  	struct ap_config_info info;
>>  	struct list_head mdev_list;
>>  	struct mutex lock;
>> +	struct ap_driver  *vfio_ap_drv;
>>  };
>>  
>>  extern struct ap_matrix_dev *matrix_dev;
> 
> You are introducing a new bus just for a user space application which is unable
> to deal with a device directly attached to the root of devices ? So you are fixing
> kernel code because of disability of userspace code. Hm, you are switching
> root cause and effect. However, not my job.

the kernel rule is pretty simple. If userspace breaks due to a kernel change fix the
kernel.

> 
> Why do you need this dummy bus ? Did you evaluate using a "class" subsystem
> instead ? This is very common and my assumption is that libudev is able to handle
> this. I am using a "zcrypt" class for providing additional zcrypt device nodes and
> this works fine together with udev. I would avoid the introduction and maintenance
> of bus code at any cost.

The class variant sounds promising. Pierre what do you think?
> 
> Btw. having a look onto the naming ... the module is named "vfio_ap", the
> driver is named "vfio_ap", the bus is named "vfio_ap", the root bus device is
> named "vfio_ap" ... a bunch of vfio_aps naming different things.
> 
> regards
> Harald Freudenberger
> 
