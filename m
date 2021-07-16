Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68872C12002
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 06:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC9613EE
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 06:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhGPGg3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jul 2021 02:36:29 -0400
Received: from verein.lst.de ([213.95.11.211]:41976 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234896AbhGPGg3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Jul 2021 02:36:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C874467373; Fri, 16 Jul 2021 08:33:32 +0200 (CEST)
Date:   Fri, 16 Jul 2021 08:33:32 +0200
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
Subject: Re: [PATCH v1 16/16] dma-mapping: Disallow .map_sg operations from
 returning zero on error
Message-ID: <20210716063332.GD13345@lst.de>
References: <20210715164544.6827-1-logang@deltatee.com> <20210715164544.6827-17-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715164544.6827-17-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 15, 2021 at 10:45:44AM -0600, Logan Gunthorpe wrote:
> @@ -194,6 +194,8 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  	else
>  		ents = ops->map_sg(dev, sg, nents, dir, attrs);
>  
> +	WARN_ON_ONCE(ents == 0);

Turns this into a negative error code while we're at it, just to keep
the callers sane?
