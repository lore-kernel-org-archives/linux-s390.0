From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 04/26] s390: vfio-ap: base implementation of VFIO AP
 device driver
Date: Thu, 20 Sep 2018 11:53:19 -0400
Message-ID: <528f4faa-6c0f-ec48-5f8d-aaacc060871f@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180920173156.70299b6c.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920173156.70299b6c.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/20/2018 11:31 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:54 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
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
>>     devices to be reserved for guest usage from the zcrypt
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
>> * Creates a matrix device, /sys/devices/vfio_ap/matrix,
>>    to serve as the parent of the mediated devices created, one
>>    for each guest, and to hold the APQNs of the AP devices bound to
>>    the VFIO AP device driver.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Christian's S-o-b looks a bit odd here; OTOH, it's probably him anyway
> who will queue the patches in the end :)

It went in there when Christian submitted the patch series in my absence 
back in
July while I was on vacation. I wasn't aware it was in the actual commit 
message,
so it never got removed. I'll remove it if a v11 needs to be submitted.

>
>> ---
>>   MAINTAINERS                           |   10 +++
>>   arch/s390/Kconfig                     |   11 +++
>>   drivers/iommu/Kconfig                 |    8 ++
>>   drivers/s390/crypto/Makefile          |    4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     |  134 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   34 ++++++++
>>   6 files changed, 201 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>>   create mode 100644 drivers/s390/crypto/vfio_ap_private.h
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>
