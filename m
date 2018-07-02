From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 07/21] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Mon, 2 Jul 2018 11:39:23 -0400
Message-ID: <51fada6f-db0b-b884-7bd7-07cddecf3824@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f4fdea7d-1c4d-bb6e-1dd2-27e441dc9837@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f4fdea7d-1c4d-bb6e-1dd2-27e441dc9837@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/02/2018 09:53 AM, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
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
>>    1. A lack of access to older systems needed to test the
>>       older AP device models;
>>
>>    2. A desire to keep the code as simple as possible;
>>
>>    3. Some older models are no longer supported by the kernel
>>       and others are getting close to end of service.
>>
>>    The probe and remove callbacks will be provided to support
>>    the binding/unbinding of AP queue devices to/from the VFIO
>>    AP device driver.
>>
>> * Creates a /sys/devices/vfio-ap/matrix device to hold
>>    the APQNs of the AP devices bound to the VFIO
>>    AP device driver and serves as the parent of the
>>    mediated devices created for each guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   MAINTAINERS                           |   10 +++
>>   arch/s390/Kconfig                     |   11 +++
>>   drivers/s390/crypto/Makefile          |    4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     |  140 
>> +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   29 +++++++
>>   include/uapi/linux/vfio.h             |    2 +
>>   samples/bpf/bpf_load.c                |   62 +++++++++++++++
>
> You have probably touched the last one by accident.

I'll have to figure out what happened here.

>
>
> Regards,
> Halil
