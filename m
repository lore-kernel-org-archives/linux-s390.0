From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Wed, 28 Oct 2015 07:07:05 -0700 (PDT)
Message-ID: <20151028.070705.1277125569024626755.davem@davemloft.net>
References: <1446013801.3405.183.camel@infradead.org>
	<20151028111049.GA30785@shamir-ThinkPad-T430>
	<1446039110.3405.212.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446039110.3405.212.camel@infradead.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: dwmw2@infradead.org
Cc: shamir.rabinovitch@oracle.com, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, jroedel@suse.de, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, pbonzini@redhat.com, hch@lst.de, benh@kernel.crashing.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 28 Oct 2015 22:31:50 +0900

> On Wed, 2015-10-28 at 13:10 +0200, Shamir Rabinovitch wrote:
>> On Wed, Oct 28, 2015 at 03:30:01PM +0900, David Woodhouse wrote:
>> > > > +For systems with IOMMU it is assumed all DMA translations use the IOMMU.
>> > 
>> > Not entirely true. We have per-device dma_ops on a most architectures
>> > already, and we were just talking about the need to add them to
>> > POWER/SPARC too, because we need to avoid trying to use the IOMMU to
>> > map virtio devices too.
>> 
>> SPARC has it's implementation under arch/sparc for dma_ops (sun4v_dma_ops).
>> 
>> Some drivers use IOMMU under SPARC for example ixgbe (Intel 10G ETH).
>> Some, like IB, suffer from IOMMU MAP setup/tear-down & limited address range.
>> On SPARC IOMMU bypass is not total bypass of the IOMMU but rather much simple
>> translation that does not require any complex translations tables.
> 
> We have an option in the Intel IOMMU for pass-through mode too, which
> basically *is* a total bypass. In practice, what's the difference
> between that and a "simple translation that does not require any
> [translation]"? We set up a full 1:1 mapping of all memory, and then
> the map/unmap methods become no-ops.
> 
> Currently we have no way to request that mode on a per-device basis; we
> only have 'iommu=pt' on the command line to set it for *all* devices.
> But performance-sensitive devices might want it, while we keep doing
> proper translation for others.

In the sparc64 case, the 64-bit DMA address space is divided into
IOMMU translated and non-IOMMU translated.

You just set the high bits differently depending upon what you want.

So a device could use both IOMMU translated and bypass accesses at the
same time.  While seemingly interesting, I do not recommend we provide
this kind of flexibility in our DMA interfaces.
