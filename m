Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbgLVPhs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Dec 2020 10:37:48 -0500
Subject: Re: [PATCH v4] s390/vfio-ap: clean up vfio_ap resources when KVM
 pointer invalidated
References: <20201221185625.24914-1-akrowiak@linux.ibm.com>
 <20201222050521.46af2bf1.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <853da84f-092b-6b94-62d5-628f440abc40@linux.ibm.com>
Date: Tue, 22 Dec 2020 10:37:01 -0500
MIME-Version: 1.0
In-Reply-To: <20201222050521.46af2bf1.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com



On 12/21/20 11:05 PM, Halil Pasic wrote:
> On Mon, 21 Dec 2020 13:56:25 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> The vfio_ap device driver registers a group notifier with VFIO when the
>> file descriptor for a VFIO mediated device for a KVM guest is opened to
>> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
>> event). When the KVM pointer is set, the vfio_ap driver takes the
>> following actions:
>> 1. Stashes the KVM pointer in the vfio_ap_mdev struct that holds the state
>>     of the mediated device.
>> 2. Calls the kvm_get_kvm() function to increment its reference counter.
>> 3. Sets the function pointer to the function that handles interception of
>>     the instruction that enables/disables interrupt processing.
>> 4. Sets the masks in the KVM guest's CRYCB to pass AP resources through to
>>     the guest.
>>
>> In order to avoid memory leaks, when the notifier is called to receive
>> notification that the KVM pointer has been set to NULL, the vfio_ap device
>> driver should reverse the actions taken when the KVM pointer was set.
>>
>> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [..]
>
>>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>   				       unsigned long action, void *data)
>>   {
>> -	int ret;
>> +	int ret, notify_rc = NOTIFY_DONE;
>>   	struct ap_matrix_mdev *matrix_mdev;
>>   
>>   	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>>   		return NOTIFY_OK;
>>   
>>   	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>> +	mutex_lock(&matrix_dev->lock);
>>   
>>   	if (!data) {
>> -		matrix_mdev->kvm = NULL;
>> -		return NOTIFY_OK;
>> +		if (matrix_mdev->kvm)
>> +			vfio_ap_mdev_unset_kvm(matrix_mdev);
>> +		notify_rc = NOTIFY_OK;
>> +		goto notify_done;
>>   	}
>>   
>>   	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
>>   	if (ret)
>> -		return NOTIFY_DONE;
>> +		goto notify_done;
>>   
>>   	/* If there is no CRYCB pointer, then we can't copy the masks */
>>   	if (!matrix_mdev->kvm->arch.crypto.crycbd)
>> -		return NOTIFY_DONE;
>> +		goto notify_done;
>>   
>>   	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
>>   				  matrix_mdev->matrix.aqm,
>>   				  matrix_mdev->matrix.adm);
>>   
>> -	return NOTIFY_OK;
> Shouldn't there be an
>   +	notify_rc = NOTIFY_OK;
> here? I mean you initialize notify_rc to NOTIFY_DONE, in the !data branch
> on success you set notify_rc to NOTIFY_OK, but in the !!data branch it
> just stays NOTIFY_DONE. Or am I missing something?

I don't think it matters much since NOTIFY_OK and NOTIFY_DONE have
no further effect on processing of the notification queue, but I believe
you are correct, this is a change from what we originally had. I can
restore the original return values if you'd prefer.

>
> Otherwise LGTM!
>
> Regards,
> Halil
>
>> +notify_done:
>> +	mutex_unlock(&matrix_dev->lock);
>> +	return notify_rc;
>>   }
>>
> [..]
