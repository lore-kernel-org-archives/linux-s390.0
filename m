Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfGIKOu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 9 Jul 2019 06:14:50 -0400
Date: Tue, 9 Jul 2019 12:14:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC v2 5/5] vfio-ccw: Update documentation for csch/hsch
Message-ID: <20190709121445.1d7bf8ed.cohuck@redhat.com>
In-Reply-To: <df21c81e3d40144c103f1dfdf856853552990c05.1562616169.git.alifm@linux.ibm.com>
References: <cover.1562616169.git.alifm@linux.ibm.com>
        <df21c81e3d40144c103f1dfdf856853552990c05.1562616169.git.alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon,  8 Jul 2019 16:10:38 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> We now support CLEAR SUBCHANNEL and HALT SUBCHANNEL
> via ccw_cmd_region.
> 

Thanks, I forgot about this.

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")

> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> index 1f6d0b5..40e4110 100644
> --- a/Documentation/s390/vfio-ccw.rst
> +++ b/Documentation/s390/vfio-ccw.rst
> @@ -180,6 +180,13 @@ The process of how these work together.
>     add it to an iommu_group and a vfio_group. Then we could pass through
>     the mdev to a guest.
>  
> +
> +VFIO-CCW Regions
> +----------------
> +
> +The vfio-ccw driver exposes MMIO regions to accept requests from and return
> +results to userspace.
> +
>  vfio-ccw I/O region
>  -------------------
>  
> @@ -205,6 +212,25 @@ irb_area stores the I/O result.
>  
>  ret_code stores a return code for each access of the region.
>  
> +This region is always available.
> +
> +vfio-ccw cmd region
> +-------------------
> +
> +The vfio-ccw cmd region is used to accept asynchronous instructions
> +from userspace.
> +
> +#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
> +#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
> +struct ccw_cmd_region {
> +       __u32 command;
> +       __u32 ret_code;
> +} __packed;
> +
> +This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
> +
> +CLEAR SUBCHANNEL and HALT SUBCHANNEL currently uses this region.

"Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region". ?

> +
>  vfio-ccw operation details
>  --------------------------
>  
> @@ -306,9 +332,8 @@ Together with the corresponding work in QEMU, we can bring the passed
>  through DASD/ECKD device online in a guest now and use it as a block
>  device.
>  
> -While the current code allows the guest to start channel programs via
> -START SUBCHANNEL, support for HALT SUBCHANNEL or CLEAR SUBCHANNEL is
> -not yet implemented.
> +The current code allows the guest to start channel programs via
> +START SUBCHANNEL, and supports HALT SUBCHANNEL or CLEAR SUBCHANNEL.

"The current code allows the guest to start channel programs via START
SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL." ?

>  
>  vfio-ccw supports classic (command mode) channel I/O only. Transport
>  mode (HPF) is not supported.
