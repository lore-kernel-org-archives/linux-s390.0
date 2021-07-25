Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4FC4320E
	for <linux-s390@archiver.kernel.org>; Sun, 25 Jul 2021 06:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE0B60F26
	for <linux-s390@archiver.kernel.org>; Sun, 25 Jul 2021 06:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhGYF1V (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:27:21 -0400
Received: from verein.lst.de ([213.95.11.211]:41944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhGYF1V (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 25 Jul 2021 01:27:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DC2267373; Sun, 25 Jul 2021 08:07:48 +0200 (CEST)
Date:   Sun, 25 Jul 2021 08:07:47 +0200
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
        Martin Oliveira <martin.oliveira@eideticom.com>
Subject: Re: [PATCH v2 01/21] dma-mapping: Allow map_sg() ops to return
 negative error codes
Message-ID: <20210725060747.GA10852@lst.de>
References: <20210723175008.22410-1-logang@deltatee.com> <20210723175008.22410-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723175008.22410-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> +int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
> +		    enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int nents;
> +
> +	nents = __dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
> +	if (nents == 0)
> +		return -EIO;
> +	else if (nents < 0) {
> +		if (WARN_ON_ONCE(nents != -EINVAL && nents != -ENOMEM &&
> +				 nents != -EIO))
> +			return -EIO;

I think this validation of the errnos needs to go into __dma_map_sg_attrs,
so that we catch it for the classic dma_map_sg callers as well.
