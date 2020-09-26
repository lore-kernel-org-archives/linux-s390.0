Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIZMjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 08:39:47 -0400
Date: Sat, 26 Sep 2020 14:38:53 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <your-ad-here.call-01601123933-ext-6476@work.hours>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.992429909@linutronix.de>
 <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Jon Derrick <jonathan.derrick@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Marc Zyngier <maz@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@mellanox.com>, Dave Jiang <dave.jiang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, Baolu Lu <baolu.lu@intel.com>, Kevin Tian <kevin.tian@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Sep 25, 2020 at 09:54:52AM -0400, Qian Cai wrote:
> On Wed, 2020-08-26 at 13:17 +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
> > requires them or not. Architectures which are fully utilizing hierarchical
> > irq domains should never call into that code.
> > 
> > It's not only architectures which depend on that by implementing one or
> > more of the weak functions, there is also a bunch of drivers which relies
> > on the weak functions which invoke msi_controller::setup_irq[s] and
> > msi_controller::teardown_irq.
> > 
> > Make the architectures and drivers which rely on them select them in Kconfig
> > and if not selected replace them by stub functions which emit a warning and
> > fail the PCI/MSI interrupt allocation.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Today's linux-next will have some warnings on s390x:
> 
> .config: https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config
> 
> WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - S390 [=y]
> 
> WARNING: unmet direct dependencies detected for PCI_MSI_ARCH_FALLBACKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - S390 [=y]
>

Yes, as well as on mips and sparc which also don't FORCE_PCI.
This seems to work for s390:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b0b7acf07eb8..41136fbe909b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -192,3 +192,3 @@ config S390
        select PCI_MSI                  if PCI
-       select PCI_MSI_ARCH_FALLBACKS
+       select PCI_MSI_ARCH_FALLBACKS   if PCI
        select SET_FS
