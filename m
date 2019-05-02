Return-Path: <SRS0=sFCg=TC=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v7 3/4] s390: ap: implement PAPQ AQIC interception in
 kernel
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
 <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
 <20190430152605.3bb21f31.pasic@linux.ibm.com>
 <622a9ab0-579d-17f4-6fa1-74d73da13b19@linux.ibm.com>
Date: Thu, 2 May 2019 09:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <622a9ab0-579d-17f4-6fa1-74d73da13b19@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <42185132-dfc4-c997-3d69-31e43d25e525@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 30/04/2019 16:09, Pierre Morel wrote:
> On 30/04/2019 15:26, Halil Pasic wrote:
>> On Fri, 26 Apr 2019 15:01:27 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> +/**
>>> + * vfio_ap_clrirq: Disable Interruption for a APQN
>>> + *
>>> + * @dev: the device associated with the ap_queue
>>> + * @q:   the vfio_ap_queue holding AQIC parameters
>>> + *
>>> + * Issue the host side PQAP/AQIC
>>> + * On success: unpin the NIB saved in *q and unregister from GIB
>>> + * interface
>>> + *
>>> + * Return the ap_queue_status returned by the ap_aqic()
>>> + */
>>> +static struct ap_queue_status vfio_ap_clrirq(struct vfio_ap_queue *q)
>>> +{
>>> +    struct ap_qirq_ctrl aqic_gisa = {};
>>> +    struct ap_queue_status status;
>>> +    int checks = 10;
>>> +
>>> +    status = ap_aqic(q->apqn, aqic_gisa, NULL);
>>> +    if (!status.response_code) {
>>> +        while (status.irq_enabled && checks--) {
>>> +            msleep(20);
>>
>> Hm, that seems like a lot of time to me. And I suppose we are holding the
>> kvm lock: e.g. no other instruction can be interpreted by kvm in the
>> meantime.
>>
>>> +            status = ap_tapq(q->apqn, NULL);
>>> +        }
>>> +        if (checks >= 0)
>>> +            vfio_ap_free_irq_data(q);
>>
>> Actually we don't have to wait for the async part to do it's magic
>> (indicated by the status.irq_enabled --> !status.irq_enabled transition)
>> in the instruction handler. We have to wait so we can unpin the NIB but
>> that could be done async (e.g. workqueue).
>>
>> BTW do you have any measurements here? How many msleep(20) do we
>> experience for one clear on average?
> 
> No idea but it is probably linked to the queue state and usage history.
> I can use a lower sleep time and increment the retry count.
> 
>>
>> If linux is not using clear (you told so offline, and I also remember
>> something similar), we can probably get away with something like this,
>> and do it properly (from performance standpoint) later.
> 
> In the Linux AP code it is only used once, in the explicit
> ap_queue_enable_interruption() function.

My answer is not clear: ap_aqic() is used only once, during the bus 
probe, in the all code to enable interrupt and is never used to disable 
interrupt.

Interrupt disabling is only done by using ap_zapq() or ap_rapq() which 
can not be intercepted.


> 
> Yes, thanks, I will keep it as is, may be just play with msleep()time 
> and retry count.
> 
> Regards,
> Pierre
> 
>>
>> Regards,
>> Halil
>>
>>> +        else
>>> +            WARN_ONCE("%s: failed disabling IRQ", __func__);
>>> +    }
>>> +
>>> +    return status;
>>> +}
>>
> 
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
