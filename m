Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbfKSPQe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 10:16:34 -0500
Subject: Re: [RFC PATCH v1 03/10] vfio-ccw: Use subchannel lpm in the orb
References: <20191115025620.19593-1-farman@linux.ibm.com>
 <20191115025620.19593-4-farman@linux.ibm.com>
 <20191119140046.4b81edd8.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <fa7f22e1-df44-4ad2-871a-23cd4feebc5e@linux.ibm.com>
Date: Tue, 19 Nov 2019 10:16:30 -0500
MIME-Version: 1.0
In-Reply-To: <20191119140046.4b81edd8.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>



On 11/19/19 8:00 AM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 03:56:13 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> The subchannel logical path mask (lpm) would have the most
>> up to date information of channel paths that are logically
>> available for the subchannel.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v0->v1: [EF]
>>      - None; however I am greatly confused by this one.  Thoughts?
> 
> I think it's actually wrong.
> 
>>
>>  drivers/s390/cio/vfio_ccw_cp.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index 3645d1720c4b..d4a86fb9d162 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -779,9 +779,7 @@ union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm)
>>  	orb->cmd.intparm = intparm;
>>  	orb->cmd.fmt = 1;
>>  	orb->cmd.key = PAGE_DEFAULT_KEY >> 4;
>> -
>> -	if (orb->cmd.lpm == 0)
>> -		orb->cmd.lpm = lpm;
> 
> In the end, the old code will use the lpm from the subchannel
> structure, if userspace did not supply anything to be used.
> 
>> +	orb->cmd.lpm = lpm;
> 
> The new code will always discard any lpm userspace has supplied and
> replace it with the lpm from the subchannel structure. This feels
> wrong; what if the I/O is supposed to be restricted to a subset of the
> paths?

I had the same opinion, but didn't want to flat-out discard it from his
series without a second look.  :)

> 
> If we want to include the current value of the subchannel lpm in the
> requests, we probably want to AND the masks instead.

Then we'd be on the hook to return some sort of error if the result is
zero.  Is it better to just send it to hw as-is, and let the response
come back naturally?  (Which is what we do today.)

> 
>>  
>>  	chain = list_first_entry(&cp->ccwchain_list, struct ccwchain, next);
>>  	cpa = chain->ch_ccw;
> 
