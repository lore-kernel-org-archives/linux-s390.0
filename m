Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98304C32793
	for <linux-s390@archiver.kernel.org>; Sun, 21 Aug 2022 11:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiHULgX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiHULgW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Aug 2022 07:36:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FEE18349
        for <linux-s390@vger.kernel.org>; Sun, 21 Aug 2022 04:36:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so10091652wri.0
        for <linux-s390@vger.kernel.org>; Sun, 21 Aug 2022 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UGvwPzXngv88+qXXF2O4AJ0Z86Zyohdzp8L49ZwcrUI=;
        b=RFEWL69QfCRQQBK2lSa24K7nmexDHde5oOE9gK1KPgEWu/3N9BF1FKy/yant22fc7r
         SovDED+cd6fyc8s48RsE9t5Hb3/EgfWZ8sE3O0GnkOdMg4SdBVoDYmAToK0UlC8wMjST
         Dy83emsgcvHF06ICzpd5w01aqlAlScw3qmuXagdS4mHF7olMtod+7IqWIhUdkXJ+916y
         U1Es8YS/+TK13ci36gErubIgfOBWFCDMDaoX4eO6VW8NZFXjHEZ/W3FjivuixLu0wK4X
         zDWTdTcgDyHjq82/Wl3ihmDAM4A9lKTGfM1UAU6X5jcP18LNvlgBNWHiNIjIB1igLJZQ
         vXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UGvwPzXngv88+qXXF2O4AJ0Z86Zyohdzp8L49ZwcrUI=;
        b=G3rJW4zIX8lVqW520M2lL8l5f2HBfuNelfGF23ZIqF3YeRX6ZbBYssWi7CTPPjMjKe
         xzGtSfcTXF2aHB0rAhc34gwcMyFtDNzFhJzKJNCgr9Lr9VYSM+rOy9qieNT7lEg1r6pT
         uVJl5zPxYAy0zF1RWC19qw38Okf8s+oGE/cgI5K7AyF+xGPf13OFaRI6bnXpbwVfDtu0
         H+jJpnqQXRIPKRptX4xcNCaxwjwQxWE4z7ZfMV1Dr3Z9YGb6fFsNdkglc2puywjMtNut
         OFGHC4Uri/3xLCjorlT1Mt9cj1jpQhaBFXHLp9lGleXnAfXfY6PRO+pWGc+HzPR4rKF2
         hPyg==
X-Gm-Message-State: ACgBeo0f0//d3sy/0uWHNfUz50i/9YkLOfQuLjzqlWiOkzmUYAgstb2/
        Wp9i0opaz32LLyCNa7ETkDYk1w==
X-Google-Smtp-Source: AA6agR6HxOhtorb8TKIhxX8S9RXjgPAg541CyxctPo1Ydg0AdY48FkmATY5ytrYfPqqcMNSVf1d3pg==
X-Received: by 2002:a5d:6841:0:b0:225:3558:972d with SMTP id o1-20020a5d6841000000b002253558972dmr6441695wrw.461.1661081778602;
        Sun, 21 Aug 2022 04:36:18 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:18 -0700 (PDT)
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
Subject: [PATCH 1/6] asm-generic: add a cpuinfo_ops definition in shared code
Date:   Sun, 21 Aug 2022 12:35:08 +0100
Message-Id: <20220821113512.2056409-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220821113512.2056409-1-mail@conchuod.ie>
References: <20220821113512.2056409-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On RISC-V sparse complains that:
arch/riscv/kernel/cpu.c:204:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?

Sure, it could be dumped into asm/processor.h like other archs have
done, but putting it in an asm-generic header seems to be a saner
strategy.

Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/processor.h | 1 +
 include/asm-generic/processor.h    | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 100644 include/asm-generic/processor.h

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 19eedd4af4cd..dd2c9a382192 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -9,6 +9,7 @@
 #include <linux/const.h>
 
 #include <vdso/processor.h>
+#include <asm-generic/processor.h>
 
 #include <asm/ptrace.h>
 
diff --git a/include/asm-generic/processor.h b/include/asm-generic/processor.h
new file mode 100644
index 000000000000..2ec9af562e9b
--- /dev/null
+++ b/include/asm-generic/processor.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PROCESSOR_H
+#define __ASM_PROCESSOR_H
+
+extern const struct seq_operations cpuinfo_op;
+
+#endif /* __ASM_PROCESSOR_H */
-- 
2.37.1

