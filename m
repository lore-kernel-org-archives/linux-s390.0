Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229500AbhBAMXl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Feb 2021 07:23:41 -0500
Subject: Re: [kvm-unit-tests PATCH v1 2/5] s390x: css: simplifications of the
 tests
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-3-git-send-email-pmorel@linux.ibm.com>
 <4f5ca0b9-378e-431c-33ec-79946bdf21b2@linux.ibm.com>
 <10f3108b-c1fe-7da9-7153-803690d311d4@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <0069eb2c-7b9c-1582-c86f-0c68a147d608@linux.ibm.com>
Date: Mon, 1 Feb 2021 13:22:52 +0100
MIME-Version: 1.0
In-Reply-To: <10f3108b-c1fe-7da9-7153-803690d311d4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

On 2/1/21 1:15 PM, Pierre Morel wrote:
> 
> 
> On 2/1/21 11:11 AM, Janosch Frank wrote:
>> On 1/29/21 3:34 PM, Pierre Morel wrote:
> 
> ...snip...
> 
>>> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
>>> index fe05021..f300969 100644
>>> --- a/lib/s390x/css_lib.c
>>> +++ b/lib/s390x/css_lib.c
>>> @@ -118,6 +118,31 @@ out:
>>>   	return schid;
>>>   }
>>>   
>>> +/*
>>> + * css_enable: enable the subchannel with the specified ISC
>>
>> enabled or enable?
> 
> Forgot to change the cut and paste :(
> 
> /*
>   * css_enabled: report if the sub channel is enabled
> 
>>
>> I.e. do you test if it is enabled or do you want to enable it.
>>
>>> + * @schid: Subchannel Identifier
>>> + * Return value:
>>> + *   true if the subchannel is enabled
>>> + *   false otherwise
>>> + */
>>> +bool css_enabled(int schid)
>>> +{
>>> +	struct pmcw *pmcw = &schib.pmcw;
>>> +	int cc;
>>> +
>>> +	cc = stsch(schid, &schib);
>>> +	if (cc) {
>>> +		report_info("stsch: updating sch %08x failed with cc=%d",
>>> +			    schid, cc);
>>> +		return false;
>>> +	}
>>> +
>>> +	if (!(pmcw->flags & PMCW_ENABLE)) {
>>> +		report_info("stsch: sch %08x not enabled", schid);
>>> +		return 0;
>>
>> Please stay with true/false or change the return type to int and use ints.
> 
> yes
> 
>>
>>> +	}
>>> +	return true;
>>> +}
> 
> ...snip...
> 
>>> @@ -129,16 +120,21 @@ static void test_sense(void)
>>>   	report_info("reserved 0x%02x cu_type 0x%04x cu_model 0x%02x dev_type 0x%04x dev_model 0x%02x",
>>>   		    senseid->reserved, senseid->cu_type, senseid->cu_model,
>>>   		    senseid->dev_type, senseid->dev_model);
>>> +	report_info("cu_type expected 0x%04x got 0x%04x", (uint16_t)cu_type,
>>> +		    senseid->cu_type);
>>>   
>>> -	report(senseid->cu_type == cu_type, "cu_type expected 0x%04x got 0x%04x",
>>> -	       (uint16_t)cu_type, senseid->cu_type);
>>> +	retval = senseid->cu_type == cu_type;
>>>   
>>>   error:
>>>   	free_io_mem(ccw, sizeof(*ccw));
>>>   error_ccw:
>>>   	free_io_mem(senseid, sizeof(*senseid));
>>> -error_senseid:
>>> -	unregister_io_int_func(css_irq_io);
>>> +	return retval;
>>
>> Could you return senseid->cu_type == cu_type here?
> 
> It would work for the current code and DEFAULT_CU_TYPE.
> But I do not think it is a good idea due to the goto we have in error 
> case before I find that it makes the code less understandable.
> 
> Other opinion?

That's why I asked, it wasn't a direct suggestion.
I'm not a big fan of the ret/retval naming but the function is short so
it should be ok.

> 
> Thanks for the comments,
> Pierre
> 
