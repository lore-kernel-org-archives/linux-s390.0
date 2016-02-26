From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 1/5] all: syscall wrappers: add documentation
Date: Fri, 26 Feb 2016 17:34:51 +0300
Message-ID: <1456497295-22991-2-git-send-email-ynorov@caviumnetworks.com>
References: <1456497295-22991-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1456497295-22991-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: heiko.carstens@de.ibm.com, arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/adding-syscalls.txt | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/adding-syscalls.txt b/Documentation/adding-syscalls.txt
index cc2d4ac..d02a6bd 100644
--- a/Documentation/adding-syscalls.txt
+++ b/Documentation/adding-syscalls.txt
@@ -341,6 +341,38 @@ To summarize, you need:
  - instance of __SC_COMP not __SYSCALL in include/uapi/asm-generic/unistd.h
 
 
+Compatibility System Calls Wrappers
+--------------------------------
+
+Some architectures prevent 32-bit userspace from access to top halves of 64-bit
+registers, but some not. It's not a problem if specific argument is the same
+size in kernel and userspace. It also is not a problem if system call is already
+handled by compatible routine. Otherwise we'd take care of it. Usually, glibc
+and compiler handles register's top halve, but from kernel side, we cannot rely
+on it, as malicious code may cause incorrect behaviour and/or security
+vulnerabilities.
+
+For now, only s390 and arm64/ilp32 are affected.
+
+To clear that top halves, automatic wrappers are introduced. They clear all
+required registers before passing control to regular syscall handler.
+
+If your architecture allows userspace code to access top halves of register,
+you need to:
+ - enable COMPAT_WRAPPER in configuration file;
+ - declare: "#define __SC_WRAP(nr, sym) [nr] = compat_##sym,", just before
+   compatible syscall table declaration, if you use generic unistd; or
+ - declare compat wrappers manually, if you use non-generic syscall table.
+   The list of unsafe syscalls is in kernel/compat_wrapper.
+
+If you write new syscall, make sure, its arguments are the same size in both
+64- and 32-bits modes. If no, and if there's no explicit compat version for
+syscall handler, you need to:
+ - declare compat version prototype in 'include/linux/compat.h';
+ - in 'include/uapi/asm-generic/unistd.h' declare syscall with macro '__SC_WRAP'
+   instead of '__SYSCALL';
+ - add corresponding line to 'kernel/compat_wrapper.c' to let it generate wrapper.
+
 Compatibility System Calls (x86)
 --------------------------------
 
-- 
2.5.0
