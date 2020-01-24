Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387599AbgAXP24 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jan 2020 10:28:56 -0500
Date: Fri, 24 Jan 2020 16:28:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 0/1] vfio-ccw: Fix interrupt handling for HALT/CLEAR
Message-ID: <20200124162804.1a32e22a.cohuck@redhat.com>
In-Reply-To: <20200124145455.51181-1-farman@linux.ibm.com>
References: <20200124145455.51181-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 24 Jan 2020 15:54:54 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> Conny,
> 
> As I mentioned offline, I have been encountering some problems while
> testing the channel path code.  By pure coincidence, I found some
> really good clues that led me to this proposed fix.  I moved this
> commit to the head of my channel path v2 code, but think maybe it
> should be sent by itself so it doesn't get lost in that noise.
> 
> Figure 16-6 in SA22-7832-12 (POPS) goes into great detail of the
> contents of the irb.cpa based on the other bits in the IRB.
> Both the existing code and this new patch treates the irb.cpa as
> valid all the time, even though that table has many many entries
> where the cpa contents are "unpredictable."  Methinks that this
> is partially how we got into this mess, so maybe I need to write
> some smarter logic here anyway?  Thoughts?

Yes, we probably should go over this table a bit. I think the generic
common I/O layer code has some checks where it does exactly that, but
these are probably only done on the ccw_device level (i.e. in the
normal I/O subchannel driver). Maybe we can refactor/reuse some of
those checks?

> 
> (Disclaimer1:  I didn't go back and re-read the conversations
> that were had for the commit I marked in the "Fixes:" tag,
> but will just to make sure we didn't miss something.)
> 
> (Disclaimer2:  This makes my torturing-of-the-chpids test run
> quite nicely, but I didn't go back to try some of the other
> cruel-and-unusual tests at my disposable to ensure this patch
> doesn't cause any other regressions.  That's on today's agenda.)
> 
> Eric Farman (1):
>   vfio-ccw: Don't free channel programs for unrelated interrupts
> 
>  drivers/s390/cio/vfio_ccw_cp.c  | 11 +++++++++--
>  drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
>  drivers/s390/cio/vfio_ccw_drv.c |  4 ++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
