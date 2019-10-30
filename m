Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] arch: msgbuf.h: make uapi asm/msgbuf.h self-contained
Date: Wed, 30 Oct 2019 15:38:54 +0900
Message-Id: <20191030063855.9989-2-yamada.masahiro@socionext.com>
In-Reply-To: <20191030063855.9989-1-yamada.masahiro@socionext.com>
References: <20191030063855.9989-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Masahiro Yamada <yamada.masahiro@socionext.com>

The user-space cannot compile <asm/msgbuf.h> due to some missing type
definitions. For example, building it for x86 fails as follows:

  CC      usr/include/asm/msgbuf.h.s
In file included from ./usr/include/asm/msgbuf.h:6:0,
                 from <command-line>:32:
./usr/include/asm-generic/msgbuf.h:25:20: error: field ‘msg_perm’ has incomplete type
  struct ipc64_perm msg_perm;
                    ^~~~~~~~
./usr/include/asm-generic/msgbuf.h:27:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t msg_stime; /* last msgsnd time */
  ^~~~~~~~~~~~~~~
./usr/include/asm-generic/msgbuf.h:28:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t msg_rtime; /* last msgrcv time */
  ^~~~~~~~~~~~~~~
./usr/include/asm-generic/msgbuf.h:29:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t msg_ctime; /* last change time */
  ^~~~~~~~~~~~~~~
./usr/include/asm-generic/msgbuf.h:41:2: error: unknown type name ‘__kernel_pid_t’
  __kernel_pid_t msg_lspid; /* pid of last msgsnd */
  ^~~~~~~~~~~~~~
./usr/include/asm-generic/msgbuf.h:42:2: error: unknown type name ‘__kernel_pid_t’
  __kernel_pid_t msg_lrpid; /* last receive pid */
  ^~~~~~~~~~~~~~

It is just a matter of missing include directive.

Include <asm/ipcbuf.h> to make it self-contained, and add it to
the compile-test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/uapi/asm/msgbuf.h    | 1 +
 arch/parisc/include/uapi/asm/msgbuf.h  | 1 +
 arch/powerpc/include/uapi/asm/msgbuf.h | 2 ++
 arch/sparc/include/uapi/asm/msgbuf.h   | 2 ++
 arch/x86/include/uapi/asm/msgbuf.h     | 3 +++
 arch/xtensa/include/uapi/asm/msgbuf.h  | 2 ++
 include/uapi/asm-generic/msgbuf.h      | 2 ++
 usr/include/Makefile                   | 1 -
 8 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/msgbuf.h b/arch/mips/include/uapi/asm/msgbuf.h
index 46aa15b13e4e..2722f9b82cf2 100644
--- a/arch/mips/include/uapi/asm/msgbuf.h
+++ b/arch/mips/include/uapi/asm/msgbuf.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_MSGBUF_H
 #define _ASM_MSGBUF_H
 
+#include <asm/ipcbuf.h>
 
 /*
  * The msqid64_ds structure for the MIPS architecture.
diff --git a/arch/parisc/include/uapi/asm/msgbuf.h b/arch/parisc/include/uapi/asm/msgbuf.h
index 6a2e9ab2ef8d..02ae1f616347 100644
--- a/arch/parisc/include/uapi/asm/msgbuf.h
+++ b/arch/parisc/include/uapi/asm/msgbuf.h
@@ -3,6 +3,7 @@
 #define _PARISC_MSGBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /* 
  * The msqid64_ds structure for parisc architecture, copied from sparc.
diff --git a/arch/powerpc/include/uapi/asm/msgbuf.h b/arch/powerpc/include/uapi/asm/msgbuf.h
index 2b1b37797a47..30d5e1b45553 100644
--- a/arch/powerpc/include/uapi/asm/msgbuf.h
+++ b/arch/powerpc/include/uapi/asm/msgbuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_MSGBUF_H
 #define _ASM_POWERPC_MSGBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The msqid64_ds structure for the PowerPC architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/sparc/include/uapi/asm/msgbuf.h b/arch/sparc/include/uapi/asm/msgbuf.h
index ffc46c211d6d..81a8460fdd67 100644
--- a/arch/sparc/include/uapi/asm/msgbuf.h
+++ b/arch/sparc/include/uapi/asm/msgbuf.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_MSGBUF_H
 #define _SPARC_MSGBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The msqid64_ds structure for sparc64 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
index 90ab9a795b49..e09fd2363300 100644
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -5,6 +5,9 @@
 #if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/msgbuf.h>
 #else
+
+#include <asm/ipcbuf.h>
+
 /*
  * The msqid64_ds structure for x86 architecture with x32 ABI.
  *
diff --git a/arch/xtensa/include/uapi/asm/msgbuf.h b/arch/xtensa/include/uapi/asm/msgbuf.h
index d6915e9f071c..1ed2c85b693a 100644
--- a/arch/xtensa/include/uapi/asm/msgbuf.h
+++ b/arch/xtensa/include/uapi/asm/msgbuf.h
@@ -17,6 +17,8 @@
 #ifndef _XTENSA_MSGBUF_H
 #define _XTENSA_MSGBUF_H
 
+#include <asm/ipcbuf.h>
+
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #ifdef __XTENSA_EB__
diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index 9fe4881557cb..7cdc7e52490d 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -3,6 +3,8 @@
 #define __ASM_GENERIC_MSGBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
+
 /*
  * generic msqid64_ds structure.
  *
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 70f8fe256aed..099d7401aa23 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -16,7 +16,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-header-test- += asm/msgbuf.h
 header-test- += asm/sembuf.h
 header-test- += asm/shmbuf.h
 header-test- += asm/signal.h
-- 
2.17.1
