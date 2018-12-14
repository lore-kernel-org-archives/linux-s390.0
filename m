From: Christoph Hellwig <hch@lst.de>
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Date: Fri, 14 Dec 2018 14:33:18 +0100
Message-ID: <20181214133318.GA13968@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

And in various places this used GFP_ZERO instead of __GFP_ZERO,
so won't compile.

The fixed version is available here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-alloc-always-zero
