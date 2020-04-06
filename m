Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728476AbgDFNlG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 09:41:06 -0400
Date: Mon, 6 Apr 2020 15:40:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 5/9] vfio-ccw: Introduce a new CRW region
Message-ID: <20200406154057.6016c4a7.cohuck@redhat.com>
In-Reply-To: <20200206213825.11444-6-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
        <20200206213825.11444-6-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Feb 2020 22:38:21 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> This region provides a mechanism to pass Channel Report Word(s)
> that affect vfio-ccw devices, and need to be passed to the guest
> for its awareness and/or processing.
> 
> The base driver (see crw_collect_info()) provides space for two
> CRWs, as a subchannel event may have two CRWs chained together
> (one for the ssid, one for the subcahnnel).  All other CRWs will
> only occupy the first one.  Even though this support will also
> only utilize the first one, we'll provide space for two also.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v1-v2:
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
>  Documentation/s390/vfio-ccw.rst     | 15 ++++++++
>  drivers/s390/cio/vfio_ccw_chp.c     | 56 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 20 +++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     |  4 +++
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  include/uapi/linux/vfio.h           |  1 +
>  include/uapi/linux/vfio_ccw.h       |  9 +++++
>  7 files changed, 108 insertions(+)
> 

(...)

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index 826d08379fe3..8fde94552149 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -73,3 +73,59 @@ int vfio_ccw_register_schib_dev_regions(struct vfio_ccw_private *private)
>  					    VFIO_REGION_INFO_FLAG_READ,
>  					    private->schib_region);
>  }
> +
> +static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
> +					char __user *buf, size_t count,
> +					loff_t *ppos)
> +{
> +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> +	struct ccw_crw_region *region;
> +	int ret;
> +
> +	if (pos + count > sizeof(*region))
> +		return -EINVAL;
> +
> +	if (list_empty(&private->crw))
> +		return 0;
> +
> +	mutex_lock(&private->io_mutex);
> +	region = private->region[i].data;
> +
> +	if (copy_to_user(buf, (void *)region + pos, count))
> +		ret = -EFAULT;
> +	else
> +		ret = count;
> +
> +	mutex_unlock(&private->io_mutex);
> +	return ret;
> +}

Would it make sense to clear out the crw after it has been read by
userspace?

In patch 7, you add a notification for a new crw via eventfd, but
nothing is preventing userspace from reading this even if not
triggered. I also don't see the region being updated there until a new
crw is posted.

Or am I missing something?
