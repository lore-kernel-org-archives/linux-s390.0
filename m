Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgDQMiT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 08:38:19 -0400
Date: Fri, 17 Apr 2020 14:38:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200417143811.7e6ecb2c.cohuck@redhat.com>
In-Reply-To: <20200403124032.5e70603d.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

Friendly ping.

On Fri, 3 Apr 2020 12:40:32 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Hi,
> 
> this is kind-of-a-followup to the uevent patches I sent in
> <20200327124503.9794-1-cohuck@redhat.com> last Friday.
> 
> Currently, the common I/O layer will suppress uevents for subchannels
> that are being registered, delegating generating a delayed ADD uevent
> to the driver that actually binds to it and only generating the uevent
> itself if no driver gets bound. The initial version of that delaying
> was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
> subchannels"); from what I remember, we were seeing quite bad storms of
> uevents on LPARs that had a lot of I/O subchannels with no device
> accessible through them.
> 
> So while there's definitely a good reason for wanting to delay uevents,
> it is also introducing problems. One is udev rules for subchannels that
> are supposed to do something before a driver binds (e.g. setting
> driver_override to bind an I/O subchannel to vfio_ccw instead of
> io_subchannel) are not effective, as the ADD uevent will only be
> generated when the io_subchannel driver is already done with doing all
> setup. Another one is that only the ADD uevent is generated after
> uevent suppression is lifted; any other uevents that might have been
> generated are lost.
> 
> So, what to do about this, especially in the light of vfio-ccw handling?
> 
> One idea I had is to call css_sch_is_valid() from
> css_register_subchannel(); this would exclude the largest class of
> non-operational subchannels already (those that don't have a valid
> device; I'm not quite sure if there's also something needed for EADM
> subchannels?) If we got rid of the uevent delaying, we would still get
> ADD/REMOVE events for subchannels where the device turns out to be
> non-accessible, but I believe (hope) that those are not too many in a
> sane system at least. As a bonus, we could also add additional values
> from the pmcw to the uevent; the device number, for example, could be
> helpful for vfio-ccw matching rules.
> 
> A drawback is that we change the timing (not the sequence, AFAICS) of
> the uevents, which might break brittle setups.
> 
> Thoughts?
> 
