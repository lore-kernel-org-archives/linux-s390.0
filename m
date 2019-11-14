Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfKNR4E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 12:56:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEHmptW000793
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 12:56:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w998dpuuv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 12:56:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 17:55:59 -0000
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
 <db451544-fcb1-9d81-7042-ef91c8324204@linux.ibm.com>
 <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
 <b5ce5e92-9412-d491-8d7c-270a92f3bff0@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 18:55:56 +0100
MIME-Version: 1.0
In-Reply-To: <b5ce5e92-9412-d491-8d7c-270a92f3bff0@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <ba992c10-b411-c3ec-826e-ffbdd0019a00@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com


On 2019-11-14 18:09, Janosch Frank wrote:
> On 11/14/19 5:38 PM, Pierre Morel wrote:
>> On 2019-11-14 10:15, Janosch Frank wrote:
>>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>>> This simple test test the I/O reading by the SUB Channel by:
>>>> - initializing the Channel SubSystem with predefined CSSID:
>>>>     0xfe000000 CSSID for a Virtual CCW
>>>>     0x00090000 SSID for CCW-PONG
>>>> - initializing the ORB pointing to a single READ CCW
>>>> - starts the STSH command with the ORB
>>>> - Expect an interrupt
>>>> - writes the read data to output
>>>>
>>>> The test implements lots of traces when DEBUG is on and
>>>> tests if memory above the stack is corrupted.
>>> What happens if we do not habe the pong device?
>> CC error on stsch() which is currently not cached (but will in the next
>> version)
>>
>> CC error on msch() and on ssch() which is cached and makes the test to fail.
>>
>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    lib/s390x/css.h      | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    lib/s390x/css_dump.c | 141 +++++++++++++++++++++++++++++
>>> Hmm, what about splitting the patch into css.h/css_dump.c and the actual
>>> test in s390x/css.c?
>> OK
>>
>>
>>>>    s390x/Makefile       |   2 +
>>>>    s390x/css.c          | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>    s390x/unittests.cfg  |   4 +
>>>>    5 files changed, 613 insertions(+)
>>>>    create mode 100644 lib/s390x/css.h
>>>>    create mode 100644 lib/s390x/css_dump.c
>>>>    create mode 100644 s390x/css.c
>>>>
>>>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>>>> new file mode 100644
>> OK to all comments...  (I sniped out for clarity)
>>
>> ...snip...
>>
>>
>>>> +static char buffer[4096];
>>>> +
>>>> +static void delay(int d)
>>>> +{
>>>> +	int i, j;
>>>> +
>>>> +	while (d--)
>>>> +		for (i = 1000000; i; i--)
>>>> +			for (j = 1000000; j; j--)
>>>> +				;
>>>> +}
>>> You could set a timer.
>>
>> Hum, do we really want to do this?
> Why exactly do you need it if you can't have an exact time to wait for?

In fact I do not need it since the CCW instructions are treated 
synchronously.

It was for the fact we speak to a real device or if QEMU uses iothreads 
for CCW handling.


...snip


>>>> +
>>>> +	delay(1);
>>>> +
>>>> +	stsch(CSSID_PONG, &schib);
>>>> +	dump_schib(&schib);
>>> Is all that dumping necessary or just a dev remainder?
>>
>> it goes in the logs, so I thought it could be interresting to keep it.
> Depends on how much output is produced.
> If I have to scroll through your dumps to get to the ouptuts
>   of the reports then they are .
>
> See the answer below...


OK


>
>>
>>>> +	DBG("got: %s\n", buffer);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +#define MAX_ERRORS 10
>>>> +static int checkmem(phys_addr_t start, phys_addr_t end)
>>>> +{
>>>> +	phys_addr_t curr;
>>>> +	int err = 0;
>>>> +
>>>> +	for (curr = start; curr != end; curr += PAGE_SIZE)
>>>> +		if (memcmp((void *)start, (void *)curr, PAGE_SIZE)) {
>>>> +			report("memcmp failed %lx", true, curr);
>>> How many errors do you normally run into (hopefully 0)?
>>
>> hopefully.
>>
>> However I thought it could be interesting to know how many pages have
>> been dirtied.
> Honestly, for debugging a failing test we would need to add prints or
> attach gdb anyway. So I see no reason to not fail on the first occurrence.


OK

I will make the second version more quiet and much better.

Thanks for the comments,

Regards,

Pierre



-- 
Pierre Morel
IBM Lab Boeblingen
