Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbhANNEN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 08:04:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10ED2wQ9074497
        for <linux-s390@vger.kernel.org>; Thu, 14 Jan 2021 08:03:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362p9prch8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Jan 2021 08:03:32 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10ED3TNB079056
        for <linux-s390@vger.kernel.org>; Thu, 14 Jan 2021 08:03:31 -0500
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
 <20201124093407.23189-2-vneethv@linux.ibm.com>
 <20201124140220.77c65539.cohuck@redhat.com>
 <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
 <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
 <20201208183054.44f4fc2d.cohuck@redhat.com>
 <20201209135203.0008ab18.pasic@linux.ibm.com>
 <20201215191307.281c6e6f.cohuck@redhat.com>
 <20201219073316.1be609d5.pasic@linux.ibm.com>
 <20201221164634.11cd3813.cohuck@redhat.com>
 <20201221175117.2c5f5fcb.pasic@linux.ibm.com>
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
Message-ID: <d4dffa29-60b3-db27-fca7-ee4901c77162@linux.ibm.com>
Date: Thu, 14 Jan 2021 14:03:25 +0100
MIME-Version: 1.0
In-Reply-To: <20201221175117.2c5f5fcb.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.vnet.ibm.com>, oberpar@linux.ibm.com, linux-s390@vger.kernel.org, farman@linux.ibm.com

On 12/21/20 5:51 PM, Halil Pasic wrote:
> On Mon, 21 Dec 2020 16:46:34 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Sat, 19 Dec 2020 07:33:16 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> I finally came around to test this. In my experience driverctl works for
>>> subchannels and vfio_ccw without this patch, and continues to work with
>>> it. I found the code in driverctl that does the unbind and the implicit
>>> bind (via drivers_probe after after driver_override was set).
>>>
>>> So now I have to ask, how exactly was the original problem diagnosed?
>>>
>>> In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
>>> paragraph like:
>>>
>>> """
>>> So while there's definitely a good reason for wanting to delay uevents,
>>> it is also introducing problems. One is udev rules for subchannels that
>>> are supposed to do something before a driver binds (e.g. setting
>>> driver_override to bind an I/O subchannel to vfio_ccw instead of
>>> io_subchannel) are not effective, as the ADD uevent will only be
>>> generated when the io_subchannel driver is already done with doing all
>>> setup. Another one is that only the ADD uevent is generated after
>>> uevent suppression is lifted; any other uevents that might have been
>>> generated are lost.
>>> """
>>>
>>> This is not how driverclt works! I.e. it deals with the situation that
>>> the I/O subchannel was already bound to the io_subchannel driver at
>>> the time the udev rule installed by driverctl activates (via the
>>> mechanism I described above).
>>
>> That's... weird. It definitely did not work on the LPAR I initially
>> tried it out on!
>>
> 
> I think Boris told me some weeks ago that it didn't work for him either.
> I will check with him after the winter sleep.

Yesterday I used driverctl successfully for a subchannel on F33.

Not sure what went wrong a couple of months ago but I cannot reproduce 
driverctl not working now.

> 
>> However, I think removing the suppression still looks like a good idea:
>> we still have the "any uevent other than ADD will have been lost"
>> problem.
>>
I totally agree with this.

> 
> I agree. I didn't look into the details, in general I think removing
> quirks specific to 390 (when possible) is a good thing.
> 
> Regards,
> Halil
> 


-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
