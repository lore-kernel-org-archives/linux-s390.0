Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520CEC64EC6
	for <linux-s390@archiver.kernel.org>; Thu,  9 Feb 2023 07:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBIHON (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBIHOL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 02:14:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5EC7D83;
        Wed,  8 Feb 2023 23:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/T4VPApsxOCRYXE6SImzPx5lKNCEkQLiXWRn9bzttN0=; b=W2FoUXLV4Xvya2KzPdFvUZrTqY
        VxFyHA4GPvFuils8/x95VpknWWg9Z/0vmzfpFYEGpoLJ5Jr8x3hZwO06lt7ABy432Ic3e4i4dws9t
        jjaaTpPJr14287g1gd95Rqg2ex+YrulrOQi745z99+WcqQtzoEvrNmh2al29Nmmx0JbWhj6nG/Dma
        prEQxTOCfR5tj6KdHH81QSdpUwfYW2FzGC05CJiy/w8I33+m4bQKp5i5/enMFqWCP4RIY+fIry0DJ
        zHEo4FyrS/Z6LqyeeOvoLPYZ+/fiWDvFkORS1E7D09X0muCct5De6AsoqcxonrRZjfh2AORvBduIo
        E/2apNCw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18E-000LPt-Rv; Thu, 09 Feb 2023 07:14:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 15/24] Documentation: s390: correct spelling
Date:   Wed,  8 Feb 2023 23:13:51 -0800
Message-Id: <20230209071400.31476-16-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Correct spelling problems for Documentation/s390/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/s390/pci.rst      |    4 ++--
 Documentation/s390/vfio-ccw.rst |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/s390/pci.rst b/Documentation/s390/pci.rst
--- a/Documentation/s390/pci.rst
+++ b/Documentation/s390/pci.rst
@@ -51,7 +51,7 @@ Entries specific to zPCI functions and e
 
   The slot entries are set up using the function identifier (FID) of the
   PCI function. The format depicted as XXXXXXXX above is 8 hexadecimal digits
-  with 0 padding and lower case hexadecimal digitis.
+  with 0 padding and lower case hexadecimal digits.
 
   - /sys/bus/pci/slots/XXXXXXXX/power
 
@@ -66,7 +66,7 @@ Entries specific to zPCI functions and e
 
   - function_handle
     Low-level identifier used for a configured PCI function.
-    It might be useful for debuging.
+    It might be useful for debugging.
 
   - pchid
     Model-dependent location of the I/O adapter.
diff -- a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -176,7 +176,7 @@ The process of how these work together.
    Use the 'mdev_create' sysfs file, we need to manually create one (and
    only one for our case) mediated device.
 3. vfio_mdev.ko drives the mediated ccw device.
-   vfio_mdev is also the vfio device drvier. It will probe the mdev and
+   vfio_mdev is also the vfio device driver. It will probe the mdev and
    add it to an iommu_group and a vfio_group. Then we could pass through
    the mdev to a guest.
 
