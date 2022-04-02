Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861FAC35276
	for <linux-s390@archiver.kernel.org>; Sat,  2 Apr 2022 13:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356025AbiDBN5W (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 2 Apr 2022 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346866AbiDBN4d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 Apr 2022 09:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3679AB0F;
        Sat,  2 Apr 2022 06:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F4661567;
        Sat,  2 Apr 2022 13:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB084C36AE2;
        Sat,  2 Apr 2022 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648907659;
        bh=a1P2DNQDu+Nr0wIsMe45GFTAoBbxFKExa639SNMT8Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=py1EmqnyL/JK1TQDsoToy5o0nUL8/KBUq7CsOp/CuANDfS6H5pVyfcfwSbftBueOi
         Jdo24WBVHOcUuKcX1vSzCehzwOSpn5qwo3M1ZCKmdZHNTMTJrjgXfHQgGutc+weXN7
         PGpMDltxg93nun/BjM1kbx+z5wyWMFOTYGXkGAZaFk3m9IS/4D4SKJUCTCaqhUl05S
         UwOoK9L2lRMJGzPH5m/EeywxSjfGyfpurz657YQF4rSD+FtzRZ291HGZKO86wUYXoG
         nKNqQUEaw/T5XSAtokODePKsxj/+lXQ6rQIKDD/OAtadKM1aJOZ+iMBaPNB01/symJ
         EgQnxbt1R8NHg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V11 13/20] riscv: compat: process: Add UXL_32 support in start_thread
Date:   Sat,  2 Apr 2022 21:52:49 +0800
Message-Id: <20220402135256.2691868-14-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402135256.2691868-1-guoren@kernel.org>
References: <20220402135256.2691868-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If the current task is in COMPAT mode, set SR_UXL_32 in status for
returning userspace. We need CONFIG _COMPAT to prevent compiling
errors with rv32 defconfig.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/kernel/process.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..8c7665481a9f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -97,6 +97,15 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 	regs->epc = pc;
 	regs->sp = sp;
+
+#ifdef CONFIG_64BIT
+	regs->status &= ~SR_UXL;
+
+	if (is_compat_task())
+		regs->status |= SR_UXL_32;
+	else
+		regs->status |= SR_UXL_64;
+#endif
 }
 
 void flush_thread(void)
-- 
2.25.1

