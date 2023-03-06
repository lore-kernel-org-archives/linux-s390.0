Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22094C6FD19
	for <linux-s390@archiver.kernel.org>; Mon,  6 Mar 2023 10:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCFKZf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCFKZc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Mar 2023 05:25:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268E23110
        for <linux-s390@vger.kernel.org>; Mon,  6 Mar 2023 02:25:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h14so8238694wru.4
        for <linux-s390@vger.kernel.org>; Mon, 06 Mar 2023 02:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+ybm5kRJ/yopWCa5U60FTtFVB//Mx8KShs1YeyPeDk=;
        b=VlycwB8hzOW9PVDwiHzu8l5k/quntXrG5VLkAdaIUu+/LZCsC62+PMUXQUNH66i4Un
         YUr9PSMjdim9JJVp0F/a2lCvx6Dfm4lHivR6dyGvTchP3bcl02II04OrcXPhLuJXC68I
         hFAZ56aFTu0sT4cOr9/aG7bDGWiPIOGa3i+I9TDtD57f0bhZLgiK9s6H6nPMJNIirSh5
         3L9OPB/FnM19Y8dZkKeKnuXREhgl6zSf/NqYvjRKKbFiXLNRab21fQ3koK19T+QK7UeG
         tKqz6Lyq6ZoOeVSc9TkrOeWO2POmCSVfI6pjP0fJ1mCCRpUfByX5yb5R9ss+54U+8PpK
         AG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+ybm5kRJ/yopWCa5U60FTtFVB//Mx8KShs1YeyPeDk=;
        b=CDvTfABoxl8DNUaTynPiirDpfYDJhPXpbFDb0nmcxF+BajgUVPANzgL5x8Rw+WWR16
         VViHQ03WCwc1EpxCJbA0lZpE1WQ9aFSgXFxF8/EZITXIzYqZg5V0edWxypUN4kldU+NG
         eVVrXiyELRpE7ZBLPc/eAk9mUiwYgWW5vgEu9gFTlUkEKfZRwO8AiLLYeIndKBnz9ytO
         Rv0N4G4I8msJUFO5OmlauKyW7v8/CbWD5hLMZbDSjWuGv7prWHBL6znQjEJo5M4xbGlY
         Tf8pSccAeeu0VpRPgcSCD0nzhkGG2uJQrAf9MewhSgnGmLBK303IHz6FMqNmxsYEXmZU
         DL+w==
X-Gm-Message-State: AO0yUKVlXIsnoOGhg+rGkwL+CpVtftSRcHLLN9G052QdBlH5FwZOkeWf
        oaOcEscrifAxHIn8lSd+6P52Lw==
X-Google-Smtp-Source: AK7set94cTKKb7k88vdudKOJ64sJrcPXn8BrGA9ye0HB30JkyjiZxJZV4O6iTHRJH43XJ6BrpN1Yyw==
X-Received: by 2002:adf:e887:0:b0:2ca:67bb:11ba with SMTP id d7-20020adfe887000000b002ca67bb11bamr6856201wrm.34.1678098316456;
        Mon, 06 Mar 2023 02:25:16 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c170a00b003db0bb81b6asm9613294wmn.1.2023.03.06.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:25:16 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
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
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 19/26] sparc: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:05:01 +0100
Message-Id: <20230306100508.1171812-20-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/sparc/include/uapi/asm/setup.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/setup.h

diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/asm/setup.h
deleted file mode 100644
index c3cf1b0d30b3..000000000000
--- a/arch/sparc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- *	Just a place holder. 
- */
-
-#ifndef _UAPI_SPARC_SETUP_H
-#define _UAPI_SPARC_SETUP_H
-
-#endif /* _UAPI_SPARC_SETUP_H */
-- 
2.37.2

