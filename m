Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA78C7EE39
	for <linux-s390@archiver.kernel.org>; Thu,  2 Mar 2023 09:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCBJus (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCBJub (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Mar 2023 04:50:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFE4345C
        for <linux-s390@vger.kernel.org>; Thu,  2 Mar 2023 01:50:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g3so7015662wri.6
        for <linux-s390@vger.kernel.org>; Thu, 02 Mar 2023 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idYCXIp655Ab81Nczde08CzuCRs/GqKbYJdOtnXaBl0=;
        b=dY4nMA6MIJG3fqoZn6cWV7Von83Lc0x1Euxe+EWA3PM9Nn9Pxq0mUH8Uydkm4CoZ2A
         1TRBkgnyUzTA4XgHfPMO9mU9xcWLmxnFKybR0v6WM5MRkJf65egPQvN3q2unssWMYZBx
         u3WvHFGbn53G3b4wnHX2ENZa3SUAAh81J9n4EkQi7fI3lpY8Wyvcz3cyZ8C79Mqrlot4
         XiYcQ7a+Ql66IcBdDbinU5Ah5bQRXBJDeBPKr3WJ9O+X+4v9dc6xbj7kgEgUVsaJoqFk
         XMjbLNtmIXlOx4LEIeUYXzGZLdODHKjjTgWsgrEYeim3IwWT+mUOIS47OCKGx5SDTOwZ
         Hvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idYCXIp655Ab81Nczde08CzuCRs/GqKbYJdOtnXaBl0=;
        b=mGJJCbm0D2+VgOrt05QfdWkHQaVxFH6DBVGMcz2AqXpSXc6FpNk1RJP87cF6rserIv
         CPRNlX+8SkTOI7lIPL+0675C8ioDPR2rYSpunUpVrl43jz4zjNdailn+nssKNN29931/
         32ykHarHCAOS+9bbN1CDmQZzyZzxPxqMJJXbJ6IJ7WztcH7C0vF5YkQDFU9Y7kyEPEEm
         aq73DYFdA8l4i/yPXauARJZ6VefAWsjZKkAKYb9bcI94a+4oKTX7IecasI9Rm8lwH+9l
         SzZ7KdnwCZMc4LmTveohVUHjchoSEAvRlL1cWhM/XwWtxJV6m7ZeZSxBb27WOkVlDX9d
         hEUg==
X-Gm-Message-State: AO0yUKXdAH+63+ILOPoVThi4DlLVIdlMc1v9FSvtpgxx7LOEJSh8PdiB
        SYm+CCC4eRIuzsvs1uKEM32a3Q==
X-Google-Smtp-Source: AK7set/Z/nu62r61HIUYvdDZs4gz5GwOOC+pnLkKj34Io66Ad5aUaKaZBVv/KVU3q1Rm1U0D/wyDRQ==
X-Received: by 2002:adf:e745:0:b0:2c5:a38f:ca3a with SMTP id c5-20020adfe745000000b002c5a38fca3amr975140wrn.10.1677750606279;
        Thu, 02 Mar 2023 01:50:06 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id hn4-20020a05600ca38400b003dc5b59ed7asm2400563wmb.11.2023.03.02.01.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:50:06 -0800 (PST)
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
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 14/24] arc: Remove empty <uapi/asm/setup.h>
Date:   Thu,  2 Mar 2023 10:35:29 +0100
Message-Id: <20230302093539.372962-15-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302093539.372962-1-alexghiti@rivosinc.com>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 arch/arc/include/asm/setup.h      | 1 -
 arch/arc/include/uapi/asm/setup.h | 6 ------
 2 files changed, 7 deletions(-)
 delete mode 100644 arch/arc/include/uapi/asm/setup.h

diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 028a8cf76206..fe45ff4681bc 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -7,7 +7,6 @@
 
 
 #include <linux/types.h>
-#include <uapi/asm/setup.h>
 
 #define COMMAND_LINE_SIZE 256
 
diff --git a/arch/arc/include/uapi/asm/setup.h b/arch/arc/include/uapi/asm/setup.h
deleted file mode 100644
index a6d4e44938be..000000000000
--- a/arch/arc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/*
- * setup.h is part of userspace header ABI so UAPI scripts have to generate it
- * even if there's nothing to export - causing empty <uapi/asm/setup.h>
- * However to prevent "patch" from discarding it we add this placeholder
- * comment
- */
-- 
2.37.2

