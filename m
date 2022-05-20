Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49CC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 11:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348794AbiETL5Z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348814AbiETL5V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 07:57:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E43A72C
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 04:57:18 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F71B402F0
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047837;
        bh=IrJRmi5AylxlMjpRypcc8BFU8eV/I3jeS/028ygI84I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=W2LmZ8p1+4iiWzPsg/eTiQBSOXnzESYD+kkwVaAPgPRUecmcCOeAW9UGIFGNGfyyo
         OlrV+LBGjTMVdwzveHCB0QeI3MB83n7k6RdqhU7efoN9Ul4dN2o+rrfk+3n5NkByR2
         emSuiRumw9d4kWHOsec+RgcfXyMxxnLLFGJdTeI7S0bUorrwartBMqPn8da+ecrf7v
         SvVp3oL19XQTysqMGKA8+Ew24H2s7ybMZZ0UUqI24iO4meY+KCvSDuIaMxyXEF8YZj
         UoM2XK81ORfnCbVbmhrhBGxnU2kGfna742DAISng5ddlMXV/tZq53Gq38OEqOEPloj
         nenRwAADtlDJA==
Received: by mail-ej1-f70.google.com with SMTP id qb36-20020a1709077ea400b006f45e182187so3894426ejc.14
        for <linux-s390@vger.kernel.org>; Fri, 20 May 2022 04:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrJRmi5AylxlMjpRypcc8BFU8eV/I3jeS/028ygI84I=;
        b=kzI4hb2U0pTOUt+sdkXAS/LDZXKvkL9IbofGGhfr8FLD4iFx+0KtGi3ohS/y+THEdY
         Z5n6S537pY9FkEnPgu0hevYHvMFRELazcPehc7Bh9nCBaGO0S+h+8V5gOcCT4UjSdJhH
         rDQX+DFp/eWij6ogxT3NMyPhjVjgaFm0HzJ7O/aaTI5STQf18qkcc2pu1xYei8UOdSe7
         b3FX5IcIDiS5ZWcqK06lhTPObel4JRC3iNlEV1MphUZNkzr6ZLxTJ+L339DRyUdCHx++
         6jdTany0WwmHU3NPS3G0SiGlIVdUhGi2GCAcXrrrziusQ12mNMsdAYOs0AgHSBEWebV7
         3CkA==
X-Gm-Message-State: AOAM533ei1Pssi6V1XN0o3TY5HQ6ZUqd01avSSr0B2/CLA66P4d/Ik3H
        GQ+bfDVF7wcS5592UZVk8iULZ2/EMMnYGG/5PPazpfJdIqxXWEEuh4lo7dItLrXeVnF657TV6lU
        yv+idrkUImqp+ENRhb+RMMoZmKQwFSqhzJ+5QJBM=
X-Received: by 2002:a05:6402:34c2:b0:42a:f4da:5aa0 with SMTP id w2-20020a05640234c200b0042af4da5aa0mr10262571edc.260.1653047833820;
        Fri, 20 May 2022 04:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2s0EaRhVoMr9T7xvlSBA3I2jqCC/ZSF868KNzlmYWVfHrBmT0n59jDqNhraJB/bedEh2XMg==
X-Received: by 2002:a05:6402:34c2:b0:42a:f4da:5aa0 with SMTP id w2-20020a05640234c200b0042af4da5aa0mr10262556edc.260.1653047833614;
        Fri, 20 May 2022 04:57:13 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006fe88802203sm2946451ejb.46.2022.05.20.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:13 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/2] s390: Kconfig.debug: Fix indentation
Date:   Fri, 20 May 2022 13:57:08 +0200
Message-Id: <20220520115708.147841-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520115708.147841-1-juergh@canonical.com>
References: <20220520115708.147841-1-juergh@canonical.com>
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
 arch/s390/Kconfig.debug | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
index e94a2a7f6bf4..c4300ea4abf8 100644
--- a/arch/s390/Kconfig.debug
+++ b/arch/s390/Kconfig.debug
@@ -14,9 +14,9 @@ config DEBUG_ENTRY
 	  If unsure, say N.
 
 config CIO_INJECT
-       bool "CIO Inject interfaces"
-       depends on DEBUG_KERNEL && DEBUG_FS
-       help
-	This option provides a debugging facility to inject certain artificial events
-	and instruction responses to the CIO layer of Linux kernel. The newly created
-	debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
+	bool "CIO Inject interfaces"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	help
+	  This option provides a debugging facility to inject certain artificial events
+	  and instruction responses to the CIO layer of Linux kernel. The newly created
+	  debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
-- 
2.32.0

