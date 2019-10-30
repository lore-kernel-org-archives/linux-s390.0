Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] arch: ipcbuf.h: make uapi asm/ipcbuf.h self-contained
Date: Wed, 30 Oct 2019 15:38:53 +0900
Message-Id: <20191030063855.9989-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Masahiro Yamada <yamada.masahiro@socionext.com>

The user-space cannot compile <asm/ipcbuf.h> due to some missing type
definitions. For example, building it for x86 fails as follows:

  CC      usr/include/asm/ipcbuf.h.s
In file included from ./usr/include/asm/ipcbuf.h:1:0,
                 from <command-line>:32:
./usr/include/asm-generic/ipcbuf.h:21:2: error: unknown type name ‘__kernel_key_t’
  __kernel_key_t  key;
  ^~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:22:2: error: unknown type name ‘__kernel_uid32_t’
  __kernel_uid32_t uid;
  ^~~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:23:2: error: unknown type name ‘__kernel_gid32_t’
  __kernel_gid32_t gid;
  ^~~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:24:2: error: unknown type name ‘__kernel_uid32_t’
  __kernel_uid32_t cuid;
  ^~~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:25:2: error: unknown type name ‘__kernel_gid32_t’
  __kernel_gid32_t cgid;
  ^~~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:26:2: error: unknown type name ‘__kernel_mode_t’
  __kernel_mode_t  mode;
  ^~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:28:35: error: ‘__kernel_mode_t’ undeclared here (not in a function)
  unsigned char  __pad1[4 - sizeof(__kernel_mode_t)];
                                   ^~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:31:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused1;
  ^~~~~~~~~~~~~~~~
./usr/include/asm-generic/ipcbuf.h:32:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused2;
  ^~~~~~~~~~~~~~~~

It is just a matter of missing include directive.

Include <asm/posix_types.h> to make it self-contained, and add it to
the compile-test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/uapi/asm/ipcbuf.h   | 2 ++
 arch/sparc/include/uapi/asm/ipcbuf.h  | 2 ++
 arch/xtensa/include/uapi/asm/ipcbuf.h | 2 ++
 include/uapi/asm-generic/ipcbuf.h     | 2 ++
 usr/include/Makefile                  | 1 -
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/ipcbuf.h b/arch/s390/include/uapi/asm/ipcbuf.h
index 5b1c4f47c656..1030cd186899 100644
--- a/arch/s390/include/uapi/asm/ipcbuf.h
+++ b/arch/s390/include/uapi/asm/ipcbuf.h
@@ -2,6 +2,8 @@
 #ifndef __S390_IPCBUF_H__
 #define __S390_IPCBUF_H__
 
+#include <linux/posix_types.h>
+
 /*
  * The user_ipc_perm structure for S/390 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/sparc/include/uapi/asm/ipcbuf.h b/arch/sparc/include/uapi/asm/ipcbuf.h
index 9d0d125500e2..5b933a598a33 100644
--- a/arch/sparc/include/uapi/asm/ipcbuf.h
+++ b/arch/sparc/include/uapi/asm/ipcbuf.h
@@ -2,6 +2,8 @@
 #ifndef __SPARC_IPCBUF_H
 #define __SPARC_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * The ipc64_perm structure for sparc/sparc64 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/xtensa/include/uapi/asm/ipcbuf.h b/arch/xtensa/include/uapi/asm/ipcbuf.h
index a57afa0b606f..3bd0642f6660 100644
--- a/arch/xtensa/include/uapi/asm/ipcbuf.h
+++ b/arch/xtensa/include/uapi/asm/ipcbuf.h
@@ -12,6 +12,8 @@
 #ifndef _XTENSA_IPCBUF_H
 #define _XTENSA_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * Pad space is left for:
  * - 32-bit mode_t and seq
diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
index 7d80dbd336fb..41a01b494fc7 100644
--- a/include/uapi/asm-generic/ipcbuf.h
+++ b/include/uapi/asm-generic/ipcbuf.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_IPCBUF_H
 #define __ASM_GENERIC_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * The generic ipc64_perm structure:
  * Note extra padding because this structure is passed back and forth
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 57b20f7b6729..70f8fe256aed 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -16,7 +16,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-header-test- += asm/ipcbuf.h
 header-test- += asm/msgbuf.h
 header-test- += asm/sembuf.h
 header-test- += asm/shmbuf.h
-- 
2.17.1
