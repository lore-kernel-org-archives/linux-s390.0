Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DEC48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 11:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DCE6145C
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 11:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhFOLoL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:44:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57105 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFOLoK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Jun 2021 07:44:10 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1lt7SH-0007bj-Ey
        for linux-s390@vger.kernel.org; Tue, 15 Jun 2021 11:42:05 +0000
Received: by mail-wm1-f71.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so1393355wmh.9
        for <linux-s390@vger.kernel.org>; Tue, 15 Jun 2021 04:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CYDncFNuUvtFCPbJvAJNhxcp0bRwM7nHPoRx8JOBLSQ=;
        b=ELWoPwgSCLPLlM3+jPLHKBqcsJOekPCNz2huTGdw4h4Fj7l+75bHzWjslL7WPIfn5g
         9ifottpYjF63AsANXDPSKl0v7CtBPtW5pSHFl+NFWsPcDHApEpo5SloCw03t1htQEbW0
         sMWYiVXSdCZItTNWAuB0f5mLUBC9qwJkJiVu1rar8ffdsyT/NhVV9CI+Nu4Bhu0GmlgP
         p0NysReWGG+pH/m0FAgz4WQqTnaW8VsVf88+N+jIzz6grU3/9EuaQgrOfDO5G0H3xd4+
         FehG4d2xTUzpwZgTlInourzM0oNcHATmGkaZFDTdYInrUBz6/hqS/rUnw327mFHhcxlV
         TUNA==
X-Gm-Message-State: AOAM532EWc/gNVQm9KPOn8fAPA/1wyKRzLozwZmn7jZVsZhKRcP9trwU
        HKjjhCFFJfxomloJAwZFfe1TB01NhAywgLzr2hFLbH6APMt7VENbOKUcbgANmd2xjv4v5akI/c8
        8v2mT2Hm6pK/nYB/aruOLNCfGDmkAL2CTxifyGxs=
X-Received: by 2002:adf:f990:: with SMTP id f16mr25183223wrr.340.1623757325208;
        Tue, 15 Jun 2021 04:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOYE9lZAw7L+BTijLcTg5ei2l1NBa58a2BDZyzq1Dzi2zpfv/VgRp5Qc3iid2UXmV/5e3ACw==
X-Received: by 2002:adf:f990:: with SMTP id f16mr25183194wrr.340.1623757324976;
        Tue, 15 Jun 2021 04:42:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:dc22:6ba5:a376:4d8d])
        by smtp.gmail.com with ESMTPSA id r2sm19428181wrv.39.2021.06.15.04.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:42:04 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/boot: add zstd support
Date:   Tue, 15 Jun 2021 12:41:50 +0100
Message-Id: <20210615114150.325080-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Enable ztsd support in s390/boot, to enable booting with zstd
compressed kernel when configured with CONFIG_KERNEL_ZSTD=y.

BugLink: https://bugs.launchpad.net/bugs/1931725
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
cc: Heiko Carstens <hca@linux.ibm.com>
cc: Vasily Gorbik <gor@linux.ibm.com>
cc: Christian Borntraeger <borntraeger@de.ibm.com>
cc: linux-s390@vger.kernel.org
---
 arch/s390/Kconfig                        | 1 +
 arch/s390/boot/compressed/Makefile       | 4 ++++
 arch/s390/boot/compressed/decompressor.c | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b4c7c34069f8..fdbf584e13eb 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -172,6 +172,7 @@ config S390
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_UNCOMPRESSED
 	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_ZSTD
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index de18dab518bb..75660aaaa7a3 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -14,6 +14,7 @@ obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
 obj-all := $(obj-y) piggy.o syms.o
 targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
+targets += vmlinux.bin.zst
 targets += info.bin syms.bin vmlinux.syms $(obj-all)
 
 KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
@@ -63,6 +64,7 @@ suffix-$(CONFIG_KERNEL_LZ4)  := .lz4
 suffix-$(CONFIG_KERNEL_LZMA)  := .lzma
 suffix-$(CONFIG_KERNEL_LZO)  := .lzo
 suffix-$(CONFIG_KERNEL_XZ)  := .xz
+suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
@@ -76,6 +78,8 @@ $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzo)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
+$(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
+	$(call if_changed,zstd22)
 
 OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section .data=.vmlinux.bin.compressed
 $(obj)/piggy.o: $(obj)/vmlinux.bin$(suffix-y) FORCE
diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index 3061b11c4d27..02fd0d245c7e 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -61,6 +61,10 @@ static unsigned long free_mem_end_ptr = (unsigned long) _end + BOOT_HEAP_SIZE;
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
+#ifdef CONFIG_KERNEL_ZSTD
+#include "../../../../lib/decompress_unzstd.c"
+#endif
+
 #define decompress_offset ALIGN((unsigned long)_end + BOOT_HEAP_SIZE, PAGE_SIZE)
 
 unsigned long mem_safe_offset(void)
-- 
2.27.0

