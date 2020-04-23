Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729504AbgDWQ2L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Apr 2020 12:28:11 -0400
Date: Thu, 23 Apr 2020 18:27:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200423182751.55dafe55.cohuck@redhat.com>
In-Reply-To: <20200423175559.309cc924.pasic@linux.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <20200423175559.309cc924.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

On Thu, 23 Apr 2020 17:55:59 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 17 Apr 2020 14:38:11 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Friendly ping.
> >   
> 
> Sorry for the late answer. I prefer to let Vineeth give us his opinion
> first. I did invest some 30 minutes in understanding the problem, but
> I'm not sure I understood it properly. According to my current
> understanding, the current state of affairs is a mess, and the proposed
> change wouldn't make the situation substantially cleaner, but it would
> help with the problem at hand.
> 
> Conny, do you have more background information on uevent suppression
> (is there some sort of a generic contract between kernel and userspace
> for uevent suppression)?

I'm not aware of a 'generic contract'; it's probably a lot of 'we
thought it would be a good idea to do it like that'.

> 
> From a quick grep it seems to me that most of the uses are about being
> nice to userspace in a sense, that we want to make sure that when
> event is received by userspace it can do it's thing, and does not have
> to wait until the kernel has finished with the stuff that needs to be
> done to reach a state of affairs that can be considered normal.

The general idea is that once userspace is notified of the existence of
a device, it can go ahead and try to make use of it. This is not always
true; sometimes, there's a logic problem in how devices are
initialized, sometimes, we want indeed to avoid userspace do work that
will turn out to be useless. The latter was the intention with uevent
suppression for I/O subchannels: do not notify userspace of the
existence of an I/O subchannel, unless there's a valid ccw device
behind it. Of course, that leads to trouble for vfio-ccw.

Another idea: Have the add uevent for subchannels in all cases, but
adapt any udev rules that do anything other than set driver_override to
do nothing unless a (to be added) change uevent comes along.

(And yes, I agree that this is a mess.)

> 
> Regards,
> Halil
> 
> 
> 
> > On Fri, 3 Apr 2020 12:40:32 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > Hi,
> > > 
> > > this is kind-of-a-followup to the uevent patches I sent in
> > > <20200327124503.9794-1-cohuck@redhat.com> last Friday.
> > > 
> > > Currently, the common I/O layer will suppress uevents for subchannels
> > > that are being registered, delegating generating a delayed ADD uevent
> > > to the driver that actually binds to it and only generating the uevent
> > > itself if no driver gets bound. The initial version of that delaying
> > > was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
> > > subchannels"); from what I remember, we were seeing quite bad storms of
> > > uevents on LPARs that had a lot of I/O subchannels with no device
> > > accessible through them.  
> [..]
> > > Thoughts?
> > >   
> >   
> 
