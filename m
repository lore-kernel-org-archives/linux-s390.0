Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9123C4338F
	for <linux-s390@archiver.kernel.org>; Thu, 12 Aug 2021 09:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0AE60C3F
	for <linux-s390@archiver.kernel.org>; Thu, 12 Aug 2021 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhHLJWc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:22:32 -0400
Received: from verein.lst.de ([213.95.11.211]:43616 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236069AbhHLJWb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Aug 2021 05:22:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A512367373; Thu, 12 Aug 2021 11:22:04 +0200 (CEST)
Date:   Thu, 12 Aug 2021 11:22:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
Message-ID: <20210812092204.GB4827@lst.de>
References: <20210811070542.3403116-1-jhubbard@nvidia.com> <20210811070542.3403116-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811070542.3403116-4-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 11, 2021 at 12:05:42AM -0700, John Hubbard wrote:
> -		if (unlikely(!try_get_page(page)))
> +		if (unlikely(try_get_compound_head(page, 1) == NULL))

Why not a simple ! instead of the == NULL?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
