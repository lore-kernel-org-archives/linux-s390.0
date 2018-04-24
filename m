From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
Date: Tue, 24 Apr 2018 10:40:56 +0200
Message-ID: <ac4b7441-2d17-922b-695e-98c01d87cd42@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 24/04/2018 08:54, Dong Jia Shi wrote:
> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:04 +0200]:
>
> [...]
>
>> @@ -94,9 +83,15 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>   static void vfio_ccw_sch_irq(struct subchannel *sch)
>>   {
>>   	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>> +	struct irb *irb = this_cpu_ptr(&cio_irb);
>>
>>   	inc_irq_stat(IRQIO_CIO);
>> -	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
>> +	memcpy(&private->irb, irb, sizeof(*irb));
>> +
>> +	WARN_ON(work_pending(&private->io_work));
> Hmm, why do we need this?

The current design insure that we have not two concurrent SSCH requests.
How ever I want here to track spurious interrupt.
If we implement cancel, halt or clear requests, we also may trigger (AFAIU)
a second interrupts depending on races between instructions, controller 
and device.

We do not need it strongly.

>
>> +	queue_work(vfio_ccw_work_q, &private->io_work);
>> +	if (private->completion)
>> +		complete(private->completion);
>>   }
>>
>>   static int vfio_ccw_sch_probe(struct subchannel *sch)
> [...]
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
