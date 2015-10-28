From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/4] Provide simple noop dma ops
Date: Wed, 28 Oct 2015 09:41:32 +0900
Message-ID: <20151028004132.GC2805@suse.de>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <1445986131-239566-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445986131-239566-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christian,

On Tue, Oct 27, 2015 at 11:48:48PM +0100, Christian Borntraeger wrote:
> +static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
> +				      unsigned long offset, size_t size,
> +				      enum dma_data_direction dir,
> +				      struct dma_attrs *attrs)
> +{
> +	return page_to_phys(page) + offset;
> +}

X86 also has its own version of these noop dma_ops, see
arch/x86/kernel/pci-nommu.c. This one also checks the dma_mask and
prints a warning if the physical address doesn't fit into the mask.

I think this would make sense here too, and that we can also make x86
use the same generic noop-dma-ops your are introducing.


	Joerg
