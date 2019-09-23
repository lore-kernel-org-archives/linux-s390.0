Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394324AbfIWMfL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCRO1o020983
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v6vce4amd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:07 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 3/3] dma-mapping: warn on harmful GFP_* flags
Date: Mon, 23 Sep 2019 14:34:18 +0200
In-Reply-To: <20190923123418.22695-1-pasic@linux.ibm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
Message-Id: <20190923123418.22695-4-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

The commit message of commit 57bf5a8963f8 ("dma-mapping: clear harmful
GFP_* flags in common code") says that probably warn when we encounter
harmful GFP_* flags which we clean -- because the client code is best
case silly if not buggy. I concur with that.

Let's warn once when we encounter silly GFP_* flags. The guys caring
about the respective client code will hopefully fix these soon.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---

I'm not too happy with my warning message. Suggestions welcome!
---
 include/linux/dma-mapping.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 5024bc863fa7..299f36ac8668 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -823,6 +823,9 @@ extern gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags);
 static inline gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags)
 {
 	/* let the implementation decide on the zone to allocate from: */
+	dev_WARN_ONCE(dev,
+		      flags & (__GFP_DMA32 | __GFP_DMA | __GFP_HIGHMEM),
+		      "fixme: don't dma_alloc with any of: __GFP_DMA32, __GFP_DMA, __GFP_HIGHMEM\n");
 	return flags & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 }
 #endif
-- 
2.17.1
