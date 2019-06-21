Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfFUORU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 10:17:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LEEpgu107001
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 10:17:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8yt2k9a9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Jun 2019 10:17:16 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Fri, 21 Jun 2019 15:17:13 +0100
Subject: Re: [RFC v1 1/1] vfio-ccw: Don't call cp_free if we are processing a
 channel program
References: <cover.1561055076.git.alifm@linux.ibm.com>
 <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
 <638804dc-53c0-ff2f-d123-13c257ad593f@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 21 Jun 2019 10:17:09 -0400
MIME-Version: 1.0
In-Reply-To: <638804dc-53c0-ff2f-d123-13c257ad593f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <581d756d-7418-cd67-e0e8-f9e4fe10b22d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, cohuck@redhat.com
Cc: pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 06/20/2019 04:27 PM, Eric Farman wrote:
> 
> 
> On 6/20/19 3:40 PM, Farhan Ali wrote:
>> There is a small window where it's possible that an interrupt can
>> arrive and can call cp_free, while we are still processing a channel
>> program (i.e allocating memory, pinnging pages, translating
> 
> s/pinnging/pinning/
> 
>> addresses etc). This can lead to allocating and freeing at the same
>> time and can cause memory corruption.
>>
>> Let's not call cp_free if we are currently processing a channel program.
> 
> The check around this cp_free() call is for a solicited interrupt, so
> it's presumably in response to a SSCH we issued.  But if we're still
> processing a CP, then we hadn't issued the SSCH to the hardware yet.  So
> what is this interrupt for?  Do the contents of irb.cpa provide any
> clues, perhaps if it's in the current cp or for someone else?
> 

I don't think the interrupt is in response to an ssch but rather due to 
an csch/hsch.

>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>
>> I have been running my test overnight with this patch and I haven't
>> seen the stack traces that I mentioned about earlier. I would like
>> to get some reviews on this and also if this is the right thing to
>> do?
>>
>> Thanks
>> Farhan
>>
>>   drivers/s390/cio/vfio_ccw_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
>> index 66a66ac..61ece3f 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -88,7 +88,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>   		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
>>   	if (scsw_is_solicited(&irb->scsw)) {
>>   		cp_update_scsw(&private->cp, &irb->scsw);
> 
> As I alluded earlier, do we know this irb is for this cp?  If no, what
> does this function end up putting in the scsw?
> 
>> -		if (is_final)
>> +		if (is_final && private->state != VFIO_CCW_STATE_CP_PROCESSING)
> 
> In looking at how we set this state, and how we exit it, I see we do:
> 
> if SSCH got CC0, CP_PROCESSING -> CP_PENDING
> if SSCH got !CC0, CP_PROCESSING -> IDLE
> 
> While the first scenario happens immediately after the SSCH instruction,
> I guess it could be just tiny enough, like the io_trigger FSM patch I
> sent a few weeks ago.
> 
> Meanwhile, the latter happens way after we return from the jump table.
> So that scenario leaves considerable time for such an interrupt to
> occur, though I don't understand why it would if we got a CC(1-3) on the
> SSCH.
> 
> And anyway, the return from fsm_io_helper() in that case will also call
> cp_free().  So why does the cp->initialized check provide protection
> from a double-free in that direction, but not here?  I'm confused.

I have a theory where I think it's possible to have 2 different threads 
executing cp_free

If we start with private->state == IDLE and the guest issues a 
clear/halt and then an ssch

- clear/halt will be issued to hardware, and if succeeds we will return 
cc=0 to guest

- the guest can then issue ssch

- we get an interrupt for csch/hsch and we queue the interrupt in the 
workqueue

- we start processing the ssch and then at the same time another cpu 
could be working on the
interrupt


Thread 1                                        Thread 2
--------                                        --------

fsm_io_request                                  vfio_ccw_sch_io_todo 

     cp_init                                         cp_free
     cp_prefetch
     fsm_io_helper
         cp_free



The test that I am trying is with a guest running an fio workload, while 
at the same time stressing the error recovery path in the guest. So 
there is a lot of ssch and lot of csch.

Of course I don't think my patch completely solves the problem, I think 
it just makes the window narrower. I just wanted to get a discussion 
started :)


Now that I am thinking more about it, I think we might have to protect 
cp with it's own mutex.

Thanks
Farhan


> 
>>   			cp_free(&private->cp);
>>   	}
>>   	mutex_lock(&private->io_mutex);
>>
> 
