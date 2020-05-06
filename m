Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgEFNxJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 09:53:09 -0400
Date: Wed, 6 May 2020 15:52:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 7/8] vfio-ccw: Wire up the CRW irq and CRW region
Message-ID: <20200506155259.4ec538e2.cohuck@redhat.com>
In-Reply-To: <20200505122745.53208-8-farman@linux.ibm.com>
References: <20200505122745.53208-1-farman@linux.ibm.com>
        <20200505122745.53208-8-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Tue,  5 May 2020 14:27:44 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> Use the IRQ to notify userspace that there is a CRW
> pending in the region, related to path-availability
> changes on the passthrough subchannel.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v3->v4:
>      - s/vfio_ccw_alloc_crw()/vfio_ccw_queue_crw()/ [CH]
>      - Remove cssid from crw that is built [CH]
>     
>     v2->v3:
>      - Refactor vfio_ccw_alloc_crw() to accept rsc, erc, and rsid fields
>        of a CRW as input [CH]
>      - Copy the right amount of CRWs to the crw_region [EF]
>      - Use sizeof(target) for the memcpy, rather than sizeof(source) [EF]
>      - Ensure the CRW region is empty if no CRW is present [EF/CH]
>      - Refactor how data goes from private-to-region-to-user [CH]
>      - Reduce the number of CRWs from two to one [CH]
>      - s/vc_crw/crw/ [EF]
>     
>     v1->v2:
>      - Remove extraneous 0x0 in crw.rsid assignment [CH]
>      - Refactor the building/queueing of a crw into its own routine [EF]
>     
>     v0->v1: [EF]
>      - Place the non-refactoring changes from the previous patch here
>      - Clean up checkpatch (whitespace) errors
>      - s/chp_crw/crw/
>      - Move acquire/release of io_mutex in vfio_ccw_crw_region_read()
>        into patch that introduces that region
>      - Remove duplicate include from vfio_ccw_drv.c
>      - Reorder include in vfio_ccw_private.h
> 
>  drivers/s390/cio/vfio_ccw_chp.c     | 17 ++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 49 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  8 +++++
>  3 files changed, 74 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
