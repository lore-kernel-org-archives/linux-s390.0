From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Tue, 30 Sep 2014 13:53:54 -0400
Message-ID: <20140930175354.GC8824@laptop.dumpdata.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop>
	<20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
	<CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
	<20140930153821.GA4456@redhat.com>
	<CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
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

> x86 will be worse than PPC, too: the special case needed to support
> QEMU 2.2 with IOMMU and virtio enabled with a Xen guest will be fairly
> large and disgusting and will only exist to support something that IMO
> should never have existed in the first place.

<scratches his head> I don't follow.
> 
> PPC at least avoids *that* problem by virtue of not having Xen
> paravirt.  (And please don't add Xen paravirt to PPC -- x86 is trying
> to kill it off, but this is a 5-10 year project.)

Correction:
 - The Xen project is trying to kill some of the paravirts off.
 - KVM uses paravirts as well (and then added some)

> 
> [..., reordered]
> 
> >>
> >> Except that I think that PPC is the only platform on which QEMU's code
> >> actually bypasses any IOMMU.  Unless we've all missed something, there
> >> is no QEMU release that will put a virtio device behind an IOMMU on
> >> any platform other than PPC.
> >
> > I think that is true but it seems that this will be true for x86 for
> > QEMU 2.2 unless we make some changes there.
> > Which we might not have the time for since 2.2 is feature frozen
> > from tomorrow.
> > Maybe we should disable the IOMMU in 2.2, this is worth considering.
> >
> 
> Please do.
> 
> Also, try booting this 2.2 QEMU candidate with nested virtualization
> on.  Then bind vfio to a virtio-pci device and watch the guest get
> corrupted.  QEMU will blame Linux for incorrectly programming the

Hehe.
> hardware, and Linux will blame QEMU for its blatant violation of the
> ACPI spec.  Given that this is presumably most of the point of adding
> IOMMU support, it seems like a terrible idea to let code like that
> into the wild.
> 
> If this happens, Linux may also end up needing a quirk to prevent vfio
> from binding to QEMU 2.2's virtio-pci devices.
> 
> --Andy
