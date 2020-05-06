Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728717AbgEFNSo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 09:18:44 -0400
Date: Wed, 6 May 2020 15:18:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 2/8] vfio-ccw: Register a chp_event callback for
 vfio-ccw
Message-ID: <20200506151818.34d5cae5.cohuck@redhat.com>
In-Reply-To: <20200505122745.53208-3-farman@linux.ibm.com>
References: <20200505122745.53208-1-farman@linux.ibm.com>
        <20200505122745.53208-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Tue,  5 May 2020 14:27:39 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> Register the chp_event callback to receive channel path related
> events for the subchannels managed by vfio-ccw.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v3->v4:
>      - Check schib.lpum before calling cio_cancel_halt_clear [CH]
>     
>     v2->v3:
>      - Add a call to cio_cancel_halt_clear() for CHP_VARY_OFF [CH]
>     
>     v1->v2:
>      - Move s390dbf before cio_update_schib() call [CH]
>     
>     v0->v1: [EF]
>      - Add s390dbf trace
> 
>  drivers/s390/cio/vfio_ccw_drv.c | 47 +++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
