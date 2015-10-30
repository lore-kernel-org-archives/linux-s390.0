From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Fri, 30 Oct 2015 10:51:54 +0900
Message-ID: <1446169914.1856.72.camel@kernel.crashing.org>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
	 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
	 <1446013801.3405.183.camel@infradead.org>
	 <20151028111049.GA30785@shamir-ThinkPad-T430>
	 <1446039110.3405.212.camel@infradead.org>
	 <1446078721.1856.49.camel@kernel.crashing.org>
	 <1446079332.3405.273.camel@infradead.org>
	 <1446081046.1856.55.camel@kernel.crashing.org>
	 <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2015-10-29 at 11:31 -0700, Andy Lutomirski wrote:
> On Oct 28, 2015 6:11 PM, "Benjamin Herrenschmidt"
> <benh@kernel.crashing.org> wrote:
> > 
> > On Thu, 2015-10-29 at 09:42 +0900, David Woodhouse wrote:
> > > On Thu, 2015-10-29 at 09:32 +0900, Benjamin Herrenschmidt wrote:
> > > 
> > > > On Power, I generally have 2 IOMMU windows for a device, one at
> > > > the
> > > > bottom is remapped, and is generally used for 32-bit devices
> > > > and the
> > > > one at the top us setup as a bypass
> > > 
> > > So in the normal case of decent 64-bit devices (and not in a VM),
> > > they'll *already* be using the bypass region and have full access
> > > to
> > > all of memory, all of the time? And you have no protection
> > > against
> > > driver and firmware bugs causing stray DMA?
> > 
> > Correct, we chose to do that for performance reasons.
> 
> Could this be mitigated using pools?  I don't know if the net code
> would play along easily.

Possibly, the pools we have already limit the lock contention but we
still have the map/unmap overhead which under a hypervisor can be quite
high. I'm not necessarily against changing the way we do things but it
would have to be backed up with numbers.

Cheers,
Ben.
