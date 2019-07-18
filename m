Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfGRLgq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 07:36:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IBahMk086508
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 07:36:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttp2y53t5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 18 Jul 2019 07:36:45 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 18 Jul 2019 12:36:38 +0100
Date: Thu, 18 Jul 2019 13:36:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
References: <20190718091700.353b3721@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718091700.353b3721@ezekiel.suse.cz>
Message-Id: <20190718113633.GB3581@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>

On Thu, Jul 18, 2019 at 09:17:00AM +0200, Petr Tesarik wrote:
> Hi all,
> 
> while looking into DMA allocation, I noticed that
> __dma_direct_optimal_gfp_mask() in kernel/dma/direct.c can probably be
> improved. It uses GFP_DMA if dev->coherent_dma_mask is less than
> DMA_BIT_MASK(ARCH_ZONE_DMA_BITS). There is no s390-specific definition
> of ARCH_ZONE_DMA_BITS. The default is 24 bits, but the DMA zone on s390
> is 31 bits. CCW subchannel devices set sch->dev.coherent_dma_mask to
> DMA_BIT_MASK(31), which is greater than DMA_BIT_MASK(24), so buffers
> are allocated from the Normal zone first.
> 
> Would it make sense to set ARCH_ZONE_BITS to 31 on s390, or did I miss
> something?

No, this seems to be broken. Halil, can you look into this and provide
a patch?
