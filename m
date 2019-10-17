Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34690 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503311AbfJQSWf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Oct 2019 14:22:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so1835797pgi.1
        for <linux-s390@vger.kernel.org>; Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
Subject: [PATCH 3/3] pci: Default to PCI_MSI_IRQ_DOMAIN
Date: Thu, 17 Oct 2019 11:19:37 -0700
Message-Id: <20191017181937.7004-4-palmer@sifive.com>
In-Reply-To: <20191017181937.7004-1-palmer@sifive.com>
References: <20191017181937.7004-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com, helgaas@kernel.org
Cc: tony.luck@intel.com, fenghua.yu@intel.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org, Greg KH <gregkh@linuxfoundation.org>, Palmer Dabbelt <palmer@sifive.com>, kstewart@linuxfoundation.org, pbonzini@redhat.com, firoz.khan@linaro.org, yamada.masahiro@socionext.com, longman@redhat.com, mingo@kernel.org, peterz@infradead.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..77c1428cd945 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool y
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.21.0
