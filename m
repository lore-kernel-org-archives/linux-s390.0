Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727671AbfLBSeH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 13:34:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2IWS2Z113492
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 13:34:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6g8t069-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 13:34:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 2 Dec 2019 18:34:03 -0000
Subject: Re: [kvm-unit-tests PATCH v2 6/9] s390x: css: stsch, enumeration test
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-7-git-send-email-pmorel@linux.ibm.com>
 <20191202152246.4d627b0e.cohuck@redhat.com>
 <aa588c00-79ac-2942-7911-b476abb224db@linux.ibm.com>
 <20191202191541.1ffd987e.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 2 Dec 2019 19:33:59 +0100
MIME-Version: 1.0
In-Reply-To: <20191202191541.1ffd987e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bb189d95-ddfc-7031-d0dd-7de3e0dd5a7f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-02 19:15, Cornelia Huck wrote:
> On Mon, 2 Dec 2019 18:53:16 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2019-12-02 15:22, Cornelia Huck wrote:
>>> On Thu, 28 Nov 2019 13:46:04 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> +static int test_device_sid;
>>>> +
>>>> +static void test_enumerate(void)
>>>> +{
>>>> +	struct pmcw *pmcw = &schib.pmcw;
>>>> +	int sid;
>>>> +	int ret, i;
>>>> +	int found = 0;
>>>> +
>>>> +	for (sid = 0; sid < 0xffff; sid++) {
>>>> +		ret = stsch(sid|SID_ONE, &schib);
>>>
>>> This seems a bit odd. You are basically putting the subchannel number
>>> into sid, OR in the one, and then use the resulting value as the sid
>>> (subchannel identifier).
>>>    
>>>> +		if (!ret && (pmcw->flags & PMCW_DNV)) {
>>>> +			report_info("SID %04x Type %s PIM %x", sid,
>>>
>>> That's not a sid, but the subchannel number (see above).
>>>    
>>>> +				     Channel_type[pmcw->st], pmcw->pim);
>>>> +			for (i = 0; i < 8; i++)  {
>>>> +				if ((pmcw->pim << i) & 0x80) {
>>>> +					report_info("CHPID[%d]: %02x", i,
>>>> +						    pmcw->chpid[i]);
>>>> +					break;
>>>> +				}
>>>> +			}
>>>> +			found++;
>>>> +	
>>>> +		}
>>>
>>> Here, you iterate over the 0-0xffff range, even if you got a condition
>>> code 3 (indicating no more subchannels in that set). Is that
>>> intentional?
>>
>> I thought there could be more subchannels.
>> I need then a break in the loop when this happens.
>> I will reread the PoP to see how to find that no more subchannel are in
>> that set.
> 
> The fact that cc 3 for stsch == no more subchannels is unfortunately a
> bit scattered across the PoP :/ Dug it out some time ago, maybe it's
> still in the archives somewhere...

So the the subchannel are always one after the other?

> 
>>
>>>    
>>>> +		if (found && !test_device_sid)
>>>> +			test_device_sid = sid|SID_ONE;
>>>
>>> You set test_device_sid to the last valid subchannel? Why?
>>
>> The last ? I wanted the first one
> 
> It is indeed the first one, -ENOCOFFEE.

Would never happend to me.


> 
>>
>> I wanted something easy but I should have explain.
>>
>> To avoid doing complicated things like doing a sense on each valid
>> subchannel I just take the first one.
>> Should be enough as we do not go to the device in this test.
> 
> Yes; but you plan to reuse that code, don't you?

yes, so I must think about this

> 
>>
>>>    
>>>> +	}
>>>> +	if (!found) {
>>>> +		report("Found %d devices", 0, found);
> 
> Now that I look at this again: If you got here, you always found 0
> devices, so that message is not super helpful :)

yes, found is too much.
A cut and past from the time I was happy to find even one! :)

> 
>>>> +		return;
>>>> +	}
>>>> +	ret = stsch(test_device_sid, &schib);
>>>
>>> Why do you do a stsch() again?
>>
>> right, no need.
>> In an internal version I used to print some informations from the SCHIB.
>> Since in between I overwrote the SHIB, I did it again.
>> But in this version; no need.
> 
> You could copy the schib of the subchannel to be tested to a different
> place, but I'm not sure it's worth it.
> 
>>
>>>    
>>>> +	if (ret) {
>>>> +		report("Err %d on stsch on sid %08x", 0, ret, test_device_sid);
>>>> +		return;
>>>> +	}
>>>> +	report("Tested", 1);
>>>> +	return;
>>>
>>> I don't think you need this return statement.
>>
>> right I have enough work. :)
>>
>>>
>>> Your test only enumerates devices in the first subchannel set. Do you
>>> plan to enhance the test to enable the MSS facility and iterate over
>>> all subchannel sets?
>>
>> Yes, it is something we can do in a following series
> 
> Sure, just asked out of interest :)
> 

Thanks,

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
