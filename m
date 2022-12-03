Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5738C47089
	for <linux-s390@archiver.kernel.org>; Sat,  3 Dec 2022 03:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiLCDFt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Dec 2022 22:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiLCDFq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Dec 2022 22:05:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF52F4EA3
        for <linux-s390@vger.kernel.org>; Fri,  2 Dec 2022 19:05:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so6760155pjb.0
        for <linux-s390@vger.kernel.org>; Fri, 02 Dec 2022 19:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhR/DvZbp+3vR9eB4A5wFYKGQTjA+LqOJxd/xHKwNw4=;
        b=KpJKmzUqKuY7RNz1zoEByIJW90y1Livh3n8yRVCtF7Wr2SNUWd5EFqo0EjjNi6loJv
         TlFuL2eEbd8DZ8FBCGv2ReWj958YzPC2Tt8AZagpgWofFTbPz3N9Aoss5wquaRZv35pt
         zf534yNV0g0gfKF8Bxz3qsNDzOBS2wJGcO2gP6yGN2p/yU3fATEm0f/qdKSMHwBwAsqk
         jnSfc+OaPsVevmGerR1dP9afYP2sPSSOlwlnAwWpFHuq0XqOLftSexffps5iSRlfBRFT
         fJHeyOjJR8qw7F5Bxhqn6UBDRAZfg680T48PHv4bOtksy7UlERFx7XNKzkB4IIToom71
         zAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhR/DvZbp+3vR9eB4A5wFYKGQTjA+LqOJxd/xHKwNw4=;
        b=lmynZNynrT6H2gj1LoR7soGxcfOJDoRh1VUemYcjIo28STMF8IErIbpzlFP7X8DG4l
         be0oJ/r4RkPlLQsjdcLZpxTUmYiqUlIkC4NLGUFNmN11lm1Vt+2UOon/uPuwc13USzn3
         5+CloBln67wSuNwVhlWKaomGJsV2DT4KSYSMbKMJt5NIP7LD+fmeFCNux9WRdVxMFWSa
         3hEipZMXrl4FlgIDE7sGD+BW5QGWiSO9AwMN/aURMh/CSgbPJtGMZHgluyVHFX9QrnE2
         eA6pMp3ABpSqejAbwXnxFlPdZfOnvgIpiKcfQka1W6N8HyYEq2LISUcD+QKcjo5wk+ai
         LaLw==
X-Gm-Message-State: ANoB5pnLnr2swFdgiebEMeKrRG9HVIAql5FYknjMcsRnRH5J+KZZCOnk
        8Kq8xzQzGwfvHmW1N6gFqlMHEg==
X-Google-Smtp-Source: AA0mqf7bOAyepA04ituLKXHZJH3uQ4cqneDkfqNEF7GDlldsPNuzsJMKn7BDVi7Zx/YGZ+BpcYq8AA==
X-Received: by 2002:a17:902:bf06:b0:188:d3b1:dbfc with SMTP id bi6-20020a170902bf0600b00188d3b1dbfcmr57933988plb.127.1670036744950;
        Fri, 02 Dec 2022 19:05:44 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b00186c3afb49esm6182561plh.209.2022.12.02.19.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:44 -0800 (PST)
Subject: [PATCH 3/5] arm: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:54 -0800
Message-Id: <20221203030356.3917-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
References: <20221203030356.3917-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These conflict with VM_FAULT_HINDEX_MASK, so move to some designated
arch-specific values.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arm/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 46cccd6bf705..7063b875b05f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -201,8 +201,8 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_0
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_1
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
-- 
2.38.1

