From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 27 Jul 2018 13:37:26 +0000
Subject: Re: [PATCH v7 08/22] s390: vfio-ap: base implementation of VFIO AP device driver
Message-Id: <d95a386c-9c47-64ac-41d4-933240e95a05@linux.ibm.com>
In-Reply-To: <20180727112101.47e41c1d.cohuck@redhat.com>
References: <20180727112101.47e41c1d.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 07/27/2018 11:21 AM, Cornelia Huck wrote:
> On Thu, 26 Jul 2018 21:54:15 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces a new AP device driver. This device driver
>> is built on the VFIO mediated device framework. The framework
>> provides sysfs interfaces that facilitate passthrough
>> access by guests to devices installed on the linux host.
>>
>> The VFIO AP device driver will serve two purposes:
>>
>> 1. Provide the interfaces to reserve AP devices for exclusive
>>     use by KVM guests. This is accomplished by unbinding the
>>     devices to be reserved for guest usage from the default AP
>>     device driver and binding them to the VFIO AP device driver.
>>
>> 2. Implements the functions, callbacks and sysfs attribute
>>     interfaces required to create one or more VFIO mediated
>>     devices each of which will be used to configure the AP
>>     matrix for a guest and serve as a file descriptor
>>     for facilitating communication between QEMU and the
>>     VFIO AP device driver.
>>
>> When the VFIO AP device driver is initialized:
>>
>> * It registers with the AP bus for control of type 10 (CEX4
>>    and newer) AP queue devices. This limitation was imposed
>>    due to:
>>
>>    1. A desire to keep the code as simple as possible;
>>
>>    2. Some older models are no longer supported by the kernel
>>       and others are getting close to end of service.
>>
>>    The probe and remove callbacks will be provided to support
>>    the binding/unbinding of AP queue devices to/from the VFIO
>>    AP device driver.
>>
>> * Creates a virtual misc device, /sys/devices/virtual/misc/vfio_ap,
>>    device to serve as the parent of the mediated devices created, one
>>    for each guest, and to hold the APQNs of the AP devices bound to
>>    the VFIO AP device driver.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   MAINTAINERS                           |  10 +++
>>   arch/s390/Kconfig                     |  11 +++
>>   drivers/s390/crypto/Makefile          |   4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     | 112 ++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  30 +++++++
>>   include/uapi/linux/vfio.h             |   2 +
>>   6 files changed, 169 insertions(+)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>>   create mode 100644 drivers/s390/crypto/vfio_ap_private.h
>>
> 
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 1aa7b82e8169..f378b9802d8b 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -200,6 +200,7 @@ struct vfio_device_info {
>>   #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>>   #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>>   #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
>> +#define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */

And this one is also unused for now I guess.

>>   	__u32	num_regions;	/* Max region index + 1 */
>>   	__u32	num_irqs;	/* Max IRQ index + 1 */
>>   };
>> @@ -215,6 +216,7 @@ struct vfio_device_info {
>>   #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
>>   #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
>>   #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
>> +#define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
>>   
>>   /**
>>    * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
> 
> Should this hunk go into the next patch?
> 

Yes.
