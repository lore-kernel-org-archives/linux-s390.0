Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89682C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 05:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3061042
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 05:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhHTFob (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:44:31 -0400
Received: from verein.lst.de ([213.95.11.211]:39793 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233004AbhHTFo3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Aug 2021 01:44:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6E7A6736F; Fri, 20 Aug 2021 07:43:40 +0200 (CEST)
Date:   Fri, 20 Aug 2021 07:43:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org
Subject: can we finally kill off CONFIG_FS_DAX_LIMITED
Message-ID: <20210820054340.GA28560@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi all,

looking at the recent ZONE_DEVICE related changes we still have a
horrible maze of different code paths.  I already suggested to
depend on ARCH_HAS_PTE_SPECIAL for ZONE_DEVICE there, which all modern
architectures have anyway.  But the other odd special case is
CONFIG_FS_DAX_LIMITED which is just used for the xpram driver.  Does
this driver still see use?  If so can we make it behave like the
other DAX drivers and require a pgmap?  I think the biggest missing
part would be to implement ARCH_HAS_PTE_DEVMAP for s390.
