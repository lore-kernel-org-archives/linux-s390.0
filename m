From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Tue, 22 Mar 2011 09:00:15 +0000
Subject: Re: replace the default scheduler code with a udev rule
Message-Id: <4D88651F.2020709@linux.vnet.ibm.com>
In-Reply-To: <4D84D4AF.8060406@gmail.com>
References: <4D84D4AF.8060406@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Xose,

thanks for your suggestion.

Am 19.03.2011 17:07, schrieb Xose Vazquez Perez:
> On 03/03/2011 09:42 AM, Heiko Carstens wrote:
>
>> I leave it up to Stefan W. and Stefan H. to make comments to your
>> suggestion. Thanks!
>>
> also, why deadline over cfq ?
>
> _old_ IBM papers show a little gain of deadline in _some_ cases, but *today* ??
>
> -thanks-
>
We chose deadline scheduler because our performance analysis showed, 
that other schedulers like cfq only have more overhead and do not 
improve performance for our typical workload. There may be workload 
which benefit from cfq but the most cases won't. This seems not to have 
improved. So our default scheduler will stay deadline.
>> Full quote:
>>
>>> hi,
>>>
>>> udev can handle it, as do 60-readahead.rules with read_ahead_kb
>>> in s390-tools.
>>>
>>> change part of this, drivers/s390/block/dasd.c:
>>>
>>> /*
>>>   * Allocate and initialize request queue and default I/O scheduler.
>>>   */
>>> static int dasd_alloc_queue(struct dasd_block *block)
>>> {
>>> 	int rc;
>>>
>>> 	block->request_queue = blk_init_queue(do_dasd_request,
>>> 					&block->request_queue_lock);
>>> 	if (block->request_queue == NULL)
>>> 		return -ENOMEM;
>>>
>>> 	block->request_queue->queuedata = block;
>>>
>>> 	elevator_exit(block->request_queue->elevator);
>>> 	block->request_queue->elevator = NULL;
>>> 	rc = elevator_init(block->request_queue, "deadline");
>>> 	if (rc) {
>>> 		blk_cleanup_queue(block->request_queue);
>>> 		return rc;
>>> 	}
>>> 	return 0;
>>> }
>>>
>>>
>>> for this other, 61-scheduler.rules :
>>>
>>> #
>>> # Rules to change the default scheduler to deadline
>>> # This file should be installed in /etc/udev/rules.d
>>> #
>>>
>>> SUBSYSTEM!="block", GOTO="ra_end"
>>>
>>> ACTION!="add", GOTO="ra_end"
>>> # on device add change the default scheduler to deadline
>>> KERNEL=="sd*[!0-9]", ATTR{queue/scheduler}="deadline"
>>> KERNEL=="dasd*[!0-9]", ATTR{queue/scheduler}="deadline"
>>>
>>> LABEL="ra_end"
>>>
>>>
>>> simpler, more flexible and less C code.
>>>
>>> -thanks-
This is a nice way to do the setup but I do not see any advantage for 
our customers. If they try to set the elevator via kernel command line 
they still will not see the expected effect as now a udev rule will 
overwrite this default. Everybody who wants to change the default 
scheduler for his distro is able to define a udev rule and redefine it 
this way.
The disadvantage is, that we have to provide one more udev rules to our 
distributors and check if they are included correctly and working. So 
only more overhead from this point of view.
Maybe I do not get all usage scenarios. So if you see something that the 
current code can not do, let us no and we will reconsider but otherwise 
we will leave it as it is.

regards
Stefan
