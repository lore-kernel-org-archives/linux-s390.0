Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC v2 2/3] vfio-ccw: Prevent quiesce function going into an
 infinite loop
References: <cover.1554756534.git.alifm@linux.ibm.com>
 <2c17cf29fbce8fc1cfbf60cfd04559d00c8eeac0.1554756534.git.alifm@linux.ibm.com>
 <20190411182434.07d5f685.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 11 Apr 2019 16:30:44 -0400
MIME-Version: 1.0
In-Reply-To: <20190411182434.07d5f685.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ffcffd06-5bbd-a97c-021e-855b2240982d@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/11/2019 12:24 PM, Cornelia Huck wrote:
> On Mon,  8 Apr 2019 17:05:32 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> The quiesce function calls cio_cancel_halt_clear() and if we
>> get an -EBUSY we go into a loop where we:
>> 	- wait for any interrupts
>> 	- flush all I/O in the workqueue
>> 	- retry cio_cancel_halt_clear
>>
>> During the period where we are waiting for interrupts or
>> flushing all I/O, the channel subsystem could have completed
>> a halt/clear action and turned off the corresponding activity
>> control bits in the subchannel status word. This means the next
>> time we call cio_cancel_halt_clear(), we will again start by
>> calling cancel subchannel and so we can be stuck between calling
>> cancel and halt forever.
>>
>> Rather than calling cio_cancel_halt_clear() immediately after
>> waiting, let's try to disable the subchannel. If we succeed in
>> disabling the subchannel then we know nothing else can happen
>> with the device.
>>
>> Suggested-by: Eric Farman <farman@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c | 27 ++++++++++++---------------
>>   1 file changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 5aca475..4405f2a 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -43,26 +43,23 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
>>   	if (ret != -EBUSY)
>>   		goto out_unlock;
>>   
>> +	iretry = 255;
>>   	do {
>> -		iretry = 255;
>>   
>>   		ret = cio_cancel_halt_clear(sch, &iretry);
>> -		while (ret == -EBUSY) {
>> -			/*
>> -			 * Flush all I/O and wait for
>> -			 * cancel/halt/clear completion.
>> -			 */
>> -			private->completion = &completion;
>> -			spin_unlock_irq(sch->lock);
>> -
>> +		/*
>> +		 * Flush all I/O and wait for
>> +		 * cancel/halt/clear completion.
>> +		 */
>> +		private->completion = &completion;
>> +		spin_unlock_irq(sch->lock);
>> +
>> +		if (ret == -EBUSY)
> 
> I don't think you need to do the unlock/lock and change
> private->completion if you don't actually wait, no?

If we don't end up waiting, then changing private->completion would not 
be needed. But we would still need to release the spinlock due to [1].

> 
> Looking at the possible return codes:
> * -ENODEV -> device is not operational anyway, in theory you should even
>     not need to bother with disabling the subchannel
> * -EIO -> we've run out of retries, and the subchannel still is not
>    idle; I'm not sure if we could do anything here, as disable is
>    unlikely to work, either

We could break out of the loop early for these cases. My thinking was I 
wanted to depend on the result of trying to disable, because ultimately 
that's what we want.

I can add the cases to break out of the loop early.


> * -EBUSY -> we expect an interrupt (or a timeout), the loop looks fine
>    for that
> * 0 -> the one thing that might happen is that we get an unsolicited
>    interrupt between the successful cancel_halt_clear and the disable;
>    not even giving up the lock here might even be better here?

I didn't think of this case, but if cancel_halt_clear succeeds with 0 
then we should wait, no?

> 
> I think this loop will probably work as it is after this patch, but
> giving up the lock when not really needed makes me a bit queasy... what
> do others think?
> 
>>   			wait_for_completion_timeout(&completion, 3*HZ);
>>   
>> -			private->completion = NULL;
>> -			flush_workqueue(vfio_ccw_work_q);
>> -			spin_lock_irq(sch->lock);
>> -			ret = cio_cancel_halt_clear(sch, &iretry);
>> -		};
>> -
>> +		private->completion = NULL;

[1]  flush_workqueue can go to sleep so we would still need to release 
spinlock and reacquire it again to try disabling the subchannel.

>> +		flush_workqueue(vfio_ccw_work_q);
>> +		spin_lock_irq(sch->lock);
>>   		ret = cio_disable_subchannel(sch);
>>   	} while (ret == -EBUSY);
>>   out_unlock:
> 
> 
