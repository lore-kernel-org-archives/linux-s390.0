Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgH1XFj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Aug 2020 19:05:39 -0400
Subject: Re: [PATCH v10 03/16] s390/vfio-ap: manage link between queue struct
 and matrix mdev
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-4-akrowiak@linux.ibm.com>
 <20200825122501.624474df.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <88f4061c-e609-38ee-a8c5-1f608d642158@linux.ibm.com>
Date: Fri, 28 Aug 2020 19:05:31 -0400
MIME-Version: 1.0
In-Reply-To: <20200825122501.624474df.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 8/25/20 6:25 AM, Cornelia Huck wrote:
> On Fri, 21 Aug 2020 15:56:03 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> Let's create links between each queue device bound to the vfio_ap device
>> driver and the matrix mdev to which the queue is assigned. The idea is to
>> facilitate efficient retrieval of the objects representing the queue
>> devices and matrix mdevs as well as to verify that a queue assigned to
>> a matrix mdev is bound to the driver.
>>
>> The links will be created as follows:
>>
>>     * When the queue device is probed, if its APQN is assigned to a matrix
>>       mdev, the structures representing the queue device and the matrix mdev
>>       will be linked.
>>
>>     * When an adapter or domain is assigned to a matrix mdev, for each new
>>       APQN assigned that references a queue device bound to the vfio_ap
>>       device driver, the structures representing the queue device and the
>>       matrix mdev will be linked.
>>
>> The links will be removed as follows:
>>
>>     * When the queue device is removed, if its APQN is assigned to a matrix
>>       mdev, the structures representing the queue device and the matrix mdev
>>       will be unlinked.
>>
>>     * When an adapter or domain is unassigned from a matrix mdev, for each
>>       APQN unassigned that references a queue device bound to the vfio_ap
>>       device driver, the structures representing the queue device and the
>>       matrix mdev will be unlinked.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 132 +++++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |   2 +
>>   2 files changed, 129 insertions(+), 5 deletions(-)
>>
> (...)
>
>> @@ -548,6 +557,87 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>>   	return 0;
>>   }
>>   
>> +enum qlink_type {
> <bikeshed>I think this is less of a type, and more of an action, so
> maybe call this 'qlink_action' (and the function parameter below
> 'action'?)</bikeshed>

Sure, but what is this <bikeshed> tag?

>
>> +	LINK_APID,
>> +	LINK_APQI,
>> +	UNLINK_APID,
>> +	UNLINK_APQI,
>> +};
>> +
>> +static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
>> +				    unsigned long apid, unsigned long apqi)
>> +{
>> +	struct vfio_ap_queue *q;
>> +
>> +	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
>> +	if (q) {
>> +		q->matrix_mdev = matrix_mdev;
>> +		hash_add(matrix_mdev->qtable,
>> +			 &q->mdev_qnode, q->apqn);
>> +	}
>> +}
>> +
>> +static void vfio_ap_mdev_unlink_queue(unsigned long apid, unsigned long apqi)
>> +{
>> +	struct vfio_ap_queue *q;
>> +
>> +	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
>> +	if (q) {
>> +		q->matrix_mdev = NULL;
>> +		hash_del(&q->mdev_qnode);
>> +	}
>> +}
>> +
>> +/**
>> + * vfio_ap_mdev_link_queues
>> + *
>> + * @matrix_mdev: The matrix mdev to link.
>> + * @type:	 The type of @qlink_id.
>> + * @qlink_id:	 The APID or APQI of the queues to link.
>> + *
>> + * Sets or clears the links between the queues with the specified @qlink_id
>> + * and the @matrix_mdev:
>> + *     @type == LINK_APID: Set the links between the @matrix_mdev and the
>> + *                         queues with the specified @qlink_id (APID)
>> + *     @type == LINK_APQI: Set the links between the @matrix_mdev and the
>> + *                         queues with the specified @qlink_id (APQI)
>> + *     @type == UNLINK_APID: Clear the links between the @matrix_mdev and the
>> + *                           queues with the specified @qlink_id (APID)
>> + *     @type == UNLINK_APQI: Clear the links between the @matrix_mdev and the
>> + *                           queues with the specified @qlink_id (APQI)
>> + */
>> +static void vfio_ap_mdev_link_queues(struct ap_matrix_mdev *matrix_mdev,
>> +				     enum qlink_type type,
>> +				     unsigned long qlink_id)
>> +{
>> +	unsigned long id;
>> +
>> +	switch (type) {
>> +	case LINK_APID:
>> +		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
>> +				     matrix_mdev->matrix.aqm_max + 1)
>> +			vfio_ap_mdev_link_queue(matrix_mdev, qlink_id, id);
>> +		break;
>> +	case UNLINK_APID:
>> +		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
>> +				     matrix_mdev->matrix.aqm_max + 1)
>> +			vfio_ap_mdev_unlink_queue(qlink_id, id);
>> +		break;
>> +	case LINK_APQI:
>> +		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
>> +				     matrix_mdev->matrix.apm_max + 1)
>> +			vfio_ap_mdev_link_queue(matrix_mdev, id, qlink_id);
>> +		break;
>> +	case UNLINK_APQI:
>> +		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
>> +				     matrix_mdev->matrix.apm_max + 1)
>> +			vfio_ap_mdev_link_queue(matrix_mdev, id, qlink_id);
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +	}
>> +}
>> +
> (...)
>
> I have not reviewed this deeply, but at a glance, it seems fine.
>
