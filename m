Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84581C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 07:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbiEEHcn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbiEEHce (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 03:32:34 -0400
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D604447ADD
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 00:28:55 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-09.nifty.com with ESMTP id 2457QJTr005146
        for <linux-s390@vger.kernel.org>; Thu, 5 May 2022 16:26:20 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenn019426;
        Thu, 5 May 2022 16:23:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenn019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735427;
        bh=vWIe6Hz1v6TN6G/VnDfKR17//GxSJcR4wll8Uklx9kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZSbHVFmHWUVZ1VYDxo4qTVmtK1DQkx05aFyb75DtQuxwykuQwLM1GEGYTVcN2AYy
         ZRYnGGFvrFdSLcMleP2JQYsOs41x+FT25Qe/9MZQaiR1nhJjDS6mYatL6nkxsPLZWm
         qI+Tx/R2vqo4ROnpxOcvbJLLAMDvYQ5/0Gygfjm5qlZxKanhPnvKI+5gFolY/A7qei
         sT4F+Aq7wiqzNyi4dfIx4wfwFSaR4Lqgylp5qByKxdfXW0y69Au4GY5WnqsUwYuDV+
         /svKyOJ5f5mej1QH7LKgybltl2t1e4x5ZOSJNBu+Q80h6pv0vlLGje8hbPdWfLukei
         slwvBQjHty62Q==
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
Subject: [PATCH v3 05/15] kbuild: generate a list of objects in vmlinux
Date:   Thu,  5 May 2022 16:22:34 +0900
Message-Id: <20220505072244.1155033-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A *.mod file lists the member objects of a module, but vmlinux does
not have such a file to list out all the member objects.

Generate this list to allow modpost to know all the member objects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v2)

Changes in v2:
  - Move '> .vmlinux.objs' to the outside of the loop (Nicolas)
  - Clean up .vmlinux.objs explicitly

 scripts/link-vmlinux.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f44504a644..eceb3ee7ec06 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -311,6 +311,7 @@ cleanup()
 	rm -f vmlinux.map
 	rm -f vmlinux.o
 	rm -f .vmlinux.d
+	rm -f .vmlinux.objs
 }
 
 # Use "make V=1" to debug this script
@@ -342,6 +343,16 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 modpost_link vmlinux.o
 objtool_link vmlinux.o
 
+# Generate the list of objects in vmlinux
+for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
+	case ${f} in
+	*.a)
+		${AR} t ${f} ;;
+	*)
+		echo ${f} ;;
+	esac
+done > .vmlinux.objs
+
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
 
-- 
2.32.0

