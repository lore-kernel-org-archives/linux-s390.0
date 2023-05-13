Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CE6C77B7F
	for <linux-s390@archiver.kernel.org>; Sat, 13 May 2023 13:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjEMN33 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 13 May 2023 09:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbjEMN31 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 13 May 2023 09:29:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DA40CF;
        Sat, 13 May 2023 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683984541; x=1715520541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBJRq3qZNBqtx20tG6OP6phR2tRqYeQ+5aeFBb+MBro=;
  b=WE2gNoso9W3+mixZ3zrY1dfqE1VKOM5VX/Fow2F0W30Tms7+PH2wA3jF
   TMYCGlOrwMZQy0kp1eyInEHbDXiA1KDZix9I77m+VrT2MY9vI6oAh9roi
   91V5cGmewDR/PACdjeGlhH/H9Lm2BSiMyvvJMQFPo2M/TGZUNdUQS2jn4
   sDsPMgzLeZ183dMU9XHKBtGdBuf6faOJPHGO1zQe9KlpqHHHab2uHBGvT
   3Pv1oxk9UHLn/j9qiiVNr5H/g5tTjiOaFAMeCaIrYa7AFEBB8D4kenFGX
   rgnIJt1VmPau9GTHM8aAnBRMYM8UKXA/Ok8MW9+t/9HQ+L/eL2DN5YQ3N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="354100796"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="354100796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 06:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="703459511"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="703459511"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2023 06:28:52 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.l.liu@intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
        jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com,
        lulu@redhat.com, suravee.suthikulpanit@amd.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com, zhenzhong.duan@intel.com,
        clegoate@redhat.com
Subject: [PATCH v11 16/23] vfio: Name noiommu vfio_device with "noiommu-" prefix
Date:   Sat, 13 May 2023 06:28:20 -0700
Message-Id: <20230513132827.39066-17-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230513132827.39066-1-yi.l.liu@intel.com>
References: <20230513132827.39066-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For noiommu device, vfio core names the cdev node with prefix "noiommu-".

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/vfio_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 599d551fc4b5..89720b73fa30 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -284,13 +284,14 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	ret = dev_set_name(&device->device, "vfio%d", device->index);
+	ret = vfio_device_set_group(device, type);
 	if (ret)
 		return ret;
 
-	ret = vfio_device_set_group(device, type);
+	ret = dev_set_name(&device->device, "%svfio%d",
+			   vfio_device_is_noiommu(device) ? "noiommu-" : "", device->index);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = device_add(&device->device);
 	if (ret)
-- 
2.34.1

