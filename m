Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCF7C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 23 May 2022 05:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiEWF6Q (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 May 2022 01:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiEWF6P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 01:58:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61B936E36
        for <linux-s390@vger.kernel.org>; Sun, 22 May 2022 22:58:13 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F8D93F175
        for <linux-s390@vger.kernel.org>; Mon, 23 May 2022 05:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653285491;
        bh=5fCLgio4eOhfw1k5CS2PLumAftaAOSFd6efiEZiEJqo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vhhaQz2imbrVUdDwJspFtl7yEoiAZHMkeskuYOFq1f+ALPzZiFGHe6PkZlofxzle4
         r9MJiACl9cbkbdy+4jYUH3t2Nah6mM77sQaGjXutqm0vrL08wmrCKBKW6InafHOkkr
         Exwf25SFDn4TSB6qO1MQ/oCHlt6Vh0hXNbRMpO2awYWx95cfYQXZ/omty4cz8O3tho
         QTIk1tOlkDWxCn2i6kDX4QHDNGzaVCE6GYrF2ih7G01YmTFASmfm51wLJbOTq8BiGo
         mhrQBflNCt/Z0FE+BB24WP3Y81+qh+La8Czpg/CoMsbp7aQM4Ssv9XM6WgQHixrbMB
         V/CD9JpyvS/tA==
Received: by mail-ej1-f71.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso5419119ejs.12
        for <linux-s390@vger.kernel.org>; Sun, 22 May 2022 22:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fCLgio4eOhfw1k5CS2PLumAftaAOSFd6efiEZiEJqo=;
        b=VjxN2SQP7WgLzPk/QHqY65d5FDbsPJvmcMrVm773Bg7a6U2759We8MnLQkvx2ngFJB
         g4OwZJtQBUJCVWF/HXB6KO+0EZAcPq6kwLUm8yrOb+bsOZ9vxLauGEuzqSumbDTbe1G+
         MMwyHF4E8X8fLwabAM3qECfLmlCXH04LGVA/oEevo4b08oQvUhIDoG34xEh8VqyY0tIZ
         BOw3hVFL4pgXwQ2T4B+BaBpYyJjaweRvT+kFFds5nIYdmH2wYHEEVFQeaYG/mOsH+WmM
         8s8nrRPib5Q7ip58RdOav6CCFQhSJUCA6EhzAbupveSr2HKjnRlQeGBX1pgq2W9LpBca
         3Tgg==
X-Gm-Message-State: AOAM531S6yW4DNZaBdd4T0tkvTHEkDY86hxHydnZQcFQo1rfRTGCFAEx
        Z5ZHN9Kr+4qMNTaKfR9u5GwHw+bb3Kh+FtUfzuATAJB3kmS5dDA5B6aJCy11acph0qIZ+bYRRiS
        wRsa4IPHw84hIsyZWVpsc/sluVUAVZ8DCmArqRss=
X-Received: by 2002:a17:907:7e84:b0:6fe:cded:7d1f with SMTP id qb4-20020a1709077e8400b006fecded7d1fmr4980117ejc.35.1653285491009;
        Sun, 22 May 2022 22:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfJtcFSbeKmiGpMnperQwR7MKkXvhirZBqreQSPSqS1L8LPlV0rM0x+Qgcxcb9LgCvBNK+zQ==
X-Received: by 2002:a17:907:7e84:b0:6fe:cded:7d1f with SMTP id qb4-20020a1709077e8400b006fecded7d1fmr4980108ejc.35.1653285490869;
        Sun, 22 May 2022 22:58:10 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bf15-20020a0564021a4f00b0042a9fcd7c73sm7782160edb.46.2022.05.22.22.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:58:10 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/2 v2] s390: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 07:57:35 +0200
Message-Id: <20220523055735.4538-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <8d86b87edc9c9fa33b6a18fac8b160ee56e6a07c.camel@perches.com>
References: <8d86b87edc9c9fa33b6a18fac8b160ee56e6a07c.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
v2:
  Drop trailing endmenu comments.

---
 arch/s390/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e084c72104f8..543e859905df 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -736,11 +736,11 @@ config VFIO_AP
 	depends on S390_AP_IOMMU && VFIO_MDEV && KVM
 	depends on ZCRYPT
 	help
-		This driver grants access to Adjunct Processor (AP) devices
-		via the VFIO mediated device interface.
+	  This driver grants access to Adjunct Processor (AP) devices
+	  via the VFIO mediated device interface.
 
-		To compile this driver as a module, choose M here: the module
-		will be called vfio_ap.
+	  To compile this driver as a module, choose M here: the module
+	  will be called vfio_ap.
 
 endmenu
 
-- 
2.32.0

