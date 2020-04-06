Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727614AbgDFMEA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 08:04:00 -0400
Date: Mon, 6 Apr 2020 14:03:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] s390/cio: correct some uevent issues
Message-ID: <20200406140349.3171d2fb.cohuck@redhat.com>
In-Reply-To: <your-ad-here.call-01586174287-ext-5095@work.hours>
References: <20200327124503.9794-1-cohuck@redhat.com>
        <20200406135441.743db659.cohuck@redhat.com>
        <your-ad-here.call-01586174287-ext-5095@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

On Mon, 6 Apr 2020 13:58:07 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Mon, Apr 06, 2020 at 01:54:41PM +0200, Cornelia Huck wrote:
> > On Fri, 27 Mar 2020 13:45:01 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > For subchannels, we currently delay the initial ADD uevent to a
> > > point in time controlled by the driver bound to it (this is to
> > > avoid a storm of useless uevents for I/O subchannels that do not
> > > have an operational device behind it and will get deregistered
> > > again, which are potentially a lot on LPARs.)
> > > 
> > > If we unbind from the io_subchannel driver and rebind again later,
> > > we'll get a duplicate ADD uevent -- not a common workflow, but might
> > > happen e.g. when you use a device in the host, then pass it to a
> > > guest via vfio-ccw, and then want to use it in the host again. Fixed
> > > by the first patch.
> > > 
> > > The vfio_ccw subchannel driver did not generate any ADD uevent at
> > > all -- currently not a problem, as every I/O subchannel will have been
> > > bound to the io_subchannel driver before, but let's fix this anyway
> > > (second patch).
> > > 
> > > [As an aside, setting driver_override via a udev rule does not work
> > > as expected, due to the uevent delaying -- a specified driver_override
> > > works as designed, but userspace won't get the ADD uevent until after
> > > the io_subchannel driver has been bound to the device already... we
> > > may want to rethink this whole uevent mechanism for subchannels later,
> > > but I don't think it's too pressing an issue.]
> > > 
> > > Probably easiest for both patches to go via the s390 arch maintainers.  
> > 
> > Friendly ping. Anyone taking these?  
> 
> I've just applied them, thank you!
> 

Wonderful, thanks!
