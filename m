Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Aug 2020 13:47:59 +0100
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
In-Reply-To: <20200828121944.GQ1152540@nvidia.com>
References: <20200826112333.992429909@linutronix.de>
 <20200827182040.GA2049623@bjorn-Precision-5520>
 <20200828112142.GA14208@e121166-lin.cambridge.arm.com>
 <20200828121944.GQ1152540@nvidia.com>
Message-ID: <0cc8bfd9258dfc507585fd0f19a945e3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Jon Derrick <jonathan.derrick@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Megha Dey <megha.dey@intel.com>, Dave Jiang <dave.jiang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, Baolu Lu <baolu.lu@intel.com>, Kevin Tian <kevin.tian@intel.com>, Dan Williams <dan.j.williams@intel.com>, Rob Herring <robh@kernel.org>

Hi Jason,

On 2020-08-28 13:19, Jason Gunthorpe wrote:
> On Fri, Aug 28, 2020 at 12:21:42PM +0100, Lorenzo Pieralisi wrote:
>> On Thu, Aug 27, 2020 at 01:20:40PM -0500, Bjorn Helgaas wrote:
>> 
>> [...]
>> 
>> > And I can't figure out what's special about tegra, rcar, and xilinx
>> > that makes them need it as well.  Is there something I could grep for
>> > to identify them?  Is there a way to convert them so they don't need
>> > it?
>> 
>> I think DT binding and related firmware support are needed to setup 
>> the
>> MSI IRQ domains correctly, there is nothing special about tegra, rcar
>> and xilinx AFAIK (well, all native host controllers MSI handling is
>> *special* just to be polite but let's gloss over this for the time
>> being).
>> 
>> struct msi_controller, to answer the first question.
>> 
>> I have doubts about pci_mvebu too, they do allocate an msi_controller
>> but without methods so it looks pretty much useless.
> 
> Oh, I did once know things about mvebu..
> 
> I suspect the msi controller pointer assignment is dead code at this
> point. The only implementation of MSI with that PCI root port is
> drivers/irqchip/irq-armada-370-xp.c which looks like it uses
> irq_domain.
> 
> Actually looks like things are very close to eliminating
> msi_controller.
> 
> This is dead code, can't find a setter for hw_pci->msi_ctrl:
> 
> arch/arm/include/asm/mach/pci.h:        struct msi_controller 
> *msi_ctrl;
> arch/arm/kernel/bios32.c:                               bridge->msi =
> hw->msi_ctrl;
> 
> This is probably just copying NULL from one place to another:
> 
> drivers/pci/controller/pci-mvebu.c:     struct msi_controller *msi;
> 
> These need conversion to irq_domain (right?):
> 
> drivers/pci/controller/pci-hyperv.c:    struct msi_controller msi_chip;
> drivers/pci/controller/pci-tegra.c:     struct msi_controller chip;
> drivers/pci/controller/pcie-rcar-host.c:        struct msi_controller 
> chip;
> drivers/pci/controller/pcie-xilinx.c:static struct msi_controller
> xilinx_pcie_msi_chip = {
> 
> Then the stuff in drivers/pci/msi.c can go away.
> 
> So the arch_setup_msi_irq/etc is not really an arch hook, but some
> infrastructure to support those 4 PCI root port drivers.

I happen to have a *really old* patch addressing Tegra [1], which
I was never able to test (no HW). Rebasing it shouldn't be too hard,
and maybe you can find someone internally willing to give it a spin?

That'd be a good start towards the removal of this cruft.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/kill-msi-controller&id=83b3602fcee7972b9d549ed729b56ec28de16081
-- 
Jazz is not dead. It just smells funny...
