Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726444AbgLSGeF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 19 Dec 2020 01:34:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ6WMcj163280
        for <linux-s390@vger.kernel.org>; Sat, 19 Dec 2020 01:33:24 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35hc2688w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 19 Dec 2020 01:33:23 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BJ6WsTN163977
        for <linux-s390@vger.kernel.org>; Sat, 19 Dec 2020 01:33:23 -0500
Date: Sat, 19 Dec 2020 07:33:16 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201219073316.1be609d5.pasic@linux.ibm.com>
In-Reply-To: <20201215191307.281c6e6f.cohuck@redhat.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
        <20201215191307.281c6e6f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.vnet.ibm.com>, oberpar@linux.ibm.com, linux-s390@vger.kernel.org, farman@linux.ibm.com, fiuczy@linux.ibm.com

On Tue, 15 Dec 2020 19:13:07 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 9 Dec 2020 13:52:03 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 8 Dec 2020 18:30:54 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > > 
> > > > But, the more i look at this patch and discuss on this, i think this is 
> > > > not complete.
> > > > i.e as you know, the main reason for this RFC was the the below thread.
> > > > https://marc.info/?l=linux-s390&m=158591045732735&w=2
> > > > We are still not solving the problem that was mentioned in that RFD.
> > > > 
> > > > There are couple of things which we needs to consider here. With this 
> > > > patch, the uevents
> > > > are generated before doing the initialization or before finding the 
> > > > ccw-device
> > > > connected. Which means, the udev-rules have to manage with a 
> > > > non-initialized setup
> > > > compared to the previous version (Version without this patch). As you 
> > > > mentioned, the
> > > > current user-space programs which works with this uevent, especially in 
> > > > case of vfio-ccw
> > > > will have a problem.    
> > > 
> > > IIUC, we'll get the "normal" ADD uevent when the subchannel device is
> > > registered (i.e. made visible). For the vfio-ccw case, we want the
> > > driverctl rule to match in this case, so that the driver override can
> > > be set before the subchannel device ends up being bound to the I/O
> > > subchannel driver. So I think that removing the suppression is giving
> > > us exactly what we want? Modulo any errors in the initialization
> > > sequence we might currently have in the css bus code, of course.
> > >  
> > 
> > I believe, I'm the originator of these concerns, yet I find my
> > concern hard to recognize in the comment of Vineeth, so let me
> > please try to explain this in a different way.
> > 
> > AFAIK the uevent handling is asynchronous with regards to matching and
> > probing, in a sense that there is no synchronization mechanism that
> > ensures, the userspace has had the ADD event handled (e.g.
> > driver_override set_ before the kernel proceeds with matching and
> > probing of the device. Am I wrong about this?
> > 
> > If I'm, with the suppression gone we end up with race, where userspace
> > may or may not set driver_override in time.
> > 
> > The man page of driverctl
> > (https://manpages.debian.org/testing/driverctl/driverctl.8.en.html)
> > claims that: "driverctl integrates with udev to support overriding driver
> > selection for both cold- and hotplugged devices from the moment of discovery, ..."
> > and "The driver overrides created by driverctl are persistent across
> > system reboots by default."
> > 
> > Writing to the driver_override sysfs attribute does not auto-rebind. So
> > if we can't ensure being in time to set driver_override for the
> > subchannel before the io_subchannel driver binds, then the userspace
> > should handle this situation (by unbind and bind) to ensure the
> > effectiveness of 'driver override'. I couldn't find that code in
> > driverctl, and I assume if we had that, driver override would work
> > without this patch. Conny, does that sound about right?
> > 
> > My argument is purely speculative. I didn't try this out, but trying
> > stuff out is of limited value with races anyway. Vineeth did you try?
> > If not, I could check this out myself some time later.
> 
> Whenever we delegate policy decisions like that to userspace, we'll end
> up with uncertainty depending on timing. I don't think that there's any
> way around it. (FWIW, driver_override for pci behaves just the same,
> unless I misread the code.)
> 
> What removing the uevent suppression does give us is at least a chance
> to influence the driver that is being bound and not wait until we have
> a fully setup ccw device as a child as well.

I finally came around to test this. In my experience driverctl works for
subchannels and vfio_ccw without this patch, and continues to work with
it. I found the code in driverctl that does the unbind and the implicit
bind (via drivers_probe after after driver_override was set).

So now I have to ask, how exactly was the original problem diagnosed?

In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
paragraph like:

"""
So while there's definitely a good reason for wanting to delay uevents,
it is also introducing problems. One is udev rules for subchannels that
are supposed to do something before a driver binds (e.g. setting
driver_override to bind an I/O subchannel to vfio_ccw instead of
io_subchannel) are not effective, as the ADD uevent will only be
generated when the io_subchannel driver is already done with doing all
setup. Another one is that only the ADD uevent is generated after
uevent suppression is lifted; any other uevents that might have been
generated are lost.
"""

This is not how driverclt works! I.e. it deals with the situation that
the I/O subchannel was already bound to the io_subchannel driver at
the time the udev rule installed by driverctl activates (via the
mechanism I described above).

Regards,
Halil
