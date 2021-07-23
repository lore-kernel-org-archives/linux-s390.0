Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC4C19F33
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8927160F02
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhGWRJw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:09:52 -0400
Received: from ale.deltatee.com ([204.191.154.188]:50578 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGWRJr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jul 2021 13:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=x3KSnhFQmhq0kDAcj69QIXa3ZhZHzFN2nEhizdLNjiI=; b=M3qmRbqsKCC+FKzgIYDrT251SH
        Nzml0wv2K48qt2sJXjzM1DxP/eDRfrPjJ9bdzaj0HtsiKgS7pahyju0brznWg3AUJX+JatcVTcM4g
        0wsnuMo5aYzvw314Ri5RUkrtzSp9HF/aXGG5ksmYAYRZ5BAnS1pC0gSFfSU2XiRUXllDLfF/3xgcP
        YUj9pjNTYWDHh8iHeimXsNZzv//XPnvhiWZXPpnRGhPZv18QuImLyc5EfuRCj99XGEoFia3P4JxFW
        zRK7JfICPO6TzZ/eLMEo6IcVqpEkBhDIJpDj5PqWbAxQ3M83go6+8pynIzl/aD4Jy3LIvtXsBIgDO
        p3nGybYg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1m6zJQ-0005Lg-RK; Fri, 23 Jul 2021 11:50:17 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1m6zJN-0005rT-EK; Fri, 23 Jul 2021 11:50:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 23 Jul 2021 11:50:07 -0600
Message-Id: <20210723175008.22410-21-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723175008.22410-1-logang@deltatee.com>
References: <20210723175008.22410-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com, martin.oliveira@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 20/21] dma-mapping: return error code from dma_dummy_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Martin Oliveira <martin.oliveira@eideticom.com>

The .map_sg() op now expects an error code instead of zero on failure.

The only errno to return is -EINVAL in the case when DMA is not
supported.

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
index eacd4c5b10bf..b492d59ac77e 100644
--- a/kernel/dma/dummy.c
+++ b/kernel/dma/dummy.c
@@ -22,7 +22,7 @@ static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nelems, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	return 0;
+	return -EINVAL;
 }
 
 static int dma_dummy_supported(struct device *hwdev, u64 mask)
-- 
2.20.1

