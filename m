Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgDWOwf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 10:52:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NEY45H139292
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 10:52:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmvkd49b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 10:52:35 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03NEZfaI145175
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 10:52:34 -0400
Subject: Re: [RFD] uevent handling for subchannels
From: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
 <20200417143811.7e6ecb2c.cohuck@redhat.com>
 <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
Message-ID: <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2020 16:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

Hi Corenelia,

few cents on this,

1. css_register_subchannel() is called only for valid subchannels, which 
is taken care in the
css_alloc_subchannel(). So Adding a second css_sch_is_valid() in 
css_register_subchannel()
might not help us here. We still need to find a mechanism to avoid the 
performance impact
because of the uevent-storm from IO-subchannels without any valid device 
on them.

2. We will have to find a way to get the AVAILABLE-VALID-CCW-device 
information from css layer,
which would help vfio-ccw drivers to work with the uevents when it is 
not suppressed.
Then we could also change the way ccw_device_call_sch_unregister() 
works, where
the subchannel-unregister is happening from an upper layer.

Vineeth

On 4/20/20 5:29 PM, Vineeth Vijayan wrote:
> Thank you.
>
> Looks like a reasonable idea. But a bit worried about the consequences of
> this change. So i am trying to do some tests on LPARs and play around a
> bit before i reply to you. For example, testing it on an LPAR which 
> has got a large
> number of ccw-devices which are DEV_STATE_NOT_OPER.
>
> Let me get back to you after couple of tests.
>
> On 4/17/20 2:38 PM, Cornelia Huck wrote:
>> Friendly ping.
>>
>> On Fri, 3 Apr 2020 12:40:32 +0200
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> Hi,
>>>
>>> this is kind-of-a-followup to the uevent patches I sent in
>>> <20200327124503.9794-1-cohuck@redhat.com> last Friday.
>>>
>>> Currently, the common I/O layer will suppress uevents for subchannels
>>> that are being registered, delegating generating a delayed ADD uevent
>>> to the driver that actually binds to it and only generating the uevent
>>> itself if no driver gets bound. The initial version of that delaying
>>> was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
>>> subchannels"); from what I remember, we were seeing quite bad storms of
>>> uevents on LPARs that had a lot of I/O subchannels with no device
>>> accessible through them.
>>>
>>> So while there's definitely a good reason for wanting to delay uevents,
>>> it is also introducing problems. One is udev rules for subchannels that
>>> are supposed to do something before a driver binds (e.g. setting
>>> driver_override to bind an I/O subchannel to vfio_ccw instead of
>>> io_subchannel) are not effective, as the ADD uevent will only be
>>> generated when the io_subchannel driver is already done with doing all
>>> setup. Another one is that only the ADD uevent is generated after
>>> uevent suppression is lifted; any other uevents that might have been
>>> generated are lost.
>>>
>>> So, what to do about this, especially in the light of vfio-ccw 
>>> handling?
>>>
>>> One idea I had is to call css_sch_is_valid() from
>>> css_register_subchannel(); this would exclude the largest class of
>>> non-operational subchannels already (those that don't have a valid
>>> device; I'm not quite sure if there's also something needed for EADM
>>> subchannels?) If we got rid of the uevent delaying, we would still get
>>> ADD/REMOVE events for subchannels where the device turns out to be
>>> non-accessible, but I believe (hope) that those are not too many in a
>>> sane system at least. As a bonus, we could also add additional values
>>> from the pmcw to the uevent; the device number, for example, could be
>>> helpful for vfio-ccw matching rules.
>>>
>>> A drawback is that we change the timing (not the sequence, AFAICS) of
>>> the uevents, which might break brittle setups.
>>>
>>> Thoughts?
>>>
