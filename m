From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 5/9] virtio_ring: Support DMA APIs
Date: Wed, 3 Feb 2016 09:53:39 -0800
Message-ID: <CALCETrWXPEMTTTD3raO6uOF+WG+msszRXQY5QMhBf+UwF5kArw@mail.gmail.com>
References: <cover.1454477782.git.luto@kernel.org> <a6c1a2d0b3ea60bfb27c810896179bd553e7e240.1454477782.git.luto@kernel.org>
 <20160203154633-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20160203154633-mutt-send-email-mst@redhat.com>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, linux-s390 <linux-s390@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Christoph Hellwig <hch@lst.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Feb 3, 2016 5:52 AM, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> On Tue, Feb 02, 2016 at 09:46:36PM -0800, Andy Lutomirski wrote:
> > virtio_ring currently sends the device (usually a hypervisor)
> > physical addresses of its I/O buffers.  This is okay when DMA
> > addresses and physical addresses are the same thing, but this isn't
> > always the case.  For example, this never works on Xen guests, and
> > it is likely to fail if a physical "virtio" device ever ends up
> > behind an IOMMU or swiotlb.
> >
> > The immediate use case for me is to enable virtio on Xen guests.
> > For that to work, we need vring to support DMA address translation
> > as well as a corresponding change to virtio_pci or to another
> > driver.
> >
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  drivers/virtio/Kconfig           |   2 +-
> >  drivers/virtio/virtio_ring.c     | 200 ++++++++++++++++++++++++++++++++-------
> >  tools/virtio/linux/dma-mapping.h |  17 ++++
> >  3 files changed, 183 insertions(+), 36 deletions(-)
> >  create mode 100644 tools/virtio/linux/dma-mapping.h
> >
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index cab9f3f63a38..77590320d44c 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -60,7 +60,7 @@ config VIRTIO_INPUT
> >
> >   config VIRTIO_MMIO
> >       tristate "Platform bus driver for memory mapped virtio devices"
> > -     depends on HAS_IOMEM
> > +     depends on HAS_IOMEM && HAS_DMA
> >       select VIRTIO
> >       ---help---
> >        This drivers provides support for memory mapped virtio
>
> What's this chunk doing here btw? Should be part of the mmio patch?
>

IIRC it was deliberate.  Making virtio depend on HAS_DMA didn't work
right because kconfig doesn't propagate dependencies through select
intelligently.  This patch makes core virtio depend on HAS_DMA, so I
added the dependency here, too.

--Andy
