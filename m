Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4144C25B06
	for <linux-s390@archiver.kernel.org>; Sun, 14 Aug 2022 21:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiHNVwM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 14 Aug 2022 17:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHNVwL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 14 Aug 2022 17:52:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BA12D26;
        Sun, 14 Aug 2022 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/RNl//CQIdgfxBiYXR2ClSuv26fcHBeLkZBQXo1ac8A=; b=Vfz3IoiDMyXbd/8N1C2zY4t4OO
        0cNfyaYdHnoPSTcBG5nWEnmmxA7RE3fuAhp7FwUL0ZlrE4S974mAA67zoNnVLmW8to84O4OTACHdd
        KmT0OkQpJFui+9udyZk1NS0cjqqo4GO3tUUuFMr96zvD4JkuHzJ2QMcQKXk89Sz4YuEhGFuzlWPl7
        XYYDVM/l5WbDFfORJRnxs/dP/zaYlOt2OcHN0KPR5VD59j/RZUdPyxjcQKih+fRsYS9zz+iGJFwHm
        ETljBGy3T/Tdodt+QcVe9f6FGTtIkJmZHJeELc46QESdK88XsbUT58mjc5pxtM6+ch8GJnKit1i6E
        gnHC8WQQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNLWc-0058iR-Rj; Sun, 14 Aug 2022 21:52:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH] vfio-pci/zdev: require KVM to be built-in
Date:   Sun, 14 Aug 2022 14:51:54 -0700
Message-Id: <20220814215154.32112-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix build errors when CONFIG_KVM=m:

s390-linux-ld: drivers/vfio/pci/vfio_pci_zdev.o: in function `vfio_pci_zdev_open_device':
vfio_pci_zdev.c:(.text+0x242): undefined reference to `kvm_s390_pci_register_kvm'
s390-linux-ld: drivers/vfio/pci/vfio_pci_zdev.o: in function `vfio_pci_zdev_close_device':
vfio_pci_zdev.c:(.text+0x296): undefined reference to `kvm_s390_pci_unregister_kvm'

Having a bool Kconfig symbol depend on a tristate symbol can often
lead to problems like this.

Fixes: 8061d1c31f1a ("vfio-pci/zdev: add open/close device hooks")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: kvm@vger.kernel.org
---
 drivers/vfio/pci/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -46,7 +46,7 @@ endif
 
 config VFIO_PCI_ZDEV_KVM
 	bool "VFIO PCI extensions for s390x KVM passthrough"
-	depends on S390 && KVM
+	depends on S390 && KVM=y
 	default y
 	help
 	  Support s390x-specific extensions to enable support for enhancements
