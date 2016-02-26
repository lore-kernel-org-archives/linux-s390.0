From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH v3 0/5] all: s390: make compat wrappers the generic solution
Date: Fri, 26 Feb 2016 17:34:50 +0300
Message-ID: <1456497295-22991-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: heiko.carstens@de.ibm.com, arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

The problem that makes us use wrappers is that some compat
architectures allows user code to access top halves of registers.
This is not a problem for syscalls that are already handled by compat
code, or for that who has types of the same size in kernel and
userspace. In case of s390 and lp64/ilp32 the problem is in pointer
types, long, unsigned long.

S390 folks already have the solution for it. In this patchset,
it is turned to be general, as arm64/ilp32 needs it too.

This patchset is created as the part of the work of enabling arm64
with ILP32 user mode. See details here:
http://thread.gmane.org/gmane.linux.kernel/2126946

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

v2:
 This is the implementation of one of two possible approaches. First
 one defines new syscall handler declaration macro, that creates both compat and
 non-compat handlers, see [1]. This one declares all wrappers in separated file
 kernel/compat_wrapper.c

v3: 
 - move 2 s390-related wrappers from kernel/compat_wrappers.h
   to arch/s390/kernel/compat_linux.c
 - comments extended
Build-tested on s390.

[1] http://www.spinics.net/lists/linux-s390/msg11593.html

Yury Norov (5):
  all: syscall wrappers: add documentation
  all: introduce COMPAT_WRAPPER option and enable it for s390
  all: s390: move wrapper infrastructure to generic headers
  all: s390: move compat_wrappers.c from arch/s390/kernel to kernel/
  all: wrap needed syscalls in generic unistd

 Documentation/adding-syscalls.txt |  32 +++++
 arch/Kconfig                      |   4 +
 arch/s390/Kconfig                 |   1 +
 arch/s390/include/asm/compat.h    |  17 ++-
 arch/s390/kernel/Makefile         |   2 +-
 arch/s390/kernel/compat_wrapper.c | 180 ------------------------
 include/linux/compat.h            | 278 ++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h          |  57 +-------
 include/linux/syscalls_structs.h  |  60 ++++++++
 include/uapi/asm-generic/unistd.h | 231 +++++++++++++++----------------
 kernel/Makefile                   |   1 +
 kernel/compat_wrapper.c           | 170 +++++++++++++++++++++++
 12 files changed, 680 insertions(+), 353 deletions(-)
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 create mode 100644 include/linux/syscalls_structs.h
 create mode 100644 kernel/compat_wrapper.c

-- 
2.5.0
