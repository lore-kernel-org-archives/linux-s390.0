Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgLVXPm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Dec 2020 18:15:42 -0500
Subject: Re: [PATCH v4] s390/vfio-ap: clean up vfio_ap resources when KVM
 pointer invalidated
References: <20201221185625.24914-1-akrowiak@linux.ibm.com>
 <20201222050521.46af2bf1.pasic@linux.ibm.com>
 <853da84f-092b-6b94-62d5-628f440abc40@linux.ibm.com>
 <20201222165706.66e0120d.cohuck@redhat.com>
 <20201222204335.1b456342.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <5b10c838-bdc6-1923-bae7-ede1a0efe933@linux.ibm.com>
Date: Tue, 22 Dec 2020 18:14:58 -0500
MIME-Version: 1.0
In-Reply-To: <20201222204335.1b456342.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, borntraeger@de.ibm.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com



On 12/22/20 2:43 PM, Halil Pasic wrote:
> On Tue, 22 Dec 2020 16:57:06 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Tue, 22 Dec 2020 10:37:01 -0500
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> On 12/21/20 11:05 PM, Halil Pasic wrote:
>>>> On Mon, 21 Dec 2020 13:56:25 -0500
>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>>    static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>>>>    				       unsigned long action, void *data)
>>>>>    {
>>>>> -	int ret;
>>>>> +	int ret, notify_rc = NOTIFY_DONE;
>>>>>    	struct ap_matrix_mdev *matrix_mdev;
>>>>>    
>>>>>    	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>>>>>    		return NOTIFY_OK;
>>>>>    
>>>>>    	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>>>>> +	mutex_lock(&matrix_dev->lock);
>>>>>    
>>>>>    	if (!data) {
>>>>> -		matrix_mdev->kvm = NULL;
>>>>> -		return NOTIFY_OK;
>>>>> +		if (matrix_mdev->kvm)
>>>>> +			vfio_ap_mdev_unset_kvm(matrix_mdev);
>>>>> +		notify_rc = NOTIFY_OK;
>>>>> +		goto notify_done;
>>>>>    	}
>>>>>    
>>>>>    	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
>>>>>    	if (ret)
>>>>> -		return NOTIFY_DONE;
>>>>> +		goto notify_done;
>>>>>    
>>>>>    	/* If there is no CRYCB pointer, then we can't copy the masks */
>>>>>    	if (!matrix_mdev->kvm->arch.crypto.crycbd)
>>>>> -		return NOTIFY_DONE;
>>>>> +		goto notify_done;
>>>>>    
>>>>>    	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
>>>>>    				  matrix_mdev->matrix.aqm,
>>>>>    				  matrix_mdev->matrix.adm);
>>>>>    
>>>>> -	return NOTIFY_OK;
>>>> Shouldn't there be an
>>>>    +	notify_rc = NOTIFY_OK;
>>>> here? I mean you initialize notify_rc to NOTIFY_DONE, in the !data branch
>>>> on success you set notify_rc to NOTIFY_OK, but in the !!data branch it
>>>> just stays NOTIFY_DONE. Or am I missing something?
>>> I don't think it matters much since NOTIFY_OK and NOTIFY_DONE have
>>> no further effect on processing of the notification queue, but I believe
>>> you are correct, this is a change from what we originally had. I can
>>> restore the original return values if you'd prefer.
>> Even if they have the same semantics now, that might change in the
>> future; restoring the original behaviour looks like the right thing to
>> do.
> I agree. Especially since we do care to preserve the behavior in
> the !data branch. If there is no difference between the two, then it
> would probably make sense to clean that up globally.

Got it. I'm going to do a quick turnaround on the next version so we
can get this merged if need be. I will be taking off for Christmas vacation
and will be gone until sometime the first week in January.

>
> Regards,
> Halil
