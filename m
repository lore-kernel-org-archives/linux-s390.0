From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
Date: Wed, 27 Feb 2019 15:14:37 -0500
Message-ID: <b1479ec8-54e8-2378-cd1f-0e1275888945@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <0c109cf1-c5f0-9a8b-7729-2ce8bbe1dedd@linux.ibm.com>
 <d46abd0d-d365-299e-0ca7-8bae13e440d6@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d46abd0d-d365-299e-0ca7-8bae13e440d6@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/27/19 4:29 AM, Pierre Morel wrote:
> On 26/02/2019 19:14, Tony Krowiak wrote:
>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>> We need to associate the ap_vfio_queue, which will hold the
>>> per queue information for interrupt with a matrix mediated device
>>> which hold the configuration and the way to the CRYCB.
>>>
>>> Let's do this when assigning a APID or a APQI to the mediated device
>>> and clear the relation when unassigning.
>>>
>>> Queuing the devices on a list of free devices and testing the
>>> matrix_mdev pointer to the associated matrix allow us to know
>>> if the queue is associated to the matrix device and associated
>>> or not to a mediated device.
>>>
>>> When resetting an AP queue we must wait until there are no more
>>> messages in the message queue before considering the queue is really
>>> in a clean state.
>>>
>>> Let's do it and wait until the status response code indicate the
>>> queue is empty after issuing a PAPQ/ZAPQ instruction.
>>>
>>> Being at work on the reset function, let's simplify
>>> vfio_ap_mdev_reset_queue and vfio_ap_mdev_reset_queues by using the
>>> vfio_ap_queue structure as parameter.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c | 385 
>>> +++++++++++++++++++-------------------
>>>   1 file changed, 189 insertions(+), 196 deletions(-)
> 
> ...snip...
> 
>>> +static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>> +{
>>> +    struct ap_queue_status status;
>>> +    int retry = 20;
>>> +
>>> +    do {
>>> +        status = ap_zapq(q->apqn);
>>> +        switch (status.response_code) {
>>> +        case AP_RESPONSE_NORMAL:
>>> +            while (!status.queue_empty && retry--) {
>>> +                msleep(20);
>>> +                status = ap_tapq(q->apqn, NULL);
>>> +            }
>>
>> I am not sure the above is necessary. I have an email out to the author
>> of the architecture doc to verify.
> 
> I do not know the question you asked but the documentation is very clear 
> on the reset behavior: a queue is completely reseted only after the RC 
> of reset/zapq is 0 and the queue_empty bit is set.

You may want to check your email once in a while. I copied you on the
email I sent to the doc author. What you say is true and you may very
well be right, but I found the doc to be confusing in the way it was
worded. I would like to get confirmation of the need for this. Notice
that I started my sentence off with I AM NOT SURE, so I clearly wasn't
saying it is definitely not necessary.

> 
>>
>>> +            if (retry <= 0)
>>> +                pr_warn("%s: queue 0x%04x not empty\n",
> 
> ...snip...
> 
>>> + * @matrix_mdev: the matrix mediated device for which we want to 
>>> associate
>>> + *         all available queues with a given apqi.
>>> + * @apid:     The apid which associated with all defined APQI of the
>>> + *         mediated device will define a AP queue.
>>>    *
>>> - * - If @data contains only an apid value, @data will be flagged as
>>> - *   reserved if the APID field in the AP queue device matches
>>> - *
>>> - * - If @data contains only an apqi value, @data will be flagged as
>>> - *   reserved if the APQI field in the AP queue device matches
>>> - *
>>> - * Returns 0 to indicate the input to function succeeded. Returns 
>>> -EINVAL if
>>> - * @data does not contain either an apid or apqi.
>>> + * We remove the queue from the list of queues associated with the
>>> + * mediated device and put them back to the free list of the matrix
>>> + * device and clear the matrix_mdev pointer.
>>>    */
>>> -static int vfio_ap_has_queue(struct device *dev, void *data)
>>> +static void vfio_ap_put_all_domains(struct ap_matrix_mdev *matrix_mdev,
>>> +                    int apid)
>>
>> I would prefer this be named:
>>
>>      vfio_ap_mdev_free_queues_with_apid()
>>
>> get/put is typically used to increment/decrement reference counters.
>> What you are doing in this function freeing all queues connected to 
>> specified card.
> 
> OK, I can change this function name and the further one you mentioned.
> 
>>
>>>   {
>>> -    struct vfio_ap_queue_reserved *qres = data;
>>> -    struct ap_queue *ap_queue = to_ap_queue(dev);
>>> -    ap_qid_t qid;
>>> -    unsigned long id;
>>> +    int apqi, apqn;
>>> -    if (qres->apid && qres->apqi) {
>>> -        qid = AP_MKQID(*qres->apid, *qres->apqi);
>>> -        if (qid == ap_queue->qid)
>>> -            qres->reserved = true;
>>> -    } else if (qres->apid && !qres->apqi) {
>>> -        id = AP_QID_CARD(ap_queue->qid);
>>> -        if (id == *qres->apid)
>>> -            qres->reserved = true;
>>> -    } else if (!qres->apid && qres->apqi) {
>>> -        id = AP_QID_QUEUE(ap_queue->qid);
>>> -        if (id == *qres->apqi)
>>> -            qres->reserved = true;
>>> -    } else {
>>> -        return -EINVAL;
>>> +    for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>>> +        apqn = AP_MKQID(apid, apqi);
>>> +        vfio_ap_free_queue(apqn, matrix_mdev);
>>>       }
>>
>> Maybe you should clear the bit corresponding to apid from the APM here?
> 
> I do not think so, this is pure list handling, the APM bit is already 
> cleared in the unassign_adapter_store function.
> 
> I only answered once for all comments on naming and bit mask but will 
> treat them the same way.
> Thanks for comments.
> 
> Regards,
> Pierre
> 
> 
> 
