Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391816AbhASLsY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 06:48:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10JBXdxa105555
        for <linux-s390@vger.kernel.org>; Tue, 19 Jan 2021 06:47:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365xfg8r2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Jan 2021 06:47:39 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10JBbHi3133010
        for <linux-s390@vger.kernel.org>; Tue, 19 Jan 2021 06:47:38 -0500
Date: Tue, 19 Jan 2021 12:47:24 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20210119124724.4c5cec19.pasic@linux.ibm.com>
In-Reply-To: <d4dffa29-60b3-db27-fca7-ee4901c77162@linux.ibm.com>
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
        <d4dffa29-60b3-db27-fca7-ee4901c77162@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Boris Fiuczynski <fiuczy@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.vnet.ibm.com>, oberpar@linux.ibm.com, linux-s390@vger.kernel.org, farman@linux.ibm.com

On Thu, 14 Jan 2021 14:03:25 +0100
Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:

> On 12/21/20 5:51 PM, Halil Pasic wrote:
> > On Mon, 21 Dec 2020 16:46:34 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Sat, 19 Dec 2020 07:33:16 +0100
> >> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>  
> >>> I finally came around to test this. In my experience driverctl works for
> >>> subchannels and vfio_ccw without this patch, and continues to work with
> >>> it. I found the code in driverctl that does the unbind and the implicit
> >>> bind (via drivers_probe after after driver_override was set).
> >>>
> >>> So now I have to ask, how exactly was the original problem diagnosed?
> >>>
> >>> In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
> >>> paragraph like:
> >>>
> >>> """
> >>> So while there's definitely a good reason for wanting to delay uevents,
> >>> it is also introducing problems. One is udev rules for subchannels that
> >>> are supposed to do something before a driver binds (e.g. setting
> >>> driver_override to bind an I/O subchannel to vfio_ccw instead of
> >>> io_subchannel) are not effective, as the ADD uevent will only be
> >>> generated when the io_subchannel driver is already done with doing all
> >>> setup. Another one is that only the ADD uevent is generated after
> >>> uevent suppression is lifted; any other uevents that might have been
> >>> generated are lost.
> >>> """
> >>>
> >>> This is not how driverclt works! I.e. it deals with the situation that
> >>> the I/O subchannel was already bound to the io_subchannel driver at
> >>> the time the udev rule installed by driverctl activates (via the
> >>> mechanism I described above).  
> >>
> >> That's... weird. It definitely did not work on the LPAR I initially
> >> tried it out on!
> >>  
> > 
> > I think Boris told me some weeks ago that it didn't work for him either.
> > I will check with him after the winter sleep.  
> 
> Yesterday I used driverctl successfully for a subchannel on F33.
> 
> Not sure what went wrong a couple of months ago but I cannot reproduce 
> driverctl not working now.

Thanks Boris!

@Conny: IMHO driver_override has to work without this patch. Can you
figure out, why did you claim it does not (and provide instructions
on how to reproduce the problem)?

> 
> >   
> >> However, I think removing the suppression still looks like a good idea:
> >> we still have the "any uevent other than ADD will have been lost"
> >> problem.
> >>  
> I totally agree with this.

@Vineeth: I think the best way to move forward is to respin this patch
with a commit message, that doesn't argue about driver_override.

Regards,
Halil

[..]
