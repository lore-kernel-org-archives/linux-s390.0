From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 4/7] s390: ap: setup relation betwen KVM and mediated
 device
Date: Tue, 19 Mar 2019 10:38:42 +0100
Message-ID: <7c199329-0e82-ff61-46b7-78237a0f01ce@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
 <20190315191557.6c8d7668@oc2783563651>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315191557.6c8d7668@oc2783563651>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/03/2019 19:15, Halil Pasic wrote:
> On Wed, 13 Mar 2019 17:05:01 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> When the mediated device is open we setup the relation with KVM unset it
>> when the mediated device is released.
>>
>> We ensure KVM is present on opening of the mediated device.
>>
>> We ensure that KVM survives the mediated device, and establish a direct
> 
> survives?

what alternative do you prefer?

> 
>> link from KVM to the mediated device to simplify the relationship.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---

...snip...

>>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>   				       unsigned long action, void *data)
>>   {
>> -	int ret;
>>   	struct ap_matrix_mdev *matrix_mdev;
>>   
>>   	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>>   		return NOTIFY_OK;
>>   
>>   	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>> -
>> -	if (!data) {
>> -		matrix_mdev->kvm = NULL;
>> -		return NOTIFY_OK;
>> -	}
>> -
>> -	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
>> -	if (ret)
>> -		return NOTIFY_DONE;
>> -
>> -	/* If there is no CRYCB pointer, then we can't copy the masks */
>> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
>> -		return NOTIFY_DONE;
>> -
>> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
>> -				  matrix_mdev->matrix.aqm,
>> -				  matrix_mdev->matrix.adm);
>> +	matrix_mdev->kvm = data;
>>   
>>   	return NOTIFY_OK;
>>   }
>> @@ -888,6 +873,12 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   	if (ret)
>>   		goto err_group;
>>   
>> +	/* We do not support opening the mediated device without KVM */
>> +	if (!matrix_mdev->kvm) {
>> +		ret = -ENODEV;
>> +		goto err_group;
>> +	}
>> +
>>   	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>>   	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>>   
>> @@ -896,8 +887,15 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   	if (ret)
>>   		goto err_iommu;
>>   
>> +	ret = vfio_ap_mdev_set_kvm(matrix_mdev);
> 
> At this point the matrix_mdev->kvm ain't guaranteed to be valid IMHO. Or
> am I wrong? If I'm right kvm_get_kvm(matrix_mdev->kvm) could be too late.

What about the if (!matrix_mdev->kvm) 10 lines above ?

> 
>> +	if (ret)
>> +		goto err_kvm;
>> +
>>   	return 0;
>>   
>> +err_kvm:
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				 &matrix_mdev->iommu_notifier);
>>   err_iommu:
>>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>   				 &matrix_mdev->group_notifier);
>> @@ -906,19 +904,33 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   	return ret;
>>   }
>>   
>> -static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> +static int vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>>   {
>> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	struct kvm *kvm = matrix_mdev->kvm;
>>   
>>   	if (matrix_mdev->kvm)
>>   		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> 
> This still conditional?

Yes, nothing to clear if there is no KVM.

> 
>> -
>> +	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> 
> I guess your intention was to move vfio_ap_mdev_reset_queues()
> here from vfio_ap_mdev_release(), but you still have a
> vfio_ap_mdev_reset_queues() call in vfio_ap_mdev_release().
> 
>> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>   	matrix_mdev->kvm = NULL;
>> +
>> +	kvm_put_kvm(kvm);
>> +	return 0;
>> +}
>> +
>> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +	mutex_lock(&matrix_dev->lock);
>> +
>>   	vfio_ap_mdev_reset_queues(mdev);

right, this one will go away.
Thanks for reviewing.

Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
