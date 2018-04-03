From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 08/14] s390: vfio-ap: sysfs interfaces to configure
 adapters
Date: Tue, 3 Apr 2018 09:33:40 -0400
Message-ID: <5d5052ce-8811-21a2-5a0d-06187a3dc788@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180403131002.3e3cfb49.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403131002.3e3cfb49.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 04/03/2018 07:10 AM, Cornelia Huck wrote:
> On Wed, 14 Mar 2018 14:25:48 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index a388b66..f6e7ed1 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/types.h>
>>   #include <linux/device.h>
>>   #include <linux/mdev.h>
>> +#include <asm/kvm-ap.h>
>>   
>>   #include "ap_bus.h"
>>   
> Does this hunk belong in this patch?
It does look out of place here. I'll restore it to its rightful resting 
place.
>
