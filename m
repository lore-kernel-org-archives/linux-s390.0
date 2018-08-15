From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 18/22] s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
Date: Wed, 15 Aug 2018 17:05:48 -0400
Message-ID: <4bcf1214-1978-aa11-ca22-7ab4352dacfb@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-19-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815183835.66470bc6.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815183835.66470bc6.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/15/2018 12:38 PM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:15 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Implements the VFIO_DEVICE_RESET ioctl. This ioctl zeroizes
>> all of the AP queues assigned to the guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index cc90323..d4a065b 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -832,7 +832,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>>   	if (info.argsz < minsz)
>>   		return -EINVAL;
>>   
>> -	info.flags = VFIO_DEVICE_FLAGS_AP;
>> +	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
>>   	info.num_regions = 0;
>>   	info.num_irqs = 0;
>>   
>> @@ -848,6 +848,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>>   	case VFIO_DEVICE_GET_INFO:
>>   		ret = vfio_ap_mdev_get_device_info(arg);
>>   		break;
>> +	case VFIO_DEVICE_RESET:
>> +		ret = vfio_ap_mdev_reset_queues(mdev, true);
> If I see it correctly, you call this function only ever with force ==
> true (here and in the previous patch). Is that what you intended?

That does seem to be the case now; however, I think at one time there were
additional calls to this function. For some reason of which I am not aware,
those were removed, so there is probably no need for it now.

>
>> +		break;
>>   	default:
>>   		ret = -EOPNOTSUPP;
>>   		break;
