Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA398C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 07:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbiCPHGQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354078AbiCPHGD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 03:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D651C10C;
        Wed, 16 Mar 2022 00:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B404161040;
        Wed, 16 Mar 2022 07:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B164EC36AE3;
        Wed, 16 Mar 2022 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647414289;
        bh=a1P2DNQDu+Nr0wIsMe45GFTAoBbxFKExa639SNMT8Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgPd0H/CgAWrDa1r6V53xbwnOApkexZkCZrfY+9Anm67m/JBXCD8lcjanyRL64Ppd
         QXZc6ovx7MD/aWmVbdzsO48tXypXLMMK2cWjpIib1cT/GXwnNK8Nn/rnCmSw3amNbr
         DP0j/M/jjdTvKABOKUP2KgiSx66XlMucJT9wrMq/3alMD0BgFxBh31R4rA1MCeGqdZ
         maMic0O5dv/tk2cHByy5DPEDsBclItk+BQfdNUc0GirxZygxc8yjkVCSTPC45KeWlX
         TLiOzBX03oPft9KwUSlV2n/RkiN+X5oWXw0RlQ++mkE2319ChO/7TBx2F/pgXGdWUL
         ioVnB7G2ibpbw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V8 13/20] riscv: compat: process: Add UXL_32 support in start_thread
Date:   Wed, 16 Mar 2022 15:03:10 +0800
Message-Id: <20220316070317.1864279-14-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316070317.1864279-1-guoren@kernel.org>
References: <20220316070317.1864279-1-guoren@kernel.org>
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

