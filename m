Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728878AbgDWPLM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 11:11:12 -0400
Date: Thu, 23 Apr 2020 17:11:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200423171103.497dcd02.cohuck@redhat.com>
In-Reply-To: <20200423155620.493cb7cb.pasic@linux.ibm.com>
References: <20200417182939.11460-1-jrossi@linux.ibm.com>
        <20200417182939.11460-2-jrossi@linux.ibm.com>
        <20200423155620.493cb7cb.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 15:56:20 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 17 Apr 2020 14:29:39 -0400
> Jared Rossi <jrossi@linux.ibm.com> wrote:
> 
> > Remove the explicit prefetch check when using vfio-ccw devices.
> > This check is not needed as all Linux channel programs are intended
> > to use prefetch and will be executed in the same way regardless.  
> 
> Hm. This is a guest thing or? So you basically say, it is OK to do
> this, because you know that the guest is gonna be Linux and that it
> the channel program is intended to use prefetch -- but the ORB supplied
> by the guest that designates the channel program happens to state the
> opposite.
> 
> Or am I missing something?

I see this as a kind of architecture compliance/ease of administration
tradeoff, as we none of the guests we currently support uses something
that breaks with prefetching outside of IPL (which has a different
workaround).

One thing that still concerns me a bit is debuggability if a future
guest indeed does want to dynamically rewrite a channel program: the
guest thinks it instructed the device to not prefetch, and then
suddenly things do not work as expected. We can log when a guest
submits an orb without prefetch set, but we can't find out if the guest
actually does something that relies on non-prefetch.

The only correct way to handle this would be to actually implement
non-prefetch processing, where I would not really know where to even
start -- and then we'd only have synthetic test cases, for now. None of
the options are pleasant :(
