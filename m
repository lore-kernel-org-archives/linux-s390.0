Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A254C54E94
	for <linux-s390@archiver.kernel.org>; Tue, 24 Jan 2023 14:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjAXOLC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjAXOLB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Jan 2023 09:11:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8961042BDB;
        Tue, 24 Jan 2023 06:11:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3427068D09; Tue, 24 Jan 2023 14:45:18 +0100 (CET)
Date:   Tue, 24 Jan 2023 14:45:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] s390/dcssblk:: don't call bio_split_to_limits
Message-ID: <20230124134517.GA26408@lst.de>
References: <20230123075356.60847-1-hch@lst.de> <Y8/gDgQfQA7++8tw@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/gDgQfQA7++8tw@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jan 24, 2023 at 02:41:34PM +0100, Alexander Gordeev wrote:
> If my understanding is correct that this change was as good as
> early as commit 54efd50bfd87 ("block: make generic_make_request
> handle arbitrarily sized bios") took place and simply fell into
> the second category?

Yes.
