From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 2/7] s390: ap: new vfio_ap_queue structure
Date: Thu, 28 Mar 2019 13:53:25 +0100
Message-ID: <d40af924-cd5d-18ae-5fe4-88763e429f7f@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-3-git-send-email-pmorel@linux.ibm.com>
 <169eec34-6397-3150-27df-9985c9e711b8@linux.ibm.com>
 <bf728b35-a610-d343-6ec1-5397025a86cb@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bf728b35-a610-d343-6ec1-5397025a86cb@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 27/03/2019 12:00, Harald Freudenberger wrote:
> On 26.03.19 21:45, Tony Krowiak wrote:
>> On 3/22/19 10:43 AM, Pierre Morel wrote:
>>> The AP interruptions are assigned on a queue basis and

...snip...

>>> +static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev *matrix_mdev)
>>> +{
>>> +    struct vfio_ap_queue *q;
>>> +
>>> +    q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
>>> +    if (!q)
>>> +        return;
>>> +    q->matrix_mdev = NULL;
>>> +    vfio_ap_mdev_reset_queue(q);
>>
>> I'm wondering if it's necessary to reset the queue here. The only time
>> a queue is used is when a guest using the mdev device is started. When
>> that guest is terminated, the fd for the mdev device is closed and the
>> mdev device's release callback is invoked. The release callback resets
>> the queues assigned to the mdev device. Is it really necessary to
>> reset the queue again when it is unassigned even if there would have
>> been no subsequent activity?
> When I understand this here right this code is called when a queue goes
> away from the guest but is still reserved for use by the vfio dd. So it is
> possible to assign the queue now to another guest. But then it makes
> sense to clear all the entries in the millicode queue because a pending
> reply could be "received" by the wrong guest.
> 
> If this function is just called on remove of a queue device where the
> device goes back to the AP bus, a reset is not needed.

You are right Harald, the function is called when un-assigning a queue 
from a mediated device, so it must be reset before to assign it to another.


Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
