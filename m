Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F57BC433FE
	for <linux-s390@archiver.kernel.org>; Tue,  5 Apr 2022 07:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiDEHRI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDEHQX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 03:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEF1107;
        Tue,  5 Apr 2022 00:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE96B81B14;
        Tue,  5 Apr 2022 07:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E4C34112;
        Tue,  5 Apr 2022 07:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649142858;
        bh=i7PzdXl6Dn+FdofUFi023qh/x+M4yzmCIkQuIb/yw0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJCIg9dymp/i3aYY8UDGKP6XwUMI28CDXVTTuITqtu219zO0Lxn23mDuhegiJzT9o
         6VoKVF8iGni6jpWF9GRDjJb6aoZw7Gc/Jzm7gD+EMaiYqASXVyeql+u4JQJGgPbkVQ
         m7RkMxlBkVTY071Sdi1zkDXSUPfpbycxNWKkl6WEqcwIXzGXqsdeelojFAlyNKiEtz
         KTL5O27JfICsO8FoUskCgR/ON5gA0/y/3OdDj2cV9WGlC2p6ME2xqLYnFS8tNl1NvT
         Ghp1FSuIuHRSTQmgQJLxPrkjcZZIOacuzpf592EwBhj7o7JasfnhZ0w2Y4fo75Fa8X
         muA3+K2dMOUhQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de, nathan@kernel.org,
        naresh.kamboju@linaro.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V12 08/20] riscv: Fixup difference with defconfig
Date:   Tue,  5 Apr 2022 15:13:02 +0800
Message-Id: <20220405071314.3225832-9-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405071314.3225832-1-guoren@kernel.org>
References: <20220405071314.3225832-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Let's follow the origin patch's spirit:

The only difference between rv32_defconfig and defconfig is that
rv32_defconfig has  CONFIG_ARCH_RV32I=y.

This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.

Fixes: 1b937e8faa87ccfb ("RISC-V: Add separate defconfig for 32bit systems")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..c6ca1b9cbf71 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -154,3 +154,7 @@ PHONY += rv64_randconfig
 rv64_randconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
 		-f $(srctree)/Makefile randconfig
+
+PHONY += rv32_defconfig
+rv32_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 32-bit.config
-- 
2.25.1

