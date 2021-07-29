Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E56C19F41
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E50160F23
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhG2UQc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:16:32 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59224 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhG2UQC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 16:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=fB/z94v+Zqx6MpbGppBoixHLzAQycdh8k5f4rRFmrO0=; b=Q/yOit+wzn0WTLkgHijTX4TkhO
        8+eoLaiFE1mafvZ/q4c2J8dgiHrEu7XfRLxOMtaCE2yip7zxl1sE/WyHaFGuCUlAsojHu3Yn1olhc
        F6lgtyAVdYp7At6SrmssFkRyMNq/7Y8eEHEoLDTW3SL2JS9ATF53ewVI4ZZgHkeKeWzP92SM7FH34
        eTt7FT+3sGYlOVErWUL9BBZ81w65udV5r7T9L+Bim7OvBQFE+Z+0NIEO7fp0Dm/dAqjBx6Z8qCOHg
        eaGZJCGwxHsUZUd8FtgHTl3bnmB6UbQ2wz20VgRmFykYHYTmvncDFTw4bL71o7DIitalfyY4Hk8F1
        0BLcIVQA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1m9CRd-0008VM-3g; Thu, 29 Jul 2021 14:15:54 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1m9CRV-0001UB-QR; Thu, 29 Jul 2021 14:15:45 -0600
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
        Logan Gunthorpe <logang@deltatee.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Date:   Thu, 29 Jul 2021 14:15:34 -0600
Message-Id: <20210729201539.5602-17-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729201539.5602-1-logang@deltatee.com>
References: <20210729201539.5602-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com, martin.oliveira@eideticom.com, logang@deltatee.com, James.Bottomley@HansenPartnership.com, deller@gmx.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 16/21] parisc: return error code from .map_sg() ops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Martin Oliveira <martin.oliveira@eideticom.com>

The .map_sg() op now expects an error code instead of zero on failure.
Return -EINVAL if the ioc cannot be obtained.

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/parisc/ccio-dma.c  | 2 +-
 drivers/parisc/sba_iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index b5f9ee81a46c..452e72b7bd01 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -918,7 +918,7 @@ ccio_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	BUG_ON(!dev);
 	ioc = GET_IOC(dev);
 	if (!ioc)
-		return 0;
+		return -EINVAL;
 	
 	DBG_RUN_SG("%s() START %d entries\n", __func__, nents);
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index dce4cdf786cd..e60690d38d67 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -947,7 +947,7 @@ sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
 
 	ioc = GET_IOC(dev);
 	if (!ioc)
-		return 0;
+		return -EINVAL;
 
 	/* Fast path single entry scatterlists. */
 	if (nents == 1) {
-- 
2.20.1

