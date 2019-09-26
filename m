Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfIZMhy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Sep 2019 08:37:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8QCXs4o073801
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 08:37:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8ur5w77j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 08:37:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 26 Sep 2019 13:37:51 +0100
Date: Thu, 26 Sep 2019 14:37:45 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch
 customizable
In-Reply-To: <20190923152117.GA2767@lst.de>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
        <20190923123418.22695-2-pasic@linux.ibm.com>
        <20190923152117.GA2767@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190926143745.68bdd082.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

On Mon, 23 Sep 2019 17:21:17 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Sep 23, 2019 at 02:34:16PM +0200, Halil Pasic wrote:
> > Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
> > common code") tweaking the client code supplied GFP_* flags used to be
> > an issue handled in the architecture specific code. The commit message
> > suggests, that fixing the client code would actually be a better way
> > of dealing with this.
> > 
> > On s390 common I/O devices are generally capable of using the full 64
> > bit address space for DMA I/O, but some chunks of the DMA memory need to
> > be 31 bit addressable (in physical address space) because the
> > instructions involved mandate it. Before switching to DMA API this used
> > to be a non-issue, we used to allocate those chunks from ZONE_DMA.
> > Currently our only option with the DMA API is to restrict the devices to
> > (via dma_mask and dma_mask_coherent) to 31 bit, which is sub-optimal.
> > 
> > Thus s390 we would benefit form having control over what flags are
> > dropped.
> 
> No way, sorry.  You need to express that using a dma mask instead of
> overloading the GFP flags.

Thanks for your feedback and sorry for the delay. Can you help me figure
out how can I express that using a dma mask? 

IMHO what you ask from me is frankly impossible.

What I need is the ability to ask for  (considering the physical
address) 31 bit addressable DMA memory if the chunk is supposed to host
control-type data that needs to be 31 bit addressable because that is
how the architecture is, without affecting the normal data-path. So
normally 64 bit mask is fine but occasionally (control) we would need
a 31 bit mask.

Regards,
Halil
