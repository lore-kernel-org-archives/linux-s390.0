Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44079 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgGCJpg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 05:45:36 -0400
Date: Fri, 3 Jul 2020 11:45:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: Fix a build error due to missing include of
 linux/slab.h
Message-ID: <20200703114527.790ffb82.cohuck@redhat.com>
In-Reply-To: <20200703022628.6036-1-sean.j.christopherson@intel.com>
References: <20200703022628.6036-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Eric Farman <farman@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu,  2 Jul 2020 19:26:28 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> Include linux/slab.h to fix a build error due to kfree() being undefined.
> 
> Fixes: 3f02cb2fd9d2d ("vfio-ccw: Wire up the CRW irq and CRW region")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> Encountered this when cross-compiling with a pretty minimal config, didn't
> bother digging into why the error only showed up in my environment.
> 
>  drivers/s390/cio/vfio_ccw_chp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index a646fc81c872..13b26a1c7988 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -8,6 +8,7 @@
>   *            Eric Farman <farman@linux.ibm.com>
>   */
>  
> +#include <linux/slab.h>
>  #include <linux/vfio.h>
>  #include "vfio_ccw_private.h"
>  

Thanks, applied.
