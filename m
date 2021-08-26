Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9BC432BE
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 09:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8F3610C8
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 09:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhHZJZU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhHZJZU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Aug 2021 05:25:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB4C0613C1;
        Thu, 26 Aug 2021 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=LYfeTLyAHXXI2HOhgQZ5BD+hiE
        Avlq7CYPwanSRNHhRaAe2DPsjijOmZxwRj9pMh9EC1/9kMfUHX7CINGP/lIftKKObzRoyOE1adfeY
        4SZ/aKfNHyL/SznN+c+Tthbn6EwyGKf6BXSCM5/ty+aTIKpB1F/ZfllvxudKfKU1nTZeWghEOpwlC
        pwImiH5MaOR7YHRihzyMpviwLSaBS6jCp8bl5QMim3eHFMyS8hlqUj/kAERYijDkho7LRj2bWpWXM
        hOPSHglSkZw2vJeCjX5YNYSn5dKeTtUWlgx++fqQJkQULdg4PDWrHl6dqlm1VsftrDpN6ltgcEFGr
        PYl1OkTA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJBb7-00D9Gj-LB; Thu, 26 Aug 2021 09:23:24 +0000
Date:   Thu, 26 Aug 2021 10:22:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, alex.williamson@redhat.com,
        diana.craciun@oss.nxp.com, kwankhede@nvidia.com,
        eric.auger@redhat.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        mgurtovoy@nvidia.com, jgg@nvidia.com, maorg@nvidia.com,
        leonro@nvidia.com
Subject: Re: [PATCH V4 03/13] vfio/pci: Rename vfio_pci_device to
 vfio_pci_core_device
Message-ID: <YSddcccCdJgXDPKB@infradead.org>
References: <20210825135139.79034-1-yishaih@nvidia.com>
 <20210825135139.79034-4-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825135139.79034-4-yishaih@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
