From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 4/5] all: wrap getdents64 syscall
Date: Mon, 25 Jan 2016 19:57:26 +0300
Message-ID: <1453741047-5498-5-git-send-email-ynorov@caviumnetworks.com>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

This system call may be handled by compat handler if
__ARCH_WANT_COMPAT_SYS_GETDENTS64 is defined. So we
should declare wrapper otherwise only.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 fs/readdir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/readdir.c b/fs/readdir.c
index ced6791..d34cc49 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -17,6 +17,7 @@
 #include <linux/dirent.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <linux/unistd.h>
 
 #include <asm/uaccess.h>
@@ -274,8 +275,13 @@ efault:
 	return -EFAULT;
 }
 
+#ifndef __ARCH_WANT_COMPAT_SYS_GETDENTS64
+SYSCALL_DEFINE_WRAP3(getdents64, unsigned int, fd,
+		struct linux_dirent64 __user *, dirent, unsigned int, count)
+#else
 SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 		struct linux_dirent64 __user *, dirent, unsigned int, count)
+#endif
 {
 	struct fd f;
 	struct linux_dirent64 __user * lastdirent;
-- 
2.5.0
