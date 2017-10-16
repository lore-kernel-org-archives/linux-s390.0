From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 06/19] s390/zcrypt: register matrix device with VFIO
 mediated device framework
Date: Mon, 16 Oct 2017 12:09:07 -0400
Message-ID: <17ca0940-e6eb-f810-b51b-b4d008b7b471@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016110329.234c9adb@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016110329.234c9adb@mschwideX1>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/16/2017 05:03 AM, Martin Schwidefsky wrote:
> On Fri, 13 Oct 2017 13:38:51 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> diff --git a/drivers/s390/crypto/ap_matrix_bus.c b/drivers/s390/crypto/ap_matrix_bus.c
>> index 66bfa54..418c23b 100644
>> --- a/drivers/s390/crypto/ap_matrix_bus.c
>> +++ b/drivers/s390/crypto/ap_matrix_bus.c
>> @@ -61,6 +61,7 @@ static int ap_matrix_dev_create(void)
>>   	matrix->device.bus = &ap_matrix_bus_type;
>>   	matrix->device.parent = ap_matrix_root_device;
>>   	matrix->device.release = ap_matrix_dev_release;
>> +	INIT_LIST_HEAD(&matrix->queues);
>>
>>   	ret = device_register(&matrix->device);
>>   	if (ret) {
>> diff --git a/drivers/s390/crypto/ap_matrix_bus.h b/drivers/s390/crypto/ap_matrix_bus.h
>> index c2aff23..3eccc36 100644
>> --- a/drivers/s390/crypto/ap_matrix_bus.h
>> +++ b/drivers/s390/crypto/ap_matrix_bus.h
>> @@ -12,8 +12,12 @@
>>
>>   #include <linux/device.h>
>>
>> +#include "ap_bus.h"
>> +
>>   struct ap_matrix {
>>   	struct device device;
>> +	spinlock_t qlock;
>> +	struct list_head queues;
>>   };
>>
>>   struct ap_matrix *ap_matrix_get_device(void);
> Move these two hunks into patch #5 please. Yes, strictly speaking the two elements
> in the struct ap_matrix are needed only with patch #6, but it is fine to introduce
> an element with a new driver that is only exploited with a later patch.
Will do.
>
