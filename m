From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH linux-next] iommu: add iommu for s390 platform
Date: Mon, 27 Oct 2014 15:32:01 +0100
Message-ID: <20141027153201.517f4ff4@thinkpad>
References: <1413892645-37657-1-git-send-email-blaschka@linux.vnet.ibm.com>
 <20141022141728.GG10074@8bytes.org>
 <20141022154320.GA42442@tuxmaker.boeblingen.de.ibm.com>
 <20141023124115.GB10053@8bytes.org>
 <20141023140437.GA31009@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141023140437.GA31009@tuxmaker.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, sebott@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 23 Oct 2014 16:04:37 +0200
Frank Blaschka <blaschka@linux.vnet.ibm.com> wrote:

> On Thu, Oct 23, 2014 at 02:41:15PM +0200, Joerg Roedel wrote:
> > On Wed, Oct 22, 2014 at 05:43:20PM +0200, Frank Blaschka wrote:
> > > Basically there are no limitations. Depending on the s390 maschine
> > > generation a device starts its IOVA at a specific address
> > > (announced by the HW). But as I already told each device starts
> > > at the same address. I think this prevents having multiple
> > > devices on the same IOMMU domain.
> > 
> > Why, each device has its own IOVA address space, so IOVA A could
> > map to physical address X for one device and to Y for another, no?
> > And if you point multiple devices to the same dma_table they share
> > the mappings (and thus the address space). Or am I getting
> > something wrong?
> > 
> > > yes, you are absolutely right. There is a per-device dma_table.
> > > There is no general IOMMU device but each pci device has its own
> > > IOMMU translation capability.
> > 
> > I see, in this way it is similar to ARM where there is often also
> > one IOMMU per master device.
> > 
> > > Is there a possibility the IOMMU domain can support e.g.
> > > something like
> > > 
> > > VIOA 0x10000 -> pci device 1
> > > VIOA 0x10000 -> pci device 2
> > 
> > A domain is basically an abstraction for a DMA page table (or a
> > dma_table, as you call it on s390). So you can easily create similar
> > mappings for more than one device with it.
> >
> ok, maybe I was too close to the existing s390 dma implementation or
> simply wrong, maybe Sebastian or Gerald can give more background

Not sure if I understood the concept of IOMMU domains right. But if this
is about having multiple devices in the same domain, so that iommu_ops->map
will establish the _same_ DMA mapping on _all_ registered devices, then
this should be possible.

We cannot have shared DMA tables because each device gets its own DMA table
allocated during device initialization. But we could just keep all devices
from one domain in a list and then call dma_update_trans() for all devices
during iommu_ops->map/unmap.

Gerald
