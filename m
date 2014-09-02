From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 2 Sep 2014 16:56:26 -0400
Message-ID: <20140902205626.GA17982@laptop.dumpdata.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1409691213.30640.37.camel@pasglop>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 03, 2014 at 06:53:33AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2014-09-01 at 22:55 -0700, Andy Lutomirski wrote:
> > 
> > On x86, at least, I doubt that we'll ever see a physically addressed
> > PCI virtio device for which ACPI advertises an IOMMU, since any sane
> > hypervisor will just not advertise an IOMMU for the virtio device.
> > But are there arm64 or PPC guests that use virtio_pci, that have
> > IOMMUs, and that will malfunction if the virtio_pci driver ends up
> > using the IOMMU?  I certainly hope not, since these systems might be
> > very hard-pressed to work right if someone plugged in a physical
> > virtio-speaking PCI device.
> 
> It will definitely not work on ppc64. We always have IOMMUs on pseries,
> all PCI busses do, and because it's a paravirtualized environment,
> napping/unmapping pages means hypercalls -> expensive.
> 
> But our virtio implementation bypasses it in qemu, so if virtio-pci
> starts using the DMA mapping API without changing the DMA ops under the
> hood, it will break for us.

What is the default dma_ops that the Linux guests start with as
guests under ppc64?

Thanks!
> 
> Cheers,
> Ben.
> 
> 
