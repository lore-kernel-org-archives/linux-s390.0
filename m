Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91769C61DA4
	for <linux-s390@archiver.kernel.org>; Mon,  6 Mar 2023 10:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjCFK1P (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCFK0s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Mar 2023 05:26:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D025B81
        for <linux-s390@vger.kernel.org>; Mon,  6 Mar 2023 02:26:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j2so8217253wrh.9
        for <linux-s390@vger.kernel.org>; Mon, 06 Mar 2023 02:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678098378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Swqwg1ld/osn6FVGiU0tRhJoEIYHACqIeiNcFb5PLI=;
        b=uIfY1NRXzEv+Xx/IYayWVnpzA4exJklrAwIb3ziJrRorM1XluURLNe5sRP/ryqZYpH
         a/ROxZBG/PG3wqXEXFLgmc9IwQJMtJTeJVdZkx9HkTXi3YcloRvI0Ka60lGCZWzAqitd
         s8kb5y1Al5ulup5Y9WUbhZSCqL8VLLE28WkIRRztX5wElA5K0w4aOgqjDYTJquKniuWS
         8YlGMCdIBW0itW/lFwZO+SGXFLtcZlBF8ZuhVhvpM6nHQKyjbreMrzIlhd56H2CyYJX0
         OC/OHVVFh/+iUfAq4Ek70MGaipb61JQEk8RcMhvIfK2xVIBEtu1MYjED6cGdncSMd6/n
         946Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Swqwg1ld/osn6FVGiU0tRhJoEIYHACqIeiNcFb5PLI=;
        b=CRwbyPcjvc0MJUQIL/f9Ovy/kDKWbwfrYrnSi/trNeCYwRAnZKG78Zl4vqCg4RtpI/
         PCLVoWGgl7d1e1NRQerrZVoLrCNADQPGAKQ6bJk1ZBBuDYhFXe5z8I2/cmosYRvFNwkX
         1aK2TzryenuQ5zPXp1ePYYCQugmax/fqV/W8XBNB/xsDwiSuSoWJVhd1mIMr3zbjXzwd
         17zxkWy7tT7o8CDVijNW6/cZgR/0aoJHg4X58b0oIGhT96VaxIFpVmjHTASkNWv097YQ
         gJbzLEsfw4T6RTWr8i9q23lDZbPqyl8a52ONd2rcDH0X8DVV3/73gs3NX4WoxwKsIdeV
         AkQQ==
X-Gm-Message-State: AO0yUKUWCiCcKJ+oGd84kfZqe+ayEOHxlsY43b7qytXHLrRu88hCVkwQ
        3IoGCQ5bNIeG4P3Hbkd5UYClCg==
X-Google-Smtp-Source: AK7set9U6fM9Xsgv6YkGBRqVzeGSi+gpLiQEhEz2I65vcVv3MM3OWhwJd6wPw1/siNKByhVwY2r8Wg==
X-Received: by 2002:a5d:6148:0:b0:2c5:5335:73f3 with SMTP id y8-20020a5d6148000000b002c5533573f3mr10413383wrt.34.1678098378256;
        Mon, 06 Mar 2023 02:26:18 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z16-20020adfdf90000000b002c707785da4sm9415798wrl.107.2023.03.06.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:26:18 -0800 (PST)
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
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 20/26] parisc: Remove empty <uapi/asm/setup.h>
Date:   Mon,  6 Mar 2023 11:05:02 +0100
Message-Id: <20230306100508.1171812-21-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230306100508.1171812-1-alexghiti@rivosinc.com>
References: <20230306100508.1171812-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/parisc/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/parisc/include/uapi/asm/setup.h

diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uapi/asm/setup.h
deleted file mode 100644
index bfad89428e47..000000000000
--- a/arch/parisc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _PARISC_SETUP_H
-#define _PARISC_SETUP_H
-
-#endif /* _PARISC_SETUP_H */
-- 
2.37.2

