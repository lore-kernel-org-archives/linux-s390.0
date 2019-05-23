Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 23 May 2019 17:17:56 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
In-Reply-To: <alpine.LFD.2.21.1905081447280.1773@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905081447280.1773@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190523171756.4d30233a.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 May 2019 15:18:10 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> > @@ -224,6 +228,9 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
> >  	INIT_WORK(&sch->todo_work, css_sch_todo);
> >  	sch->dev.release = &css_subchannel_release;
> >  	device_initialize(&sch->dev);
> > +	sch->dma_mask = css_dev_dma_mask;
> > +	sch->dev.dma_mask = &sch->dma_mask;
> > +	sch->dev.coherent_dma_mask = sch->dma_mask;  
> 
> Could we do:
> 	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
> 	sch->dev.coherent_dma_mask = css_dev_dma_mask;
> ?

Looks like a good idea to me. We will do it for all 3 (sch, ccw and
css). Thanks!

Regards,
Halil
