Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 3 May 2019 15:33:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 00/10] s390: virtio: support protected virtualization
Message-ID: <20190503153310.04d4b85c.cohuck@redhat.com>
In-Reply-To: <20190503115511.17a1f6d1.cohuck@redhat.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190503115511.17a1f6d1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 3 May 2019 11:55:11 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 26 Apr 2019 20:32:35 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 

> > What needs to be done
> > =====================
> > 
> > Thus what needs to be done to bring virtio-ccw up to speed with respect
> > to protected virtualization is:
> > * use some 'new' common virtio stuff
> 
> Doing this makes sense regardless of the protected virtualization use
> case, and I think we should go ahead and merge those patches for 5.2.
> 
> > * make sure that virtio-ccw specific stuff uses shared memory when
> >   talking to the hypervisor (except control/communication blocks like ORB,
> >   these are handled by the ultravisor)
> 
> TBH, I'm still a bit hazy on what needs to use shared memory and what
> doesn't.
> 
> > * make sure the DMA API does what is necessary to talk through shared
> >   memory if we are a protected virtualization guest.
> > * make sure the common IO layer plays along as well (airqs, sense).

I've skimmed some more over the rest of the patches; but I think this
needs review by someone else.

For example, I'm not sure what the semantics of using the main css
device as the dma device are, as I'm not sufficiently familiar with the
intricacies of the dma infrastructure. Combine this with a lack of
documentation of the hardware architecture, and I think that others can
provide much better feedback on this than I am able to.
