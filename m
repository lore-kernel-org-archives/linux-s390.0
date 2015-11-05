From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Thu, 05 Nov 2015 16:08:10 -0500 (EST)
Message-ID: <20151105.160810.1916907637281203788.davem@davemloft.net>
References: <1446081046.1856.55.camel@kernel.crashing.org>
	<CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
	<1446158125.4471.5.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1446158125.4471.5.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: dwmw2@infradead.org
Cc: luto@amacapital.net, benh@kernel.crashing.org, borntraeger@de.ibm.com, linux-arch@vger.kernel.org, pbonzini@redhat.com, shamir.rabinovitch@oracle.com, schwidefsky@de.ibm.com, linux-doc@vger.kernel.org, sebott@linux.vnet.ibm.com, linux-s390@vger.kernel.org, cornelia.huck@de.ibm.com, jroedel@suse.de, corbet@lwn.net, kvm@vger.kernel.org, arnd@arndb.de, hch@lst.de
List-ID: <linux-s390.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 29 Oct 2015 22:35:25 +0000

> For the receive side, it shouldn't be beyond the wit of man to
> introduce an API which allocates *and* DMA-maps a skb. Pass it to
> netif_rx() still mapped, with a destructor that just shoves it back in
> a pool for re-use.

For forwarding, the SKB is going to another device to be DMA'd,
perhaps via another IOMMU.

For local connections, it's going to sit for an unpredictable and
unbounded amount of time in the socket queue.

We've been through this thought process before, believe me :)
