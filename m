Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9BCCA47A
	for <linux-s390@archiver.kernel.org>; Tue, 14 Jun 2022 04:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiFNEyw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Jun 2022 00:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiFNEyt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jun 2022 00:54:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3906937BD9;
        Mon, 13 Jun 2022 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AZzutnG50lKr2/Ph8sA9sjy9B+4ZEBV2t6fpN+CzXzo=; b=tFnS+0fakga6Q0vQBV8FcxmZ1S
        L20a7yhIpJRNhm72PBPsx7BUjfNhcudP7srTCbK6lFiWUmshB1rheI+8Vdv3fniwoyz8pKTrR6lIB
        kufsPG3/6lcShXAS0gUMUsII4DHGgZl3tgxtU7OtBKzrDBRISpOPbFKOKXXZC5/BFjzrqBpmSMP2x
        vkPcBuLVmgy2nfF8DBPJJul7aQomUipseh6H+W89mkHacMFIehdWPIPMY3l8ondywnc8ZbS3RWTA9
        NofO43fGaOZx0CVGBqEo124JT9QEulwvTkH+vaDSO8xhqUtfPdJh6cUxTGUVSEEAA/9sgz+UmJiWA
        W20kpcjg==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0yZi-0072fj-82; Tue, 14 Jun 2022 04:54:46 +0000
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
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 06/13] vfio/mdev: unexport mdev_bus_type
Date:   Tue, 14 Jun 2022 06:54:21 +0200
Message-Id: <20220614045428.278494-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614045428.278494-1-hch@lst.de>
References: <20220614045428.278494-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

mdev_bus_type is only used in mdev.ko now, so unexport it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/vfio/mdev/mdev_driver.c  | 1 -
 drivers/vfio/mdev/mdev_private.h | 1 +
 include/linux/mdev.h             | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
index 1da1ecf76a0d5..5b3c94f4fb13d 100644
--- a/drivers/vfio/mdev/mdev_driver.c
+++ b/drivers/vfio/mdev/mdev_driver.c
@@ -46,7 +46,6 @@ struct bus_type mdev_bus_type = {
 	.remove		= mdev_remove,
 	.match		= mdev_match,
 };
-EXPORT_SYMBOL_GPL(mdev_bus_type);
 
 /**
  * mdev_register_driver - register a new MDEV driver
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 346b9ec320466..62a98b78d929d 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -13,6 +13,7 @@
 int  mdev_bus_register(void);
 void mdev_bus_unregister(void);
 
+extern struct bus_type mdev_bus_type;
 extern const struct attribute_group *mdev_device_groups[];
 
 #define to_mdev_type_attr(_attr)	\
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 409e86d343a05..dd11c142bf887 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -92,8 +92,6 @@ static inline const guid_t *mdev_uuid(struct mdev_device *mdev)
 	return &mdev->uuid;
 }
 
-extern struct bus_type mdev_bus_type;
-
 int mdev_register_parent(struct mdev_parent *parent, struct device *dev,
 		struct mdev_driver *mdev_driver, struct mdev_type **types,
 		unsigned int nr_types);
-- 
2.30.2

