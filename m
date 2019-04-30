Return-Path: <SRS0=Ul9H=TA=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v7 2/4] vfio: ap: register IOMMU VFIO notifier
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
 <1556283688-556-3-git-send-email-pmorel@linux.ibm.com>
 <20190429180702.641c9110.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 30 Apr 2019 09:59:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190429180702.641c9110.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b1577203-78c7-24f3-9357-42159feb08ae@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 29/04/2019 18:07, Halil Pasic wrote:
> On Fri, 26 Apr 2019 15:01:26 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> @@ -858,7 +887,17 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   		return ret;
>>   	}
>>   
>> -	return 0;
>> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				     &events, &matrix_mdev->iommu_notifier);
>> +	if (!ret)
>> +		return ret;
>> +
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +				 &matrix_mdev->group_notifier);
>> +	module_put(THIS_MODULE);
> 
> Can you please explain this module_put() here? I don't see anything in
> the cover letter.

May be you should have a look at the sources or the original patch 
series of Tony, there is a try_module_get() at the beginning of open to 
make sure that the module is not taken away while in use by the guest.

In the case we failed to open the mediated device we let fall the reference.

Regards,
Pierre


> 
> Regards,
> Halil
> 
>> +	return ret;
>>   }
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
