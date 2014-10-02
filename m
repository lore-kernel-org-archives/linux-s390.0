From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Thu, 2 Oct 2014 12:36:39 -0400
Message-ID: <20141002163639.GE1715@laptop.dumpdata.com>
References: <6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop>
	<20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
	<CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
	<20140930153821.GA4456@redhat.com>
	<CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
	<20140930175354.GC8824@laptop.dumpdata.com>
	<CALCETrV7xZ0df6n7tdWJx+Wpj=a8_yGaw1a+9EVDvxE4NU-a1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrV7xZ0df6n7tdWJx+Wpj=a8_yGaw1a+9EVDvxE4NU-a1A@mail.gmail.com>
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
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 30, 2014 at 11:01:29AM -0700, Andy Lutomirski wrote:
> On Tue, Sep 30, 2014 at 10:53 AM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> >> x86 will be worse than PPC, too: the special case needed to support
> >> QEMU 2.2 with IOMMU and virtio enabled with a Xen guest will be fairly
> >> large and disgusting and will only exist to support something that IMO
> >> should never have existed in the first place.
> >
> > <scratches his head> I don't follow.
> 
> If you boot a Xen PV dom0 on QEMU master with -machine q35,iommu=on
> and you add a virtio device, dom0 will end up with a PCI device that
> does DMA to "machine" addresses.  These addresses are not compatible
> with the DMA API (which works with bus addresses), nor are they the
> same as physical addresses.

That is presumarily because the IOMMU assumes the virtio devices are real
devices, not fake ones.
> 
> So virtio in current kernels won't work for the same reason they never
> work on Xen.  But virtio-pci with my patches won't work either,
> because they (or the Xen hypervisor) will try to program the IOMMU
> with a non-identity mapping, causing everything to explode.
> 
> Hacking up the virtio-pci driver to explicitly ask Xen for machine
> addresses might work, but, at the very least, it will be a giant
> security hole if anyone binds a virtio device to a domain other than
> dom0 (which, again, is kind of the point of having an IOMMU).
> 
> >>
> >> PPC at least avoids *that* problem by virtue of not having Xen
> >> paravirt.  (And please don't add Xen paravirt to PPC -- x86 is trying
> >> to kill it off, but this is a 5-10 year project.)
> >
> > Correction:
> >  - The Xen project is trying to kill some of the paravirts off.
> >  - KVM uses paravirts as well (and then added some)
> 
> By "paravirt" I meant PV, where there's the weird physical/machine
> address discrepancy that's visible to the guest.  This is not to say
> that Xen PVH wouldn't also be screwed running on QEMU master.
> 
> --Andy
