Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 01/25] all: syscall wrappers: add documentation
Date: Wed, 6 Apr 2016 01:08:23 +0300
Message-ID: <1459894127-17698-2-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160405220823.gWgolSTrvCaYgN7S5SPFXiF3LhtSnTMqk0bRkJkGlAE@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
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
