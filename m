Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
In-Reply-To: <8736492jot.wl-maz@kernel.org>
References: <20200826111628.794979401@linutronix.de> <20200826112333.992429909@linutronix.de> <8736492jot.wl-maz@kernel.org>
Date: Wed, 26 Aug 2020 23:27:41 +0200
Message-ID: <87lfi1t7w2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Jon Derrick <jonathan.derrick@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@mellanox.com>, Dave Jiang <dave.jiang@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, Baolu Lu <baolu.lu@intel.com>, Kevin Tian <kevin.tian@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, Aug 26 2020 at 22:14, Marc Zyngier wrote:
> On Wed, 26 Aug 2020 12:17:02 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> @@ -103,6 +105,7 @@ config PCIE_XILINX_CPM
>>  	bool "Xilinx Versal CPM host bridge support"
>>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>>  	select PCI_HOST_COMMON
>> +	select PCI_MSI_ARCH_FALLBACKS
>
> This guy actually doesn't implement MSIs at all (it seems to delegate
> them to an ITS present in the system, if I read the DT binding
> correctly). However its older brother from the same silicon dealer
> seems to need it. The patchlet below should fix it.

Gah, at some point my eyes went squared and I lost track..
