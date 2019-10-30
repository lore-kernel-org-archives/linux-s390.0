Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] arch: sembuf.h: make uapi asm/sembuf.h self-contained
Date: Wed, 30 Oct 2019 15:38:55 +0900
Message-Id: <20191030063855.9989-3-yamada.masahiro@socionext.com>
In-Reply-To: <20191030063855.9989-1-yamada.masahiro@socionext.com>
References: <20191030063855.9989-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Masahiro Yamada <yamada.masahiro@socionext.com>

The user-space cannot compile <asm/sembuf.h> due to some missing type
definitions. For example, building it for x86 fails as follows:

  CC      usr/include/asm/sembuf.h.s
In file included from <command-line>:32:0:
./usr/include/asm/sembuf.h:17:20: error: field ‘sem_perm’ has incomplete type
  struct ipc64_perm sem_perm; /* permissions .. see ipc.h */
                    ^~~~~~~~
./usr/include/asm/sembuf.h:24:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t sem_otime; /* last semop time */
  ^~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:25:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused1;
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:26:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t sem_ctime; /* last change time */
  ^~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:27:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused2;
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:29:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t sem_nsems; /* no. of semaphores in array */
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:30:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused3;
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:31:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused4;
  ^~~~~~~~~~~~~~~~

It is just a matter of missing include directive.

Include <asm/ipcbuf.h> to make it self-contained, and add it to
the compile-test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/uapi/asm/sembuf.h    | 2 ++
 arch/parisc/include/uapi/asm/sembuf.h  | 1 +
 arch/powerpc/include/uapi/asm/sembuf.h | 2 ++
 arch/sparc/include/uapi/asm/sembuf.h   | 2 ++
 arch/x86/include/uapi/asm/sembuf.h     | 2 ++
 arch/xtensa/include/uapi/asm/sembuf.h  | 1 +
 include/uapi/asm-generic/sembuf.h      | 1 +
 usr/include/Makefile                   | 1 -
 8 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi/asm/sembuf.h
index 60c89e6cb25b..7d135b93bebd 100644
--- a/arch/mips/include/uapi/asm/sembuf.h
+++ b/arch/mips/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_SEMBUF_H
 #define _ASM_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The semid64_ds structure for the MIPS architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 3c31163b1241..b17a2460b184 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -3,6 +3,7 @@
 #define _PARISC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /* 
  * The semid64_ds structure for parisc architecture.
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 3f60946f77e3..f42c9c3502c7 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_SEMBUF_H
 #define _ASM_POWERPC_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/uapi/asm/sembuf.h
index f3d309c2e1cd..5d7764cdf80f 100644
--- a/arch/sparc/include/uapi/asm/sembuf.h
+++ b/arch/sparc/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_SEMBUF_H
 #define _SPARC_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The semid64_ds structure for sparc architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index 89de6cd9f0a7..da0464af7aa6 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SEMBUF_H
 #define _ASM_X86_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The semid64_ds structure for x86 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/uapi/asm/sembuf.h
index 09f348d643f1..3b9cdd406dfe 100644
--- a/arch/xtensa/include/uapi/asm/sembuf.h
+++ b/arch/xtensa/include/uapi/asm/sembuf.h
@@ -22,6 +22,7 @@
 #define _XTENSA_SEMBUF_H
 
 #include <asm/byteorder.h>
+#include <asm/ipcbuf.h>
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 0bae010f1b64..5807fcd643ba 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /*
  * The semid64_ds structure for x86 architecture.
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 099d7401aa23..107d04bd5ee3 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -16,7 +16,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-header-test- += asm/sembuf.h
 header-test- += asm/shmbuf.h
 header-test- += asm/signal.h
 header-test- += asm/ucontext.h
-- 
2.17.1
