Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTP3T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 11:29:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KFBBsj005520
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 11:29:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu5xc9q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 11:29:17 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <vneethv@linux.vnet.ibm.com>;
        Mon, 20 Apr 2020 16:28:53 +0100
Subject: Re: [RFD] uevent handling for subchannels
References: <20200403124032.5e70603d.cohuck@redhat.com>
 <20200417143811.7e6ecb2c.cohuck@redhat.com>
From: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2020 17:29:11 +0200
MIME-Version: 1.0
In-Reply-To: <20200417143811.7e6ecb2c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

Thank you.

Looks like a reasonable idea. But a bit worried about the consequences of
this change. So i am trying to do some tests on LPARs and play around a
bit before i reply to you. For example, testing it on an LPAR which has 
got a large
number of ccw-devices which are DEV_STATE_NOT_OPER.

Let me get back to you after couple of tests.

On 4/17/20 2:38 PM, Cornelia Huck wrote:
> Friendly ping.
>
> On Fri, 3 Apr 2020 12:40:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> Hi,
>>
>> this is kind-of-a-followup to the uevent patches I sent in
>> <20200327124503.9794-1-cohuck@redhat.com> last Friday.
>>
>> Currently, the common I/O layer will suppress uevents for subchannels
>> that are being registered, delegating generating a delayed ADD uevent
>> to the driver that actually binds to it and only generating the uevent
>> itself if no driver gets bound. The initial version of that delaying
>> was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
>> subchannels"); from what I remember, we were seeing quite bad storms of
>> uevents on LPARs that had a lot of I/O subchannels with no device
>> accessible through them.
>>
>> So while there's definitely a good reason for wanting to delay uevents,
>> it is also introducing problems. One is udev rules for subchannels that
>> are supposed to do something before a driver binds (e.g. setting
>> driver_override to bind an I/O subchannel to vfio_ccw instead of
>> io_subchannel) are not effective, as the ADD uevent will only be
>> generated when the io_subchannel driver is already done with doing all
>> setup. Another one is that only the ADD uevent is generated after
>> uevent suppression is lifted; any other uevents that might have been
>> generated are lost.
>>
>> So, what to do about this, especially in the light of vfio-ccw handling?
>>
>> One idea I had is to call css_sch_is_valid() from
>> css_register_subchannel(); this would exclude the largest class of
>> non-operational subchannels already (those that don't have a valid
>> device; I'm not quite sure if there's also something needed for EADM
>> subchannels?) If we got rid of the uevent delaying, we would still get
>> ADD/REMOVE events for subchannels where the device turns out to be
>> non-accessible, but I believe (hope) that those are not too many in a
>> sane system at least. As a bonus, we could also add additional values
>> from the pmcw to the uevent; the device number, for example, could be
>> helpful for vfio-ccw matching rules.
>>
>> A drawback is that we change the timing (not the sequence, AFAICS) of
>> the uevents, which might break brittle setups.
>>
>> Thoughts?
>>
