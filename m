From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [PATCH linux-next] iommu: add iommu for s390 platform
Date: Wed, 22 Oct 2014 17:43:20 +0200
Message-ID: <20141022154320.GA42442@tuxmaker.boeblingen.de.ibm.com>
References: <1413892645-37657-1-git-send-email-blaschka@linux.vnet.ibm.com> <20141022141728.GG10074@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141022141728.GG10074@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, sebott@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 22, 2014 at 04:17:29PM +0200, Joerg Roedel wrote:
> Hi Frank,
> 
> On Tue, Oct 21, 2014 at 01:57:25PM +0200, Frank Blaschka wrote:
> > Add a basic iommu for the s390 platform. The code is pretty simple
> > since on s390 each PCI device has its own virtual io address space
> > starting at the same vio address.
> 
> Are there any limitations on IOVA address space for the devices or can
> be really any system physical address mapped starting from 0 to 2^64?
>

Hi Joerg,

Basically there are no limitations. Depending on the s390 maschine
generation a device starts its IOVA at a specific address (announced by
the HW). But as I already told each device starts at the same address.
I think this prevents having multiple devices on the same IOMMU domain.
 
> > For this a domain could hold only one pci device.
> 
> This bothers me, as it is not compatible with the IOMMU-API. I looked a
> little bit into how the mappings are created, and it seems there is a
> per-device dma_table.
>

yes, you are absolutely right. There is a per-device dma_table.
There is no general IOMMU device but each pci device has its own IOMMU
translation capability.
 
> Is there any reason a dma_table can't be per IOMMU domain and assigned
> to multiple devices at the same time?

Is there a possibility the IOMMU domain can support e.g. something like

VIOA 0x10000 -> pci device 1
VIOA 0x10000 -> pci device 2

> 
> Otherwise the code looks quite simple and straight forward.
>

Thx for your review and help 

Frank
 
> 
> 	Joerg
> 
> 
