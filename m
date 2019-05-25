Return-Path: <SRS0=nyaw=TZ=vger.kernel.org=kvm-owner@kernel.org>
Date: Sat, 25 May 2019 11:44:37 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH v2 3/8] s390/cio: add basic protected virtualization
 support
In-Reply-To: <20190523162209.9543-4-mimu@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com> <20190523162209.9543-4-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1905251124230.3359@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On Thu, 23 May 2019, Michael Mueller wrote:
>  static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
>  {
>  	struct ccw_device *cdev;
> +	struct gen_pool *dma_pool;
>  
>  	cdev  = kzalloc(sizeof(*cdev), GFP_KERNEL);
> -	if (cdev) {
> -		cdev->private = kzalloc(sizeof(struct ccw_device_private),
> -					GFP_KERNEL | GFP_DMA);
> -		if (cdev->private)
> -			return cdev;
> -	}
> +	if (!cdev)
> +		goto err_cdev;
> +	cdev->private = kzalloc(sizeof(struct ccw_device_private),
> +				GFP_KERNEL | GFP_DMA);
> +	if (!cdev->private)
> +		goto err_priv;
> +	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
> +	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
> +	dma_pool = cio_gp_dma_create(&cdev->dev, 1);

This can return NULL. gen_pool_alloc will panic in this case.
[...]

> +err_dma_area:
> +		kfree(io_priv);

Indentation.

> +err_priv:
> +	put_device(&sch->dev);
> +	return ERR_PTR(-ENOMEM);
>  }
[...]
>  void ccw_device_update_sense_data(struct ccw_device *cdev)
>  {
>  	memset(&cdev->id, 0, sizeof(cdev->id));
> -	cdev->id.cu_type   = cdev->private->senseid.cu_type;
> -	cdev->id.cu_model  = cdev->private->senseid.cu_model;
> -	cdev->id.dev_type  = cdev->private->senseid.dev_type;
> -	cdev->id.dev_model = cdev->private->senseid.dev_model;
> +	cdev->id.cu_type   =
> +		cdev->private->dma_area->senseid.cu_type;
> +	cdev->id.cu_model  =
> +		cdev->private->dma_area->senseid.cu_model;
> +	cdev->id.dev_type  =
> +		cdev->private->dma_area->senseid.dev_type;
> +	cdev->id.dev_model =
> +		cdev->private->dma_area->senseid.dev_model;

These fit into one line.

> +/**
> + * Allocate zeroed dma coherent 31 bit addressable memory using
> + * the subchannels dma pool. Maximal size of allocation supported
> + * is PAGE_SIZE.
> + */
drivers/s390/cio/device_ops.c:708: warning: Function parameter or member 'cdev' not described in 'ccw_device_dma_zalloc'
drivers/s390/cio/device_ops.c:708: warning: Function parameter or member 'size' not described in 'ccw_device_dma_zalloc'


Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
