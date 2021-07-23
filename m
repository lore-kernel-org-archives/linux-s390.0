Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C021C19F3E
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653FD60F02
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jul 2021 17:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhGWRKm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:10:42 -0400
Received: from ale.deltatee.com ([204.191.154.188]:50850 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhGWRKD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jul 2021 13:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=GqC6MNUep++aB8fDrjh2DnNmBSYDqSi9PqIeeLTquj0=; b=lZbqhlYojMDTC61acH6COEDa82
        KR35lDGt5LaHTcn+pvR+vpgnA43hQ7AZrRhWdg+la8vReBTvoNH/vEAXWztSraEGY05DkL24ACtme
        Bcz3zbGWOeM1226wPJ3MV/d18qZ29cw5QFUKHYHY6YDD0HR6PyM9cMwymZl4hFCaPse8HwgQHmW9h
        ugiZPCPhQUxiATZCAy3FMKZIkGsEDhllkY+0c7IqVxWupfCbbYjpTb+fftfITgSXMJ2m4HZlVPqDD
        meE1TkV1nr5omqhpdjfX9L8EsUv84pJnShJplThugFTXcMMMygbBGqNrGLazrRcBmCW303z4DtoKV
        5udqRChA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1m6zJg-0005Lk-DJ; Fri, 23 Jul 2021 11:50:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1m6zJL-0005qt-IL; Fri, 23 Jul 2021 11:50:11 -0600
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Fri, 23 Jul 2021 11:49:55 -0600
Message-Id: <20210723175008.22410-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723175008.22410-1-logang@deltatee.com>
References: <20210723175008.22410-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com, martin.oliveira@eideticom.com, logang@deltatee.com, mpe@ellerman.id.au, schnelle@linux.ibm.com, tsbogend@alpha.franken.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 08/21] ia64/sba_iommu: return error code from sba_map_sg_attrs()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Martin Oliveira <martin.oliveira@eideticom.com>

The .map_sg() op now expects an error code instead of zero on failure.

In the case of a dma_mapping_error() return -EIO as the actual cause
is opaque here.

sba_coalesce_chunks() may only presently fail if sba_alloc_range()
fails, which in turn only fails if the iommu is out of mapping
resources, hence a -ENOMEM is used in that case.

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/ia64/hp/common/sba_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 9148ddbf02e5..430c166b68cd 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -1458,8 +1458,8 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 		sglist->dma_length = sglist->length;
 		sglist->dma_address = sba_map_page(dev, sg_page(sglist),
 				sglist->offset, sglist->length, dir, attrs);
-		if (dma_mapping_error(dev, sglist->dma_address))
-			return 0;
+		if(dma_mapping_error(dev, sglist->dma_address))
+			return -EIO;
 		return 1;
 	}
 
@@ -1486,7 +1486,7 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 	coalesced = sba_coalesce_chunks(ioc, dev, sglist, nents);
 	if (coalesced < 0) {
 		sba_unmap_sg_attrs(dev, sglist, nents, dir, attrs);
-		return 0;
+		return -ENOMEM;
 	}
 
 	/*
-- 
2.20.1

