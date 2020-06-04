Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgFDM1v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 08:27:51 -0400
Subject: Re: [kvm-unit-tests PATCH v7 08/12] s390x: css: stsch, enumeration
 test
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
 <20200527105501.53681762.cohuck@redhat.com>
 <d3890f6a-1c0e-b4cc-f958-6f33bdf75666@linux.ibm.com>
 <8b8fff3f-4954-c51e-59a3-813cb5066e26@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <764801cc-ac1f-3164-bf06-7dafdd45e542@linux.ibm.com>
Date: Thu, 4 Jun 2020 14:27:43 +0200
MIME-Version: 1.0
In-Reply-To: <8b8fff3f-4954-c51e-59a3-813cb5066e26@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com



On 2020-06-04 13:45, Thomas Huth wrote:
> On 04/06/2020 13.35, Pierre Morel wrote:
>>
>>
>> On 2020-05-27 10:55, Cornelia Huck wrote:
>>> On Mon, 18 May 2020 18:07:27 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
>>>> First step for testing the channel subsystem is to enumerate the css and
>>>> retrieve the css devices.
>>>>
>>>> This tests the success of STSCH I/O instruction, we do not test the
>>>> reaction of the VM for an instruction with wrong parameters.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    s390x/Makefile      |  1 +
>>>>    s390x/css.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    s390x/unittests.cfg |  4 ++
>>>>    3 files changed, 94 insertions(+)
>>>>    create mode 100644 s390x/css.c
>>>
>>> (...)
>>>
>>>> +static void test_enumerate(void)
>>>> +{
>>>> +    struct pmcw *pmcw = &schib.pmcw;
>>>> +    int cc;
>>>> +    int scn;
>>>> +    int scn_found = 0;
>>>> +    int dev_found = 0;
>>>> +
>>>> +    for (scn = 0; scn < 0xffff; scn++) {
>>>> +        cc = stsch(scn|SID_ONE, &schib);
>>>> +        switch (cc) {
>>>> +        case 0:        /* 0 means SCHIB stored */
>>>> +            break;
>>>> +        case 3:        /* 3 means no more channels */
>>>> +            goto out;
>>>> +        default:    /* 1 or 2 should never happened for STSCH */
>>>> +            report(0, "Unexpected cc=%d on subchannel number 0x%x",
>>>> +                   cc, scn);
>>>> +            return;
>>>> +        }
>>>> +
>>>> +        /* We currently only support type 0, a.k.a. I/O channels */
>>>> +        if (PMCW_CHANNEL_TYPE(pmcw) != 0)
>>>> +            continue;
>>>> +
>>>> +        /* We ignore I/O channels without valid devices */
>>>> +        scn_found++;
>>>> +        if (!(pmcw->flags & PMCW_DNV))
>>>> +            continue;
>>>> +
>>>> +        /* We keep track of the first device as our test device */
>>>> +        if (!test_device_sid)
>>>> +            test_device_sid = scn | SID_ONE;
>>>> +
>>>> +        dev_found++;
>>>> +    }
>>>> +
>>>> +out:
>>>> +    report(dev_found,
>>>> +           "Tested subchannels: %d, I/O subchannels: %d, I/O
>>>> devices: %d",
>>>> +           scn, scn_found, dev_found);
>>>
>>> Just wondering: with the current invocation, you expect to find exactly
>>> one subchannel with a valid device, right?
>> ...snip...
>>
>>>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>>>> index 07013b2..a436ec0 100644
>>>> --- a/s390x/unittests.cfg
>>>> +++ b/s390x/unittests.cfg
>>>> @@ -83,3 +83,7 @@ extra_params = -m 1G
>>>>    [sclp-3g]
>>>>    file = sclp.elf
>>>>    extra_params = -m 3G
>>>> +
>>>> +[css]
>>>> +file = css.elf
>>>> +extra_params =-device ccw-pong
>>>
>>> Hm... you could test enumeration even with a QEMU that does not include
>>> support for the pong device, right? Would it be worthwhile to split out
>>> a set of css tests that use e.g. a virtio-net-ccw device, and have a
>>> css-pong set of tests that require the pong device?
>>>
>>
>> Yes, you are right, using a virtio-net-ccw will allow to keep this test
>> without waiting for the PONG device to exist.
>>
>> @Thomas, what do you think? I will still have to figure something out
>> for PONG tests but here, it should be OK with virtio-net-ccw.
> 
> Sure, sounds good. We can go with -device virtio-net-ccw for now, and
> then later add an additional entry a la:
> 
> [css-pong]
> file = css.elf
> device = ccw-pong
> 
> ... where the test scripts then check for the availability of the device
> first before starting the test?
> 
>   Thomas
> 

yes,
thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
