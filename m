From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Fri, 19 Sep 2014 22:59:12 -0700
Message-ID: <CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1411162406.30672.64.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411162406.30672.64.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Sep 19, 2014 2:33 PM, "Benjamin Herrenschmidt"
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2014-09-17 at 09:07 -0700, Andy Lutomirski wrote:
> > It shouldn't.  That being said, at some point this problem will need
> > solving on PPC, and this patch doesn't help much, other than adding
> > the virtio_ring piece.
> >
> > I'd really like to see the generic or arch IOMMU code handle this so
> > that the PPC special case in the virtio-pci driver can go away.
> >
> > Another reason that this kind of special casing doesn't belong in
> > virtio-pci: if anyone ever binds vfio to a virtio-pci device, if the
> > DMA API doesn't work right, then the kernel will go boom or be
> > compromised.
>
> Well, that's also for these reasons that I think your patch shouldn't go
> through those virtio_* variants that test that "use_dma_api" flag or
> whatever you called it last time I looked :-)
>
> You should just unconditionally call the DMA API and we should fixup the
> special cases by overriding the hooks.

Unconditionally for virtio-pci or unconditionally for all drivers?  I
wouldn't be surprised if some of the virtio-mmio archs have trouble,
too.  Aarch64, at least, seems to be okay with using the DMA API on
virtio_mmio devices, even with IOMMU support compiled in.

Are there other relevant architectures that are easy to test?

>
> I can help you do the override hack for PPC for now, until we can do
> something saner accross all architectures.

Sure.

The question is: should the patches go in to 3.18 as is our should
they wait?  It would be straightforward to remove the use_dma_api
switch PPC, s390, and virtio_mmio are ready.

--Andy

>
> The main problem is s390 but I had a quick chat with Utz Bacher earlier
> this week and he seemed to think having s390 use the DMA API shouldn't
> be a big deal, they can also hookup some transparent set of ops if
> necessary.
>
> Cheers,
> Ben.
>
>
