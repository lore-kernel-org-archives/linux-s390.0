From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 20:12:25 +1000
Message-ID: <1438078345.7562.133.camel@kernel.crashing.org>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55B73A49.9050206@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, xen-devel <Xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2015-07-28 at 10:16 +0200, Paolo Bonzini wrote:
> 
> On 28/07/2015 03:08, Andy Lutomirski wrote:
> > On Mon, Sep 1, 2014 at 10:39 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> This fixes virtio on Xen guests as well as on any other platform
> >> that uses virtio_pci on which physical addresses don't match bus
> >> addresses.
> >>
> >> This can be tested with:
> >>
> >>     virtme-run --xen xen --kimg arch/x86/boot/bzImage --console
> >>
> >> using virtme from here:
> >>
> >>     https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git
> >>
> >> Without these patches, the guest hangs forever.  With these patches,
> >> everything works.
> >>
> > 
> > Dusting off an ancient thread.
> > 
> > Now that the dust has accumulated^Wsettled, is it worth pursuing this?
> >  I think the situation is considerably worse than it was when I
> > originally wrote these patches: I think that QEMU now supports a nasty
> > mode in which the guest's PCI bus appears to be behind an IOMMU but
> > the virtio devices on that bus punch straight through that IOMMU.
> 
> That is an experimental feature (it's x-iommu), so it can change.
> 
> The plan was:
> 
> - for PPC, virtio never honors IOMMU
> 
> - for non-PPC, either have virtio always honor IOMMU, or enforce that
> virtio is not under IOMMU.
> 

I dislike having PPC special cased.

In fact, today x86 guests also assume that virtio bypasses IOMMU I
believe. In fact *all* guests do.

I would much prefer if the information as to whether it honors or not
gets passed to the guest somewhat. My preference goes for passing it via
the virtio config space but there were objections that it should be a
bus property (which is tricky to do with PCI and doesn't properly
reflect the fact that in qemu you can mix & match IOMMU-honoring devices
and bypassing-virtio on the same bus). 

Ben.

> Paolo
> 
> > I have a half-hearted port to modern kernels here:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=virtio_ring_xen
> > 
> > I didn't implement DMA API access for virtio_pci_modern, and I have no
> > idea what to do about detecting whether a given virtio device honors
> > its IOMMU or not.
> > 
> > --Andy
> > 
