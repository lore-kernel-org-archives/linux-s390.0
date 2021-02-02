Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234757AbhBBOjz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 09:39:55 -0500
Subject: Re: [kvm-unit-tests PATCH v1 2/5] s390x: css: simplifications of the
 tests
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
 <20210202122311.3c1ead1c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <98905e4a-5f9a-4614-4677-5acc511d3fdd@linux.ibm.com>
Date: Tue, 2 Feb 2021 15:39:05 +0100
MIME-Version: 1.0
In-Reply-To: <20210202122311.3c1ead1c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com



On 2/2/21 12:23 PM, Cornelia Huck wrote:
> On Fri, 29 Jan 2021 15:34:26 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
...snip...

>> +bool css_enabled(int schid)
>> +{
>> +	struct pmcw *pmcw = &schib.pmcw;
>> +	int cc;
>> +
>> +	cc = stsch(schid, &schib);
>> +	if (cc) {
>> +		report_info("stsch: updating sch %08x failed with cc=%d",
>> +			    schid, cc);
>> +		return false;
>> +	}
>> +
>> +	if (!(pmcw->flags & PMCW_ENABLE)) {
>> +		report_info("stsch: sch %08x not enabled", schid);
>> +		return 0;
>> +	}
>> +	return true;
>> +}
>>   /*
>>    * css_enable: enable the subchannel with the specified ISC
>>    * @schid: Subchannel Identifier
>> @@ -167,18 +192,8 @@ retry:
>>   	/*
>>   	 * Read the SCHIB again to verify the enablement
>>   	 */
>> -	cc = stsch(schid, &schib);
>> -	if (cc) {
>> -		report_info("stsch: updating sch %08x failed with cc=%d",
>> -			    schid, cc);
>> -		return cc;
>> -	}
>> -
>> -	if ((pmcw->flags & flags) == flags) {
>> -		report_info("stsch: sch %08x successfully modified after %d retries",
>> -			    schid, retry_count);
>> +	if (css_enabled(schid))
> 
> This is a slightly different test now. Previously, you also checked
> whether the ISC matched the requested one. Not sure how valuable that
> test was.

Yes, I do not think it can be anything else when the CSS accept to 
enable the subchannel.

...
>>   
>> -	ret = css_enable(test_device_sid, IO_SCH_ISC);
>> -	if (ret) {
>> -		report(0, "Could not enable the subchannel: %08x",
>> -		       test_device_sid);
>> -		return;
>> +	if (!css_enabled(test_device_sid)) {
>> +		report(0, "enabled subchannel: %08x", test_device_sid);
> 
> Isn't that a _not_ enabled subchannel?

:) yes, may be:

s/enabled/enabling/


...snip...

>>   
>>   static void css_init(void)
>> @@ -146,8 +142,17 @@ static void css_init(void)
>>   	int ret;
>>   
>>   	ret = get_chsc_scsc();
>> -	if (!ret)
>> -		report(1, " ");
>> +	if (ret)
>> +		return;
> 
> Shouldn't you report a failure here?

Clearly yes.


Thanks for the comments,
regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
