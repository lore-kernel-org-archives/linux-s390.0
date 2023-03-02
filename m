Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCAAC7EE39
	for <linux-s390@archiver.kernel.org>; Thu,  2 Mar 2023 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCBJ5F (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Mar 2023 04:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCBJ43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Mar 2023 04:56:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0A3B65D
        for <linux-s390@vger.kernel.org>; Thu,  2 Mar 2023 01:56:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h11so4169767wrm.5
        for <linux-s390@vger.kernel.org>; Thu, 02 Mar 2023 01:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1677750976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEs3yIz8iEmRFY8PICbSYz9IDFM/n81OtFDX6/s/AEc=;
        b=knISX1iT2rRR106GIUlbJC06fpznhY3A4dilwlF3bmeod/OcRdwY77WLBaAulDxb61
         Pk0zUhuXMaIpdVWHqDXDoQZZ3D3QzpQ3Ruhv1clqcbP74yLjtq6jpqGX6eesH+6oHzeO
         3cFNkLpsLel0/ACtssFKIJ3XeqH1VIntoI5WTyMPUBcqLkiJqxc6DyFl45oy9ffoLcB6
         I5E/cyonnx/gqVU4jjtrDPhZyMePqvpZyhm7gZHvwM1XibslkBs+UwOXQFGzPPAsdzYb
         KpDXTSzIiVWdMGKpc9SW2D4U9Q+S2OqdMYO+45EVoUwJ0dpEVpNAY2jfr0NIemdeGfl+
         h4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEs3yIz8iEmRFY8PICbSYz9IDFM/n81OtFDX6/s/AEc=;
        b=hdy+IrKWT43CWX5DVaWmnfBMd9pdUhhDjw48fMoHuqNqocedJCjv2/B29UVmgN0uu3
         Q6rUlweuha4ujaOd8k1Yx6FFpbDzzJOVYX9LLJ4Z51okv6cUI5Ync0+GD+ymCz3Ec578
         3Qy21u8Jgq2DvnZeHjN5MOEdcaiHH0QVpjQPewQY8lCCFmpQreMx+1bigBQj4QB965Ed
         ErSRs393EjZKOk25rhI6p56WRkSXF/EH57lD9kglfU0tvwmWDFibdewh69lN5pkoBelr
         FWALXHIpHtoOuQ1q+naBCdNTBVqKqroAKMpCEOnm0R3N69qOgHaXQZvWRkwdAuuIdLTh
         8+5g==
X-Gm-Message-State: AO0yUKUcH3UDhnA6vUm25Kj7Lp4decGwQjwpP2oIn7DDlaAifLL/BnKN
        BgChsC7C5JfAlOY6jjwVWVqM8g==
X-Google-Smtp-Source: AK7set+NmzGCXmV49Z+yuGoqtBuUh6WsMHapZ5sjWJvg1AxjPSuRMcddn6CMUFtPpYXviamzMTzYwg==
X-Received: by 2002:a5d:4845:0:b0:2c7:7b7:ee94 with SMTP id n5-20020a5d4845000000b002c707b7ee94mr6581157wrs.13.1677750976700;
        Thu, 02 Mar 2023 01:56:16 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b002c5d3f0f737sm14703514wri.30.2023.03.02.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:56:16 -0800 (PST)
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
Subject: [PATCH v4 20/24] x86: Remove empty <uapi/asm/setup.h>
Date:   Thu,  2 Mar 2023 10:35:35 +0100
Message-Id: <20230302093539.372962-21-alexghiti@rivosinc.com>
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
 arch/x86/include/asm/setup.h      | 2 --
 arch/x86/include/uapi/asm/setup.h | 1 -
 2 files changed, 3 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/setup.h

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f37cbff7354c..449b50a2f390 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SETUP_H
 #define _ASM_X86_SETUP_H
 
-#include <uapi/asm/setup.h>
-
 #define COMMAND_LINE_SIZE 2048
 
 #include <linux/linkage.h>
diff --git a/arch/x86/include/uapi/asm/setup.h b/arch/x86/include/uapi/asm/setup.h
deleted file mode 100644
index 79a9626b5500..000000000000
--- a/arch/x86/include/uapi/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-/* */
-- 
2.37.2

