Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45949 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfJKAM7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 20:12:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so4932100pfb.12
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 17:12:59 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 19/29] c6x: Move EXCEPTION_TABLE to RO_DATA segment
Date: Thu, 10 Oct 2019 17:05:59 -0700
Message-Id: <20191011000609.29728-20-keescook@chromium.org>
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, linux-kernel@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/c6x/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index a3547f9d415b..ac99ba0864bf 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -5,6 +5,9 @@
  *  Copyright (C) 2010, 2011 Texas Instruments Incorporated
  *  Mark Salter <msalter@redhat.com>
  */
+
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
@@ -80,8 +83,6 @@ SECTIONS
 		*(.gnu.warning)
 	}
 
-	EXCEPTION_TABLE(16)
-
 	RO_DATA(PAGE_SIZE)
 	.const :
 	{
-- 
2.17.1
