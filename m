Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfFQOYv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Jun 2019 10:24:51 -0400
Subject: Re: [PATCH v4 1/7] s390: vfio-ap: Refactor vfio_ap driver probe and
 remove callbacks
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
 <1560454780-20359-2-git-send-email-akrowiak@linux.ibm.com>
 <534f8ef2-ac7a-bda3-54cf-d475b2a47c02@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <8817a913-b574-3bf4-6ef8-b8f1c5a4728e@linux.ibm.com>
Date: Mon, 17 Jun 2019 10:24:21 -0400
MIME-Version: 1.0
In-Reply-To: <534f8ef2-ac7a-bda3-54cf-d475b2a47c02@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

On 6/17/19 4:27 AM, Harald Freudenberger wrote:
> On 13.06.19 21:39, Tony Krowiak wrote:
>> In order to limit the number of private mdev functions called from the
>> vfio_ap device driver as well as to provide a landing spot for dynamic
>> configuration code related to binding/unbinding AP queue devices to/from
>> the vfio_ap driver, the following changes are being introduced:
>>
>> * Move code from the vfio_ap driver's probe callback into a function
>>    defined in the mdev private operations file.
>>
>> * Move code from the vfio_ap driver's remove callback into a function
>>    defined in the mdev private operations file.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 27 ++++++++++-----------------
>>   drivers/s390/crypto/vfio_ap_ops.c     | 28 ++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  6 +++---
>>   3 files changed, 41 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 003662aa8060..3c60df70891b 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -49,15 +49,15 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>    */
>>   static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>>   {
>> -	struct vfio_ap_queue *q;
>> -
>> -	q = kzalloc(sizeof(*q), GFP_KERNEL);
>> -	if (!q)
>> -		return -ENOMEM;
>> -	dev_set_drvdata(&apdev->device, q);
>> -	q->apqn = to_ap_queue(&apdev->device)->qid;
>> -	q->saved_isc = VFIO_AP_ISC_INVALID;
>> +	int ret;
>> +	struct ap_queue *queue = to_ap_queue(&apdev->device);
>> +
>> +	ret = vfio_ap_mdev_probe_queue(queue);
>> +	if (ret)
>> +		return ret;
>> +
>>   	return 0;
> A simple
>    return vfio_ap_mdev_probe_queue(queue);
> would be enough.

True.

>> +
>>   }
>>   
>>   /**
>> @@ -68,17 +68,10 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>>    */
>>   static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>>   {
>> -	struct vfio_ap_queue *q;
>> -	int apid, apqi;
>> +	struct ap_queue *queue = to_ap_queue(&apdev->device);
>>   
>>   	mutex_lock(&matrix_dev->lock);
>> -	q = dev_get_drvdata(&apdev->device);
>> -	dev_set_drvdata(&apdev->device, NULL);
>> -	apid = AP_QID_CARD(q->apqn);
>> -	apqi = AP_QID_QUEUE(q->apqn);
>> -	vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> -	vfio_ap_irq_disable(q);
>> -	kfree(q);
>> +	vfio_ap_mdev_remove_queue(queue);
>>   	mutex_unlock(&matrix_dev->lock);
>>   }
>>   
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 015174ff6f0a..bf2ab02b9a0b 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1302,3 +1302,31 @@ void vfio_ap_mdev_unregister(void)
>>   {
>>   	mdev_unregister_device(&matrix_dev->device);
>>   }
>> +
>> +int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
>> +{
>> +	struct vfio_ap_queue *q;
>> +
>> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
>> +	if (!q)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(&queue->ap_dev.device, q);
>> +	q->apqn = queue->qid;
>> +	q->saved_isc = VFIO_AP_ISC_INVALID;
>> +
>> +	return 0;
>> +}
>> +
>> +void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
>> +{
>> +	struct vfio_ap_queue *q;
>> +	int apid, apqi;
>> +
>> +	q = dev_get_drvdata(&queue->ap_dev.device);
>> +	dev_set_drvdata(&queue->ap_dev.device, NULL);
>> +	apid = AP_QID_CARD(q->apqn);
>> +	apqi = AP_QID_QUEUE(q->apqn);
>> +	vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> +	vfio_ap_irq_disable(q);
>> +	kfree(q);
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index f46dde56b464..5cc3c2ebf151 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -90,8 +90,6 @@ struct ap_matrix_mdev {
>>   
>>   extern int vfio_ap_mdev_register(void);
>>   extern void vfio_ap_mdev_unregister(void);
>> -int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>> -			     unsigned int retry);
>>   
>>   struct vfio_ap_queue {
>>   	struct ap_matrix_mdev *matrix_mdev;
>> @@ -100,5 +98,7 @@ struct vfio_ap_queue {
>>   #define VFIO_AP_ISC_INVALID 0xff
>>   	unsigned char saved_isc;
>>   };
>> -struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);
>> +int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
>> +void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 
