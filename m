Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38899 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfGLPLc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 11:11:32 -0400
Date: Fri, 12 Jul 2019 17:11:29 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Message-ID: <20190712151129.GA30636@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com> <20190712140812.GA29628@lst.de> <20190712165153.78d49095.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712165153.78d49095.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

On Fri, Jul 12, 2019 at 04:51:53PM +0200, Halil Pasic wrote:
> Thank you very much! I will have another look, but it seems to me,
> without further measures taken, this would break protected virtualization
> support on s390. The effect of the che for s390 is that
> force_dma_unencrypted() will always return false instead calling into
> the platform code like it did before the patch, right?
> 
> Should I send a  Fixes: e67a5ed1f86f "dma-direct: Force unencrypted DMA
> under SME for certain DMA masks" (Tom Lendacky, 2019-07-10) patch that
> rectifies things for s390 or how do we want handle this?

Yes, please do.  I hadn't noticed the s390 support had landed in
mainline already.
