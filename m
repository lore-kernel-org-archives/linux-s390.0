Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: let import_iovec deal with compat_iovecs as well
Date: Fri, 18 Sep 2020 14:45:24 +0200
Message-Id: <20200918124533.3487701-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Hi Al,

this series changes import_iovec to transparently deal with comat iovec
structures, and then cleanups up a lot of code dupliation.  But to get
there it first has to fix the pre-existing bug that io_uring compat
contexts don't trigger the in_compat_syscall() check.  This has so far
been relatively harmless as very little code callable from io_uring used
the check, and even that code that could be called usually wasn't.

Diffstat
 arch/arm64/include/asm/unistd32.h                  |   10 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   10 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   10 
 arch/parisc/kernel/syscalls/syscall.tbl            |   10 
 arch/powerpc/kernel/syscalls/syscall.tbl           |   10 
 arch/s390/kernel/syscalls/syscall.tbl              |   10 
 arch/sparc/include/asm/compat.h                    |    3 
 arch/sparc/kernel/syscalls/syscall.tbl             |   10 
 arch/x86/entry/syscall_x32.c                       |    5 
 arch/x86/entry/syscalls/syscall_32.tbl             |   10 
 arch/x86/entry/syscalls/syscall_64.tbl             |   10 
 arch/x86/include/asm/compat.h                      |    2 
 block/scsi_ioctl.c                                 |   12 
 drivers/scsi/sg.c                                  |    9 
 fs/aio.c                                           |   38 --
 fs/io_uring.c                                      |   21 -
 fs/read_write.c                                    |  307 ++++-----------------
 fs/splice.c                                        |   57 ---
 include/linux/compat.h                             |   29 -
 include/linux/fs.h                                 |    7 
 include/linux/sched.h                              |    1 
 include/linux/uio.h                                |    7 
 include/uapi/asm-generic/unistd.h                  |   12 
 lib/iov_iter.c                                     |   30 --
 mm/process_vm_access.c                             |   69 ----
 net/compat.c                                       |    4 
 security/keys/compat.c                             |   37 --
 security/keys/internal.h                           |    5 
 security/keys/keyctl.c                             |    2 
 tools/include/uapi/asm-generic/unistd.h            |   12 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   10 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   10 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   10 
 33 files changed, 207 insertions(+), 582 deletions(-)
