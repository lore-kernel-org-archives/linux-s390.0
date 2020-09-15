Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgIOKZk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 06:25:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FA1Spn032202
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2020 06:25:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33jrqge892-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2020 06:25:38 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FA1ZR0033017
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2020 06:25:37 -0400
Subject: Re: [RFD] uevent handling for subchannels
References: <20200403124032.5e70603d.cohuck@redhat.com>
 <20200417143811.7e6ecb2c.cohuck@redhat.com>
 <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
 <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
 <20200423182001.40345df8.cohuck@redhat.com>
 <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
 <20200430124316.023a82b0.cohuck@redhat.com>
 <20200629135631.10db3c32.cohuck@redhat.com>
 <20200701112313.62a22156.cohuck@redhat.com>
 <20200914134642.5e2e2c0e.cohuck@redhat.com>
From: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Message-ID: <923020f2-e722-a6ba-fcb4-08dd8228fc00@linux.vnet.ibm.com>
Date: Tue, 15 Sep 2020 12:25:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200914134642.5e2e2c0e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

Hi Conny,
Thank you for the ping. This is pending for a long time and we just resumed
looking at this approach. Me and Peter had a short discussion on this and we
are trying to do some cleaning as well on the CIO layer while working 
with the
new approach.

There are few uncertainties with the new approach, which we would like 
to clarify
and i am trying to test it.For example, the impact on the way 
cio-console driver works.
So, as discussed with Peter, let me make a smaller draft which will 
consolidate
your approach and the "cleaning" part that we would like to do.

As mentioned, i will resume working on this and get back to you with 
myfindings.

Thank you,
Vineeth



On 9/14/20 1:46 PM, Cornelia Huck wrote:
> <casts "reanimate" on dead thread>
>
> On Wed, 1 Jul 2020 11:23:13 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Mon, 29 Jun 2020 13:56:31 +0200
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> Ok, so I've resumed the thinking process, and I think getting rid of
>>> the "no I/O subchannel without functional device" approach is a good
>>> idea, and allows us to make handling driver matches more similar to
>>> everyone else.
>> As an aside, there's another odd construct: the I/O subchannel driver
>> *always* binds to the subchannel device, even if there is a problem,
>> and schedules an unregistration of the subchannel device on error. This
>> was introduced because events from machine check handling are not
>> processed if there isn't a driver (at least I thought back then that it
>> was a good idea.) I think a more correct way to handle this would be to
>> do the following:
>>
>> * If something doesn't work, clean up and return an error in the probe
>>    function. The subchannel device stays around, it's just not bound.
>> * Have the css bus do some basic processing for subchannels not bound
>>    to any driver (e.g., check dnv/w). This would also make it possible
>>    to unregister dead message subchannels if a machine check is received
>>    for them (don't know if that's an actual problem in pratice.)
>>
>>> What changes would be needed?
>>> * The whole logic to suppress uevents for subchannels and generate one
>>>    later will go. (Touches the various subchannel driver, including
>>>    vfio-ccw.)
>>> * ccw_device_todo() can just unregister the ccw device, and there's no
>>>    longer a need for ccw_device_call_sch_unregister(). (IIUC, this also
>>>    covers setting disconnected devices offline.)
>> I'm actually not sure if unregistration-by-driver is the right thing
>> for most cases (except for something like disconnected device removal),
>> that should be done by the bus. Maybe something for later (don't fear,
>> I don't plan to work on the common I/O layer again :)
>>
>>> * As the I/O subchannel driver now needs to deal with cases where no
>>>    ccw device is available, the code for that needs to be checked.
>>>    (That's probably the most time-consuming task.)
>> Had a quick look, doesn't actually look too bad (most places already
>> check for !cdev.)
>>
>>> Userspace should be fine with I/O subchannels without ccw device,
>>> that's nothing new.
>>>
>>> Does that sound reasonable?
> Is anybody looking at this? The delayed uevent handling is a bit of a
> mess for management of vfio-ccw devices...
>
