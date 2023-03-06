Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB17C6FD19
	for <linux-s390@archiver.kernel.org>; Mon,  6 Mar 2023 10:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCFKSs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCFKSc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Mar 2023 05:18:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA620564
        for <linux-s390@vger.kernel.org>; Mon,  6 Mar 2023 02:18:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f11so8201127wrv.8
        for <linux-s390@vger.kernel.org>; Mon, 06 Mar 2023 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678097884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8jUAHwbVMbK8RWIko2xHqtBuL1KyylMgTUrOJjOCCU=;
        b=ObAuaO9co25nDQl/gLe8rOAnmY1SJ/MNRhZIQLKvd0dmJCtejEEAp9VjO5ueZmwq77
         2sunlhagXc3ZRybQbORIgvtgjh2qkEyP6dv7mjew9nO81QWyUrOD18KnIi89JuAWKlVQ
         wBph9u5vcEXAFYKLw2R1CaYoc/es0FtEj3ptmhTiLJcfltfN7VENgL7XAlyBeI8VmhHZ
         HyeE5iyj056diT+pPhE/AqYPqTCqF7h1UEuIvxZm0jb1cWuzCuAJzCmptfafE+KvmsgO
         fqTB6T4p5bWSknr0H9aeAMEfr7ytra6qOWt2uq2+LIupXu7k3sa8nDlKt7kxGOLDaV+v
         Dpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8jUAHwbVMbK8RWIko2xHqtBuL1KyylMgTUrOJjOCCU=;
        b=mYKU6FHarZ4fX28dY9h27D2gKTf0p3pV8+I+7k8+d1KCW5nM+lKNqUKbQm5BcWuZB1
         yNVsQoC/VJC5UkuJE9mfX3job/52TfCWVPqpJuqyzQv9QpHHCaUE3lEvCvbmhhhMjLxz
         0gcINOM6npRGZbFkU8XrWQdVkQoP62rpuZBx5yRgUOta4IWSCT/K12P4lIoOCUPOyJxs
         Pq/J2Pm6XM98dggZK+6ln0q+dg+a99DAFSoTEUuZx+MYgH9LWrndtLjHmt7nCqbZuG+7
         IChPpeVivoJYA9hMOdYA30tBptCCUIJ6boZYeG/AfF/sTI7OFqiq+n5165icH9e9iv16
         l6wA==
X-Gm-Message-State: AO0yUKVEhrPyhPGTWMjWTl5w6BRKjTFpoXKOHbGkMoWPDUIcBBbdEJL5
        RnDOxH5YwaznMNoDxRGK7jlQug==
X-Google-Smtp-Source: AK7set9RUPCtaJosOxXOi0L6kxrJUTStoYiyoZUrRAF7YvJryt8T6e/nsOsDS8LQFTUxgDPEl19z8A==
X-Received: by 2002:a5d:46c8:0:b0:2c7:df1:a09d with SMTP id g8-20020a5d46c8000000b002c70df1a09dmr6140936wrs.4.1678097884571;
        Mon, 06 Mar 2023 02:18:04 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d4d47000000b002c5706f7c6dsm9442743wru.94.2023.03.06.02.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:18:04 -0800 (PST)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 12/26] riscv: Remove COMMAND_LINE_SIZE from uapi
Date:   Mon,  6 Mar 2023 11:04:54 +0100
Message-Id: <20230306100508.1171812-13-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

As far as I can tell this is not used by userspace and thus should not
be part of the user-visible API.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/setup.h      | 7 +++++++
 arch/riscv/include/uapi/asm/setup.h | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/setup.h

diff --git a/arch/riscv/include/asm/setup.h b/arch/riscv/include/asm/setup.h
new file mode 100644
index 000000000000..f165a14344e2
--- /dev/null
+++ b/arch/riscv/include/asm/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_SETUP_H
+#define _ASM_RISCV_SETUP_H
+
+#define COMMAND_LINE_SIZE       1024
+
+#endif /* _ASM_RISCV_SETUP_H */
diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
index 66b13a522880..17fcecd4a2f8 100644
--- a/arch/riscv/include/uapi/asm/setup.h
+++ b/arch/riscv/include/uapi/asm/setup.h
@@ -3,6 +3,4 @@
 #ifndef _UAPI_ASM_RISCV_SETUP_H
 #define _UAPI_ASM_RISCV_SETUP_H
 
-#define COMMAND_LINE_SIZE	1024
-
 #endif /* _UAPI_ASM_RISCV_SETUP_H */
-- 
2.37.2

