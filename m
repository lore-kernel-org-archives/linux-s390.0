From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
Date: Fri, 4 May 2018 10:25:46 +0200
Message-ID: <eab19daf-adfb-fa71-d7d6-79439c6763a7@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426065954.GP5428@bjsdjshi@linux.vnet.ibm.com>
 <20180430172851.2cb3d550.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430172851.2cb3d550.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 30/04/2018 17:28, Cornelia Huck wrote:
> On Thu, 26 Apr 2018 14:59:54 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>
>> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:06 +0200]:
>>
>>> The Sub channel event callback is threaded using workqueues.
>>> The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
>>> event.
>>> The update of the SCHIB is now done inside the FSM function.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> ---
>>>   drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
>>>   drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
>>>   drivers/s390/cio/vfio_ccw_private.h |  3 +++
>>>   3 files changed, 39 insertions(+), 20 deletions(-)
>>>
>>> @@ -171,28 +181,11 @@ static void vfio_ccw_sch_shutdown(struct subchannel *sch)
>>>   static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>>>   {
>>>   	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
>>> -	unsigned long flags;
>>>
>>> -	spin_lock_irqsave(sch->lock, flags);
>>>   	if (!device_is_registered(&sch->dev))
>>> -		goto out_unlock;
>>> -
>>> -	if (work_pending(&sch->todo_work))
>>> -		goto out_unlock;
>> Just realized that this has a bug in the orignal implementation. For
>> error out this should return -EAGAIN. We'd need a separated fix on
>> this.
> Indeed. Will you send a patch, or should I hack something up?
>
>>> -
>>> -	if (cio_update_schib(sch)) {
>>> -		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
>>> -		goto out_unlock;
>>> -	}
>>> -
>>> -	private = dev_get_drvdata(&sch->dev);
>>> -	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
>>> -		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
>>> -				 VFIO_CCW_STATE_STANDBY;
>>> -	}
>> This hunk was toatally removed, and this is fine because?
The first part is moved to fsm_sch_event()
The second part disapear per design as state changes are done inside the 
FSM.

>>
>>> -
>>> -out_unlock:
>>> -	spin_unlock_irqrestore(sch->lock, flags);
>>> +		return -1;
>> -1 is not a valid code.
> -ENODEV looks more fitting, if we decide to go with this rework.
:) yes, forgot the -1 from the first tests.

>
>>> +	WARN_ON(work_pending(&private->event_work));
>>> +	queue_work(vfio_ccw_work_q, &private->event_work);
>>>
>>>   	return 0;
>>>   }
> I'm wondering why this should always be done via a workqueue. It seems
> the other subchannel types try to do as much as possible immediately?

Doing things inside the top half is not very friendly with the system.
The goal of the patch is to build a clean atomic state machine.
Allowing the use of mutexes insures atomicity.

I notice that I forgot to point this out in the cover letter although it is
one of the design key.
I will update the cover letter.

> (And returning -EAGAIN already triggers the css code to schedule
> another call later.)

Yes, if(work_pending()) return -EAGAIN

Thanks for the review

Pierre

>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
