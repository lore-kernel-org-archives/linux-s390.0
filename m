Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BCFC38159
	for <linux-s390@archiver.kernel.org>; Sun, 21 Aug 2022 11:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiHULgu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiHULgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Aug 2022 07:36:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29126AD4
        for <linux-s390@vger.kernel.org>; Sun, 21 Aug 2022 04:36:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d5so4262778wms.5
        for <linux-s390@vger.kernel.org>; Sun, 21 Aug 2022 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JBm3JbYzVZyjjb4o90s9QqDUxEn4h4q/mRrSSGBV0DA=;
        b=Ndo3cUOFcvU9vobg4ECMxbbBto0GCzZXLsi58Tc0a+aRUV5xaiUrQ1WE7WGMGonuyM
         pWjbfzMTxC3WZgc7Kd0dzvv55RE+rugIoVU2gm2JxNlyXxX9JvbfPqO3Wty5HComkoNy
         z/FrSVdRGmSxD9J/eeQS+gl4LKuNcnIyYhmaQk9x7zmNI/cHYJ6Crrta8wcLAAZP0Vvm
         849bGJo2CDf1HG1GvbOSuL5QodydxN1S9/JynQLmjaY6zPYxKiVXg8b4sMMwqt3psm61
         gyMTlAo4Cdjc4j6KyvB94c1XgT2tVCzfF/EiZnUD3iXReG81rvWzDLu4vp4rZTEsjGL4
         ygbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JBm3JbYzVZyjjb4o90s9QqDUxEn4h4q/mRrSSGBV0DA=;
        b=ppkpuJFpU2VEx3egHZArzG3wUTLhbshiI6C7WhK7BKUMAHCQYt+W48J7yqzvEQx3ZH
         LfFWI7+3UJwb3mp1nNRNCH6IAXVMKTkv19S2cIb494W7h/QBXnQHfbIZnv9XSZ3dDDFw
         7WGPSe+JF9E6l4pfqRcbBMJm11yNimcpv+BvFEJf19OoqalWev2qXvitgxqXk9WQhtQ0
         JsQOLfpB2lT6HhdVw4Fyv42fonaR4vqVzLSD3FKhXgSuaFYk6P1JLyQwYvETQf0B3wDT
         SGVn/u1kZs3ms0GfO9A/CLRDgviJqiDw5h2TqF2ZwRCkkcOqb1fXo1aJav2Gh9dR7t9Z
         IrJA==
X-Gm-Message-State: ACgBeo2BCwOchy7FrS8lU36SjcWxagMtkFAvhORmacWFwGvCgj4E2YJ1
        zPPoBDEDCt6XjtlaFKmp6JCUJg==
X-Google-Smtp-Source: AA6agR7fUuguxyVoajzO5r2IzhUFn/jBjXj29sCwHWGo+An40pD5GMxu5Abtd+UzorNvMppKEiQWPQ==
X-Received: by 2002:a05:600c:3ba0:b0:3a5:b73a:8773 with SMTP id n32-20020a05600c3ba000b003a5b73a8773mr12497956wms.64.1661081785402;
        Sun, 21 Aug 2022 04:36:25 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:24 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michal Simek <monstr@monstr.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 5/6] sparc: use the asm-generic version of cpuinfo_op
Date:   Sun, 21 Aug 2022 12:35:12 +0100
Message-Id: <20220821113512.2056409-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220821113512.2056409-1-mail@conchuod.ie>
References: <20220821113512.2056409-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

There's little point in duplicating the declaration of cpuinfo_op now
that there's a shared version of it, so drop it & include the generic
header.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/sparc/include/asm/cpudata.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
index d213165ee713..af6ef3c028a9 100644
--- a/arch/sparc/include/asm/cpudata.h
+++ b/arch/sparc/include/asm/cpudata.h
@@ -6,8 +6,7 @@
 
 #include <linux/threads.h>
 #include <linux/percpu.h>
-
-extern const struct seq_operations cpuinfo_op;
+#include <asm-generic/processor.h>
 
 #endif /* !(__ASSEMBLY__) */
 
-- 
2.37.1

