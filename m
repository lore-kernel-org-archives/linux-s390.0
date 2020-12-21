Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48322 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgLURYY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Dec 2020 12:24:24 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BLH3DcU023802
        for <linux-s390@vger.kernel.org>; Mon, 21 Dec 2020 12:23:43 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35jxasb0f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Dec 2020 12:23:41 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BLH3HP8023953
        for <linux-s390@vger.kernel.org>; Mon, 21 Dec 2020 12:23:40 -0500
Date: Mon, 21 Dec 2020 18:23:31 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201221182331.11152c3e.pasic@linux.ibm.com>
In-Reply-To: <20201221165219.7f2aa7c6.cohuck@redhat.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
        <20201215191307.281c6e6f.cohuck@redhat.com>
        <89146a87-371a-f148-057b-d3b7ce0cc21e@linux.ibm.com>
        <20201216130710.5aa6a933.cohuck@redhat.com>
        <20201219082006.2529bcec.pasic@linux.ibm.com>
        <20201221165219.7f2aa7c6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Boris Fiuczynski <fiuczy@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.vnet.ibm.com>, oberpar@linux.ibm.com, linux-s390@vger.kernel.org, farman@linux.ibm.com

On Mon, 21 Dec 2020 16:52:19 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Sat, 19 Dec 2020 08:20:06 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Wed, 16 Dec 2020 13:07:10 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Wed, 16 Dec 2020 12:53:41 +0100
> > > Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:
> > >   
> > > > On 12/15/20 7:13 PM, Cornelia Huck wrote:  
> > > > >>       
> > > > >>> I'm not sure how many rules actually care about events for the
> > > > >>> subchannel device; the ccw device seems like the more helpful device to
> > > > >>> watch out for.    
> > > > >> I tend to agree, but the problem with vfio-ccw is that (currently) we
> > > > >> don't have a ccw device in the host, because we pass-through the
> > > > >> subchannel. When we interrogate the subchannel, we do learn if there
> > > > >> is a device and if, what is its devno. If I were to run a system with
> > > > >> vfio-ccw passthrough, I would want to passthrough the subchannel that
> > > > >> talks to the DASD (identified by devno) I need passed through to my
> > > > >> guest.    
> > > > > I think that can be solved by simply adding the devno as a variable to
> > > > > the uevent (valid if it's an I/O subchannel; we don't register the
> > > > > subchannel in the first place if dnv is not set.)
> > > > >     
> > > > Providing the devno in the context of the udev event certainly helps if 
> > > > the event consumer would base its actions on it.
> > > > As far as I understand the driver_override mechanics driverctl sets the 
> > > > override based on a specified device. In that case the devno would not 
> > > > be looked at and the subchannel would end up with a vfio-ccw driver even 
> > > > so the ccw device might not be the one we want to use as pass-through 
> > > > device.  
> > > 
> > > Hm, maybe we need to make a change in driverctl that allows per-bus
> > > custom rules?
> > >   
> > 
> > The issue with that is, that this problem ain't bus specific. I.e. it
> > could make perfect sense to driver_override a certain ccw tape device to
> > an alternative tape driver.
> 
> But ccw does not provide driver_override? Confused.
> 

Right, but it could. That is not my point. I was arguing with 'per-bus
custom rules'.

> > 
> > The problem is, that the only way driverctl can identify a device is a
> > (name_of_the_bus), device_name_on_the bus) pair. Currently the udev rule
> > installed by driverctl simply ooks fora file 
> > /etc/driverctl.d/$env{SUBSYSTEM}-$kernel
> > which basically encodes the current selection criteria.
> > 
> > Can yo please elaborate on your idea? How would you extend the driverctl
> > cli and how would persistence look like for these custom rules? Would
> > you make driverctl write an udev rule for each such device/custom rule
> > on 'set-override' command instead of file in /etc/driverctl.d?
> 
> I have not really looked at how to implement this. But we could have
> driverctl support an optional "additional_parameters" option, which
> allows to specify key/value pairs that have to match. I guess that
> should be dropped into the driverctl config directory, and generate an
> additional check?
> 

The devil is always in the details. I'm sure something can be done :).
Key/value pairs for matching fits IMHO better with new udev rules than
with files in the driverctl config dir that somehow generate additiona
checks. One thing I didn't understand is, are you proposing an invocation
like 
driverctl -b css --additional_params="DEVNO=<devno>" \
set-override <subchannel_no> vfio_ccw
or 
driverctl -b css --additional_params="DEVNO=<devno>" \
set-override vfio_ccw
?

The first one would safeguard against passing through the wrong devno,
but I think, we actually want to be oblivious about the subchannel
number.

Regards,
Halil
