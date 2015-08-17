From: Christoph Hellwig <hch@lst.de>
Subject: provide more common DMA API functions V2
Date: Mon, 17 Aug 2015 09:06:51 +0200
Message-Id: <1439795216-32189-1-git-send-email-hch@lst.de>
Return-Path: <BATV+d9386a2b82e844863ec9+4376+infradead.org+hch@bombadil.srs.infradead.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu, jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn, x86@kernel.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since 2009 we have a nice asm-generic header implementing lots of DMA API
functions for architectures using struct dma_map_ops, but unfortunately
it's still missing a lot of APIs that all architectures still have to
duplicate.

This series consolidates the remaining functions, although we still
need arch opt outs for two of them as a few architectures have very
non-standard implementations.

Changes since V1:
 - keep a modified comment about dma_alloc_noncoherent vs
   dma_cache_sync in the ARM asm/dma-mapping.h
 - keep the ARM dma_set_mask instances to deal with dmabounce
