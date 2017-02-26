From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] uapi: fix asm/ipcbuf.h userspace compilation errors
Date: Sun, 26 Feb 2017 21:29:27 +0300
Message-ID: <20170226182927.GA6998@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Include <linux/posix_types.h> to fix asm/ipcbuf.h userspace compilation
errors like this:

/usr/include/asm-generic/ipcbuf.h:20:2: error: unknown type name '__kernel_key_t'
  __kernel_key_t  key;
/usr/include/asm-generic/ipcbuf.h:21:2: error: unknown type name '__kernel_uid32_t'
  __kernel_uid32_t uid;
/usr/include/asm-generic/ipcbuf.h:22:2: error: unknown type name '__kernel_gid32_t'
  __kernel_gid32_t gid;
/usr/include/asm-generic/ipcbuf.h:23:2: error: unknown type name '__kernel_uid32_t'
  __kernel_uid32_t cuid;
/usr/include/asm-generic/ipcbuf.h:24:2: error: unknown type name '__kernel_gid32_t'
  __kernel_gid32_t cgid;
/usr/include/asm-generic/ipcbuf.h:25:2: error: unknown type name '__kernel_mode_t'
  __kernel_mode_t  mode;
/usr/include/asm-generic/ipcbuf.h:27:35: error: '__kernel_mode_t' undeclared here (not in a function)
  unsigned char  __pad1[4 - sizeof(__kernel_mode_t)];
/usr/include/asm-generic/ipcbuf.h:30:2: error: unknown type name '__kernel_ulong_t'
  __kernel_ulong_t __unused1;
/usr/include/asm-generic/ipcbuf.h:31:2: error: unknown type name '__kernel_ulong_t'
  __kernel_ulong_t __unused2;

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/asm-generic/ipcbuf.h     | 2 ++
 arch/s390/include/uapi/asm/ipcbuf.h   | 2 ++
 arch/sparc/include/uapi/asm/ipcbuf.h  | 2 ++
 arch/xtensa/include/uapi/asm/ipcbuf.h | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
index 3dbcc1e..909f825 100644
--- a/include/uapi/asm-generic/ipcbuf.h
+++ b/include/uapi/asm-generic/ipcbuf.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_GENERIC_IPCBUF_H
 #define __ASM_GENERIC_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * The generic ipc64_perm structure:
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/s390/include/uapi/asm/ipcbuf.h b/arch/s390/include/uapi/asm/ipcbuf.h
index 37f293d..9f1185c 100644
--- a/arch/s390/include/uapi/asm/ipcbuf.h
+++ b/arch/s390/include/uapi/asm/ipcbuf.h
@@ -1,6 +1,8 @@
 #ifndef __S390_IPCBUF_H__
 #define __S390_IPCBUF_H__
 
+#include <linux/posix_types.h>
+
 /*
  * The user_ipc_perm structure for S/390 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/sparc/include/uapi/asm/ipcbuf.h b/arch/sparc/include/uapi/asm/ipcbuf.h
index 66013b4..b7b1bcb 100644
--- a/arch/sparc/include/uapi/asm/ipcbuf.h
+++ b/arch/sparc/include/uapi/asm/ipcbuf.h
@@ -1,6 +1,8 @@
 #ifndef __SPARC_IPCBUF_H
 #define __SPARC_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * The ipc64_perm structure for sparc/sparc64 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/xtensa/include/uapi/asm/ipcbuf.h b/arch/xtensa/include/uapi/asm/ipcbuf.h
index c33aa6a..7442e48 100644
--- a/arch/xtensa/include/uapi/asm/ipcbuf.h
+++ b/arch/xtensa/include/uapi/asm/ipcbuf.h
@@ -11,6 +11,8 @@
 #ifndef _XTENSA_IPCBUF_H
 #define _XTENSA_IPCBUF_H
 
+#include <linux/posix_types.h>
+
 /*
  * Pad space is left for:
  * - 32-bit mode_t and seq
-- 
ldv
