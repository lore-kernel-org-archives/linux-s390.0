From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Sat, 20 Sep 2014 07:28:33 +1000
Message-ID: <1411162113.30672.60.camel@pasglop>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1410972571.12562.24.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410972571.12562.24.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2014-09-17 at 09:49 -0700, David Woodhouse wrote:
> On Wed, 2014-09-17 at 09:07 -0700, Andy Lutomirski wrote:
> > 
> > I still think that this is a property of the bus, not the device.  x86
> > has such a mechanism, and this patch uses it transparently.
> 
> Right. A device driver should use the DMA API. Always.

I do agree, and that's why I suggested that instead of doing what it
does, that patch should instead:

  - Always use dma_map_*

  - Make the dma "ops" of the virtio bus/device point to a set of "null
ops" when necessary.

This would also make my life easier on powerpc since I will too have
cases where I will want virtio to use the dma mapping API, it's just
that the *current* implementation is such that qemu always bypasses
iommus and we want to keep that mode of operations as an option (even
the default) for performances.

But qemu isn't the only other implementation of virtio ...
 
> The platform's implementation of the DMA API is then free to observe
> that the device in question isn't actually served by any IOMMU and give
> a trivial 1:1 mapping.

Right.

> > > > The virtio device should advertise whether it's using that bypass
> > > > mode of operation and virtio_pci should react accordingly.
> > >
> > > Well if there's a way to detect that - that's outside the
> > > device, then we probably shouldn't use device-specific
> > > interfaces for this capability.
> > 
> > (NB: According to David Woodhouse about ten minutes ago, this should
> > work with a bit of care right now on x86 via ACPI as long as QEMU
> > configures the tables correctly.)
> 
> Well, we don't currently expose a virtual IOMMU to x86 guests at the
> moment although we're going to want to in the near future.
> 
> My answer was based on the assumption that it'll actually be an Intel
> IOMMU that we expose, rather than some paravirtualised IOMMU interface
> which allows us to support both AMD and Intel hosts. That may not be a
> valid assumption; I don't think we've really explored this at all.
> 
> But *given* that assumption, the VT-d ACPI tables allow a given IOMMU
> unit to be associated either with a list of specific devices, *or* to
> have a 'catch-all' bit set which means that it owns all
> otherwise-unmatched devices in that PCI domain.
> 
> So... if you want some devices to be seen as *not* behind an IOMMU then
> they need to be in a PCI domain which *doesn't* have a catch-all IOMMU
> unit. So either you put them in a separate PCI domain all by themselves,
> or you explicitly list all (possible) PCI BDFs under the IOMMU unit and
> don't use the catch-all facility.
>  
> Having said that... don't. Just put the damn thing behind an IOMMU. The
> guest OS doesn't *have* to use it; it either eschew the IOMMU completely
> or it can choose to use pass-through mode for specific devices.

Ben.
