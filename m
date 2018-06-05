From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 08/10] vfio: ccw: Handling reset and shutdown with
 states
Date: Tue, 5 Jun 2018 18:40:48 +0200
Message-ID: <c03e0ce2-7f14-fcf1-4fa9-f67df4b8046b@linux.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1527243678-3140-9-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180605141827.6911fc74.cohuck@redhat.com>
 <ad0c095c-249c-dc74-17db-f52c1092537d@linux.ibm.com>
 <20180605172708.24bb7af2.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605172708.24bb7af2.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/06/2018 17:27, Cornelia Huck wrote:
> On Tue, 5 Jun 2018 16:10:52 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 05/06/2018 14:18, Cornelia Huck wrote:
>>> On Fri, 25 May 2018 12:21:16 +0200
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>> +static int fsm_online(struct vfio_ccw_private *private)
>>>> +{
>>>> +	struct subchannel *sch = private->sch;
>>>> +	int ret = VFIO_CCW_STATE_IDLE;
>>>> +
>>>> +	spin_lock_irq(sch->lock);
>>>> +	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
>>>> +		ret = VFIO_CCW_STATE_NOT_OPER;
>>>> +	spin_unlock_irq(sch->lock);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +static int fsm_offline(struct vfio_ccw_private *private)
>>>> +{
>>>> +	struct subchannel *sch = private->sch;
>>>> +	int ret = VFIO_CCW_STATE_STANDBY;
>>>> +
>>>> +	spin_lock_irq(sch->lock);
>>>> +	if (cio_disable_subchannel(sch))
>>>> +		ret = VFIO_CCW_STATE_NOT_OPER;
>>> So, what about a subchannel that is busy? Why should it go to the not
>>> oper state?
>> right, thanks.
>>
>>> (And you should try to flush pending I/O and then try again in that
>>> case. Otherwise, you may have a still-enabled subchannel which may
>>> throw an interrupt.)
>> What about letting the guest doing this.
>> After giving him the right information on what happened of course.
> Why should the guest know anything about this? Getting the device to a
> usable state respectively cleaning up is the responsibility of the host
> code. This processing will happen before the guest gets use of the
> device or after it has lost use of it already (or it is some internal
> handling like reset, which the guest should not be made aware of).

Hum, not inspired today,
sorry I should have take a day to recover from holidays. :)

>
>>>   
>>>> +	spin_unlock_irq(sch->lock);
>>>> +	if (private->completion)
>>>> +		complete(private->completion);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +static int fsm_quiescing(struct vfio_ccw_private *private)
>>>> +{
>>>> +	struct subchannel *sch = private->sch;
>>>> +	int ret = VFIO_CCW_STATE_STANDBY;
>>>> +	int iretry = 255;
>>>> +
>>>> +	spin_lock_irq(sch->lock);
>>>> +	ret = cio_cancel_halt_clear(sch, &iretry);
>>>> +	if (ret == -EBUSY)
>>>> +		ret = VFIO_CCW_STATE_QUIESCING;
>>>> +	else if (private->completion)
>>>> +		complete(private->completion);
>>>> +	spin_unlock_irq(sch->lock);
>>>> +	return ret;
>>> If I read this correctly, you're calling cio_cancel_halt_clear() only
>>> once. What happened to the retry loop?
>> Same as above, what about letting the guest doing this?
> See my reply above.
>
>> And there are already 255 retries as part of the interface to cio.
>  From the kerneldoc comment for cio_cancel_halt_clear():
>
>   * This should be called repeatedly since halt/clear are asynchronous
>   * operations. We do one try with cio_cancel, three tries with cio_halt,
>   * 255 tries with cio_clear. The caller should initialize @iretry with
>   * the value 255 for its first call to this, and keep using the same
>   * @iretry in the subsequent calls until it gets a non -EBUSY return.

OK thanks, I do so.

>
>>>   
>>>> +}
>>>> +static int fsm_quiescing_done(struct vfio_ccw_private *private)
>>>> +{
>>>> +	if (private->completion)
>>>> +		complete(private->completion);
>>>> +	return VFIO_CCW_STATE_STANDBY;
>>>> +}
>>>>    /*
>>>>     * No operation action.
>>>>     */
>>>> @@ -178,15 +225,10 @@ static int fsm_sch_event(struct vfio_ccw_private *private)
>>>>    static int fsm_init(struct vfio_ccw_private *private)
>>>>    {
>>>>    	struct subchannel *sch = private->sch;
>>>> -	int ret = VFIO_CCW_STATE_STANDBY;
>>>>    
>>>> -	spin_lock_irq(sch->lock);
>>>>    	sch->isc = VFIO_CCW_ISC;
>>>> -	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
>>>> -		ret = VFIO_CCW_STATE_NOT_OPER;
>>>> -	spin_unlock_irq(sch->lock);
>>>>    
>>>> -	return ret;
>>>> +	return VFIO_CCW_STATE_STANDBY;
>>> Doesn't that change the semantic of the standby state?
>> It changes the FSM: NOT_OPER and STANDBY are clearly different.
>> Part of the initialization is now done in when putting the device online.
> Hm, I think the changes to the fsm semantics are a bit mixed up between
> patches. I'll wait for an outline of how this is supposed to look in
> the end before commenting further :)

Yes, I do this in the next cover letter.

>
>>> Your idea here seems to be to go to either disabling the subchannel
>>> directly or flushing out I/O first, depending on the state you're in.
>>> The problem is that you may need retries in any case (the subchannel
>>> may be status pending if it is enabled; not necessarily by any I/O that
>>> had been started, but also from an unsolicited notification.)
>> I wanted to let the guest do the retries as he wants to.
>> Somehow we must give the right response back to the guest
>> and take care of the error number we give back.
> As described above, we need to be clear on what should be guest-visible
> and what is just internal handling e.g. during initialization/removal.

Yes.

>
>> I will get a better look at this.
>>
>>>   
>>>>    };
>>>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>>>> index ea8fd64..b202e73 100644
>>>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>>>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>>>> @@ -21,21 +21,14 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
>>>>    
>>>>    	private = dev_get_drvdata(mdev_parent_dev(mdev));
>>>>    	sch = private->sch;
>>>> -	/*
>>>> -	 * TODO:
>>>> -	 * In the cureent stage, some things like "no I/O running" and "no
>>>> -	 * interrupt pending" are clear, but we are not sure what other state
>>>> -	 * we need to care about.
>>>> -	 * There are still a lot more instructions need to be handled. We
>>>> -	 * should come back here later.
>>>> -	 */
>>> This is still true, no? I'm thinking about things like channel monitors
>>> and the like (even if we don't support them yet).
>> I think that this is not the place to put this remark since here
>> we should send an event to the FSM, having new states
>> will be handled as FSM states.
>> I put it back, here or where I think it belong if I find another
>> place after resolving the RESET problem.
> The comment basically refers to "we aren't quite sure whether there is
> more stuff we need to reset", so I think this is indeed the correct
> place.

OK

>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
