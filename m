Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B0C76196
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCODFa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCODF3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DEC5C9E0
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cn6so4766633pjb.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849527;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnoQUwQmFqPgSrJHWK8d2p9DXhKQ1/cuEoil7CNd3DE=;
        b=TBNUeSBfuBa3ST4mxm1DS4OFwR6VEct391KodjBQ5eDMwvy7IAnH77PwGo1apR6bPh
         K7nIjhi/uZYJG5kt+DE6phOd9LZqfl9BFT5eMievU9L2UTVHzq36Jl6MFMdA5ssdKwUN
         gDJDd53OvmzgZShoscboUxRy+5c9II5aP7YLMLZ2PLDTbZH0uvz7j7szJopkCepK9dLm
         cA4Pv0tR7bnX1Y0V928WrhCq3OiYKHIIoWOc6+RX1qFGNwbibAeVMdjD8hiDrKwkQ60x
         sSkJH1wnncA5VLaZOh78cNkPD05vCaLhXPKstDORhMzPYnnwWiQ2oq7R2RYY4UnVQdNk
         6WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849527;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnoQUwQmFqPgSrJHWK8d2p9DXhKQ1/cuEoil7CNd3DE=;
        b=pU4jsqPhLBN2J9f2GE0EluGHUSehW0qdoO9/ayiHp+VKXopGE2amhG4bfE3nA3lbOH
         1B34mTeEPxGsY+aT2DMGy8Z0KmiWzSubsuY1QzqtXYBHGVO2WWHBpskZ9TBUTmg3zfMd
         yh9QYxLtT5yOE7pD4gB+IEk3aeLmZ+PB0yN/kOfUud6JL2OonBD36V2irR1hG/N8dE1J
         b9gqbJIEFzX7ZzMbWzaFo3/or0dHoo2Yt9oknz2RWyCk70Gu2FedbtDGOMoywcijjQ4M
         eIq70mAg1u4aWdLSZtZTwkjw++xk/3W/wSO3byLdqSitI1xv7OC27x3XtiAgIi/st3s9
         XzFA==
X-Gm-Message-State: AO0yUKWsLn8m0RN7HYwGqRbdSoATW/f0cpM0fEdPBMR3RHYwjV2jN+2C
        NT+XTx8IEbr2+ZwqOI9k9Iping==
X-Google-Smtp-Source: AK7set9+C9cPA06JcNB4chJKZnGHWdotuV162jlrieE+Q24dYD3lVPW20yRGsbK4VhdL3hYON+iG1Q==
X-Received: by 2002:a05:6a21:338c:b0:d5:4dc:16ce with SMTP id yy12-20020a056a21338c00b000d504dc16cemr7106582pzb.4.1678849527626;
        Tue, 14 Mar 2023 20:05:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z20-20020aa785d4000000b005e093020cabsm2305210pfn.45.2023.03.14.20.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:27 -0700 (PDT)
Subject: [PATCH v2 2/6] mm: Add a leading 0 to the VM_FAULT_* types
Date:   Tue, 14 Mar 2023 20:03:55 -0700
Message-Id: <20230315030359.14162-3-palmer@rivosinc.com>
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

The next patch will add enough codes to need another character, this
adds the 0 to all the existing codes to keep alignment.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/linux/mm_types.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0722859c3647..fd9b863869b4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -941,20 +941,20 @@ typedef __bitwise unsigned int vm_fault_t;
  *
  */
 enum vm_fault_reason {
-	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
-	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
-	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
-	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
-	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
-	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
-	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
-	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
-	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
-	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
-	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
-	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
-	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
-	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
+	VM_FAULT_OOM            = (__force vm_fault_t)0x0000001,
+	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x0000002,
+	VM_FAULT_MAJOR          = (__force vm_fault_t)0x0000004,
+	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x0000010,
+	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x0000020,
+	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x0000040,
+	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x0000100,
+	VM_FAULT_LOCKED         = (__force vm_fault_t)0x0000200,
+	VM_FAULT_RETRY          = (__force vm_fault_t)0x0000400,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x0000800,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x0001000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x0002000,
+	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x0004000,
+	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x00f0000,
 };
 
 /* Encode hstate index for a hwpoisoned large page */
-- 
2.39.2

