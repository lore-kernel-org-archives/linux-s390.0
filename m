From: "hch@lst.de" <hch@lst.de>
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Date: Thu, 20 Dec 2018 15:34:15 +0100
Message-ID: <20181220143415.GA17726@lst.de>
References: <20181214082515.14835-1-hch@lst.de> <20181219165939.GA26087@lst.de> <1545316369.14089.20.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545316369.14089.20.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>, Vineet Gupta <vineet.gupta1@synopsys.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, monst
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 20, 2018 at 02:32:52PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> I test kernel from your 'dma-alloc-always-zero' branch, and as
> I can see we have DMA peripherals (like USB) broken.

I would be really surprised if that is caused by the patch to add
the zeroing.  Can you check which commit caused the issue by bisecting
from a known good baseline?
