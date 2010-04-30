From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Date: Fri, 30 Apr 2010 20:33:21 +0000
Subject: Re: [PATCH 1/1] dasd: do not force use of deadline IO scheduler
Message-Id: <4BDB3E91.8070505@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2008-03-04 8:52:10, Martin Schwidefsky wrote:

a bit old.

> On Mon, 2008-03-03 at 15:21 -0500, Josef 'Jeff' Sipek wrote:
>> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
>> ---
>>  drivers/s390/block/dasd.c |    9 ---------
>>  1 files changed, 0 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
>> index ccf46c9..4d4f6ff 100644
>> --- a/drivers/s390/block/dasd.c
>> +++ b/drivers/s390/block/dasd.c
>> @@ -1946,21 +1946,12 @@ static void do_dasd_request(struct request_queue *queue)
>>   */
>>  static int dasd_alloc_queue(struct dasd_block *block)
>>  {
>> -	int rc;
>> -
>>  	block->request_queue = blk_init_queue(do_dasd_request,
>>  					       &block->request_queue_lock);
>>  	if (block->request_queue == NULL)
>>  		return -ENOMEM;
>> 
>>  	block->request_queue->queuedata = block;
>> -
>> -	elevator_exit(block->request_queue->elevator);
>> -	rc = elevator_init(block->request_queue, "deadline");
>> -	if (rc) {
>> -		blk_cleanup_queue(block->request_queue);
>> -		return rc;
>> -	}
>>  	return 0;
>>  }
> 
> Um, why? We have a reason to force the deadline scheduler, our
> performance test have shown that the deadline scheduler get the highest
> throughout out of the storage subsystems which are used with the
> machines.

Are there recent tests, cfq vs. deadline, with current kernels?

This FCP/SCSI test is a bit old(2005-03-16), and cfq vs. deadline shows no differences:
http://www.ibm.com/developerworks/linux/linux390/perf/tuning_res_dasd_ioScheduler.html

Any DASD test out there ?

-thanks-

-- 
�All� muevan feroz guerra, ciegos reyes por un palmo m�s de tierra;
que yo aqu� tengo por m�o cuanto abarca el mar brav�o, a quien nadie
impuso leyes. Y no hay playa, sea cualquiera, ni bandera de esplendor,
que no sienta mi derecho y d� pecho a mi valor.�
