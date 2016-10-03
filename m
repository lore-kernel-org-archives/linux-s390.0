From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 03 Oct 2016 09:07:36 +0000
Subject: [PATCH -resend 6/6] frv, mn10300, s390, sh: remove empty vga.h
Message-Id: <20161003090736.19926-6-jslaby@suse.cz>
References: <20161003090736.19926-1-jslaby@suse.cz>
In-Reply-To: <20161003090736.19926-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, David Howells <dhowells@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-am33-list@redhat.com, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Provided the architectures do not need any special handling (they seem
not to support vga at all, actually), there is no need to have an
empty vga.h. Let them refer to the generic one instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-am33-list@redhat.com
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 arch/frv/include/asm/Kbuild     |  1 +
 arch/frv/include/asm/vga.h      | 17 -----------------
 arch/mn10300/include/asm/Kbuild |  1 +
 arch/mn10300/include/asm/vga.h  | 17 -----------------
 arch/s390/include/asm/Kbuild    |  1 +
 arch/s390/include/asm/vga.h     |  6 ------
 arch/sh/include/asm/Kbuild      |  1 +
 arch/sh/include/asm/vga.h       |  6 ------
 8 files changed, 4 insertions(+), 46 deletions(-)
 delete mode 100644 arch/frv/include/asm/vga.h
 delete mode 100644 arch/mn10300/include/asm/vga.h
 delete mode 100644 arch/s390/include/asm/vga.h
 delete mode 100644 arch/sh/include/asm/vga.h

diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index 1fa084cf1a43..d1a5c16a2e0f 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -7,4 +7,5 @@ generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
+generic-y += vga.h
 generic-y += word-at-a-time.h
diff --git a/arch/frv/include/asm/vga.h b/arch/frv/include/asm/vga.h
deleted file mode 100644
index a702c800a229..000000000000
--- a/arch/frv/include/asm/vga.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* vga.h: VGA register stuff
- *
- * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _ASM_VGA_H
-#define _ASM_VGA_H
-
-
-
-#endif /* _ASM_VGA_H */
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index 1c8dd0f5cd5d..ee06fceabde0 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -9,4 +9,5 @@ generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
+generic-y += vga.h
 generic-y += word-at-a-time.h
diff --git a/arch/mn10300/include/asm/vga.h b/arch/mn10300/include/asm/vga.h
deleted file mode 100644
index 0163e50a3459..000000000000
--- a/arch/mn10300/include/asm/vga.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* MN10300 VGA register definitions
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
- */
-
-#ifndef _ASM_VGA_H
-#define _ASM_VGA_H
-
-
-
-#endif /* _ASM_VGA_H */
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 20f196b82a6e..fe3442827e61 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,4 +7,5 @@ generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
+generic-y += vga.h
 generic-y += word-at-a-time.h
diff --git a/arch/s390/include/asm/vga.h b/arch/s390/include/asm/vga.h
deleted file mode 100644
index d375526c261f..000000000000
--- a/arch/s390/include/asm/vga.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_S390_VGA_H
-#define _ASM_S390_VGA_H
-
-/* Avoid compile errors due to missing asm/vga.h */
-
-#endif /* _ASM_S390_VGA_H */
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 751c3373a92c..5b8bfba7522d 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -38,4 +38,5 @@ generic-y += termbits.h
 generic-y += termios.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
+generic-y += vga.h
 generic-y += xor.h
diff --git a/arch/sh/include/asm/vga.h b/arch/sh/include/asm/vga.h
deleted file mode 100644
index 06a5de8ace1a..000000000000
--- a/arch/sh/include/asm/vga.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_SH_VGA_H
-#define __ASM_SH_VGA_H
-
-/* Stupid drivers. */
-
-#endif /* __ASM_SH_VGA_H */
-- 
2.10.0
