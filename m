Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbfGBN4Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 09:56:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62DsgUf104875
        for <linux-s390@vger.kernel.org>; Tue, 2 Jul 2019 09:56:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tg72jv255-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 09:56:23 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Tue, 2 Jul 2019 14:56:22 +0100
Subject: Re: [RFC v1 1/4] vfio-ccw: Set orb.cmd.c64 before calling
 ccwchain_handle_ccw
References: <cover.1561997809.git.alifm@linux.ibm.com>
 <050943a6f5a427317ea64100bc2b4ec6394a4411.1561997809.git.alifm@linux.ibm.com>
 <20190702102606.2e9cfed3.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 2 Jul 2019 09:56:19 -0400
MIME-Version: 1.0
In-Reply-To: <20190702102606.2e9cfed3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <de9ae025-a96a-11ab-2ba9-8252d8b070e0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 07/02/2019 04:26 AM, Cornelia Huck wrote:
> On Mon,  1 Jul 2019 12:23:43 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> Because ccwchain_handle_ccw calls ccwchain_calc_length and
>> as per the comment we should set orb.cmd.c64 before calling
>> ccwchanin_calc_length.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index d6a8dff..5ac4c1e 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -640,16 +640,16 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>>   	memcpy(&cp->orb, orb, sizeof(*orb));
>>   	cp->mdev = mdev;
>>   
>> -	/* Build a ccwchain for the first CCW segment */
>> -	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
>> -	if (ret)
>> -		cp_free(cp);
>> -
>>   	/* It is safe to force: if not set but idals used
>>   	 * ccwchain_calc_length returns an error.
>>   	 */
>>   	cp->orb.cmd.c64 = 1;
>>   
>> +	/* Build a ccwchain for the first CCW segment */
>> +	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
>> +	if (ret)
>> +		cp_free(cp);
>> +
>>   	if (!ret)
>>   		cp->initialized = true;
>>   
> 
> Hm... has this ever been correct, or did this break only with the
> recent refactorings?
> 
> (IOW, what should Fixes: point to?)
> 
> 

I think it was correct before some of the new refactoring we did. But we 
do need to set before calling ccwchain_calc_length, because the function 
does have a check for orb.cmd.64. I will see which exact commit did it.

Thanks
Farhan
