Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3129C6FA8E
	for <linux-s390@archiver.kernel.org>; Thu,  2 Mar 2023 09:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCBJxr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCBJxQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Mar 2023 04:53:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0132B11165
        for <linux-s390@vger.kernel.org>; Thu,  2 Mar 2023 01:53:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f11so3998418wrv.8
        for <linux-s390@vger.kernel.org>; Thu, 02 Mar 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZHaQjAFpi9TJWHqFM+95KfED/Q/8XVJn3AfBj+QDY8=;
        b=Nx4N4DdfyFWmONBZABZS4Pm48hFk0i7XpSeJxFrM1IdkfpJbDeyx2UyPVjtHwnvx3a
         lpJXWjSvdy1yA0+hsNHtFHR7RAp9b0Z0XO4k4icMtyTCMym42JBufqEzKgEBwsOsjazw
         /c7TRJTAU4Nc8WHkQHpKc4GVUwoLceyqRnQjvnYnGOpH2u7mKNaRPZtCGDvInV5yov12
         JFsF8t1MvvdfsRhJQjY6N65bWxYp11k2qdDBiH4IhSi5lTyWuaqar1mM2sU6+8fhAPHw
         ib++0c+6bL+olAEsz3JXTuqgqGgSJHpnVL3Rm6fHw46S19nREvykZzaIRYjbTis2Y08+
         sXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZHaQjAFpi9TJWHqFM+95KfED/Q/8XVJn3AfBj+QDY8=;
        b=oYoH2b740vu0dW9wGd/Sja12dZjhQZEiFM6Q81lgYvYIKmMbDGwhbLgAcUP1T+UqZ8
         cHjtGIo6C4+elDYiZzj/g7nf/U3iv0wxybinEPalIrH1hou7hu58jYOjvsK8TRDXjJn5
         m1ihPXXqEAqEm6Vm9fEKM4sAdjGxondP8PKE/bfvFu/l2GJbU6IJfwhx4LpmL/w1Gmy1
         UdjtmFd7AElspmY/hsixX2OKlcMttqk1FHucWlPePCL9h6EsdzHkd0Z8ChxpI17InrWp
         xtJNqnGfgc5P1P2Ea9QyGxCROxg07wuYTEolaCNg1gxZQiIroZEOR8jP/kicWo+ngHwr
         2dnA==
X-Gm-Message-State: AO0yUKVWFQ6gSEWYZi6KtRmYYWIr/G24nN25CT9IQ8DmSAPG++5qxSHM
        ZW61cVpo2KbeOlJA8WnInFhZDg==
X-Google-Smtp-Source: AK7set81+J76ESnZZm3oyyxTlRUvfii3Bic87MlN7SxfDicQQ8S1GtBwYUf9j+RljuZEcb8UvRCRMQ==
X-Received: by 2002:adf:cf04:0:b0:2c7:19c1:5557 with SMTP id o4-20020adfcf04000000b002c719c15557mr8383081wrj.64.1677750791453;
        Thu, 02 Mar 2023 01:53:11 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b002c55efa9cbesm14490820wrr.39.2023.03.02.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:53:11 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 17/24] microblaze: Remove empty <uapi/asm/setup.h>
Date:   Thu,  2 Mar 2023 10:35:32 +0100
Message-Id: <20230302093539.372962-18-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/microblaze/include/uapi/asm/setup.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 arch/microblaze/include/uapi/asm/setup.h

diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
deleted file mode 100644
index 51aed65880e7..000000000000
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
-#define _UAPI_ASM_MICROBLAZE_SETUP_H
-
-# ifndef __ASSEMBLY__
-
-# endif /* __ASSEMBLY__ */
-#endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
-- 
2.37.2

