Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43748 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfGMH3J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 13 Jul 2019 03:29:09 -0400
Date: Sat, 13 Jul 2019 09:29:04 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific
 files
Message-ID: <20190713072904.GC17589@lst.de>
References: <20190713044554.28719-1-bauerman@linux.ibm.com> <20190713044554.28719-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713044554.28719-3-bauerman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

While this looks generally good to me, I think we want to split this
into three patches:

 1) update the swiotlb printk
 2) removing the dma-mapping check and printk
 3) clean up the mem_encrypt.h interface.
