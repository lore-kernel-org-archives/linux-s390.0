Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1FEC636CA
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 06:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1858B613E7
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 06:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhGPGfo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jul 2021 02:35:44 -0400
Received: from verein.lst.de ([213.95.11.211]:41968 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235273AbhGPGfl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Jul 2021 02:35:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2BDE767373; Fri, 16 Jul 2021 08:32:42 +0200 (CEST)
Date:   Fri, 16 Jul 2021 08:32:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 14/16] x86/amd_gart: return error code from
 gart_map_sg()
Message-ID: <20210716063241.GC13345@lst.de>
References: <20210715164544.6827-1-logang@deltatee.com> <20210715164544.6827-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715164544.6827-15-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 15, 2021 at 10:45:42AM -0600, Logan Gunthorpe wrote:
> @@ -458,7 +460,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  	iommu_full(dev, pages << PAGE_SHIFT, dir);
>  	for_each_sg(sg, s, nents, i)
>  		s->dma_address = DMA_MAPPING_ERROR;
> -	return 0;
> +	return ret;

While we're at it - setting the ->dma_address to DMA_MAPPING_ERROR is
not part of the ->map_sg calling convention.  Might be worth to fix
up while we're at it.
