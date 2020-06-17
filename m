Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v8 02/16] s390/vfio-ap: use new AP bus interface to search
 for queue devices
References: <20200605214004.14270-1-akrowiak@linux.ibm.com>
 <20200605214004.14270-3-akrowiak@linux.ibm.com>
 <93492fa3-31f1-a551-4b26-e46bc277e351@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <ba6e460c-36f5-051f-3549-9b826ae1d5ab@linux.ibm.com>
Date: Wed, 17 Jun 2020 08:02:33 -0400
MIME-Version: 1.0
In-Reply-To: <93492fa3-31f1-a551-4b26-e46bc277e351@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com



On 6/16/20 11:45 AM, Christian Borntraeger wrote:
>
> On 05.06.20 23:39, Tony Krowiak wrote:
>> This patch refactor's the vfio_ap device driver to use the AP bus's
>> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
>> information about a queue that is bound to the vfio_ap device driver.
>> The bus's ap_get_qdev() function retrieves the queue device from a
>> hashtable keyed by APQN. This is much more efficient than looping over
>> the list of devices attached to the AP bus by several orders of
>> magnitude.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 27 ++-------
>>   drivers/s390/crypto/vfio_ap_ops.c     | 82 +++++++++++++++------------
>>   drivers/s390/crypto/vfio_ap_private.h |  8 ++-
>>   3 files changed, 58 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index be2520cc010b..59233cf7419d 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -51,15 +51,9 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
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
>> -	return 0;
>> +	struct ap_queue *queue = to_ap_queue(&apdev->device);
>> +
>> +	return vfio_ap_mdev_probe_queue(queue);
>>   }
> Here we did not hold a mutex in the old code
> [...]
>
>> +int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
>> +{
>> +	struct vfio_ap_queue *q;
>> +
>> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
>> +	if (!q)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&matrix_dev->lock);
>> +	dev_set_drvdata(&queue->ap_dev.device, q);
>> +	q->apqn = queue->qid;
>> +	q->saved_isc = VFIO_AP_ISC_INVALID;
>> +	mutex_unlock(&matrix_dev->lock);
>> +
> here we do. Why do we need the matrix_dev->lock here?

You are correct, we don't need it here; but, we will need it
in a subsequent patch where we introduce linking the
q to the matrix mdev to which it is assigned. Perhaps
the locking should be introduced in that patch.

>
