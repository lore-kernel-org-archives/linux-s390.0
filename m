Return-Path: <SRS0=aATr=IG=vger.kernel.org=linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BE3C433E0
	for <linux-s390@archiver.kernel.org>; Mon,  8 Mar 2021 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAC36513A
	for <linux-s390@archiver.kernel.org>; Mon,  8 Mar 2021 07:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhCHHu3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 Mar 2021 02:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhCHHt5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Mar 2021 02:49:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932F2C06174A;
        Sun,  7 Mar 2021 23:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MvZzO53jDnLeIXWcdyjd3dBeQWtZ83MkEDAnbxpqG9E=; b=WOcK0fS6sDg9XBsaT83vmexDnZ
        jaSRFz6vNjj7TkKvZidtsyBWM/bpEIpVPisdZ0jn5HRnV3FlV3EYNHBTvzt2Jfyy/RPNAfBtaNS0j
        VHSEIn8maXGu7aB+ijVZOrsLzNCPjQI+bzBg5gQDA94adovwGwjSpu/oaOVp++X88aXyP5F9GlzdH
        54qQ1WEbzIch7gTrIfjNEnb9rvNzHshA8qQ7sa+bXy4RIKOmxFjlBLzibT92IphcS0bIZevBPVb0J
        wj+wG4df534ns8cuvazzSCLDk2zODzGIZv5+yroyUCspUI2vewkUt5Chmqj2n6ImBiPFMY+z42rTT
        sIL6s5pw==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJAdw-00FC1e-GS; Mon, 08 Mar 2021 07:49:38 +0000
Date:   Mon, 8 Mar 2021 08:49:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org
Subject: can we kill the internal blkdev_get in the dasd driver now?
Message-ID: <YEXXCw2MYKzAIKX6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi DASD maintainers,

I've recently changed the life time rules for struct block_device so
that is is a long-living instead of an ephemeral structure, that is the
whole device block_device exists from the time the disk is alloced until
it is feed, and the partitions exist from as soon as they are scanned.

With this the blkdev_get in the DASD driver should not be required, but
there seems to be a lot of magic that accounts of it in the open count.

Any chance one of you maintainers could try to remove it to further
simplify our open and liftetime rules?

