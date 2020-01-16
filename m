Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgAPNSQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 08:18:16 -0500
Subject: Re: [kvm-unit-tests PATCH v2 6/7] s390x: smp: Test all CRs on initial
 reset
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-7-frankja@linux.ibm.com>
 <7e85ec92-4d0a-f673-00c8-a9ab9a22118c@redhat.com>
 <400dc0d2-86bc-cdc8-ec8a-7d1148ebd5fa@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6f2c30a7-78a6-ef85-20dd-865e3087cdd0@redhat.com>
Date: Thu, 16 Jan 2020 14:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <400dc0d2-86bc-cdc8-ec8a-7d1148ebd5fa@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 14:07, Janosch Frank wrote:
> On 1/16/20 1:24 PM, David Hildenbrand wrote:
>> On 16.01.20 13:05, Janosch Frank wrote:
>>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>>> so we also need to test 1-13 and 15 for 0.
>>>
>>> And while we're at it, let's also set some values to cr 1, 7 and 13, so
>>> we can actually be sure that they will be zeroed.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  s390x/smp.c | 19 ++++++++++++++++++-
>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>> index d430638..ce3215d 100644
>>> --- a/s390x/smp.c
>>> +++ b/s390x/smp.c
>>> @@ -176,16 +176,31 @@ static void test_emcall(void)
>>>  	report_prefix_pop();
>>>  }
>>>  
>>> +/* Used to dirty registers of cpu #1 before it is reset */
>>> +static void test_func_initial(void)
>>> +{
>>> +	lctlg(1, 0x42000UL);
>>> +	lctlg(7, 0x43000UL);
>>> +	lctlg(13, 0x44000UL);
>>> +	testflag = 1;
>>> +	mb();
>>> +	cpu_loop();
>>
>> Can we make cpu_loop() the default when this function returns? (IOW, an
>> endless loop whenever a cpu finished executing the function?)
> 
> So adding it to cstart64.S after the br 14?

Yes I think so.

> 
>>
>> Do we need the mb() here?
> 
> Would the compiler reorder the lctlcg and testflag if it could?

lctlg() does not have a "memory" constraint, so I guess it would be
valid if it would reorder.

I assume the mb() would have to be moved in front of the testflag=1?

-- 
Thanks,

David / dhildenb
