Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNMc0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 07:32:26 -0500
Date: Fri, 14 Feb 2020 13:32:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 4/9] vfio-ccw: Introduce a new schib region
Message-ID: <20200214133218.6841b81e.cohuck@redhat.com>
In-Reply-To: <20200206213825.11444-5-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
        <20200206213825.11444-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Feb 2020 22:38:20 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> The schib region can be used by userspace to get the subchannel-
> information block (SCHIB) for the passthrough subchannel.
> This can be useful to get information such as channel path
> information via the SCHIB.PMCW fields.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v1->v2:
>      - Add new region info to Documentation/s390/vfio-ccw.rst [CH]
>      - Add a block comment to struct ccw_schib_region [CH]
>     
>     v0->v1: [EF]
>      - Clean up checkpatch (#include, whitespace) errors
>      - Remove unnecessary includes from vfio_ccw_chp.c
>      - Add ret=-ENOMEM in error path for new region
>      - Add call to vfio_ccw_unregister_dev_regions() during error exit
>        path of vfio_ccw_mdev_open()
>      - New info on the module prologue
>      - Reorder cleanup of regions
> 
>  Documentation/s390/vfio-ccw.rst     | 16 +++++-
>  drivers/s390/cio/Makefile           |  2 +-
>  drivers/s390/cio/vfio_ccw_chp.c     | 75 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 20 ++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 14 +++++-
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  include/uapi/linux/vfio.h           |  1 +
>  include/uapi/linux/vfio_ccw.h       | 10 ++++
>  8 files changed, 137 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_chp.c
> 
> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> index fca9c4f5bd9c..b805dc995fc8 100644
> --- a/Documentation/s390/vfio-ccw.rst
> +++ b/Documentation/s390/vfio-ccw.rst
> @@ -231,6 +231,19 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
>  
>  Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
>  
> +vfio-ccw schib region
> +---------------------
> +
> +The vfio-ccw schib region is used to return Subchannel-Information
> +Block (SCHIB) data to userspace::
> +
> +  struct ccw_schib_region {
> +  #define SCHIB_AREA_SIZE 52
> +         __u8 schib_area[SCHIB_AREA_SIZE];
> +  } __packed;
> +
> +This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_SCHIB.

Also mention that reading this triggers a stsch() updating the schib?

> +
>  vfio-ccw operation details
>  --------------------------
>  

(...)

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> new file mode 100644
> index 000000000000..826d08379fe3
> --- /dev/null
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Channel path related status regions for vfio_ccw
> + *
> + * Copyright IBM Corp. 2019

Should the year be updated?

> + *
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + */

(...)
