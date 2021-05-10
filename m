Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E9C433ED
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 05:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977E8613DE
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 05:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhEJFd0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 01:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhEJFdZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 10 May 2021 01:33:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9718DC061573
        for <linux-s390@vger.kernel.org>; Sun,  9 May 2021 22:32:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s82so8410430wmf.3
        for <linux-s390@vger.kernel.org>; Sun, 09 May 2021 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZFyRgnmozKWjDN/kAe3guEn8n3Orb4vZ0XP7AzqXLc=;
        b=se4yo5p/7v89/B+jP0qYSrP1GZMc7a+WwVscInYoPdPwBzHi7RV+lLfspiYLSYhylR
         vBESCTq7iKOlozd64MinJHsikhN72MLxPPWe6DjS0rqx4UrO6Taqt8HzLJrstO3QFIFh
         O4Fiew+Bu5712/LL/1IopbgXez9wCCGBq1lTKRtGm+h8S6hCLlQK5V9Np1VSLzlCaH5V
         1gHCB5YaTAXccHPGUXfs561EFsMzjGMUi9oIBh6aon2Nq0mfe+ucA6v5hrc9HFrqdgii
         JOXoPEGVhdkCdiPdiMhknH88xSAGEvvqyYJYWyZWcEr4z/U1NqqycvsuX2RLF4nRA1Hz
         Ocuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZFyRgnmozKWjDN/kAe3guEn8n3Orb4vZ0XP7AzqXLc=;
        b=YwxrshiTTMMOloky3BEvS+LNOp8aeL3CCLFJnk1BHvrqOXFrdK2qU2B1gphfTDE7vx
         mbS/hff5mtqMXg6yp15Cq7MvdSLMtH40qF8dhfVIBmeC1edfj9ZcYyBP7EuHp4xQMzZE
         MU2mRsgA7+D1J4XkfSGJG+qX222YlGbikXk+TAxkRdd7kYdEjOi4hqqq/dEOamj+Oxgv
         V1YUih315y3TND7sIEGxcnqRW7gbJ/Tn7wE0Sf7f1nEjsI6PdNuofvzVx6PXQxgLKWDj
         EOUSav6Ex/uItRNN9DgCCqYkNeNUXzjzEVXzYb3kfnDmEWvJqZg1GwU+He7Mjr5gs68I
         pGuQ==
X-Gm-Message-State: AOAM530WzZSDIiy0lHnrSGTgVwH6A03elviIp6D5aSgcfalh9iwjZfax
        cwz2khZGil7NAg6c5j4jo/WLag29kRw=
X-Google-Smtp-Source: ABdhPJzpU6XCHEs+6FkctmD93cwcVBssyU36fJGjtNzrH+0ILmJoY4Vz8Nr5Gx7H/+PzF+8t+cAXzQ==
X-Received: by 2002:a1c:9a83:: with SMTP id c125mr34752978wme.62.1620624739136;
        Sun, 09 May 2021 22:32:19 -0700 (PDT)
Received: from kali.home (lfbn-ren-1-1383-171.w86-229.abo.wanadoo.fr. [86.229.230.171])
        by smtp.gmail.com with ESMTPSA id j13sm25722316wrd.81.2021.05.09.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 22:32:18 -0700 (PDT)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-s390@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] arch/s390: disable SSP when needed
Date:   Mon, 10 May 2021 07:31:33 +0200
Message-Id: <20210510053133.1220167-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Though -nostdlib is passed in PURGATORY_LDFLAGS and -ffreestanding in
KBUILD_CFLAGS_DECOMPRESSOR, -fno-stack-protector must also be passed to
avoid linking errors related to undefined references to
'__stack_chk_guard' and '__stack_chk_fail' if toolchain enforces
-fstack-protector.

Fixes:
 - https://gitlab.com/kubu93/buildroot/-/jobs/1247043361

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 arch/s390/Makefile           | 1 +
 arch/s390/purgatory/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e443ed9947bd..098abe3a56f3 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -28,6 +28,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
+KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index c57f8c40e992..21c4ebe29b9a 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -24,6 +24,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
+KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
-- 
2.30.2

