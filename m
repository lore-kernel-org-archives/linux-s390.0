Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F173DC678D7
	for <linux-s390@archiver.kernel.org>; Tue, 10 Jan 2023 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjAJJLE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 Jan 2023 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjAJJKd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Jan 2023 04:10:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733019010;
        Tue, 10 Jan 2023 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rNWvtXigw+2fgOXzD3V8HutEFKvArAwyByUizidQEMg=; b=mZayYMmChdc1cy6IKO4/yF4IXt
        L0S6KuIGiicO2XwimsTDfHLBG2OcXRJAFeVNLlbjGHx+NEqpgXSz4nS9RQ0OOEdagTSmo8LfPfism
        nezns8n82dCcft9ZTm+wRAwRcgVSoiQsalYGU/kVB32iWxhKbB8myKCe+pZh0WAjETzI1w/5fgC86
        RWliMXSo1WgDhXAiadXHrl8lnl/Y/NgXbYfDLKXcvEz87QttbmaX7JIoVc3JrEIDU3aYMigZYLzCJ
        fwV/KjZ+7lrpFnA9EdzLAb9y5OW2HEgX29R8OPSjaCIm8tJ+TcSRskDDULMjT3HM+pkbSTqZO/Khz
        BcPWTDJw==;
Received: from [2001:4bb8:181:656b:cb3a:c552:3fcc:12a6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFAeE-0060cr-OJ; Tue, 10 Jan 2023 09:10:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] vfio-mdev: remove an non-existing driver from vfio-mediated-device
Date:   Tue, 10 Jan 2023 10:10:09 +0100
Message-Id: <20230110091009.474427-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230110091009.474427-1-hch@lst.de>
References: <20230110091009.474427-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The nvidia mdev driver does not actually exist anywhere in the tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/driver-api/vfio-mediated-device.rst | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
index d4267243b4f525..bbd548b66b4255 100644
--- a/Documentation/driver-api/vfio-mediated-device.rst
+++ b/Documentation/driver-api/vfio-mediated-device.rst
@@ -60,7 +60,7 @@ devices as examples, as these devices are the first devices to use this module::
      |   mdev.ko     |
      | +-----------+ |  mdev_register_parent() +--------------+
      | |           | +<------------------------+              |
-     | |           | |                         |  nvidia.ko   |<-> physical
+     | |           | |                         | ccw_device.ko|<-> physical
      | |           | +------------------------>+              |    device
      | |           | |        callbacks        +--------------+
      | | Physical  | |
@@ -69,12 +69,6 @@ devices as examples, as these devices are the first devices to use this module::
      | |           | |                         |  i915.ko     |<-> physical
      | |           | +------------------------>+              |    device
      | |           | |        callbacks        +--------------+
-     | |           | |
-     | |           | |  mdev_register_parent() +--------------+
-     | |           | +<------------------------+              |
-     | |           | |                         | ccw_device.ko|<-> physical
-     | |           | +------------------------>+              |    device
-     | |           | |        callbacks        +--------------+
      | +-----------+ |
      +---------------+
 
-- 
2.35.1

