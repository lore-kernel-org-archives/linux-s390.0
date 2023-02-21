Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DFC64EC7
	for <linux-s390@archiver.kernel.org>; Tue, 21 Feb 2023 03:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjBUDt3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Feb 2023 22:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjBUDtZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Feb 2023 22:49:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8805F252A7;
        Mon, 20 Feb 2023 19:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676951351; x=1708487351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+QN4g7gTAMMs8znNFnYax1SUbnU2yRxiDmKpTZqxMw=;
  b=AV9ZtNOISpwgYNuFkfeHqRaJQru4fFeqd0rqkv3bPkl2MY0MmWqqELjo
   fr57SNHMpXePRkNUn2+xuA9yxoGMJ1Bfp56P7B8WlMAlBwBey+xsZlyt4
   AYcj4hFNRE02EybXY0/Ixi5v52p8tywz1aEetQWwmvszfBVifp/2Q54Gi
   VAbYmls1fMZfyYgWoma4QOUMrxHBRZ4wZeBulzEmw9317PoN+QbkqoJnb
   n/jXbvUODeGXEDYEJ+8WTHk0yzQlta1p3zBEpFyDDpTcHU7vRCf3Z8WhP
   H3BD8+KHxsylQAdQhmMTbLb6Mfv01RnhqdY5EYp5994FIHJUt1Hbo+OWq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="397218447"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="397218447"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 19:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="664822174"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="664822174"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2023 19:48:20 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com
Cc:     joro@8bytes.org, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        yan.y.zhao@intel.com, xudong.hao@intel.com, terrence.xu@intel.com
Subject: [PATCH v4 08/19] vfio/pci: Update comment around group_fd get in vfio_pci_ioctl_pci_hot_reset()
Date:   Mon, 20 Feb 2023 19:48:01 -0800
Message-Id: <20230221034812.138051-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221034812.138051-1-yi.l.liu@intel.com>
References: <20230221034812.138051-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

this suits more on what the code does.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4704c1babae3..827524510f3f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1308,8 +1308,7 @@ static int vfio_pci_ioctl_pci_hot_reset(struct vfio_pci_core_device *vdev,
 	}
 
 	/*
-	 * For each group_fd, get the group through the vfio external user
-	 * interface and store the group and iommu ID.  This ensures the group
+	 * For each group_fd, get the group file, this ensures the group
 	 * is held across the reset.
 	 */
 	for (file_idx = 0; file_idx < hdr.count; file_idx++) {
-- 
2.34.1

