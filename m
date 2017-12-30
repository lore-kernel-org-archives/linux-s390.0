Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 30 Dec 2017 11:56:35 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: consolidate direct dma mapping and swiotlb support
Message-ID: <20171230105635.GA23696@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <23fee3bb-61ce-1735-b264-3acc0109c858@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fee3bb-61ce-1735-b264-3acc0109c858@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20171230105635.JXbSGQV9RMkEPwSAU7mFPYUA7f-XBV3R-L3lYxo8XXM@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-snps-arc@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 29, 2017 at 10:52:14AM +0000, Vladimir Murzin wrote:
> Is it available in your dma-mapping.git or somewhere else?

  git://git.infradead.org/users/hch/misc.git dma-direct

Gitweb:

  http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct
