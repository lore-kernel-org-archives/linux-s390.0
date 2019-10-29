Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45033 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfJ2VOD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 17:14:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id q16so8054209pll.11
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 14:14:02 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Date: Tue, 29 Oct 2019 14:13:23 -0700
Message-Id: <20191029211351.13243-2-keescook@chromium.org>
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Segher Boessenkool <segher@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>

The Program Header identifiers are internal to the linker scripts. In
preparation for moving the NOTES segment declaration into RO_DATA,
standardize the identifier for the PT_NOTE entry to "note" as used by
all other architectures that emit PT_NOTE.

Note that there was discussion about changing all architectures to use
"notes" instead, but I prefer to avoid that at this time. Changing only
powerpc is the smallest change to standardize the entire kernel. And
while this standardization does use singular "note" for a section that
has more than one note in it, this is just an internal identifier. It
matches the ELF "PT_NOTE", and is 4 characters (like "text", and "data")
for pretty alignment. The more exposed macro, "NOTES", use the more
sensible plural wording.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..81e672654789 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -19,7 +19,7 @@ ENTRY(_stext)
 
 PHDRS {
 	kernel PT_LOAD FLAGS(7); /* RWX */
-	notes PT_NOTE FLAGS(0);
+	note PT_NOTE FLAGS(0);
 	dummy PT_NOTE FLAGS(0);
 
 	/* binutils < 2.18 has a bug that makes it misbehave when taking an
@@ -177,7 +177,7 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :kernel :notes
+	NOTES :kernel :note
 
 	/* The dummy segment contents for the bug workaround mentioned above
 	   near PHDRS.  */
-- 
2.17.1
