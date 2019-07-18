Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57819 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfGRImR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 04:42:17 -0400
Date: Thu, 18 Jul 2019 10:42:13 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/6] swiotlb: Remove call to sme_active()
Message-ID: <20190718084213.GA24562@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718032858.28744-3-bauerman@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

On Thu, Jul 18, 2019 at 12:28:54AM -0300, Thiago Jung Bauermann wrote:
> sme_active() is an x86-specific function so it's better not to call it from
> generic code.
> 
> There's no need to mention which memory encryption feature is active, so
> just use a more generic message. Besides, other architectures will have
> different names for similar technology.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
