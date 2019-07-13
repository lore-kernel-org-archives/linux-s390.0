Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 13 Jul 2019 09:27:17 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to
 arch/Kconfig
Message-ID: <20190713072717.GB17589@lst.de>
References: <20190713044554.28719-1-bauerman@linux.ibm.com> <20190713044554.28719-2-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713044554.28719-2-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

On Sat, Jul 13, 2019 at 01:45:52AM -0300, Thiago Jung Bauermann wrote:
> powerpc is also going to use this feature, so put it in a generic location.

Looks good,

even without a third arch using it we should never habe symbols defined
under arch/$(ARCH) that are used in common code to start with.

Reviewed-by: Christoph Hellwig <hch@lst.de>
