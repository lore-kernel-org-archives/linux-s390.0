From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 2/7] s390: ap: new vfio_ap_queue structure
Date: Thu, 28 Mar 2019 17:06:06 +0100
Message-ID: <d7154477-8b87-71f8-1e15-ada53c765f61@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-3-git-send-email-pmorel@linux.ibm.com>
 <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
 <1b64ad7b-2a7c-b604-1adb-af400e7be516@linux.ibm.com>
 <0477b20a-c882-c23d-5373-d461ef721f2c@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0477b20a-c882-c23d-5373-d461ef721f2c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 28/03/2019 16:32, Tony Krowiak wrote:
> On 3/28/19 9:06 AM, Pierre Morel wrote:
>> On 26/03/2019 21:45, Tony Krowiak wrote:
>>> On 3/22/19 10:43 AM, Pierre Morel wrote:
>>>> The AP interruptions are assigned on a queue basis and

...
>>>> +static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev 
>>>> *matrix_mdev)
>>>> +{
>>>> +    struct vfio_ap_queue *q;
>>>> +
>>>> +    q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
>>>> +    if (!q)
>>>> +        return;
>>>> +    q->matrix_mdev = NULL;
>>>> +    vfio_ap_mdev_reset_queue(q);
>>>
>>> I'm wondering if it's necessary to reset the queue here. The only time
>>> a queue is used is when a guest using the mdev device is started. When
>>> that guest is terminated, the fd for the mdev device is /* Bits 41-47 
>>> must all be zeros */closed and the
>>> mdev device's release callback is invoked. The release callback resets
>>> the queues assigned to the mdev device. Is it really necessary to
>>> reset the queue again when it is unassigned even if there would have
>>> been no subsequent activity?
>>
>> Yes, it is necessary, the queue can be re-assigned to another guest 
>> later.
>> Release will only be called when unbinding the queue from the driver.
> 
> That is true, but if the queue is never used, there is nothing to reset.

:) OK


Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
