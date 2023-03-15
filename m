Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C343C7618A
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCODFf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCODFc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF65D74C
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h8so18622079plf.10
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849531;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7SkdlXoEaWhStocARTpgdbab7cejcOgFmxzTVFGnrs=;
        b=gbSrb4xKWKUDpev+5xTldKtMAFbHj3vLwF3cqvdmErbeXSowCRx3W1Kku5VNtF25hQ
         JGkCLa2+KeTI18PILqbYkEHjYMXhVfMCNMqgjJpNLqUaCjh9zvONRwuCi/E/YW4FmmML
         REtcE7XQJ857RwYQlk6ALlq0ZQyrnFYldifPs5Jz+dyuB6eKFWhEduRI01G30w/4EfT1
         1Zrdtjd+hz2mImHV62PQNbWSbo7NIeuj61fPS4UZRIH4BIrNvbJhqdFctPR80fXQ8Ma6
         7SAbNL/Xuhqf/qhPu11eD9USle9U7StUR3J1PIzOw1/jd6mYdDgvCWR6PHnQYw0mTs8Y
         uSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849531;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7SkdlXoEaWhStocARTpgdbab7cejcOgFmxzTVFGnrs=;
        b=5tVTcWqABy5TFA0tDoGK5Ql0F21QBVf/cfWyUFd0SCBQZ9RFIOXPXffegByrMh4KgF
         rmKt/FPLa0hgnVEpXUUv8pZtAbBlw+KEsq3ytyjIez+XRrbrg0V0eGFlCkPSKI/DAF0u
         /2GJLudyDAA0zB9Md4GXvYkVpCSRPYJPg/TWLAixG1L+rsMlw6lzzMyB+up+kIbtX9kS
         z7m5qi8dDB8FS55gY2P7xOfuX8yhI9IEOajGR61xGkmsDljSOrMvR82Ia6b3J694mS8d
         sJK/QFIFC9HFwnNL8qunJSvrPYhz5RqSiYShh2esXrpHz2YWXXHPUfXUCg7XM4BSEVtP
         YtqQ==
X-Gm-Message-State: AO0yUKWlw+6apoz2SCx+QC82Qk59zMffi4QVUAQm77vAUDF3FgnHxoe8
        Bt0VVYaQFG57vtoxyJZkIhjnKA==
X-Google-Smtp-Source: AK7set/LWO7bSRcbqzHLXpJ39gzf25G0Nz1mn+fYaEHT27G9psc0wa3GwCdvpFZwdrwZQMOaakTGEQ==
X-Received: by 2002:a17:90a:f3ca:b0:23d:3a3f:950b with SMTP id ha10-20020a17090af3ca00b0023d3a3f950bmr3857400pjb.22.1678849531021;
        Tue, 14 Mar 2023 20:05:31 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0050927cb606asm2185261pgg.13.2023.03.14.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:30 -0700 (PDT)
Subject: [PATCH v2 5/6] arm: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Tue, 14 Mar 2023 20:03:58 -0700
Message-Id: <20230315030359.14162-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315030359.14162-1-palmer@rivosinc.com>
References: <20230315030359.14162-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     akpm@linux-foundation.org
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
index 2418f1efabd8..c57ea332ca97 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -216,8 +216,8 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_0
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_1
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
-- 
2.39.2

