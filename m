Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5E2C4320E
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1CA60FD7
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jul 2021 22:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhG2Wf1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jul 2021 18:35:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbhG2WfH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jul 2021 18:35:07 -0400
Message-ID: <20210729222543.098828720@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6Hlz9b+gfajEt7fjlrTSAgtd7anX3wLVI1HqGJ1v/ZE=;
        b=1eQY5WI6T8vk8Is8/rdugbsg8/M8i3OlzgWpApUVPOHK27VqtdHGXq2SSSiN/s/Kj+too8
        M/a6E0SE+dLKoqmbbqjGnv8sh1QDnXmGolpfP6aiTeOOwHUztPotFqDkWXOsfrYT+imhX8
        AwU3SGZmh4XC0v+/4ne5DkDSakDCQxAkN+/vwuLg8RLFDgbIFUaUvBS0Z5jMmrCHDe/UYA
        oWwdPYUtK7imf28U7zxUGCQp2AXuVtqvP9R2w9HjMZbk8hIKZRjX02UU60c4bRtL/Y+V93
        qapxcwjK0QrPPRfQ1BJHyMbnapDJliNWMhXKd+ep/cjA60W3u/JPIF6Haw6oHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6Hlz9b+gfajEt7fjlrTSAgtd7anX3wLVI1HqGJ1v/ZE=;
        b=ar5xjcPRfN+qCCD6kJ6f+TNGmtzFvu534AEiUL76KoIvLBzo2LbIsjg3LUwcB9kmk719en
        cUpUbk6Lzzyp7JBA==
Date:   Thu, 29 Jul 2021 23:51:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 15/19] PCI/MSI: Consolidate error handling in msi_capability_init()
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Three error exits doing exactly the same ask for a common error exit point.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -659,25 +659,16 @@ static int msi_capability_init(struct pc
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	ret = msi_verify_entries(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	ret = populate_msi_sysfs(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
@@ -687,6 +678,11 @@ static int msi_capability_init(struct pc
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
 	return 0;
+
+err:
+	msi_mask_irq(entry, mask, 0);
+	free_msi_irqs(dev);
+	return ret;
 }
 
 static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)

