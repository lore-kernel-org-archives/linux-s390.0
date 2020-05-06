Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54930 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728428AbgEFNYq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 09:24:46 -0400
Date: Wed, 6 May 2020 15:24:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 6/8] vfio-ccw: Introduce a new CRW region
Message-ID: <20200506152438.27bb3d39.cohuck@redhat.com>
In-Reply-To: <20200505122745.53208-7-farman@linux.ibm.com>
References: <20200505122745.53208-1-farman@linux.ibm.com>
        <20200505122745.53208-7-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Tue,  5 May 2020 14:27:43 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> This region provides a mechanism to pass a Channel Report Word
> that affect vfio-ccw devices, and needs to be passed to the guest
> for its awareness and/or processing.
> 
> The base driver (see crw_collect_info()) provides space for two
> CRWs, as a subchannel event may have two CRWs chained together
> (one for the ssid, one for the subchannel).  As vfio-ccw will
> deal with everything at the subchannel level, provide space
> for a single CRW to be transferred in one shot.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v3->v4:
>      - Move crw_trigger and CRW_IRQ from later patch to here [EF]
>      - Cleanup descriptions of sizeof CRW region in doc, commentary,
>        and commit description [CH]
>      - Clear crw when finished [CH]
>     
>     v2->v3:
>      - Remove "if list-empty" check, since there's no list yet [EF]
>      - Reduce the CRW region to one fullword, instead of two [CH]
>     
>     v1->v2:
>      - Add new region info to Documentation/s390/vfio-ccw.rst [CH]
>      - Add a block comment to struct ccw_crw_region [CH]
>     
>     v0->v1: [EF]
>      - Clean up checkpatch (whitespace) errors
>      - Add ret=-ENOMEM in error path for new region
>      - Add io_mutex for region read (originally in last patch)
>      - Change crw1/crw2 to crw0/crw1
>      - Reorder cleanup of regions
> 
>  Documentation/s390/vfio-ccw.rst     | 19 ++++++++++
>  drivers/s390/cio/vfio_ccw_chp.c     | 55 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 20 +++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     |  8 +++++
>  drivers/s390/cio/vfio_ccw_private.h |  4 +++
>  include/uapi/linux/vfio.h           |  2 ++
>  include/uapi/linux/vfio_ccw.h       |  8 +++++
>  7 files changed, 116 insertions(+)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
