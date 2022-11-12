Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3924C4332F
	for <linux-s390@archiver.kernel.org>; Sat, 12 Nov 2022 18:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKLSr6 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 12 Nov 2022 13:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLSr5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 12 Nov 2022 13:47:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C21570C
        for <linux-s390@vger.kernel.org>; Sat, 12 Nov 2022 10:47:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668278873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CbukfNTOkvuyVF/BaGF0anCAeWGlGVb87Bp6YJX/2SA=;
        b=zA1+SFSPOj5ecQviKKukJElzZ7jjLXP3gW8FUQZ/Pf4TC98UNS2PQ2JaRA/zk3SVzBTtbz
        Io2bVpvZnOgU5AfEAlXx/cW/u1n5yxKwYeRgX3P4OXJrbUdECm9hqts6TkbFMJtW6M540N
        cejO4alpXpsV4K7veXxabcbOeO/cWuGm4MK4S6XQGAkKz9oiErZ0fR1Oids+jkfFkMli6G
        yD+WAwYlm16jtywihjuV0ciaAOp8t4/4L6ZHqpa/ounKBaK+dufM7Li1/jtTHLelH5I9fI
        DV391xWI4RriyxIs70Yg0/lEfziHBEtHYtcRl1uOnLwF3D/Hituw6ug14FpHdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668278873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CbukfNTOkvuyVF/BaGF0anCAeWGlGVb87Bp6YJX/2SA=;
        b=vylsEhJClr2J7on6xZaphqNWGlh5qxtjcuFkK7VexW3hjXd0geo1Aa4EDru2ciZ4It33Na
        WWQ8PXAzneIaviBA==
To:     linux-s390@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH] s390/pci: Use irq_data_get_msi_desc()
Date:   Sat, 12 Nov 2022 19:47:52 +0100
Message-ID: <8735aoui07.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

No point in doing another lookup of irq_data, it's already provided as
an argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/s390/pci/pci_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -132,7 +132,7 @@ static int zpci_clear_irq(struct zpci_de
 static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *dest,
 				 bool force)
 {
-	struct msi_desc *entry = irq_get_msi_desc(data->irq);
+	struct msi_desc *entry = irq_data_get_msi_desc(data);
 	struct msi_msg msg = entry->msg;
 	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
 
