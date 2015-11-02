From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] Provide simple noop dma ops
Date: Mon, 2 Nov 2015 16:16:44 +0100
Message-ID: <20151102151644.GC2876@suse.de>
References: <1446211237-111298-1-git-send-email-borntraeger@de.ibm.com>
 <1446211237-111298-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446211237-111298-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 30, 2015 at 02:20:35PM +0100, Christian Borntraeger wrote:
> +static void *dma_noop_alloc(struct device *dev, size_t size,
> +			    dma_addr_t *dma_handle, gfp_t gfp,
> +			    struct dma_attrs *attrs)
> +{
> +	void *ret;
> +
> +	ret = (void *)__get_free_pages(gfp, get_order(size));
> +	if (ret) {
> +		memset(ret, 0, size);

There is no need to zero out the memory here. If the user wants
initialized memory it can call dma_zalloc_coherent. Having the memset
here means to clear the memory twice in the dma_zalloc_coherent path.

Otherwise it looks good.


	Joerg
