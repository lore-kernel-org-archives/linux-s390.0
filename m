From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 2/7] s390: ap: new vfio_ap_queue structure
Date: Fri, 15 Mar 2019 14:29:18 +0100
Message-ID: <97431ae5-8a96-2512-870b-0a463e9ec768@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-3-git-send-email-pmorel@linux.ibm.com>
 <20190315113330.5ef0eeef.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315113330.5ef0eeef.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/03/2019 11:33, Cornelia Huck wrote:
> On Wed, 13 Mar 2019 17:04:59 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index e9824c3..df6f21a 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -40,14 +40,42 @@ static struct ap_device_id ap_queue_ids[] = {
>>   
>>   MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>   
>> +/**
>> + * vfio_ap_queue_dev_probe:
>> + *
>> + * Allocate a vfio_ap_queue structure and associate it
>> + * with the device as driver_data.
>> + */
>>   static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>>   {
>> +	struct vfio_ap_queue *q;
>> +
>> +	q = kzalloc(sizeof(*q), GFP_KERNEL);
>> +	if (!q)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(&apdev->device, q);
>> +	q->apqn = to_ap_queue(&apdev->device)->qid;
>> +	INIT_LIST_HEAD(&q->list);
>> +	mutex_lock(&matrix_dev->lock);
>> +	list_add(&q->list, &matrix_dev->free_list);
>> +	mutex_unlock(&matrix_dev->lock);
> 
>  From what I can see, dealing with the free_list is supposed to be
> protected by the matrix_dev mutex, and at a glance, it indeed seems to
> be held every time you interact with the list. I think it would be good
> to document that with a comment.

Yes.
It is a big lock but only on administrative tasks so I think it is harmless.

> 
> (I have not reviewed this deeply, and I won't be able to look at this
> more until April, sorry.)

OK.
Thanks for the comments.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
