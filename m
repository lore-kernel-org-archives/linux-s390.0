From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework
 to configure MSI/MSI-X irq
Date: Wed, 10 Sep 2014 10:59:57 -0400
Message-ID: <20140910145957.GD12893@laptop.dumpdata.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-9-git-send-email-wangyijing@huawei.com>
 <5409C8C0.8020200@citrix.com>
 <540E6095.8030409@huawei.com>
 <54104641.7020007@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <54104641.7020007@citrix.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, xen-devel@lists.xenproject.org, arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Bharat.Bhushan@freescale.com, Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>, iommu@lists.l
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 10, 2014 at 01:38:25PM +0100, David Vrabel wrote:
> On 09/09/14 03:06, Yijing Wang wrote:
> > On 2014/9/5 22:29, David Vrabel wrote:
> >> On 05/09/14 11:09, Yijing Wang wrote:
> >>> Use MSI chip framework instead of arch MSI functions to configure
> >>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> >> [...]
> >>> --- a/arch/x86/pci/xen.c
> >>> +++ b/arch/x86/pci/xen.c
> >> [...]
> >>> @@ -418,9 +430,9 @@ int __init pci_xen_init(void)
> >>>  #endif
> >>>  
> >>>  #ifdef CONFIG_PCI_MSI
> >>> -	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
> >>> -	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
> >>> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
> >>> +	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
> >>> +	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
> >>> +	x86_msi_chip = &xen_msi_chip;
> >>>  	msi_chip.irq_mask = xen_nop_msi_mask;
> >>>  	msi_chip.irq_unmask = xen_nop_msi_mask;
> >>
> >> Why have these not been changed to set the x86_msi_chip.mask/unmask
> >> fields instead?
> > 
> > Hi David, x86_msi_chip here is struct msi_chip data type, used to configure MSI/MSI-X
> > irq. msi_chip above is struct irq_chip data type, represent the MSI irq controller. They are
> > not the same object. Their name easily confusing people.
> 
> Ok, it all makes sense now.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>

You can also add 'Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>'

on the whole series - I ran it through on Xen and on baremetal with a mix of 32/64 builds.

Oh, and also Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> the Xen parts.

> 
> David
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
