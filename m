Return-Path: <SRS0=9P2n=T3=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 27 May 2019 13:57:06 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] virtio/s390: add indirection to indicators
 access
In-Reply-To: <20190527130028.62e1f7d7.cohuck@redhat.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
        <20190523162209.9543-7-mimu@linux.ibm.com>
        <20190527130028.62e1f7d7.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190527135706.34837062.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 May 2019 13:00:28 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 23 May 2019 18:22:07 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > This will come in handy soon when we pull out the indicators from
> > virtio_ccw_device to a memory area that is shared with the hypervisor
> > (in particular for protected virtualization guests).
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 40 +++++++++++++++++++++++++---------------
> >  1 file changed, 25 insertions(+), 15 deletions(-)
> > 
> 
> > @@ -338,17 +348,17 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
> >  		ccw->cda = (__u32)(unsigned long) thinint_area;
> >  	} else {
> >  		/* payload is the address of the indicators */
> > -		indicatorp = kmalloc(sizeof(&vcdev->indicators),
> > +		indicatorp = kmalloc(sizeof(indicators(vcdev)),
> >  				     GFP_DMA | GFP_KERNEL);
> >  		if (!indicatorp)
> >  			return;
> >  		*indicatorp = 0;
> >  		ccw->cmd_code = CCW_CMD_SET_IND;
> > -		ccw->count = sizeof(&vcdev->indicators);
> > +		ccw->count = sizeof(indicators(vcdev));
> >  		ccw->cda = (__u32)(unsigned long) indicatorp;
> >  	}
> >  	/* Deregister indicators from host. */
> > -	vcdev->indicators = 0;
> > +	*indicators(vcdev) = 0;
> 
> I'm not too hot about this notation, but it's not wrong and a minor
> thing :)

I don't have any better ideas :/

> 
> >  	ccw->flags = 0;
> >  	ret = ccw_io_helper(vcdev, ccw,
> >  			    vcdev->is_thinint ?
> 
> Patch looks reasonable and not dependent on the other patches here.
> 

looks reasonable == r-b?

Not dependent in a sense that this patch could be made a first patch in
the series. A subsequent patch depends on it.

Regards,
Halil
