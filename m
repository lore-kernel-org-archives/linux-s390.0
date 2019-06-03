Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 3 Jun 2019 15:42:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 3/8] s390/cio: add basic protected virtualization
 support
Message-ID: <20190603154230.0a4bfaf3.cohuck@redhat.com>
In-Reply-To: <18348fed-07d1-a11f-215c-f09ac94e9fbf@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-4-mimu@linux.ibm.com>
        <20190603140649.7d5ebc3e.cohuck@redhat.com>
        <18348fed-07d1-a11f-215c-f09ac94e9fbf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Jun 2019 14:45:03 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 03.06.19 14:06, Cornelia Huck wrote:
> > On Wed, 29 May 2019 14:26:52 +0200
> > Michael Mueller <mimu@linux.ibm.com> wrote:

> >> @@ -1593,20 +1625,31 @@ struct ccw_device * __init ccw_device_create_console(struct ccw_driver *drv)
> >>   		return ERR_CAST(sch);
> >>   
> >>   	io_priv = kzalloc(sizeof(*io_priv), GFP_KERNEL | GFP_DMA);
> >> -	if (!io_priv) {
> >> -		put_device(&sch->dev);
> >> -		return ERR_PTR(-ENOMEM);
> >> -	}
> >> +	if (!io_priv)
> >> +		goto err_priv;
> >> +	io_priv->dma_area = dma_alloc_coherent(&sch->dev,
> >> +				sizeof(*io_priv->dma_area),
> >> +				&io_priv->dma_area_dma, GFP_KERNEL);
> >> +	if (!io_priv->dma_area)
> >> +		goto err_dma_area;
> >>   	set_io_private(sch, io_priv);
> >>   	cdev = io_subchannel_create_ccwdev(sch);
> >>   	if (IS_ERR(cdev)) {
> >>   		put_device(&sch->dev);
> >> +		dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
> >> +				  io_priv->dma_area, io_priv->dma_area_dma);
> >>   		kfree(io_priv);  
> > 
> > <pre-existing, not introduced by this patch>
> > Shouldn't that branch do set_io_private(sch, NULL)? Not sure if any
> > code would make use of it, but it's probably better to clean out
> > references to freed objects.  
> 
> Added behind kfree(). I hope nobody asks for a separate patch. ;)

I would probably have added it just before the kfree, but I'm not
asking for a separate patch ;)

> 
> > </pre-existing, not introduced by this patch>
> >   
> >>   		return cdev;
> >>   	}
> >>   	cdev->drv = drv;
> >>   	ccw_device_set_int_class(cdev);
> >>   	return cdev;
> >> +
> >> +err_dma_area:
> >> +	kfree(io_priv);
> >> +err_priv:
> >> +	put_device(&sch->dev);
> >> +	return ERR_PTR(-ENOMEM);
> >>   }
> >>   
> >>   void __init ccw_device_destroy_console(struct ccw_device *cdev)  
