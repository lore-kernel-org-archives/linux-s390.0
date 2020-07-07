Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726745AbgGGLOz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:14:55 -0400
Subject: Re: [kvm-unit-tests PATCH v10 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1593707480-23921-1-git-send-email-pmorel@linux.ibm.com>
 <1593707480-23921-10-git-send-email-pmorel@linux.ibm.com>
 <20200706114655.5088b6b7.cohuck@redhat.com>
 <02eb7a70-7a74-6f09-334f-004e69aaa198@linux.ibm.com>
 <20200706162413.1a24fe40.cohuck@redhat.com>
 <b4bad260-1ae5-7cd8-2339-63c73e3218bd@linux.ibm.com>
 <20200707130530.1f365c5f.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <9080a181-90f5-425b-dc36-41444079c41e@linux.ibm.com>
Date: Tue, 7 Jul 2020 13:14:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200707130530.1f365c5f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com



On 2020-07-07 13:05, Cornelia Huck wrote:
> On Tue, 7 Jul 2020 12:57:03 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-07-06 16:24, Cornelia Huck wrote:
>>> On Mon, 6 Jul 2020 15:01:50 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> On 2020-07-06 11:46, Cornelia Huck wrote:
>>>>> On Thu,  2 Jul 2020 18:31:20 +0200
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>       
>>>>>> After a channel is enabled we start a SENSE_ID command using
>>>>>> the SSCH instruction to recognize the control unit and device.
>>>>>>
>>>>>> This tests the success of SSCH, the I/O interruption and the TSCH
>>>>>> instructions.
>>>>>>
>>>>>> The SENSE_ID command response is tested to report 0xff inside
>>>>>> its reserved field and to report the same control unit type
>>>>>> as the cu_type kernel argument.
>>>>>>
>>>>>> Without the cu_type kernel argument, the test expects a device
>>>>>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>>>>>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>> ---
>>>>>>     lib/s390x/asm/arch_def.h |   1 +
>>>>>>     lib/s390x/css.h          |  32 ++++++++-
>>>>>>     lib/s390x/css_lib.c      | 148 ++++++++++++++++++++++++++++++++++++++-
>>>>>>     s390x/css.c              |  94 ++++++++++++++++++++++++-
>>>>>>     4 files changed, 272 insertions(+), 3 deletions(-)
>>>
>>> (...)
>>>    
>>>>>> @@ -114,6 +128,7 @@ retry:
>>>>>>     		return cc;
>>>>>>     	}
>>>>>>     
>>>>>> +	report_info("stsch: flags: %04x", pmcw->flags);
>>>>>
>>>>> It feels like all of this already should have been included in the
>>>>> previous patch?
>>>>
>>>> Yes, I did not want to modify it since it was reviewed-by.
>>>
>>> It's not such a major change (the isc change and this here), though...
>>> what do the others think?
>> changed my mind:
>> What about keeping css_enable() to only do enable, in case we only want
>> to do this, and add a function to modify the ISC.
> 
> Hm, the isc is only really relevant while the subchannel is enabled, so
> this would be fine if we only ever modified the isc while the
> subchannel is disabled. On the other hand, we introduce an extra round
> of msch. No strong opinion on my side.
> 

Hum too, I fear we can not avoid the msch round:
After your comment I realize that we can not let the channel enabled 
without a valid ISC in the case we enable IRQ.
So unless other opinion, back to the css_enable(schid, isc).


-- 
Pierre Morel
IBM Lab Boeblingen
