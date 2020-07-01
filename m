Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgGAJXm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 05:23:42 -0400
Date: Wed, 1 Jul 2020 11:23:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200701112313.62a22156.cohuck@redhat.com>
In-Reply-To: <20200629135631.10db3c32.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
        <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
        <20200423182001.40345df8.cohuck@redhat.com>
        <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
        <20200430124316.023a82b0.cohuck@redhat.com>
        <20200629135631.10db3c32.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>

On Mon, 29 Jun 2020 13:56:31 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Ok, so I've resumed the thinking process, and I think getting rid of
> the "no I/O subchannel without functional device" approach is a good
> idea, and allows us to make handling driver matches more similar to
> everyone else.

As an aside, there's another odd construct: the I/O subchannel driver
*always* binds to the subchannel device, even if there is a problem,
and schedules an unregistration of the subchannel device on error. This
was introduced because events from machine check handling are not
processed if there isn't a driver (at least I thought back then that it
was a good idea.) I think a more correct way to handle this would be to
do the following:

* If something doesn't work, clean up and return an error in the probe
  function. The subchannel device stays around, it's just not bound.
* Have the css bus do some basic processing for subchannels not bound
  to any driver (e.g., check dnv/w). This would also make it possible
  to unregister dead message subchannels if a machine check is received
  for them (don't know if that's an actual problem in pratice.)

> 
> What changes would be needed?
> * The whole logic to suppress uevents for subchannels and generate one
>   later will go. (Touches the various subchannel driver, including
>   vfio-ccw.)
> * ccw_device_todo() can just unregister the ccw device, and there's no
>   longer a need for ccw_device_call_sch_unregister(). (IIUC, this also
>   covers setting disconnected devices offline.)

I'm actually not sure if unregistration-by-driver is the right thing
for most cases (except for something like disconnected device removal),
that should be done by the bus. Maybe something for later (don't fear,
I don't plan to work on the common I/O layer again :)

> * As the I/O subchannel driver now needs to deal with cases where no
>   ccw device is available, the code for that needs to be checked.
>   (That's probably the most time-consuming task.)

Had a quick look, doesn't actually look too bad (most places already
check for !cdev.)

> 
> Userspace should be fine with I/O subchannels without ccw device,
> that's nothing new.
> 
> Does that sound reasonable?
