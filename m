Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgKBV5S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 16:57:18 -0500
Subject: Re: [PATCH v11 02/14] 390/vfio-ap: use new AP bus interface to search
 for queue devices
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-3-akrowiak@linux.ibm.com>
 <20201027080158.0a4fa6b2.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <c81abca5-9831-0e50-fb29-00e841c843d8@linux.ibm.com>
Date: Mon, 2 Nov 2020 16:57:08 -0500
MIME-Version: 1.0
In-Reply-To: <20201027080158.0a4fa6b2.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10/27/20 3:01 AM, Halil Pasic wrote:
> On Thu, 22 Oct 2020 13:11:57 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> This patch refactors the vfio_ap device driver to use the AP bus's
>> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
>> information about a queue that is bound to the vfio_ap device driver.
>> The bus's ap_get_qdev() function retrieves the queue device from a
>> hashtable keyed by APQN. This is much more efficient than looping over
>> the list of devices attached to the AP bus by several orders of
>> magnitude.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thank you for your review.

>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 35 +++++++++++++------------------
>>   1 file changed, 14 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index c471832f0a30..049b97d7444c 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -26,43 +26,36 @@
>>   
>>   static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
>>   
>> -static int match_apqn(struct device *dev, const void *data)
>> -{
>> -	struct vfio_ap_queue *q = dev_get_drvdata(dev);
>> -
>> -	return (q->apqn == *(int *)(data)) ? 1 : 0;
>> -}
>> -
>>   /**
>> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
>> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
>>    * @matrix_mdev: the associated mediated matrix
>>    * @apqn: The queue APQN
>>    *
>> - * Retrieve a queue with a specific APQN from the list of the
>> - * devices of the vfio_ap_drv.
>> - * Verify that the APID and the APQI are set in the matrix.
>> + * Retrieve a queue with a specific APQN from the AP queue devices attached to
>> + * the AP bus.
>>    *
>> - * Returns the pointer to the associated vfio_ap_queue
>> + * Returns the pointer to the vfio_ap_queue with the specified APQN, or NULL.
>>    */
>>   static struct vfio_ap_queue *vfio_ap_get_queue(
>>   					struct ap_matrix_mdev *matrix_mdev,
>> -					int apqn)
>> +					unsigned long apqn)
>>   {
>> -	struct vfio_ap_queue *q;
>> -	struct device *dev;
>> +	struct ap_queue *queue;
>> +	struct vfio_ap_queue *q = NULL;
>>   
>>   	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
>>   		return NULL;
>>   	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
>>   		return NULL;
>>   
>> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> -				 &apqn, match_apqn);
>> -	if (!dev)
>> +	queue = ap_get_qdev(apqn);
>> +	if (!queue)
>>   		return NULL;
>> -	q = dev_get_drvdata(dev);
>> -	q->matrix_mdev = matrix_mdev;
>> -	put_device(dev);
>> +
>> +	if (queue->ap_dev.device.driver == &matrix_dev->vfio_ap_drv->driver)
>> +		q = dev_get_drvdata(&queue->ap_dev.device);
>> +
> Needs to be called with the vfio_ap lock held, right? Otherwise the queue could
> get unbound while we are working with it as a vfio_ap_queue... Noting
> new, but might we worth documenting.

This is always called with the vfio_ap lock held.

>
>> +	put_device(&queue->ap_dev.device);
>>   
>>   	return q;
>>   }
