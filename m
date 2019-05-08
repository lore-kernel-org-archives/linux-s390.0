Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 8 May 2019 06:54:57 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization
 support
Message-ID: <20190508135457.GA3530@infradead.org>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-7-pasic@linux.ibm.com>
 <alpine.LFD.2.21.1905081522300.1773@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1905081522300.1773@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 08, 2019 at 03:46:42PM +0200, Sebastian Ott wrote:
> > +	io_priv->dma_area = dma_alloc_coherent(&sch->dev,
> > +				sizeof(*io_priv->dma_area),
> > +				&io_priv->dma_area_dma, GFP_KERNEL);
> 
> This needs GFP_DMA.
> You use a genpool for ccw_private->dma and not for iopriv->dma - looks
> kinda inconsistent.

dma_alloc_* never needs GFP_DMA.  It selects the zone to allocate
from based on the dma_coherent_mask of the device.
