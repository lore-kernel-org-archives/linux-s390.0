Return-Path: <linux-pci-owner@vger.kernel.org>
Date: Wed, 12 Nov 2014 10:24:24 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] xen MSI code clean up
In-Reply-To: <20141111212353.GJ28161@google.com>
Message-ID: <alpine.LFD.2.11.1411121023020.1596@denkbrett>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com> <20141111212353.GJ28161@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 11 Nov 2014, Bjorn Helgaas wrote:
> [+cc Sebastian, linux-s390, David, Konrad, xen-devel]
> 
> On Mon, Oct 27, 2014 at 10:44:35AM +0800, Yijing Wang wrote:
> > 
> > Yijing Wang (3):
> >   x86/xen: Introduce a global flag to fix the MSI mask bug
> >   x86/xen: Revert "PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()"
> >   s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()
> 
> I applied these with David's reviewed-by and ack to pci/msi for v3.19.
> 
> I'd like to see an ack from Sebastian for the s390 part, but I guess that
> one is pretty trivial.

> >   s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Regards,
Sebastian

> 
> >  arch/s390/pci/pci.c             |    4 ++--
> >  arch/x86/include/asm/x86_init.h |    3 ---
> >  arch/x86/kernel/x86_init.c      |   10 ----------
> >  arch/x86/pci/xen.c              |   15 +++------------
> >  drivers/pci/msi.c               |   29 ++++++++++++-----------------
> >  include/linux/msi.h             |    5 +++--
> >  6 files changed, 20 insertions(+), 46 deletions(-)
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
