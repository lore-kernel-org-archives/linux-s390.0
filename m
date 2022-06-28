Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5E3C43334
	for <linux-s390@archiver.kernel.org>; Tue, 28 Jun 2022 05:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbiF1FQq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbiF1FQT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jun 2022 01:16:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369E02AC58;
        Mon, 27 Jun 2022 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kNBKlJmsraT3/S9BB2OU0X6U2C5cMVubPgxbYHcITCU=; b=l/xjmcmT1ECPirQpQPCSh1gxoL
        k7JoJ7rOx4RKnWMOrCgZ8yFKc4M3BoxK3DO3Nz/NvDGpUktzlzD2GXJ5/LWO+3PanKKGzrRe4rdH1
        YDLHA8LopMnY0GOTatTapkPbmfh/ciOZvvQJb6OfLlxwPUzvJ7edUns91MGaQwVnzyRoYlrHYTtbY
        zxWcbatImhLG/YeKZWnTlr43VrGlhZodNcfcY82dyPvhcvJUxvr3cGu+Iu0jrCU8hgm+2pJhnv2jQ
        y48D5+cn5LOUknare8ihHg7EeiI6rWWK+GjpwJQctiy+C1szPWanTRyHN+gNTjLaL3U15jjTVp0rw
        blXwi3Sg==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o63Ye-004KlN-7p; Tue, 28 Jun 2022 05:14:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 01/13] drm/i915/gvt: fix a memory leak in intel_gvt_init_vgpu_types
Date:   Tue, 28 Jun 2022 07:14:23 +0200
Message-Id: <20220628051435.695540-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628051435.695540-1-hch@lst.de>
References: <20220628051435.695540-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

gvt->types needs to be freed on error.

Reported-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/vgpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 46da19b3225d2..5c828556cefd7 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -142,7 +142,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 
 		if (vgpu_types[i].weight < 1 ||
 					vgpu_types[i].weight > VGPU_MAX_WEIGHT)
-			return -EINVAL;
+			goto out_free_types;
 
 		gvt->types[i].weight = vgpu_types[i].weight;
 		gvt->types[i].resolution = vgpu_types[i].edid;
@@ -167,6 +167,10 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
 
 	gvt->num_types = i;
 	return 0;
+
+out_free_types:
+	kfree(gvt->types);
+	return -EINVAL;
 }
 
 void intel_gvt_clean_vgpu_types(struct intel_gvt *gvt)
-- 
2.30.2

