Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11460 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgLDQtK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 11:49:10 -0500
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM pointer
 invalidated
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
 <20201203185514.54060568.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <a5a613ef-4c74-ad68-46bd-7159fbafef47@linux.ibm.com>
Date: Fri, 4 Dec 2020 11:48:24 -0500
MIME-Version: 1.0
In-Reply-To: <20201203185514.54060568.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com



On 12/3/20 12:55 PM, Halil Pasic wrote:
> On Wed,  2 Dec 2020 18:41:01 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> The vfio_ap device driver registers a group notifier with VFIO when the
>> file descriptor for a VFIO mediated device for a KVM guest is opened to
>> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
>> event). When the KVM pointer is set, the vfio_ap driver stashes the pointer
>> and calls the kvm_get_kvm() function to increment its reference counter.
>> When the notifier is called to make notification that the KVM pointer has
>> been set to NULL, the driver should clean up any resources associated with
>> the KVM pointer and decrement its reference counter. The current
>> implementation does not take care of this clean up.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Do we need a Fixes tag? Do we need this backported? In my opinion
> this is necessary since the interrupt patches.

I'll put in a fixes tag:
Fixes: 258287c994de (s390: vfio-ap: implement mediated device open callback)

Yes, this should probably be backported.

>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index e0bde8518745..eeb9c9130756 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1083,6 +1083,17 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>>   	return NOTIFY_DONE;
>>   }
>>   
>> +static void vfio_ap_mdev_put_kvm(struct ap_matrix_mdev *matrix_mdev)
> I don't like the name. The function does more that put_kvm. Maybe
> something  like _disconnect_kvm()?
Since the vfio_ap_mdev_set_kvm() function is called by the
notifier when the KVM pointer is set, how about:

vfio_ap_mdev_unset_kvm()

for when the KVM pointer is nullified?

>
>> +{
>> +	if (matrix_mdev->kvm) {
>> +		(matrix_mdev->kvm);
>> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> Is a plain assignment to arch.crypto.pqap_hook apropriate, or do we need
> to take more care?
>
> For instance kvm_arch_crypto_set_masks() takes kvm->lock before poking
> kvm->arch.crypto.crycb.
>
>> +		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
>> +		kvm_put_kvm(matrix_mdev->kvm);
>> +		matrix_mdev->kvm = NULL;
>> +	}
>> +}
>> +
>>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>   				       unsigned long action, void *data)
>>   {
>> @@ -1095,7 +1106,7 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>   	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>>   
>>   	if (!data) {
>> -		matrix_mdev->kvm = NULL;
>> +		vfio_ap_mdev_put_kvm(matrix_mdev);
> The lock question was already raised.
>
> What are the exact circumstances under which this branch can be taken?
>
>>   		return NOTIFY_OK;
>>   	}
>>   
>> @@ -1222,13 +1233,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>   
>>   	mutex_lock(&matrix_dev->lock);
>> -	if (matrix_mdev->kvm) {
>> -		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>> -		vfio_ap_mdev_reset_queues(mdev);
>> -		kvm_put_kvm(matrix_mdev->kvm);
>> -		matrix_mdev->kvm = NULL;
>> -	}
>> +	vfio_ap_mdev_put_kvm(matrix_mdev);
>>   	mutex_unlock(&matrix_dev->lock);
>>   
>>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
