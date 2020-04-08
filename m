Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgDHQeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 12:34:21 -0400
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: store queue struct in hash table
 for quick access
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-2-akrowiak@linux.ibm.com>
 <20200408124801.2d61bc5b.cohuck@redhat.com>
 <e0d56b61-749a-3646-18e7-47bb5c8ca862@linux.ibm.com>
 <20200408182750.6d9443f6.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <d7bce25e-9818-6673-c0d6-e4b037848012@linux.ibm.com>
Date: Wed, 8 Apr 2020 12:34:15 -0400
MIME-Version: 1.0
In-Reply-To: <20200408182750.6d9443f6.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 4/8/20 12:27 PM, Cornelia Huck wrote:
> On Wed, 8 Apr 2020 11:38:07 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 4/8/20 6:48 AM, Cornelia Huck wrote:
>>> On Tue,  7 Apr 2020 15:20:01 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> Rather than looping over potentially 65535 objects, let's store the
>>>> structures for caching information about queue devices bound to the
>>>> vfio_ap device driver in a hash table keyed by APQN.
>>> This also looks like a nice code simplification.
>>>   
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_drv.c     | 28 +++------
>>>>    drivers/s390/crypto/vfio_ap_ops.c     | 90 ++++++++++++++-------------
>>>>    drivers/s390/crypto/vfio_ap_private.h | 10 ++-
>>>>    3 files changed, 60 insertions(+), 68 deletions(-)
>>>>   
>>> (...)
>>>> - */
>>>> -static struct vfio_ap_queue *vfio_ap_get_queue(
>>>> -					struct ap_matrix_mdev *matrix_mdev,
>>>> -					int apqn)
>>>> +struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
>>>>    {
>>>>    	struct vfio_ap_queue *q;
>>>> -	struct device *dev;
>>>> -
>>>> -	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
>>>> -		return NULL;
>>>> -	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
>>>> -		return NULL;
>>> These were just optimizations and therefore can be dropped now?
>> The purpose of this function has changed from its previous incarnation.
>> This function was originally called from the handle_pqap() function and
>> served two purposes: It retrieved the struct vfio_ap_queue as driver data
>> and linked the matrix_mdev to the  vfio_ap_queue. The linking of the
>> matrix_mdev and the vfio_ap_queue are now done when queue devices
>> are probed and when adapters and domains are assigned; so now, the
>> handle_pqap() function calls this function to retrieve both the
>> vfio_ap_queue as well as the matrix_mdev to which it is linked.
>> Consequently,
>> the above code is no longer needed.
> Thanks for the explanation, that makes sense.
>
>>>   
>>>> -
>>>> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>>>> -				 &apqn, match_apqn);
>>>> -	if (!dev)
>>>> -		return NULL;
>>>> -	q = dev_get_drvdata(dev);
>>>> -	q->matrix_mdev = matrix_mdev;
>>>> -	put_device(dev);
>>>>    
>>>> -	return q;
>>>> +	hash_for_each_possible(matrix_dev->qtable, q, qnode, apqn) {
>>>> +		if (q && (apqn == q->apqn))
>>>> +			return q;
>>>> +	}
>>> Do we need any serialization here? Previously, the driver core made
>>> sure we could get a reference only if the device was still registered;
>>> not sure if we need any further guarantees now.
>> The vfio_ap_queue structs are created when the queue device is
>> probed and removed when the queue device is removed.
> Ok, so anything further is not needed.
>
>>>   
>>>> +
>>>> +	return NULL;
>>>>    }
>>>>    
>>>>    /**
>>> (...)
>>>   
> Looks good to me, then. With vfio_ap_get_queue made static and the
> kerneldoc restored/updated:

Already done, thanks for the review.

>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>
