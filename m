Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 12 Apr 2019 13:29:05 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 05/12] s390/cio: add protected virtualization
 support to cio
In-Reply-To: <alpine.LFD.2.21.1904111612160.1809@schleppi>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1904111612160.1809@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190412132905.523b821b@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 11 Apr 2019 16:15:02 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> On Fri, 5 Apr 2019, Halil Pasic wrote:
> > @@ -1593,20 +1609,29 @@ struct ccw_device * __init ccw_device_create_console(struct ccw_driver *drv)
> >  		return ERR_CAST(sch);
> >  
> >  	io_priv = kzalloc(sizeof(*io_priv), GFP_KERNEL | GFP_DMA);
> > -	if (!io_priv) {
> > -		put_device(&sch->dev);
> > -		return ERR_PTR(-ENOMEM);
> > -	}
> > +	if (!io_priv)
> > +		goto err_priv;
> > +	io_priv->dma_area = cio_dma_zalloc(sizeof(*io_priv->dma_area));
> 
> This is called very early - the dma pool is not yet initialized.
> 

Hm, I will have to have better look into this. I kind of assumed we
can't/don't create any ccw_device instances before we have a
channel_subsystem, as naive as I am.

Thank you very much for spotting this! Looking forward to more
review ;)

Regards,
Halil
