Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47182 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbfLCIoJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Dec 2019 03:44:09 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB38bQU0059651
        for <linux-s390@vger.kernel.org>; Tue, 3 Dec 2019 03:44:07 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wkm47k8xp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Dec 2019 03:44:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 3 Dec 2019 08:43:59 -0000
Subject: Re: [kvm-unit-tests PATCH v2 6/9] s390x: css: stsch, enumeration test
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-7-git-send-email-pmorel@linux.ibm.com>
 <20191202152246.4d627b0e.cohuck@redhat.com>
 <aa588c00-79ac-2942-7911-b476abb224db@linux.ibm.com>
 <20191202191541.1ffd987e.cohuck@redhat.com>
 <bb189d95-ddfc-7031-d0dd-7de3e0dd5a7f@linux.ibm.com>
 <20191202204922.508d389f.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 3 Dec 2019 09:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <20191202204922.508d389f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6bc09e13-69f9-78de-9ee1-94f65798f747@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-02 20:49, Cornelia Huck wrote:
> On Mon, 2 Dec 2019 19:33:59 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2019-12-02 19:15, Cornelia Huck wrote:
>>> On Mon, 2 Dec 2019 18:53:16 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> On 2019-12-02 15:22, Cornelia Huck wrote:
>>>>> On Thu, 28 Nov 2019 13:46:04 +0100
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>>>> +static int test_device_sid;
>>>>>> +
>>>>>> +static void test_enumerate(void)
>>>>>> +{
>>>>>> +	struct pmcw *pmcw = &schib.pmcw;
>>>>>> +	int sid;
>>>>>> +	int ret, i;
>>>>>> +	int found = 0;
>>>>>> +
>>>>>> +	for (sid = 0; sid < 0xffff; sid++) {
>>>>>> +		ret = stsch(sid|SID_ONE, &schib);
>>>>>
>>>>> This seems a bit odd. You are basically putting the subchannel number
>>>>> into sid, OR in the one, and then use the resulting value as the sid
>>>>> (subchannel identifier).
>>>>>       
>>>>>> +		if (!ret && (pmcw->flags & PMCW_DNV)) {
>>>>>> +			report_info("SID %04x Type %s PIM %x", sid,
>>>>>
>>>>> That's not a sid, but the subchannel number (see above).
>>>>>       
>>>>>> +				     Channel_type[pmcw->st], pmcw->pim);
>>>>>> +			for (i = 0; i < 8; i++)  {
>>>>>> +				if ((pmcw->pim << i) & 0x80) {
>>>>>> +					report_info("CHPID[%d]: %02x", i,
>>>>>> +						    pmcw->chpid[i]);
>>>>>> +					break;
>>>>>> +				}
>>>>>> +			}
>>>>>> +			found++;
>>>>>> +	
>>>>>> +		}
>>>>>
>>>>> Here, you iterate over the 0-0xffff range, even if you got a condition
>>>>> code 3 (indicating no more subchannels in that set). Is that
>>>>> intentional?
>>>>
>>>> I thought there could be more subchannels.
>>>> I need then a break in the loop when this happens.
>>>> I will reread the PoP to see how to find that no more subchannel are in
>>>> that set.
>>>
>>> The fact that cc 3 for stsch == no more subchannels is unfortunately a
>>> bit scattered across the PoP :/ Dug it out some time ago, maybe it's
>>> still in the archives somewhere...
>>
>> So the the subchannel are always one after the other?
> 
> While QEMU (and z/VM) usually do that, they can really be scattered
> around. For the in-between I/O subchannels that don't lead to a device,
> you'll still get cc 0, it's just the dnv bit that is 0. The cc 3
> basically just tells you that you can stop looking.
> 

Thanks for the explanation, I will change the code accordingly.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
