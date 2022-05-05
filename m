Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6324C433FE
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 07:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbiEEHc4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344810AbiEEHct (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 03:32:49 -0400
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0F0488A9
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 00:29:04 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-06.nifty.com with ESMTP id 2457QTG2008582
        for <linux-s390@vger.kernel.org>; Thu, 5 May 2022 16:26:29 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nens019426;
        Thu, 5 May 2022 16:23:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nens019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735433;
        bh=XjVFBOl1B/4tI+LO5abcsoDvV/xc8vPdA32BcnzLDtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuOivWkXLFBO79zThz1AyrMc1rrNFxbTQheE0PfMbKnd0CiVRmb8H6EJ7y64Xfy9W
         p61wWdzZsY8kP+28V0RqRhiSpOt+9xVWyp8sB45Vbwpse8rAAwUM419qpnaDdJjgPE
         XL+N+AWMJ3N5N1UpUtxT8osKrUtURA5/INQIHhfqhj6SXmdwnf1B21n8AGnGolhUGK
         fh9yI8kG5qHT5PnTEJXbWyqVvvu7USPdLVo3oiFql696uGICtEB/fQpWnloZmyLE5j
         pcKdKqKfUUYgSjC9Nn8blZHedemhjilyxwtC07iu4s9lXBcAWtNwnmV5ISctWy6eeh
         rj+sXEOluxtPg==
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
Subject: [PATCH v3 10/15] genksyms: adjust the output format to modpost
Date:   Thu,  5 May 2022 16:22:39 +0900
Message-Id: <20220505072244.1155033-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Make genksyms output symbol versions in the format modpost expects,
so the 'sed' is unneeded.

This commit makes *.symversions completely unneeded.

I will keep *.symversions in .gitignore and 'make clean' for a while.
Otherwise, some people might be upset with 'git status'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.build      | 6 ------
 scripts/genksyms/genksyms.c | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dff9220135c4..461998a2ad2b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -165,16 +165,10 @@ ifdef CONFIG_MODVERSIONS
 # o modpost will extract versions from that file and create *.c files that will
 #   be compiled and linked to the kernel and/or modules.
 
-genksyms_format := __crc_\(.*\) = \(.*\);
-
 gen_symversions =								\
 	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
-		    > $@.symversions;						\
-		sed -n 's/$(genksyms_format)/$(pound)SYMVER \1 \2/p' $@.symversions \
 			>> $(dot-target).cmd;					\
-	else									\
-		rm -f $@.symversions;						\
 	fi
 
 cmd_gen_symversions_c =	$(call gen_symversions,c)
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 6e6933ae7911..f5dfdb9d80e9 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -680,8 +680,7 @@ void export_symbol(const char *name)
 		if (flag_dump_defs)
 			fputs(">\n", debugfile);
 
-		/* Used as a linker script. */
-		printf("__crc_%s = 0x%08lx;\n", name, crc);
+		printf("#SYMVER %s 0x%08lx\n", name, crc);
 	}
 }
 
-- 
2.32.0

