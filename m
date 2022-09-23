Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ECCECAAD8
	for <linux-s390@archiver.kernel.org>; Fri, 23 Sep 2022 15:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIWPoq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiIWPoX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Sep 2022 11:44:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DE11DFC5
        for <linux-s390@vger.kernel.org>; Fri, 23 Sep 2022 08:44:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F41367373; Fri, 23 Sep 2022 17:44:19 +0200 (CEST)
Date:   Fri, 23 Sep 2022 17:44:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: RFC: dasd: use blk_mq_alloc_disk
Message-ID: <20220923154419.GA22651@lst.de>
References: <20220721133251.1878402-1-hch@lst.de> <668f8eba-6e60-fa4c-99dd-ed07cdc46ea3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668f8eba-6e60-fa4c-99dd-ed07cdc46ea3@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 23, 2022 at 05:42:10PM +0200, Stefan Haberland wrote:
> I have tested it on s390 and reviewed the code. Looks good to me.
>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
>
> Would you like to send it to Jens directly or should I take it?

I think it would be best if you could send it on.  Thanks!
