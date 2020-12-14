Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728481AbgLNXhy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Dec 2020 18:37:54 -0500
Subject: Re: [PATCH v12 05/17] s390/vfio-ap: manage link between queue struct
 and matrix mdev
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
 <20201124214016.3013-6-akrowiak@linux.ibm.com>
 <20201126150828.78776e62.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <eac90113-4c68-a42f-cbfa-41e6b2780380@linux.ibm.com>
Date: Mon, 14 Dec 2020 18:37:08 -0500
MIME-Version: 1.0
In-Reply-To: <20201126150828.78776e62.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 11/26/20 9:08 AM, Halil Pasic wrote:
> On Tue, 24 Nov 2020 16:40:04 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> @@ -1155,6 +1243,11 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>   			     matrix_mdev->matrix.apm_max + 1) {
>>   		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>   				     matrix_mdev->matrix.aqm_max + 1) {
>> +			q = vfio_ap_mdev_get_queue(matrix_mdev,
>> +						   AP_MKQID(apid, apqi));
>> +			if (!q)
>> +				continue;
>> +
>>   			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>   			/*
>>   			 * Regardless whether a queue turns out to be busy, or
>> @@ -1164,9 +1257,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>   			if (ret)
>>   				rc = ret;
>>   
>> -			q = vfio_ap_get_queue(matrix_mdev, AP_MKQID(apid, apqi);
>> -			if (q)
>> -				vfio_ap_free_aqic_resources(q);
>> +			vfio_ap_free_aqic_resources(q);
>>   		}
>>   	}
> During the review of v11 we discussed this. Introducing this the one
> way around, just to change it in the next patch, which should deal
> with something different makes no sense to me.

This is handled by the vfio_ap_mdev_reset_queue() function in the
next version.

>
> BTW I've provided a ton of feedback for '[PATCH v11 03/14]
> s390/vfio-ap: manage link between queue struct and matrix mdev', but I
> can't find your response to that. Some of the things resurface here, and
> I don't feel like repeating myself. Can you provide me an answer to
> the v11 version?

I can.
