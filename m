From: Steffen Maier <maier@linux.vnet.ibm.com>
Date: Tue, 16 Jul 2013 09:14:23 +0000
Subject: Re: [PATCH] zfcp: Fix spinlock imbalance in zfcp_qdio_sbal_get
Message-Id: <51E50EEF.5020004@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.02.1307151612341.11390@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1307151612341.11390@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Mikulas,

we worked on Martin's patch quoted below. I'm going to send the result 
upstream with my next zfcp patches batch.

Steffen

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

On 07/15/2013 10:15 PM, Mikulas Patocka wrote:
> Any progress on this?
>
> We have a bug report in Red Hat that suggest that a crash happened because
> of this spinlock imbalance, but there is no answer from the maintainer.
>
> Mikulas
>
> On Wed, 12 Jun 2013, Martin Peschke wrote:
>> On Mon, 2013-06-10 at 11:23 +0200, Heiko Carstens wrote:
>>> Fine with me. So we can eiter take Mikulas' patch which is ready or your
>>> approach.
>>> However it would be good to have this fixed within 3.10 since there is
>>> a working fix aroung. Hm?
>>
>>
>> Heiko, Mikulas,
>> this is the code that I would like to go with.
>>
>> I am still running some I/O stress test with frequent queue stall error
>> injection to ensure code coverage for time-out conditions. Looks good so
>> far. Steffen's review is pending.
>>
>> I would appreciate your review and Ack's, too.
>>
>> Thanks a lot, Mikulas for your analysis. We dropped the ball on this
>> one :-(
>>
>> Thanks, Martin
>>
>>
>>
>> [PATCH 2/2] zfcp: use wait_event_interruptible_lock_irq_timeout()
>>
>> The zfcp driver used to call wait_event_interruptible_timeout()
>> in combination with some intricate and error-prone locking. Using
>> wait_event_interruptible_lock_irq_timeout() as a replacement
>> nicely cleans up that locking. This cleanup removes a situation that
>> resulted in a locking imbalance in zfcp_qdio_sbal_get(). And we get
>> rid of that crappy lock-unlock-lock sequence at the beginning of
>> the critical section.
>>
>> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
>> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
>>
>> ---
>>   drivers/s390/scsi/zfcp_qdio.c |    8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> --- a/drivers/s390/scsi/zfcp_qdio.c
>> +++ b/drivers/s390/scsi/zfcp_qdio.c
>> @@ -223,11 +223,9 @@ int zfcp_qdio_sbals_from_sg(struct zfcp_
>>
>>   static int zfcp_qdio_sbal_check(struct zfcp_qdio *qdio)
>>   {
>> -	spin_lock_irq(&qdio->req_q_lock);
>>   	if (atomic_read(&qdio->req_q_free) ||
>>   	    !(atomic_read(&qdio->adapter->status) & ZFCP_STATUS_ADAPTER_QDIOUP))
>>   		return 1;
>> -	spin_unlock_irq(&qdio->req_q_lock);
>>   	return 0;
>>   }
>>
>> @@ -245,9 +243,8 @@ int zfcp_qdio_sbal_get(struct zfcp_qdio
>>   {
>>   	long ret;
>>
>> -	spin_unlock_irq(&qdio->req_q_lock);
>> -	ret = wait_event_interruptible_timeout(qdio->req_q_wq,
>> -			       zfcp_qdio_sbal_check(qdio), 5 * HZ);
>> +	ret = wait_event_interruptible_lock_irq_timeout(qdio->req_q_wq,
>> +		       zfcp_qdio_sbal_check(qdio), qdio->req_q_lock, 5 * HZ);
>>
>>   	if (!(atomic_read(&qdio->adapter->status) & ZFCP_STATUS_ADAPTER_QDIOUP))
>>   		return -EIO;
>> @@ -261,7 +258,6 @@ int zfcp_qdio_sbal_get(struct zfcp_qdio
>>   		zfcp_erp_adapter_reopen(qdio->adapter, 0, "qdsbg_1");
>>   	}
>>
>> -	spin_lock_irq(&qdio->req_q_lock);
>>   	return -EIO;
>>   }
>>
>>
>>
>> [PATCH 1/2] Add wait_event_interruptible_lock_irq_timeout()
>>
>> Provide another wait_event() function. It is a straight-forward descendant of
>> wait_event_interruptible_timeout() and wait_event_interruptible_lock_irq().
>>
>> There is a use case for this function in the zfcp device driver.
>>
>> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
>>
>> ---
>>   include/linux/wait.h |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> --- a/include/linux/wait.h
>> +++ b/include/linux/wait.h
>> @@ -713,6 +713,63 @@ do {									\
>>   	__ret;								\
>>   })
>>
>> +#define __wait_event_interruptible_lock_irq_timeout(wq, condition,	\
>> +						    lock, ret)		\
>> +do {									\
>> +	DEFINE_WAIT(__wait);						\
>> +									\
>> +	for (;;) {							\
>> +		prepare_to_wait(&wq, &__wait, TASK_INTERRUPTIBLE);	\
>> +		if (condition)						\
>> +			break;						\
>> +		if (signal_pending(current)) {				\
>> +			ret = -ERESTARTSYS;				\
>> +			break;						\
>> +		}							\
>> +		spin_unlock_irq(&lock);					\
>> +		ret = schedule_timeout(ret);				\
>> +		spin_lock_irq(&lock);					\
>> +		if (!ret)						\
>> +			break;						\
>> +	}								\
>> +	finish_wait(&wq, &__wait);					\
>> +} while (0)
>> +
>> +/**
>> + * wait_event_interruptible_lock_irq_timeout - sleep until a condition gets true or a timeout elapses.
>> + *		The condition is checked under the lock. This is expected
>> + *		to be called with the lock taken.
>> + * @wq: the waitqueue to wait on
>> + * @condition: a C expression for the event to wait for
>> + * @lock: a locked spinlock_t, which will be released before schedule()
>> + *	  and reacquired afterwards.
>> + * @timeout: timeout, in jiffies
>> + *
>> + * The process is put to sleep (TASK_INTERRUPTIBLE) until the
>> + * @condition evaluates to true or signal is received. The @condition is
>> + * checked each time the waitqueue @wq is woken up.
>> + *
>> + * wake_up() has to be called after changing any variable that could
>> + * change the result of the wait condition.
>> + *
>> + * This is supposed to be called while holding the lock. The lock is
>> + * dropped before going to sleep and is reacquired afterwards.
>> + *
>> + * The function returns 0 if the @timeout elapsed, -ERESTARTSYS if it
>> + * was interrupted by a signal, and the remaining jiffies otherwise
>> + * if the condition evaluated to true before the timeout elapsed.
>> + */
>> +#define wait_event_interruptible_lock_irq_timeout(wq, condition, lock,	\
>> +						  timeout)		\
>> +({									\
>> +	int __ret = timeout;						\
>> +									\
>> +	if (!(condition))						\
>> +		__wait_event_interruptible_lock_irq_timeout(		\
>> +					wq, condition, lock, __ret);	\
>> +	__ret;								\
>> +})
>> +
>>
>>   /*
>>    * These are the old interfaces to sleep waiting for an event.
>>
