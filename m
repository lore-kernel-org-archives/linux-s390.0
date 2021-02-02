Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236137AbhBBQQL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 11:16:11 -0500
Subject: Re: [kvm-unit-tests PATCH v1 3/5] s390x: css: implementing Set
 CHannel Monitor
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-4-git-send-email-pmorel@linux.ibm.com>
 <20210202124818.6084bb36.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <e28ee611-faad-bb2d-ede2-3efcb7b56c53@linux.ibm.com>
Date: Tue, 2 Feb 2021 17:15:22 +0100
MIME-Version: 1.0
In-Reply-To: <20210202124818.6084bb36.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com



On 2/2/21 12:48 PM, Cornelia Huck wrote:
> On Fri, 29 Jan 2021 15:34:27 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We implement the call of the Set CHannel Monitor instruction,
>> starting the monitoring of the all Channel Sub System, and
> 
> "initializing channel subsystem monitoring" ?

Yes, better I take this.

> 
>> the initialization of the monitoring on a Sub Channel.
> 
> "enabling monitoring for a subchannel" ?
> 
>>
>> An initial test reports the presence of the extended measurement
>> block feature.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     | 17 +++++++++-
>>   lib/s390x/css_lib.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>>   s390x/css.c         |  7 +++++
>>   3 files changed, 100 insertions(+), 1 deletion(-)
>>
> 
> (...)
> 
>> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
>> index f300969..9e0f568 100644
>> --- a/lib/s390x/css_lib.c
>> +++ b/lib/s390x/css_lib.c
>> @@ -205,6 +205,83 @@ retry:
>>   	return -1;
>>   }
>>   
>> +/*
>> + * css_enable_mb: enable the subchannel Mesurement Block
>> + * @schid: Subchannel Identifier
>> + * @mb   : 64bit address of the measurement block
>> + * @format1: set if format 1 is to be used
>> + * @mbi : the measurement block offset
>> + * @flags : PMCW_MBUE to enable measurement block update
>> + *	    PMCW_DCTME to enable device connect time
>> + * Return value:
>> + *   On success: 0
>> + *   On error the CC of the faulty instruction
>> + *      or -1 if the retry count is exceeded.
>> + */
>> +int css_enable_mb(int schid, uint64_t mb, int format1, uint16_t mbi,
>> +		  uint16_t flags)
>> +{
>> +	struct pmcw *pmcw = &schib.pmcw;
>> +	int retry_count = 0;
>> +	int cc;
>> +
>> +	/* Read the SCHIB for this subchannel */
>> +	cc = stsch(schid, &schib);
>> +	if (cc) {
>> +		report_info("stsch: sch %08x failed with cc=%d", schid, cc);
>> +		return cc;
>> +	}
>> +
>> +retry:
>> +	/* Update the SCHIB to enable the measurement block */
>> +	pmcw->flags |= flags;
>> +
>> +	if (format1)
>> +		pmcw->flags2 |= PMCW_MBF1;
>> +	else
>> +		pmcw->flags2 &= ~PMCW_MBF1;
>> +
>> +	pmcw->mbi = mbi;
>> +	schib.mbo = mb;
>> +
>> +	/* Tell the CSS we want to modify the subchannel */
>> +	cc = msch(schid, &schib);
> 
> Setting some invalid flags for measurements in the schib could lead to
> an operand exception. Do we want to rely on the caller always getting
> it right, or should we add handling for those invalid flags? (Might
> also make a nice test case.)

Yes it does.
I add new test cases to test if we get the right error.


Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
