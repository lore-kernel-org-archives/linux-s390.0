From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 16:08:06 +0300
Message-ID: <20150728160700-mutt-send-email-mst@redhat.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, xen-devel <Xen-devel@lists.xen.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 27, 2015 at 06:08:59PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 1, 2014 at 10:39 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> > This fixes virtio on Xen guests as well as on any other platform
> > that uses virtio_pci on which physical addresses don't match bus
> > addresses.
> >
> > This can be tested with:
> >
> >     virtme-run --xen xen --kimg arch/x86/boot/bzImage --console
> >
> > using virtme from here:
> >
> >     https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git
> >
> > Without these patches, the guest hangs forever.  With these patches,
> > everything works.
> >
> 
> Dusting off an ancient thread.
> 
> Now that the dust has accumulated^Wsettled, is it worth pursuing this?
>  I think the situation is considerably worse than it was when I
> originally wrote these patches: I think that QEMU now supports a nasty
> mode in which the guest's PCI bus appears to be behind an IOMMU but
> the virtio devices on that bus punch straight through that IOMMU.
> 
> I have a half-hearted port to modern kernels here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=virtio_ring_xen
> 
> I didn't implement DMA API access for virtio_pci_modern, and I have no
> idea what to do about detecting whether a given virtio device honors
> its IOMMU or not.
> 
> --Andy

It's worth thinking about. I'll need to measure what's the overhead of
supporting both modes - probably after I'm back from the KVM forum.

-- 
MST
