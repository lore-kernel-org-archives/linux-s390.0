Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11532 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgGGK5L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 06:57:11 -0400
Subject: Re: [kvm-unit-tests PATCH v10 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1593707480-23921-1-git-send-email-pmorel@linux.ibm.com>
 <1593707480-23921-10-git-send-email-pmorel@linux.ibm.com>
 <20200706114655.5088b6b7.cohuck@redhat.com>
 <02eb7a70-7a74-6f09-334f-004e69aaa198@linux.ibm.com>
 <20200706162413.1a24fe40.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <b4bad260-1ae5-7cd8-2339-63c73e3218bd@linux.ibm.com>
Date: Tue, 7 Jul 2020 12:57:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200706162413.1a24fe40.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com



On 2020-07-06 16:24, Cornelia Huck wrote:
> On Mon, 6 Jul 2020 15:01:50 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-07-06 11:46, Cornelia Huck wrote:
>>> On Thu,  2 Jul 2020 18:31:20 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> After a channel is enabled we start a SENSE_ID command using
>>>> the SSCH instruction to recognize the control unit and device.
>>>>
>>>> This tests the success of SSCH, the I/O interruption and the TSCH
>>>> instructions.
>>>>
>>>> The SENSE_ID command response is tested to report 0xff inside
>>>> its reserved field and to report the same control unit type
>>>> as the cu_type kernel argument.
>>>>
>>>> Without the cu_type kernel argument, the test expects a device
>>>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    lib/s390x/asm/arch_def.h |   1 +
>>>>    lib/s390x/css.h          |  32 ++++++++-
>>>>    lib/s390x/css_lib.c      | 148 ++++++++++++++++++++++++++++++++++++++-
>>>>    s390x/css.c              |  94 ++++++++++++++++++++++++-
>>>>    4 files changed, 272 insertions(+), 3 deletions(-)
> 
> (...)
> 
>>>> @@ -114,6 +128,7 @@ retry:
>>>>    		return cc;
>>>>    	}
>>>>    
>>>> +	report_info("stsch: flags: %04x", pmcw->flags);
>>>
>>> It feels like all of this already should have been included in the
>>> previous patch?
>>
>> Yes, I did not want to modify it since it was reviewed-by.
> 
> It's not such a major change (the isc change and this here), though...
> what do the others think?
changed my mind:
What about keeping css_enable() to only do enable, in case we only want 
to do this, and add a function to modify the ISC.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
