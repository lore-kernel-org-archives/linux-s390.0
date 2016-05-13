From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Fri, 13 May 2016 13:51:15 +0300
Message-ID: <20160513105115.GA16672@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
 <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
 <20160512134431.GB30205@yury-N73SV>
 <20160512140734.GG11226@e104818-lin.cambridge.arm.com>
 <20160512142457.GC30205@yury-N73SV>
 <20160512152805.GJ11226@e104818-lin.cambridge.arm.com>
 <57358C2B.1010106@huawei.com>
 <20160513092802.GA13400@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160513092802.GA13400@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, broonie@kernel.org, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, linux-arm-kernel@lists.infradead.org, schwab@suse.de, schwidefsky@de.ibm.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 13, 2016 at 09:28:03AM +0000, Catalin Marinas wrote:
> 
> The discussion is mainly around whether USER_DS for 32-bit compat apps
> should be the same as USER_DS for native 32-bit apps. Even for native
> 32-bit kernels, we don't use STACK_TOP as addr_limit. A read/write from
> 0xffffffff would fail in both cases anyway. I think the LTP test doesn't
> even try to access such memory but only to probe the range validity (I
> haven't managed to build the latest LTP yet).

This fix lets me build it (on top of 7b3ef3b0b)
Of course, it's not 'official'. :)

---
 testcases/kernel/syscalls/fstatat/fstatat01.c  | 1 +
 testcases/kernel/syscalls/preadv/preadv.h      | 1 +
 testcases/kernel/syscalls/pwritev/pwritev.h    | 1 +
 testcases/kernel/syscalls/request_key/Makefile | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 128f6dd..6e23c9e 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -59,6 +59,7 @@ static const char *filenames[TEST_CASES];
 static const int expected_errno[] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0 };
 static const int flags[] = { 0, 0, 0, 0, 9999, 0 };
 
+#define HAVE_FSTATAT
 #if !defined(HAVE_FSTATAT)
 #if (__NR_fstatat64 > 0)
 int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
index f3ac30d..b001389 100644
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ b/testcases/kernel/syscalls/preadv/preadv.h
@@ -21,6 +21,7 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 
+#define HAVE_PREADV
 #if !defined(HAVE_PREADV)
 int preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
index ae9d999..2a4d188 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -21,6 +21,7 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 
+#define HAVE_PWRITEV
 #if !defined(HAVE_PWRITEV)
 int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
index 9add429..2e8a37c 100644
--- a/testcases/kernel/syscalls/request_key/Makefile
+++ b/testcases/kernel/syscalls/request_key/Makefile
@@ -19,6 +19,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS		+= $(KEYUTILS_LIBS)
+LDLIBS		+= $(lkeyutils)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.5.0


> 
> -- 
> Catalin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
