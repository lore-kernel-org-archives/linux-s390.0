Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1KLp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Sep 2020 06:11:45 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
In-Reply-To: <your-ad-here.call-01601123933-ext-6476@work.hours>
References: <20200826111628.794979401@linutronix.de> <20200826112333.992429909@linutronix.de> <cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com> <your-ad-here.call-01601123933-ext-6476@work.hours>
Date: Mon, 28 Sep 2020 12:11:40 +0200
Message-ID: <87eemmky77.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>, Qian Cai <cai@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Jon Derrick <jonathan.derrick@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Marc Zyngier <maz@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@mellanox.com>, Dave Jiang <dave.jiang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, Baolu Lu <baolu.lu@intel.com>, Kevin Tian <kevin.tian@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Sat, Sep 26 2020 at 14:38, Vasily Gorbik wrote:
> On Fri, Sep 25, 2020 at 09:54:52AM -0400, Qian Cai wrote:
> Yes, as well as on mips and sparc which also don't FORCE_PCI.
> This seems to work for s390:
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index b0b7acf07eb8..41136fbe909b 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -192,3 +192,3 @@ config S390
>         select PCI_MSI                  if PCI
> -       select PCI_MSI_ARCH_FALLBACKS
> +       select PCI_MSI_ARCH_FALLBACKS   if PCI
>         select SET_FS

lemme fix that for all of them ...
