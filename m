Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/3] s390: audit and remove needless module.h includes
Date: Thu, 9 Feb 2017 15:20:22 -0500
Message-ID: <20170209202025.8713-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Originally module.h provided support for both what was modular code and
what was providing support to modules via EXPORT_SYMBOL and friends.

That changed when we forked out support for the latter into the export.h
header; roughly five years ago[1].

We dealt with the immediate fallout of that change back then, but we
did not go through and "downgrade" all the non-modular module.h users
to export.h, once the merge of that change enabled us to do so.

This means we should be able to reduce the usage of module.h in code
that is obj-y Makefile or bool Kconfig.  In the case of some of these
which are modular, we can extend that to also include files that are
building basic support functionality but not related to loading or
registering the final module; such files also have no need whatsoever
for module.h

The advantage in removing such instances is that module.h itself
sources about 15 other headers; adding significantly to what we feed
cpp, and it can obscure what headers we are effectively using.

Consider the following pseudo patch to introduce a no-op source
that just includes module.h:

    diff --git a/init/Makefile b/init/Makefile
    --- a/init/Makefile
    +++ b/init/Makefile
    @@ -2,7 +2,7 @@

    -obj-y                          := main.o version.o mounts.o
    +obj-y                          := main.o version.o mounts.o foo.o

    diff --git a/init/foo.c b/init/foo.c
    new file mode 100644
    --- /dev/null
    +++ b/init/foo.c
    @@ -0,0 +1 @@
    +#include <linux/module.h>

With that in place, we then can see the impact with this:

   paul@builder:~/git/linux-head$ make O=../build/ init/foo.i
   make[1]: Entering directory '/home/paul/git/build'
     CPP     init/foo.i

   paul@builder:~/git/linux-head$ ls -lh ../build/init/foo.i 
   -rw-rw-r-- 1 paul paul 754K Jul 12 20:04 ../build/init/foo.i

So, with every module.h include, we guarantee a minimum of 3/4 of a MB
of text output from cpp as the baseline of header preamble to process.

Repeating the same experiment with <linux/init.h> and the result is less
than 12kB; with <linux/export.h> it is only about 1/2kB; with both it
still is less than 12kB.

Since module.h might be the implicit source for init.h (for __init)
and for export.h (for EXPORT_SYMBOL) we consider each instance for the
requirement of either and replace as needed.  Some additional implicit
include issues were also fixed up as they appeared during build
coverage.

The series was done on a per directory level for the larger dirs and
then we tackle the remainder in the final commit.  This seemed like
a better solution than one giant commit.

There is no urgency to get this in tree, it can easily wait three
weeks.  That said, the risk here is entirely on introducing build
failures -- there is no changes to generated code, so if build
coverage is exhaustive, the risk should be zero.

To that end, I have done allmodconfig, allyesconfig and allnoconfig
for s390 with these changes on the linux-next from today.  We've
already merged the changes from similar audits for x86 and other
supported architectures, so this isn't a new issue.

Paul.

[1] https://lwn.net/Articles/453517/

---

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org

Paul Gortmaker (3):
  s390: kernel: Audit and remove any unnecessary uses of module.h
  s390: mm: Audit and remove any unnecessary uses of module.h
  s390: Audit and remove any remaining unnecessary uses of module.h

 arch/s390/include/asm/livepatch.h | 2 +-
 arch/s390/kernel/compat_linux.c   | 1 -
 arch/s390/kernel/cpcmd.c          | 2 +-
 arch/s390/kernel/crash_dump.c     | 3 ++-
 arch/s390/kernel/debug.c          | 2 +-
 arch/s390/kernel/diag.c           | 3 ++-
 arch/s390/kernel/dis.c            | 2 +-
 arch/s390/kernel/ebcdic.c         | 4 ++--
 arch/s390/kernel/ipl.c            | 3 ++-
 arch/s390/kernel/irq.c            | 3 ++-
 arch/s390/kernel/jump_label.c     | 1 -
 arch/s390/kernel/nmi.c            | 2 +-
 arch/s390/kernel/process.c        | 2 +-
 arch/s390/kernel/smp.c            | 2 +-
 arch/s390/kernel/stacktrace.c     | 2 +-
 arch/s390/kernel/sysinfo.c        | 2 +-
 arch/s390/kernel/time.c           | 2 +-
 arch/s390/kernel/vdso.c           | 2 +-
 arch/s390/kvm/kvm-s390.c          | 1 +
 arch/s390/lib/delay.c             | 2 +-
 arch/s390/lib/spinlock.c          | 2 +-
 arch/s390/lib/string.c            | 3 ++-
 arch/s390/lib/xor.c               | 2 +-
 arch/s390/mm/cmm.c                | 1 +
 arch/s390/mm/dump_pagetables.c    | 1 -
 arch/s390/mm/extmem.c             | 2 +-
 arch/s390/mm/mem_detect.c         | 1 -
 arch/s390/mm/mmap.c               | 2 +-
 arch/s390/mm/pageattr.c           | 1 -
 arch/s390/mm/vmem.c               | 2 +-
 30 files changed, 31 insertions(+), 29 deletions(-)

-- 
2.11.0
