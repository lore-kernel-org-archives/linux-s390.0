Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46046C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 11:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E5560F0F
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 11:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhJKLqc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 07:46:32 -0400
Received: from verein.lst.de ([213.95.11.211]:37022 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhJKLqc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 07:46:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A904B68B05; Mon, 11 Oct 2021 13:44:30 +0200 (CEST)
Date:   Mon, 11 Oct 2021 13:44:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH] dma-debug: fix sg checks in debug_dma_map_sg()
Message-ID: <20211011114430.GB16322@lst.de>
References: <20211006201943.1272825-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006201943.1272825-1-gerald.schaefer@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thanks,

applied.
