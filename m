Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E2C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbiEEHdo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 03:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbiEEHdl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 03:33:41 -0400
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83180488B1
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 00:29:55 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-08.nifty.com with ESMTP id 2457QNwJ012684
        for <linux-s390@vger.kernel.org>; Thu, 5 May 2022 16:26:23 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenx019426;
        Thu, 5 May 2022 16:23:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenx019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735438;
        bh=q2lbEzTRVD+QPFvQ/TvNHXThm5Pw736ecoqXdaet6u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg+Td5I/ravKpnTWe4pZIocSpNNW1nCsM6IHrKLKcAuzizHyyE4hanm6PXv8obBHe
         p2OgMuhQUdBaj5v+Kctpix7Kir2XgODmkfYNyqIvmopRk1jJlWZKEBGJS34pIHL6e+
         tnfVPVV51mmNWSkTdKtxqlbTnkjyKLvUyz1759W9WdehN3YVwcWa/0v4wp22cia9xo
         keOEB3XRNSgaSDoDwev15VN29q0azLvbt24+ur7modfZXaTdiTJPxPPPhXDKpN7GOd
         LccaHCWLc55aTnPqAxxGZo/JLijoUQNxNnxX459GEDsUkg2UdiV1dwLC5/MfAHBkwC
         MLNWnIbJqlYaQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 15/15] kbuild: make *.mod rule robust against too long argument error
Date:   Thu,  5 May 2022 16:22:44 +0900
Message-Id: <20220505072244.1155033-16-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Like built-in.a, the command length of the *.mod rule scales with
the depth of the directory times the number of objects in the Makefile.

Add $(obj)/ by the shell command (awk) instead of by Make's builtin
function.

In-tree modules still have some room to the limit (ARG_MAX=2097152),
but this is more future-proof for big modules in a deep directory.

For example, you can build i915 as a module (CONFIG_DRM_I915=m) and
compare drivers/gpu/drm/i915/.i915.mod.cmd with/without this commit.

The issue is more critical for external modules because the M= path
can be very long as Jeff Johnson reported before [1].

[1] https://lore.kernel.org/linux-kbuild/4c02050c4e95e4cb8cc04282695f8404@codeaurora.org/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index cea48762299c..e7b3f329d443 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -266,8 +266,8 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
-cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
-	$(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
+cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
+	$(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
 
 $(obj)/%.mod: FORCE
 	$(call if_changed,mod)
-- 
2.32.0

