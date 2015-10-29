From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Wed, 28 Oct 2015 17:23:39 -0700 (PDT)
Message-ID: <20151028.172339.458418017721569530.davem@davemloft.net>
References: <1446039110.3405.212.camel@infradead.org>
	<20151028.070705.1277125569024626755.davem@davemloft.net>
	<1446040632.3405.222.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1446040632.3405.222.camel@infradead.org>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: dwmw2@infradead.org
Cc: shamir.rabinovitch@oracle.com, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, jroedel@suse.de, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, pbonzini@redhat.com, hch@lst.de, benh@kernel.crashing.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 28 Oct 2015 22:57:12 +0900

> On Wed, 2015-10-28 at 07:07 -0700, David Miller wrote:
>> In the sparc64 case, the 64-bit DMA address space is divided into
>> IOMMU translated and non-IOMMU translated.
>> 
>> You just set the high bits differently depending upon what you want.
> 
> Wait, does that mean a (rogue) device could *always* get full access to
> physical memory just by setting the high bits appropriately? That
> mapping is *always* available?

The IOMMU supports several modes, one of which disallows passthrough
and this is what you would use in a virtual guest.
