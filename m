From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] virtio_pci: Use the DMA API
Date: Wed, 28 Oct 2015 11:50:47 +0900
Message-ID: <20151028025047.GF18467@suse.de>
References: <cover.1445994839.git.luto@kernel.org>
 <b954294d8716e96daf827b85594b0e6cbdd7c321.1445994839.git.luto@kernel.org>
 <20151028021530.GC18467@suse.de>
 <1445998972.3405.174.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445998972.3405.174.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 11:22:52AM +0900, David Woodhouse wrote:
> On Wed, 2015-10-28 at 11:15 +0900, Joerg Roedel wrote:
> > I think a good test for that is to boot a virtio kvm-guest with
> > swiotlb=force and see if it still works.
> 
> That's useful but doesn't cover the cases where dma_wmb() is needed,
> right? 
> 
> We should make sure we're handling descriptors properly as we would for
> real hardware, and ensuring that addresses etc. are written to the
> descriptor (and a write barrier occurs) *before* the bit is set which
> tells the 'hardware' that it owns that descriptor.

Hmm, good question. The virtio code has virtio_rmb/wmb and should
already call it in the right places.

The virtio-barriers default to rmb()/wmb() unless weak_barriers is set,
in which case it calls dma_rmb()/wmb(), just a compiler barrier on x86.

And weak_barriers is set by the virtio drivers when creating the queue,
and the drivers should know what they are doing. Saying this, I think
the virtio-drivers should already get this right.


	Joerg
