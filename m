Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 11 Apr 2019 16:15:02 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [RFC PATCH 05/12] s390/cio: add protected virtualization support
 to cio
In-Reply-To: <20190404231622.52531-6-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com> <20190404231622.52531-6-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1904111612160.1809@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 5 Apr 2019, Halil Pasic wrote:
> @@ -1593,20 +1609,29 @@ struct ccw_device * __init ccw_device_create_console(struct ccw_driver *drv)
>  		return ERR_CAST(sch);
>  
>  	io_priv = kzalloc(sizeof(*io_priv), GFP_KERNEL | GFP_DMA);
> -	if (!io_priv) {
> -		put_device(&sch->dev);
> -		return ERR_PTR(-ENOMEM);
> -	}
> +	if (!io_priv)
> +		goto err_priv;
> +	io_priv->dma_area = cio_dma_zalloc(sizeof(*io_priv->dma_area));

This is called very early - the dma pool is not yet initialized.
