Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732790AbgJIIAT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 04:00:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4FDC0613D6
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 01:00:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so9250764wrq.2
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 01:00:18 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 17/17] drm/i915: Properly request PCI BARs
Date: Fri,  9 Oct 2020 09:59:34 +0200
Message-Id: <20201009075934.3509076-18-daniel.vetter@ffwll.ch>
In-Reply-To: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Dan Williams <dan.j.williams@intel.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org

When trying to test my CONFIG_IO_STRICT_DEVMEM changes I realized they
do nothing for i915. Because i915 doesn't request any regions, like
pretty much all drm pci drivers. I guess this is some very old
remnants from the userspace modesetting days, when we wanted to
co-exist with the fbdev driver. Which usually requested these
resources.

But makes me wonder why the pci subsystem doesn't just request
resource automatically when we map a bar and a pci driver is bound?

Knowledge about which pci bars we need kludged together from
intel_uncore.c and intel_gtt.c from i915 and intel-gtt.c over in the
fake agp driver.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_uncore.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index 54e201fdeba4..ce39049d8919 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -1692,10 +1692,13 @@ static int uncore_mmio_setup(struct intel_uncore *uncore)
 	struct pci_dev *pdev = i915->drm.pdev;
 	int mmio_bar;
 	int mmio_size;
+	int bar_selection;
+	int ret;
 
 	mmio_bar = IS_GEN(i915, 2) ? 1 : 0;
+	bar_selection = BIT (2) | BIT(mmio_bar);
 	/*
-	 * Before gen4, the registers and the GTT are behind different BARs.
+	 * On gen3 the registers and the GTT are behind different BARs.
 	 * However, from gen4 onwards, the registers and the GTT are shared
 	 * in the same BAR, so we want to restrict this ioremap from
 	 * clobbering the GTT which we want ioremap_wc instead. Fortunately,
@@ -1703,6 +1706,8 @@ static int uncore_mmio_setup(struct intel_uncore *uncore)
 	 * generations up to Ironlake.
 	 * For dgfx chips register range is expanded to 4MB.
 	 */
+	if (INTEL_GEN(i915) == 3)
+		bar_selection |= BIT(3);
 	if (INTEL_GEN(i915) < 5)
 		mmio_size = 512 * 1024;
 	else if (IS_DGFX(i915))
@@ -1710,8 +1715,15 @@ static int uncore_mmio_setup(struct intel_uncore *uncore)
 	else
 		mmio_size = 2 * 1024 * 1024;
 
+	ret = pci_request_selected_regions(pdev, bar_selection, "i915");
+	if (ret < 0) {
+		drm_err(&i915->drm, "failed to request pci bars\n");
+		return ret;
+	}
+
 	uncore->regs = pci_iomap(pdev, mmio_bar, mmio_size);
 	if (uncore->regs == NULL) {
+		pci_release_selected_regions(pdev, bar_selection);
 		drm_err(&i915->drm, "failed to map registers\n");
 		return -EIO;
 	}
@@ -1721,9 +1733,18 @@ static int uncore_mmio_setup(struct intel_uncore *uncore)
 
 static void uncore_mmio_cleanup(struct intel_uncore *uncore)
 {
-	struct pci_dev *pdev = uncore->i915->drm.pdev;
+	struct drm_i915_private *i915 = uncore->i915;
+	struct pci_dev *pdev = i915->drm.pdev;
+	int mmio_bar;
+	int bar_selection;
+
+	mmio_bar = IS_GEN(i915, 2) ? 1 : 0;
+	bar_selection = BIT (2) | BIT(mmio_bar);
+	if (INTEL_GEN(i915) == 3)
+		bar_selection |= BIT(3);
 
 	pci_iounmap(pdev, uncore->regs);
+	pci_release_selected_regions(pdev, bar_selection);
 }
 
 void intel_uncore_init_early(struct intel_uncore *uncore,
-- 
2.28.0
