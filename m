From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Thu, 05 Nov 2015 16:11:21 -0500 (EST)
Message-ID: <20151105.161121.188431695871972310.davem@davemloft.net>
References: <20151102144427.GA2876@suse.de>
	<20151102173218.GC12484@shamir-ThinkPad-T430>
	<20151105134206.GD2255@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20151105134206.GD2255@suse.de>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: jroedel@suse.de
Cc: shamir.rabinovitch@oracle.com, dwmw2@infradead.org, benh@kernel.crashing.org, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, pbonzini@redhat.com, hch@lst.de, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>
Date: Thu, 5 Nov 2015 14:42:06 +0100

> Contended IOMMU locks are not only a problem on SPARC, but on x86 and
> various other IOMMU drivers too. But I have some ideas on how to improve
> the situation there.

And for the record Sowmini fixed a lot of the lock contention:

commit ff7d37a502022149655c18035b99a53391be0383
Author: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date:   Thu Apr 9 15:33:30 2015 -0400

    Break up monolithic iommu table/lock into finer graularity pools and lock
    
    Investigation of multithreaded iperf experiments on an ethernet
    interface show the iommu->lock as the hottest lock identified by
    lockstat, with something of the order of  21M contentions out of
    27M acquisitions, and an average wait time of 26 us for the lock.
    This is not efficient. A more scalable design is to follow the ppc
    model, where the iommu_map_table has multiple pools, each stretching
    over a segment of the map, and with a separate lock for each pool.
    This model allows for better parallelization of the iommu map search.
    
    This patch adds the iommu range alloc/free function infrastructure.
    
    Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>
