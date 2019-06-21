Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfFUMZn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 08:25:43 -0400
Date: Fri, 21 Jun 2019 14:25:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 0/5] s390: more vfio-ccw code rework
Message-ID: <20190621142540.4ed5f943.cohuck@redhat.com>
In-Reply-To: <20190618202352.39702-1-farman@linux.ibm.com>
References: <20190618202352.39702-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue, 18 Jun 2019 22:23:47 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> A couple little improvements to the malloc load in vfio-ccw.
> Really, there were just (the first) two patches, but then I
> got excited and added a few stylistic ones to the end.
> 
> The routine ccwchain_calc_length() has this basic structure:
> 
>   ccwchain_calc_length
>     a0 = kcalloc(CCWCHAIN_LEN_MAX, sizeof(struct ccw1))
>     copy_ccw_from_iova(a0, src)
>       copy_from_iova
>         pfn_array_alloc
>           b = kcalloc(len, sizeof(*pa_iova_pfn + *pa_pfn)
>         pfn_array_pin
>           vfio_pin_pages
>         memcpy(a0, src)
>         pfn_array_unpin_free
>           vfio_unpin_pages
>           kfree(b)
>     kfree(a0)
> 
> We do this EVERY time we process a new channel program chain,
> meaning at least once per SSCH and more if TICs are involved,
> to figure out how many CCWs are chained together.  Once that
> is determined, a new piece of memory is allocated (call it a1)
> and then passed to copy_ccw_from_iova() again, but for the
> value calculated by ccwchain_calc_length().
> 
> This seems inefficient.
> 
> Patch 1 moves the malloc of a0 from the CCW processor to the
> initialization of the device.  Since only one SSCH can be
> handled concurrently, we can use this space safely to
> determine how long the chain being processed actually is.
> 
> Patch 2 then removes the second copy_ccw_from_iova() call
> entirely, and replaces it with a memcpy from a0 to a1.  This
> is done before we process a TIC and thus a second chain, so
> there is no overlap in the storage in channel_program.
> 
> Patches 3-5 clean up some things that aren't as clear as I'd
> like, but didn't want to pollute the first two changes.
> For example, patch 3 moves the population of guest_cp to the
> same routine that copies from it, rather than in a called
> function.  Meanwhile, patch 4 (and thus, 5) was something I
> had lying around for quite some time, because it looked to
> be structured weird.  Maybe that's one bridge too far.
> 
> Eric Farman (5):
>   vfio-ccw: Move guest_cp storage into common struct
>   vfio-ccw: Skip second copy of guest cp to host
>   vfio-ccw: Copy CCW data outside length calculation
>   vfio-ccw: Factor out the ccw0-to-ccw1 transition
>   vfio-ccw: Remove copy_ccw_from_iova()
> 
>  drivers/s390/cio/vfio_ccw_cp.c  | 108 +++++++++++---------------------
>  drivers/s390/cio/vfio_ccw_cp.h  |   7 +++
>  drivers/s390/cio/vfio_ccw_drv.c |   7 +++
>  3 files changed, 52 insertions(+), 70 deletions(-)
> 

Thanks, applied.
