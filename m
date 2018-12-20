From: "hch@lst.de" <hch@lst.de>
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Date: Thu, 20 Dec 2018 15:46:04 +0100
Message-ID: <20181220144604.GA18034@lst.de>
References: <20181214082515.14835-1-hch@lst.de> <20181219165939.GA26087@lst.de> <1545316369.14089.20.camel@synopsys.com> <20181220143415.GA17726@lst.de> <1545316759.14089.22.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545316759.14089.22.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 20, 2018 at 02:39:20PM +0000, Eugeniy Paltsev wrote:
> > I would be really surprised if that is caused by the patch to add
> > the zeroing. 
> Me too :)
> 
> >  Can you check which commit caused the issue by bisecting
> > from a known good baseline?
> 
> Yep. At least kernel build from v4.20-rc4 (which is base for your branch)
> seems to work fine.

Well, the branch has quite a few commits.  Can you check the commit
just before the zeroing to start, and if that is already broken (which
I suspect) bisect the offending commit?
