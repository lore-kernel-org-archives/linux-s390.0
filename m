Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgIRREE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Sep 2020 13:04:04 -0400
Subject: Re: [PATCH v10 06/16] s390/vfio-ap: introduce shadow APCB
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-7-akrowiak@linux.ibm.com>
 <20200917162242.1941772a.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <49b0dd56-0c5b-9096-91d1-aacb5ec886d1@linux.ibm.com>
Date: Fri, 18 Sep 2020 13:03:55 -0400
MIME-Version: 1.0
In-Reply-To: <20200917162242.1941772a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 9/17/20 10:22 AM, Cornelia Huck wrote:
> On Fri, 21 Aug 2020 15:56:06 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> The APCB is a field within the CRYCB that provides the AP configuration
>> to a KVM guest. Let's introduce a shadow copy of the KVM guest's APCB and
>> maintain it for the lifespan of the guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 32 ++++++++++++++++++++++-----
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   2 files changed, 29 insertions(+), 5 deletions(-)
> (...)
>
>> @@ -1202,13 +1223,12 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>   	if (ret)
>>   		return NOTIFY_DONE;
>>   
>> -	/* If there is no CRYCB pointer, then we can't copy the masks */
>> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
>> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
>>   		return NOTIFY_DONE;
>>   
>> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
>> -				  matrix_mdev->matrix.aqm,
>> -				  matrix_mdev->matrix.adm);
>> +	memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
>> +	       sizeof(matrix_mdev->shadow_apcb));
>> +	vfio_ap_mdev_commit_crycb(matrix_mdev);
> We are sure that the shadow APCB always matches up as we are the only
> ones manipulating the APCB in the CRYCB, right?

Yes

>
>>   
>>   	return NOTIFY_OK;
>>   }
