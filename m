Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436660AbfFLNrJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 09:47:09 -0400
Date: Wed, 12 Jun 2019 15:46:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 4/8] s390/airq: use DMA memory for adapter interrupts
Message-ID: <20190612154655.1fcc2cd4.cohuck@redhat.com>
In-Reply-To: <20190612153324.3dc6632c.pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
        <20190606115127.55519-5-pasic@linux.ibm.com>
        <20190611121721.61bf09b4.cohuck@redhat.com>
        <20190611162721.67ca8932.pasic@linux.ibm.com>
        <20190611181944.5bf2b953.cohuck@redhat.com>
        <20190612023231.7da4908c.pasic@linux.ibm.com>
        <20190612082127.3fd63091.cohuck@redhat.com>
        <20190612153324.3dc6632c.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Wed, 12 Jun 2019 15:33:24 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 12 Jun 2019 08:21:27 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 12 Jun 2019 02:32:31 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > On Tue, 11 Jun 2019 18:19:44 +0200
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >     
> > > > On Tue, 11 Jun 2019 16:27:21 +0200
> > > > Halil Pasic <pasic@linux.ibm.com> wrote:    
> >   
> > > > > IMHO the cleanest thing to do at this stage is to check if the
> > > > > airq_iv_cache is NULL and fail the allocation if it is (to preserve
> > > > > previous behavior).      
> > > > 
> > > > That's probably the least invasive fix for now. Did you check whether
> > > > any of the other dma pools this series introduces have a similar
> > > > problem due to init not failing?
> > > >      
> > > 
> > > Good question!
> > > 
> > > I did a quick check. virtio_ccw_init() should be OK, because we don't
> > > register the driver if allocation fails, so the thing is going to end
> > > up dysfunctional as expected.
> > > 
> > > If however cio_dma_pool_init() fails, then we end up with the same
> > > problem with airqs, just on the !AIRQ_IV_CACHELINE code path. It can be
> > > fixed analogously: make cio_dma_zalloc() fail all allocation if
> > > cio_dma_pool_init() failed before.    
> > 
> > Ok, makes sense.  
> 
> v5 is out with the fixes. I have no ack/r-b from you for patch 4. Would
> you like to give some, or should I proceed without?

Please give this some more time, I will look at this later.
