From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Date: Thu, 14 Feb 2019 16:09:38 +0100
Message-ID: <38519183-5668-d05a-6d27-19d85858323c@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <8d4a76f9-9cc8-691f-b1ae-ec6e95324e74@de.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d4a76f9-9cc8-691f-b1ae-ec6e95324e74@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 14/02/2019 16:01, Christian Borntraeger wrote:
> 
> 
> On 14.02.2019 14:51, Pierre Morel wrote:
>> Libudev relies on having a subsystem link for non-root devices. To
>> avoid libudev (and potentially other userspace tools) choking on the
>> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
>> bus subsytem, and make the matrix device reside within it.
>>
>> We restrict the number of allowed devices to a single one.
>>
>> Doing this we need to suppress the forced link from the matrix device to
>> the vfio_ap driver and we suppress the device_type we do not need
>> anymore.
>>
>> Since the associated matrix driver is not the vfio_ap driver any more,
>> we have to change the search for the devices on the vfio_ap driver in
>> the function vfio_ap_verify_queue_reserved.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Didnt you want to a add a reported-by?

Yes, forgot it.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>



>> ---
> 
> 
>>   drivers/s390/crypto/vfio_ap_drv.c     | 63 +++++++++++++++++++++++++++++++----
>>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
>>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>>   3 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 31c6c84..1fd5fe6 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
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
>>   };
>>   
>>   struct ap_matrix_dev *matrix_dev;
>> @@ -62,6 +63,41 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
>>   	kfree(matrix_dev);
>>   }
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
>> +static int matrix_probe(struct device *dev);
>> +static int matrix_remove(struct device *dev);
>> +static struct matrix_driver matrix_driver = {
>> +	.drv = {
>> +		.name = "vfio_ap",
>> +		.bus = &matrix_bus,
>> +		.probe = matrix_probe,
>> +		.remove = matrix_remove,
>> +	},
>> +};
>> +
>> +static int matrix_probe(struct device *dev)
>> +{
>> +	if (matrix_driver.device_count)
>> +		return -EEXIST;
>> +	matrix_driver.device_count++;
>> +	return 0;
>> +}
>> +
>> +static int matrix_remove(struct device *dev)
>> +{
>> +	matrix_driver.device_count--;
>> +	return 0;
>> +}
>> +
>>   static int vfio_ap_matrix_dev_create(void)
>>   {
>>   	int ret;
>> @@ -71,6 +107,10 @@ static int vfio_ap_matrix_dev_create(void)
>>   	if (IS_ERR(root_device))
>>   		return PTR_ERR(root_device);
>>   
>> +	ret = bus_register(&matrix_bus);
>> +	if (ret)
>> +		goto bus_register_err;
>> +
>>   	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
>>   	if (!matrix_dev) {
>>   		ret = -ENOMEM;
>> @@ -87,30 +127,41 @@ static int vfio_ap_matrix_dev_create(void)
>>   	mutex_init(&matrix_dev->lock);
>>   	INIT_LIST_HEAD(&matrix_dev->mdev_list);
>>   
>> -	matrix_dev->device.type = &vfio_ap_dev_type;
>>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>   	matrix_dev->device.parent = root_device;
>> +	matrix_dev->device.bus = &matrix_bus;
>>   	matrix_dev->device.release = vfio_ap_matrix_dev_release;
>> -	matrix_dev->device.driver = &vfio_ap_drv.driver;
>> +	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
>>   
>>   	ret = device_register(&matrix_dev->device);
>>   	if (ret)
>>   		goto matrix_reg_err;
>>   
>> +	ret = driver_register(&matrix_driver.drv);
>> +	if (ret)
>> +		goto matrix_drv_err;
>> +
>>   	return 0;
>>   
>> +matrix_drv_err:
>> +	device_unregister(&matrix_dev->device);
>>   matrix_reg_err:
>>   	put_device(&matrix_dev->device);
>>   matrix_alloc_err:
>> +	bus_unregister(&matrix_bus);
>> +bus_register_err:
>>   	root_device_unregister(root_device);
>> -
>>   	return ret;
>>   }
>>   
>>   static void vfio_ap_matrix_dev_destroy(void)
>>   {
>> +	struct device *root_device = matrix_dev->device.parent;
>> +
>> +	driver_unregister(&matrix_driver.drv);
>>   	device_unregister(&matrix_dev->device);
>> -	root_device_unregister(matrix_dev->device.parent);
>> +	bus_unregister(&matrix_bus);
>> +	root_device_unregister(root_device);
>>   }
>>   
>>   static int __init vfio_ap_init(void)
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 272ef42..900b9cf 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>>   	qres.apqi = apqi;
>>   	qres.reserved = false;
>>   
>> -	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
>> -				     vfio_ap_has_queue);
>> +	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> +				     &qres, vfio_ap_has_queue);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 5675492..76b7f98 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -40,6 +40,7 @@ struct ap_matrix_dev {
>>   	struct ap_config_info info;
>>   	struct list_head mdev_list;
>>   	struct mutex lock;
>> +	struct ap_driver  *vfio_ap_drv;
>>   };
>>   
>>   extern struct ap_matrix_dev *matrix_dev;
>>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
