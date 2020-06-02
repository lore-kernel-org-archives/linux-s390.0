Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbgFBNNb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 09:13:31 -0400
Date: Tue, 2 Jun 2020 15:13:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 08/10] vfio-ccw: Introduce a new CRW region
Message-ID: <20200602151313.0e639b57.cohuck@redhat.com>
In-Reply-To: <20200525094115.222299-9-cohuck@redhat.com>
References: <20200525094115.222299-1-cohuck@redhat.com>
        <20200525094115.222299-9-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>

On Mon, 25 May 2020 11:41:13 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

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
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Message-Id: <20200505122745.53208-7-farman@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  Documentation/s390/vfio-ccw.rst     | 19 ++++++++++
>  drivers/s390/cio/vfio_ccw_chp.c     | 55 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 20 +++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     |  8 +++++
>  drivers/s390/cio/vfio_ccw_private.h |  4 +++
>  include/uapi/linux/vfio.h           |  2 ++
>  include/uapi/linux/vfio_ccw.h       |  8 +++++
>  7 files changed, 116 insertions(+)
> 

(...)

> @@ -413,6 +423,16 @@ static int __init vfio_ccw_sch_init(void)
>  		goto out_err;
>  	}
>  
> +	vfio_ccw_crw_region = kmem_cache_create_usercopy("vfio_ccw_crw_region",
> +					sizeof(struct ccw_crw_region), 0,
> +					SLAB_ACCOUNT, 0,
> +					sizeof(struct ccw_crw_region), NULL);

Ugh, I just tested this rebased to the s390 features branch, and I must
have used some different options, because I now get

   kmem_cache_create(vfio_ccw_crw_region) integrity check failed

presumably due to the size of the ccw_crw_region.

We maybe need to pad it up (leave it unpacked)? Eric, what do you think?

> +
> +	if (!vfio_ccw_crw_region) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
>  	isc_register(VFIO_CCW_ISC);
>  	ret = css_driver_register(&vfio_ccw_sch_driver);
>  	if (ret) {

(...)

> diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.h
> index 758bf214898d..cff5076586df 100644
> --- a/include/uapi/linux/vfio_ccw.h
> +++ b/include/uapi/linux/vfio_ccw.h
> @@ -44,4 +44,12 @@ struct ccw_schib_region {
>  	__u8 schib_area[SCHIB_AREA_SIZE];
>  } __packed;
>  
> +/*
> + * Used for returning a Channel Report Word to userspace.
> + * Note: this is controlled by a capability
> + */
> +struct ccw_crw_region {
> +	__u32 crw;
> +} __packed;
> +
>  #endif
