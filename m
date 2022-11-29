Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90054C4321E
	for <linux-s390@archiver.kernel.org>; Tue, 29 Nov 2022 10:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiK2K6f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiK2K6e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Nov 2022 05:58:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972227DCE;
        Tue, 29 Nov 2022 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669719513; x=1701255513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gpq6XMGJA8yeDNB1SV9LoTeJdCcXiIy6XwKuTb6lJ7w=;
  b=LNgenmBQv4wontdCQJcDccQ4c1qLG2F4OvAi2bNI40Bs2dZ6bm9CPKmw
   Amq7XQH/oTOoWXiGvA4KVljBLUR6r5PthvYI+wsTtS5znXm2i/nGbyYCD
   /z0Y+I3BGtxVN/lbAM+M5srtc9mDKOxYtqf2yExvzcBwUpmxnU7HaLvfu
   mOu7jVtBIyPs8Kw0kToi/VCx+HnM5GZO0+hpU85R8UyWaWHDxN6G+cA38
   oG11C1SQuMOT7tkgUwLGof6Mvq8hl7L9/cu7NEkngNAWlOboDjCWLScBh
   iQBngTGWcxEyaYp6uaEWU4twRuhIe4HKvNjO7XW2LuCYXtgjb5kcVlKBR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="295457243"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="295457243"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 02:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="621411018"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="621411018"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2022 02:58:33 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     jgg@nvidia.com
Cc:     alex.williamson@redhat.com, kevin.tian@intel.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, intel-gvt-dev@lists.freedesktop.org,
        linux-s390@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: [[RESEND] iommufd PATCH v2 0/2] Make mdev driver dma_unmap callback tolerant to unmaps come before device open
Date:   Tue, 29 Nov 2022 02:58:29 -0800
Message-Id: <20221129105831.466954-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Jason's "Connect VFIO to IOMMUFD" introduces vfio iommufd compat mode. Under
this mode, vfio_iommufd_bind() creates an access which has an unmap callback,
which can be called immediately. This means mdev drivers may receive unmap
requests before the mdev is opened. For now, there are only three drivers
(gvt, vfio-ap and vfio-ccw) providing dma_unmap(). vfio-ccw is fine with
such requests. While gvt-g and vfio-ap may have potential problem with such
requests due to internal implementation. This series tries to enhance the two
drivers.

This series is based on Jason's below branch.

https://github.com/jgunthorpe/linux/tree/iommufd

(commit: 41973418f6c8c241ed5647d1408d5b917f24dfd8)

Change:
v2:
 - Refine the cover letter and commit message of patch 0001 (Kevin)
 - Rename patch 0001 to better fit the commit message
 - Add r-b from Zhi for patch 0001
 - Tweak iova range test to assume page-aligned for patch 0002 (Jason)
 - Remove break so all queues within range are removed for patch 0002 (Kevin)

v1: https://lore.kernel.org/kvm/20221123134832.429589-1-yi.l.liu@intel.com/

Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: intel-gvt-dev@lists.freedesktop.org

Regards,
	Yi Liu

Matthew Rosato (1):
  vfio/ap: validate iova during dma_unmap and trigger irq disable

Yi Liu (1):
  i915/gvt: Move gvt mapping cache initialization to
    intel_vgpu_init_dev()

 drivers/gpu/drm/i915/gvt/kvmgt.c  | 13 +++++++++----
 drivers/s390/crypto/vfio_ap_ops.c | 18 +++++++++++++++++-
 2 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.34.1

