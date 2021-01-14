Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbhANVfu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 16:35:50 -0500
Subject: Re: [PATCH v13 07/15] s390/vfio-ap: introduce shadow APCB
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
 <20201223011606.5265-8-akrowiak@linux.ibm.com>
 <20210111235058.32ed94b5.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <47a353f5-e34f-db7b-65da-6fcf405959d5@linux.ibm.com>
Date: Thu, 14 Jan 2021 16:35:01 -0500
MIME-Version: 1.0
In-Reply-To: <20210111235058.32ed94b5.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 1/11/21 5:50 PM, Halil Pasic wrote:
> On Tue, 22 Dec 2020 20:15:58 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> The APCB is a field within the CRYCB that provides the AP configuration
>> to a KVM guest. Let's introduce a shadow copy of the KVM guest's APCB and
>> maintain it for the lifespan of the guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 15 +++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 2d58b39977be..44b3a81cadfb 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -293,6 +293,20 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
>>   	matrix->adm_max = info->apxa ? info->Nd : 15;
>>   }
>>   
>> +static bool vfio_ap_mdev_has_crycb(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	return (matrix_mdev->kvm && matrix_mdev->kvm->arch.crypto.crycbd);
>> +}
>> +
>> +static void vfio_ap_mdev_commit_shadow_apcb(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	if (vfio_ap_mdev_has_crycb(matrix_mdev))
>> +		kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>> +					  matrix_mdev->shadow_apcb.apm,
>> +					  matrix_mdev->shadow_apcb.aqm,
>> +					  matrix_mdev->shadow_apcb.adm);
>> +}
>> +
>>   static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>>   {
>>   	struct ap_matrix_mdev *matrix_mdev;
>> @@ -308,6 +322,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>>   
>>   	matrix_mdev->mdev = mdev;
>>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>> +	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
>>   	hash_init(matrix_mdev->qtable);
>>   	mdev_set_drvdata(mdev, matrix_mdev);
>>   	matrix_mdev->pqap_hook.hook = handle_pqap;
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 4e5cc72fc0db..d2d26ba18602 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -75,6 +75,7 @@ struct ap_matrix {
>>    * @list:	allows the ap_matrix_mdev struct to be added to a list
>>    * @matrix:	the adapters, usage domains and control domains assigned to the
>>    *		mediated matrix device.
>> + * @shadow_apcb:    the shadow copy of the APCB field of the KVM guest's CRYCB
>>    * @group_notifier: notifier block used for specifying callback function for
>>    *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
>>    * @kvm:	the struct holding guest's state
>> @@ -82,6 +83,7 @@ struct ap_matrix {
>>   struct ap_matrix_mdev {
>>   	struct list_head node;
>>   	struct ap_matrix matrix;
>> +	struct ap_matrix shadow_apcb;
>>   	struct notifier_block group_notifier;
>>   	struct notifier_block iommu_notifier;
>>   	struct kvm *kvm;
> What happened to the following hunk from v12?

That's a very good question, I'll reinstate it.

>
> @@ -1218,13 +1233,9 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   	if (ret)
>   		return NOTIFY_DONE;
>   
> -	/* If there is no CRYCB pointer, then we can't copy the masks */
> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
> -		return NOTIFY_DONE;
> -
> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> -				  matrix_mdev->matrix.aqm,
> -				  matrix_mdev->matrix.adm);
> +	memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
> +	       sizeof(matrix_mdev->shadow_apcb));
> +	vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
>   
>   	return NOTIFY_OK;
>   }
