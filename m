Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727793AbgH0OYS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 10:24:18 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 02/16] s390/vfio-ap: use new AP bus interface to
 search for queue devices
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-3-akrowiak@linux.ibm.com>
 <20200825121334.0ff35d7a.cohuck@redhat.com>
Message-ID: <b1c6bad8-3ec6-183c-3e35-9962e9c721c7@linux.ibm.com>
Date: Thu, 27 Aug 2020 10:24:07 -0400
MIME-Version: 1.0
In-Reply-To: <20200825121334.0ff35d7a.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>



On 8/25/20 6:13 AM, Cornelia Huck wrote:
> On Fri, 21 Aug 2020 15:56:02 -0400
> Tony Krowiak<akrowiak@linux.ibm.com>  wrote:
>
>> This patch refactor's the vfio_ap device driver to use the AP bus's
> s/refactor's/refactors/

Of course, what was I thinking?:)

>> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
>> information about a queue that is bound to the vfio_ap device driver.
>> The bus's ap_get_qdev() function retrieves the queue device from a
>> hashtable keyed by APQN. This is much more efficient than looping over
>> the list of devices attached to the AP bus by several orders of
>> magnitude.
>>
>> Signed-off-by: Tony Krowiak<akrowiak@linux.ibm.com>
>> Reported-by: kernel test robot<lkp@intel.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 27 ++-------
>>   drivers/s390/crypto/vfio_ap_ops.c     | 86 +++++++++++++++------------
>>   drivers/s390/crypto/vfio_ap_private.h |  8 ++-
>>   3 files changed, 59 insertions(+), 62 deletions(-)
>>
> (...)
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index e0bde8518745..ad3925f04f61 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -26,43 +26,26 @@
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
>> - * @matrix_mdev: the associated mediated matrix
>> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
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
>> -static struct vfio_ap_queue *vfio_ap_get_queue(
>> -					struct ap_matrix_mdev *matrix_mdev,
>> -					int apqn)
>> +static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
>>   {
>> +	struct ap_queue *queue;
>>   	struct vfio_ap_queue *q;
>> -	struct device *dev;
>>   
>> -	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
>> -		return NULL;
>> -	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
> I think you should add some explanation to the patch description why
> testing the matrix bitmasks is not needed anymore.

As a result of this comment, I took a closer look at the code to
determine the reason for eliminating the matrix_mdev
parameter. The reason is because the code below (i.e., find the device
and get the driver data) was also repeated in the vfio_ap_irq_disable_apqn()
function, so I replaced it with a call to the function above; however, the
vfio_ap_irq_disable_apqn() function  does not have a reference to the
matrix_mdev, so I eliminated the matrix_mdev parameter. Note that the
vfio_ap_irq_disable_apqn() is called for each APQN assigned to a matrix
mdev, so there is no need to test the bitmasks there.

The other place from which the function above is called is
the handle_pqap() function which does have a reference to the
matrix_mdev. In order to ensure the integrity of the instruction
being intercepted - i.e., PQAP(AQIC) enable/disable IRQ for aN
AP queue - the testing of the matrix bitmasks probably ought to
be performed, so it will be done there instead of in the
vfio_ap_get_queue() function above.


> +	queue = ap_get_qdev(apqn);
> +	if (!queue)
>   		return NULL;
>   
> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				 &apqn, match_apqn);
> -	if (!dev)
> -		return NULL;
> -	q = dev_get_drvdata(dev);
> -	q->matrix_mdev = matrix_mdev;
> -	put_device(dev);
> +	q = dev_get_drvdata(&queue->ap_dev.device);
> +	put_device(&queue->ap_dev.device);
>   
>   	return q;
>   }
> (...)
>
