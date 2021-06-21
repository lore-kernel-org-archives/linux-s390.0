Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D57C48BE5
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 07:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E9C60E08
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 07:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhFUHaB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:30:01 -0400
Received: from verein.lst.de ([213.95.11.211]:40890 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhFUHaB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 03:30:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFD2768BEB; Mon, 21 Jun 2021 09:27:45 +0200 (CEST)
Date:   Mon, 21 Jun 2021 09:27:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] dasd: unexport dasd_set_target_state
Message-ID: <20210621072745.GA6896@lst.de>
References: <20210614060440.3965603-1-hch@lst.de> <4e202558-05b4-9c63-f08e-a5762b93c9ce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e202558-05b4-9c63-f08e-a5762b93c9ce@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 17, 2021 at 02:40:06PM +0200, Stefan Haberland wrote:
> Am 14.06.21 um 08:04 schrieb Christoph Hellwig:
> > dasd_set_target_state is only used inside of dasd_mod.ko, so don't
> > export it.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Acked-by: Stefan Haberland <sth@linux.ibm.com>

Can you pick this up through the s390 tree?
