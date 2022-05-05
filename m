Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25864C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 07:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiEEHck (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 03:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbiEEHcd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 03:32:33 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BF3DDD9
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 00:28:54 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-05.nifty.com with ESMTP id 2457QG3l005888
        for <linux-s390@vger.kernel.org>; Thu, 5 May 2022 16:26:16 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenl019426;
        Thu, 5 May 2022 16:23:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenl019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735424;
        bh=BFUO29caSUfobdcXOazaV3japZmLNF4oOw4tiPaDpqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JXJtDn1hClMMIl6bpROdtphb7/17freo+cExsk4J/TqIDUdWrhKpo1o6NUNh/N58
         FaQ70f+YJJ/kk9WFVGWJQMNfNKKFdcY7vy9JQ/HwvMf+QX4rNCKE/9yjvXt2bJVWD9
         r0eq6EECwY2wndn8OtvSRs1egxovqi5mhxtmPEH/cPOmeO5GAS0dn0ZWWlg7sRmPrX
         /KYZPW/9dnYmKW7DZ6CjoCWT7lt/0TjPi8l9YfWL58ZV5uYLpGBHsPfOm3TwxkZyF+
         ZEuHzSYuVCHMH0vnqyY0K9YjNqU10nv7KZdtgpeGsMJgiYMLtRTDfqWfAtONJsNwrl
         w3JB3Ca53DTeQ==
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
Subject: [PATCH v3 03/15] modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
Date:   Thu,  5 May 2022 16:22:32 +0900
Message-Id: <20220505072244.1155033-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

add_intree_flag(), add_retpoline(), and add_staging_flag() are small
enough to be merged into add_header().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - New patch

 scripts/mod/modpost.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ebd80c77fa03..ae8e4a4dcfd2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2200,25 +2200,17 @@ static void add_header(struct buffer *b, struct module *mod)
 			      "#endif\n");
 	buf_printf(b, "\t.arch = MODULE_ARCH_INIT,\n");
 	buf_printf(b, "};\n");
-}
 
-static void add_intree_flag(struct buffer *b, int is_intree)
-{
-	if (is_intree)
+	if (!external_module)
 		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
-}
 
-/* Cannot check for assembler */
-static void add_retpoline(struct buffer *b)
-{
-	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
-	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
-	buf_printf(b, "#endif\n");
-}
+	buf_printf(b,
+		   "\n"
+		   "#ifdef CONFIG_RETPOLINE\n"
+		   "MODULE_INFO(retpoline, \"Y\");\n"
+		   "#endif\n");
 
-static void add_staging_flag(struct buffer *b, const char *name)
-{
-	if (strstarts(name, "drivers/staging"))
+	if (strstarts(mod->name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
 }
 
@@ -2544,9 +2536,6 @@ int main(int argc, char **argv)
 		check_exports(mod);
 
 		add_header(&buf, mod);
-		add_intree_flag(&buf, !external_module);
-		add_retpoline(&buf);
-		add_staging_flag(&buf, mod->name);
 		add_versions(&buf, mod);
 		add_depends(&buf, mod);
 		add_moddevtable(&buf, mod);
-- 
2.32.0

