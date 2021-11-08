Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DAC433FE
	for <linux-s390@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F34C61207
	for <linux-s390@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhKHKP7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:15:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238549AbhKHKPX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:23 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3A2A1EC0528;
        Mon,  8 Nov 2021 11:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTGviVrkJtoUIT++uIt9iUfOplAtk1ARh06fr945E7Y=;
        b=LWt1g1khm25IgKX8cUlUchkMDKG4PJwa6C1IxobL/UkA4uO/j6kbewklULBwA4tY7lDTrn
        V2kTWsYLhmNNiYUTBJ1wwX5gbhV9hZk2GT2q8qxLO3D9J7oxX77GxzmYEBeI0JQ7LczmaH
        Vehoko2zyVP3iuyk0s0MSgrh9DYjmLI=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org
Subject: [PATCH v0 36/42] s390: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:51 +0100
Message-Id: <20211108101157.15189-37-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/ipl.c         | 4 +++-
 arch/s390/kvm/kvm-s390.c       | 7 +++++--
 drivers/s390/char/con3215.c    | 5 ++++-
 drivers/s390/char/con3270.c    | 5 ++++-
 drivers/s390/char/sclp_con.c   | 4 +++-
 drivers/s390/char/sclp_vt220.c | 4 +++-
 drivers/s390/char/zcore.c      | 4 +++-
 7 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index e2cc35775b99..3b1dceede55c 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2069,7 +2069,9 @@ void __init setup_ipl(void)
 		/* We have no info to copy */
 		break;
 	}
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb))
+		pr_warn("Panic notifier already registered\n");
 }
 
 void s390_reset_system(void)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c6257f625929..11b325724272 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -325,8 +325,11 @@ int kvm_arch_hardware_setup(void *opaque)
 	gmap_register_pte_notifier(&gmap_notifier);
 	vsie_gmap_notifier.notifier_call = kvm_s390_vsie_gmap_notifier;
 	gmap_register_pte_notifier(&vsie_gmap_notifier);
-	atomic_notifier_chain_register(&s390_epoch_delta_notifier,
-				       &kvm_clock_notifier);
+
+	if (atomic_notifier_chain_register(&s390_epoch_delta_notifier,
+					   &kvm_clock_notifier))
+		pr_warn("KVM clock notifier already registered\n");
+
 	return 0;
 }
 
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index f356607835d8..52b441b29fbc 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -865,7 +865,10 @@ static int __init con3215_init(void)
 		raw3215[0] = NULL;
 		return -ENODEV;
 	}
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb))
+		pr_warn("Panic notifier already registered\n");
+
 	register_reboot_notifier(&on_reboot_nb);
 	register_console(&con3215);
 	return 0;
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index e4592890f20a..0ce25924fb18 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -641,7 +641,10 @@ con3270_init(void)
 	condev->cline->len = 0;
 	con3270_create_status(condev);
 	condev->input = alloc_string(&condev->freemem, 80);
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb))
+		pr_warn("Panic notifier already registered\n");
+
 	register_reboot_notifier(&on_reboot_nb);
 	register_console(&con3270);
 	return 0;
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index de028868c6f4..42bb2ddaf791 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -285,7 +285,9 @@ sclp_console_init(void)
 	timer_setup(&sclp_con_timer, sclp_console_timeout, 0);
 
 	/* enable printk-access to this driver */
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb))
+		pr_warn("Panic notifier already registered\n");
+
 	register_reboot_notifier(&on_reboot_nb);
 	register_console(&sclp_console);
 	return 0;
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 29a6a0099f83..89cf7a7b0194 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -836,7 +836,9 @@ sclp_vt220_con_init(void)
 	if (rc)
 		return rc;
 	/* Attach linux console */
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb))
+		pr_warn("Panic notifier already registered\n");
+
 	register_reboot_notifier(&on_reboot_nb);
 	register_console(&sclp_vt220_console);
 	return 0;
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 3ba2d934a3e8..0bf28583a3b9 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -323,7 +323,9 @@ static int __init zcore_init(void)
 					     NULL, &zcore_hsa_fops);
 
 	register_reboot_notifier(&zcore_reboot_notifier);
-	atomic_notifier_chain_register(&panic_notifier_list, &zcore_on_panic_notifier);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &zcore_on_panic_notifier))
+		pr_warn("Panic notifier already registered\n");
 
 	return 0;
 fail:
-- 
2.29.2

