From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 2/7] s390: ap: new vfio_ap_queue structure
Date: Thu, 28 Mar 2019 14:06:46 +0100
Message-ID: <1b64ad7b-2a7c-b604-1adb-af400e7be516@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-3-git-send-email-pmorel@linux.ibm.com>
 <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 26/03/2019 21:45, Tony Krowiak wrote:
> On 3/22/19 10:43 AM, Pierre Morel wrote:
>> The AP interruptions are assigned on a queue basis and
>> the GISA structure is handled on a VM basis, so that
>> we need to add a structure we can retrieve from both side
> 
> s/side/sides/
OK

> 
>> holding the information we need to handle PQAP/AQIC interception
>> and setup the GISA.
> 
> s/setup/set up/

OK

...snip...

>> +
>> +static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>> +{
>> +    struct ap_queue_status status;
>> +    int retry = 1;
>> +
>> +    do {
>> +        status = ap_zapq(q->apqn);
>> +        switch (status.response_code) {
>> +        case AP_RESPONSE_NORMAL:
>> +            return 0;
>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>> +        case AP_RESPONSE_BUSY:
>> +            msleep(20);
>> +            break;
>> +        default:
>> +            /* things are really broken, give up */
> 
> I'm not sure things are necessarily broken. We could end up here if
> the AP is removed from the configuration via the SE or SCLP Deconfigure
> Adjunct Processor command.

OK, but note that it is your original comment I just moved the function 
here ;)

> 
>> +            return -EIO;
>> +        }
>> +    } while (retry--);
>> +
>> +    return -EBUSY;
>> +}
>> +
>>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>>                   struct ap_matrix *matrix)
>>   {
>> @@ -45,6 +107,7 @@ static int vfio_ap_mdev_create(struct kobject 
>> *kobj, struct mdev_device *mdev)
>>           return -ENOMEM;
>>       }
>> +    INIT_LIST_HEAD(&matrix_mdev->qlist);
>>       vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>>       mdev_set_drvdata(mdev, matrix_mdev);
>>       mutex_lock(&matrix_dev->lock);
>> @@ -113,162 +176,189 @@ static struct attribute_group 
>> *vfio_ap_mdev_type_groups[] = {
>>       NULL,
>>   };
>> -struct vfio_ap_queue_reserved {
>> -    unsigned long *apid;
>> -    unsigned long *apqi;
>> -    bool reserved;
>> -};
>> +static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    struct vfio_ap_queue *q;
>> +
>> +    q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
>> +    if (!q)
>> +        return;
>> +    q->matrix_mdev = NULL;
>> +    vfio_ap_mdev_reset_queue(q);
> 
> I'm wondering if it's necessary to reset the queue here. The only time
> a queue is used is when a guest using the mdev device is started. When
> that guest is terminated, the fd for the mdev device is closed and the
> mdev device's release callback is invoked. The release callback resets
> the queues assigned to the mdev device. Is it really necessary to
> reset the queue again when it is unassigned even if there would have
> been no subsequent activity?

Yes, it is necessary, the queue can be re-assigned to another guest later.
Release will only be called when unbinding the queue from the driver.

> 
>> +    list_move(&q->list, &matrix_dev->free_list);
>> +}

...snip...

>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
>> +        apqn = AP_MKQID(apid, apqi);
>> +        q = vfio_ap_find_queue(apqn);
>> +        if (!q) {
>> +            ret = -EADDRNOTAVAIL;
>> +            goto rewind;
>> +        }
>> +        if (q->matrix_mdev) {
> 
> If somebody assigns the same domain a second time, the assignment will
> fail because the matrix_mdev will already have been associated with the
> queue. I don't think it is appropriate to fail the assignment if the

It is usual to report a failure in the case the operation requested has 
already be done.
But we can do as you want. Any other opinion?

> q->matrix_mdev is the same as the input matrix_mdev. This should be
> changed to:
> 
>      if (q->matrix_mdev != matrix_mdev)

You surely want to say: add this, not change to this. ;)

> 

Thanks for commenting,

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
