From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 2/7] s390: ap: new vfio_ap_queue structure
Date: Thu, 28 Mar 2019 14:12:19 +0100
Message-ID: <fcec11aa-6d7a-a1ec-c68d-1a8559d79876@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-3-git-send-email-pmorel@linux.ibm.com>
 <636599aa-9884-3bec-8ee0-fc048e3acd91@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <636599aa-9884-3bec-8ee0-fc048e3acd91@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 25/03/2019 09:05, Harald Freudenberger wrote:
> On 22.03.19 15:43, Pierre Morel wrote:
>> The AP interruptions are assigned on a queue basis and
>> the GISA structure is handled on a VM basis, so that

...snip...

>> + * vfio_ap_queue_dev_remove:
>> + *
>> + * Free the associated vfio_ap_queue structure
>> + */
>>   static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>>   {
>> -	/* Nothing to do yet */
>> +	struct vfio_ap_queue *q;
>> +
>> +	q = dev_get_drvdata(&apdev->device);
> I'd add a check if q != NULL here.

I wonder if this can ever happen.
However I added a check in the next patch.
I can move it here.

>> +	mutex_lock(&matrix_dev->lock);
>> +	list_del(&q->list);
>> +	mutex_unlock(&matrix_dev->lock);
>> +	kfree(q);
> I would add a line:
>      dev_set_drvdata(&apdev->device, NULL);

OK, I clean it before giving it back, fair.

Thanks.

Rgeards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
