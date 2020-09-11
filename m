Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgIKPoo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Sep 2020 11:44:44 -0400
Subject: Re: s390 PCI dma ops
References: <20200911072734.GA23043@lst.de>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <73550e74-1fda-cc34-0e14-54e2b7e76e99@linux.ibm.com>
Date: Fri, 11 Sep 2020 10:39:02 -0400
MIME-Version: 1.0
In-Reply-To: <20200911072734.GA23043@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: linux-s390@vger.kernel.org

On 9/11/20 3:27 AM, Christoph Hellwig wrote:
> Hi S/390 PCI and IOMMU maintainers,
> 
> We've recently tried to convert all implementations of the IOMMU API to
> use drivers/iommu/dma-iommu.c instead of their local IOMMU ops.  I've
> looked at S/390 and while some comments mention things about the iommu
> API the implementation looks quite separate.  Do arch/s390/pci/pci_dma.c
> and drivers/iommu/s390-iommu.c driver the same hardware?  If so would a

Yes, these drivers are dealing with the same hardware.

> switch to drivers/iommu/dma-iommu.c be feasibel?
> 

Hmm...  s390 does some particular things that are arch-specific, largely 
as forms of optimization.  One such example is a case where we avoid 
reusing IO TLB Page Table Entries until we have to do a global flush.

I'd need to take a closer look at what AMD did / what intel is doing. 
Fundamentally we are open to the idea as the maintenance benefit is 
clear, but I don't think it's a trivial swap - I think we would need 
extensions to dma-iommu to accommodate some of our special cases / 
optimizations.
