From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Sat, 7 Nov 2015 17:06:42 +0200
Message-ID: <20151107150642.GA4405@shamir-ThinkPad-T430>
References: <20151102144427.GA2876@suse.de>
 <20151102173218.GC12484@shamir-ThinkPad-T430>
 <20151105134206.GD2255@suse.de>
 <20151105.161121.188431695871972310.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151105.161121.188431695871972310.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: jroedel@suse.de, dwmw2@infradead.org, benh@kernel.crashing.org, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, pbonzini@redhat.com, hch@lst.de, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 05, 2015 at 04:11:21PM -0500, David Miller wrote:
> 
> And for the record Sowmini fixed a lot of the lock contention:
> 
> commit ff7d37a502022149655c18035b99a53391be0383
> Author: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date:   Thu Apr 9 15:33:30 2015 -0400
> 
>     Break up monolithic iommu table/lock into finer graularity pools and lock
>     

The poor rds-stress results w/o IOMMU bypass I sent in early post were taken from
kernel that has the above patch and that has all the needed changes in arch/sparc
to use this new feature.

It seems that it worked well for 10G ETH IOMMU lock contention but it still not solving
the rds-stress issue.

The difference can be from:

1. Lock contention still left with this enhancement <-- zero in bypass
2. Overhead to setup the IOMMU mapping <-- almost zero in bypass (require 1 HV call)
3. Overhead to use the IOMMU mapping <-- not sure how to measure this
4. Overhead to tear the IOMMU mapping <-- zero in bypass 
