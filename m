From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 05/14] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Thu, 15 Mar 2018 13:25:25 -0400
Message-ID: <e4d7621c-a09c-bdfd-ffe2-35c5ea3acdc7@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1d5a5e18-1886-dd73-a17e-9bec617507ba@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1d5a5e18-1886-dd73-a17e-9bec617507ba@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03/15/2018 09:25 AM, Pierre Morel wrote:
> On 14/03/2018 19:25, Tony Krowiak wrote:
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
>>    and newer) AP queue devices. The probe and remove callbacks
>>    will be provided to support the binding/unbinding of
>>    AP queue devices to/from the VFIO AP device driver.
>>
>> * Creates a /sys/devices/vfio-ap/matrix device to hold
>>    the APQNs of the AP devices bound to the VFIO
>>    AP device driver and serves as the parent of the
>>    mediated devices created for each guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                           |    2 +
>>   arch/s390/Kconfig                     |   11 +++
>>   drivers/s390/crypto/Makefile          |    4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     |  135 
>> +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   22 ++++++
>>   include/uapi/linux/vfio.h             |    2 +
>>   6 files changed, 176 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>>   create mode 100644 drivers/s390/crypto/vfio_ap_private.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 72742d5..f129253 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11884,6 +11884,8 @@ W: 
>> http://www.ibm.com/developerworks/linux/linux390/
>>   S:    Supported
>>   F:    arch/s390/include/asm/kvm/kvm-ap.h
>>   F:    arch/s390/kvm/kvm-ap.c
>> +F:    drivers/s390/crypto/vfio_ap_drv.c
>> +F:    drivers/s390/crypto/vfio_ap_private.h
>>
>>   S390 ZFCP DRIVER
>>   M:    Steffen Maier <maier@linux.vnet.ibm.com>
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index cbe1d97..58509db 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -771,6 +771,17 @@ config VFIO_CCW
>>         To compile this driver as a module, choose M here: the
>>         module will be called vfio_ccw.
>>
>> +config VFIO_AP
>> +    def_tristate m
> not sure it must be module by default.
> I would not set it by default.
Connie also asked about this in the last review, so I will go ahead
and change it.
>
>> +    prompt "VFIO support for AP devices"
>> +    depends on ZCRYPT && VFIO_MDEV_DEVICE
>
> VFIO_MDEV_DEVICE is a general feature *needed* by VFIO_AP
> and has no use case by its own. If it is set it is obviously because some
> mediated device drivers needs it.
> while ZCRYPT is a Z feature which may be set without VFIO_AP.
>
> So you need:
>
> config VFIO_AP
>     def_tristate n
>     prompt "VFIO support for AP devices"
>     depends on ZCRYPT
>     select VFIO_MDEV
>     select VFIO_MDEV_DEVICE
> ...
I was thinking the same just yesterday and I agree, this makes sense.
>
>
>
> Pierre
>
